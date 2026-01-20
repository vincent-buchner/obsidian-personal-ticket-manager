<%*

// Required fields
const folder_name = await tp.system.prompt("Folder Name:");
if (!folder_name) return;

const project_name = (await tp.system.prompt("Project Name (empty = folder name):") || folder_name);
const prefix = (await tp.system.prompt("ID Prefix:") || "PROJ");

// Optional fields
const subheading = (await tp.system.prompt("Subheading (optional):") || "");
const tldr       = (await tp.system.prompt("TL;DR (optional):") || "");

// ─── Content builder ────────────────────────────────
const sections = [];
const item_folder = "quest log"
const init_file_name = "Overview"

sections.push(`---
prefix: ${prefix}
---
# ${project_name}`);

// Optional content
if (subheading) sections.push(`## ${subheading}`);
sections.push("***");

// Always present button
sections.push(`\`\`\`button
name Create Side Quest
type note(${folder_name}/${item_folder}/\<\% await app.insertIncrementalId(tp.frontmatter.prefix) \%\>, tab) template
action ticket_template
templater true
\`\`\``);

if (tldr) sections.push(`## TL;DR\n${tldr}`);

// Always present HeatMap
sections.push(`### Created HeatMap\n\`\`\`dataviewjs
const pages = dv.pages('"${folder_name}/${item_folder}"')

const calendarData = {
    entries: []
}

// Group pages by created date and count them
const dateGroups = {}

for (let page of pages) {
    if (page.created) {
        // Convert the created date to YYYY-MM-DD format
        let dateStr
        if (page.created.toFormat) {
            // If it's a Luxon DateTime object
            dateStr = page.created.toFormat('yyyy-MM-dd')
        } else if (page.created instanceof Date) {
            // If it's a JavaScript Date object
            dateStr = page.created.toISOString().split('T')[0]
        } else {
            // If it's a string, try to parse it
            dateStr = String(page.created).split('T')[0]
        }
        
        dateGroups[dateStr] = (dateGroups[dateStr] || 0) + 1
    }
}

// Convert to the format expected by heatmap calendar
for (let [date, count] of Object.entries(dateGroups)) {
    calendarData.entries.push({
        date: date,
        intensity: count
    })
}

renderHeatmapCalendar(this.container, calendarData)
\`\`\``)

sections.push(`### Status Charts

\`\`\`chartsview
#-----------------#
#- chart type    -#
#-----------------#
type: Pie

#-----------------#
#- chart data    -#
#-----------------#
data: |
  dataviewjs:
  return dv.pages('"${folder_name}/${item_folder}"')
           .groupBy(p => p.status)
           .map(p => ({status: p.key || "No Status", count: p.rows.length}))
           .array();

#-----------------#
#- chart options -#
#-----------------#
options:
  angleField: "count"
  colorField: "status"
  label:
    type: "outer"
    content: "{name} {percentage}"
  legend:
    position: "right"

\`\`\`

\`\`\`chartsview
#-----------------#
#- chart type    -#
#-----------------#
type: Radar
#-----------------#
#- chart data    -#
#-----------------#
data: |
  dataviewjs:
  return dv.pages('"${folder_name}/${item_folder}"')
           .groupBy(p => p.status)
           .map(p => ({
             category: p.key || "No Status",
             count: p.rows.length
           }))
           .array();
#-----------------#
#- chart options -#
#-----------------#
options:
  xField: "category"
  yField: "count"
  meta:
    count:
      alias: "Count"
      min: 0
      nice: true
  xAxis:
    line: null
    tickLine: null
  yAxis:
    label: false
    grid:
      alternateColor: "rgba(0, 0, 0, 0.04)"
  point:
    size: 4
  area: {}

\`\`\``)


sections.push(`\`\`\`dataview
TABLE WITHOUT ID
  status as Status,
  length(rows) as Count
FROM "${folder_name}/${item_folder}"
GROUP BY status
\`\`\``)

sections.push(`### Type Charts

\`\`\`chartsview
#-----------------#
#- chart type    -#
#-----------------#
type: Pie

#-----------------#
#- chart data    -#
#-----------------#
data: |
  dataviewjs:
  return dv.pages('"${folder_name}/${item_folder}"')
           .groupBy(p => p.type)
           .map(p => ({type: p.key || "No Type", count: p.rows.length}))
           .array();

#-----------------#
#- chart options -#
#-----------------#
options:
  angleField: "count"
  colorField: "type"
  label:
    type: "outer"
    content: "{name} {percentage}"
  legend:
    position: "right"

\`\`\`

\`\`\`chartsview
#-----------------#
#- chart type    -#
#-----------------#
type: Radar
#-----------------#
#- chart data    -#
#-----------------#
data: |
  dataviewjs:
  return dv.pages('"${folder_name}/${item_folder}"')
           .groupBy(p => p.type)
           .map(p => ({
             category: p.key || "No Type",
             count: p.rows.length
           }))
           .array();
#-----------------#
#- chart options -#
#-----------------#
options:
  xField: "category"
  yField: "count"
  meta:
    count:
      alias: "Count"
      min: 0
      nice: true
  xAxis:
    line: null
    tickLine: null
  yAxis:
    label: false
    grid:
      alternateColor: "rgba(0, 0, 0, 0.04)"
  point:
    size: 4
  area: {}

\`\`\``)


sections.push(`\`\`\`dataview
TABLE WITHOUT ID
  type as Type,
  length(rows) as Count
FROM "${folder_name}/${item_folder}"
GROUP BY type
\`\`\``)

// Join with newlines
const overview = sections.join("\n\n");

// ─── Execution ──────────────────────────────────────
const folder_path = `${folder_name}`;

await app.vault.createFolder(folder_path);
await app.vault.createFolder(`${folder_path}/${item_folder}`);
await app.vault.create(`${folder_path}/${init_file_name}.md`, overview);

new Notice(`Created: ${folder_path}/${init_file_name}.md`);
 -%>