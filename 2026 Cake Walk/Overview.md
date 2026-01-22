---
prefix: Y26
---
# Items of 2026 - The Cake Walk

## test

***

```button
name Create Side Quest
type note(2026 Cake Walk/quest log/<% await app.insertIncrementalId(tp.frontmatter.prefix) %>  <% tp.system.prompt("What's the title?", "") %> , tab) template
action ticket_template
templater true
```

## TL;DR
Okay

### Created HeatMap
```dataviewjs
const pages = dv.pages('"2026 Cake Walk/quest log"')

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
```

### Status Charts

```chartsview
#-----------------#
#- chart type    -#
#-----------------#
type: Pie

#-----------------#
#- chart data    -#
#-----------------#
data: |
  dataviewjs:
  return dv.pages('"2026 Cake Walk/quest log"')
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

```

```chartsview
#-----------------#
#- chart type    -#
#-----------------#
type: Radar
#-----------------#
#- chart data    -#
#-----------------#
data: |
  dataviewjs:
  return dv.pages('"2026 Cake Walk/quest log"')
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

```

```dataview
TABLE WITHOUT ID
  status as Status,
  length(rows) as Count
FROM "2026 Cake Walk/quest log"
GROUP BY status
```

### Type Charts

```chartsview
#-----------------#
#- chart type    -#
#-----------------#
type: Pie

#-----------------#
#- chart data    -#
#-----------------#
data: |
  dataviewjs:
  return dv.pages('"2026 Cake Walk/quest log"')
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

```

```chartsview
#-----------------#
#- chart type    -#
#-----------------#
type: Radar
#-----------------#
#- chart data    -#
#-----------------#
data: |
  dataviewjs:
  return dv.pages('"2026 Cake Walk/quest log"')
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

```

```dataview
TABLE WITHOUT ID
  type as Type,
  length(rows) as Count
FROM "2026 Cake Walk/quest log"
GROUP BY type
```