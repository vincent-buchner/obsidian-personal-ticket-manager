---
prefix: EX
---
# Example

## This is only an example!

***

```button
name Create Side Quest
type note(Example/quest log/<% await app.insertIncrementalId(tp.frontmatter.prefix) %>, tab) template
action ticket_template
templater true
```

## TL;DR
This directory is only for an example. You can delete if you'd like. That's your choice.

### Created HeatMap
```dataviewjs
const pages = dv.pages('"Example/quest log"')

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
  return dv.pages('"Example/quest log"')
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
  return dv.pages('"Example/quest log"')
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
FROM "Example/quest log"
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
  return dv.pages('"Example/quest log"')
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
  return dv.pages('"Example/quest log"')
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
FROM "Example/quest log"
GROUP BY type
```