let margin = {top: 50, right: 50, bottom: 50, left: 50}

let width = 500 - margin.left - margin.right
let height = 500 - margin.top - margin.bottom
let x = width / 2
let y = height / 2
let radius = 150


let svg = d3.select("div")
    .append("svg")
    .attr("margin-left", $(window).width() / 2)
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .attr("class", "text-center")
    .append("g")
    .attr("transform", "translate(" + x + "," + y + ")")


let popup = d3.select("svg").append('text')
    .attr("transform", "translate(" + x + "," + (y + radius + 28) + ")")
    .attr("dx", -70)
    .style("font-size", 19)

d3.csv('./data/master.csv', function (row) {
    row.suicides_no = Number(row.suicides_no)
    return row;
}, function (suicides) {
    couters = {male: 0, female: 0}
    suicides.forEach(function myFunction(row, index) {

        if (row.sex === "male") {
            couters.male += row.suicides_no
        } else if (row.sex === "female") {
            couters.female += row.suicides_no
        }
    });

    let color = d3.scaleOrdinal()
        .domain(couters)
        .range(["#a05d56", "#7b6888"])

    let pie = d3.pie()
        .value(function (d) {
            return d.value;
        })
    let data_ready = pie(d3.entries(couters))

    let arcGenerator = d3.arc()
        .innerRadius(0)
        .outerRadius(radius)

    svg.selectAll('mySlices')
        .data(data_ready)
        .enter()
        .append('path')
        .attr('d', arcGenerator)
        .attr('fill', function (d) {
            return (color(d.data.key))
        })
        .attr("stroke", "black")
        .style("stroke-width", "2px")
        .style("opacity", 0.7)
        .on('mouseover', function (d, i) {
            popup.text(d.value + " человек.")
        })
        .on('mouseout', function (d, i) {
            popup.text('')
        })

    svg.selectAll('mySlices')
        .data(data_ready)
        .enter()
        .append('text')
        .attr("dx", -10)
        .text(function (d) {
            if (d.data.key === "male") {
                return "Male: " + Math.ceil((couters.male / (couters.male + couters.female)) * 100) + "%"
            }
            if (d.data.key === "female") {
                return "Female: " + Math.floor((couters.female / (couters.male + couters.female)) * 100) + "%"
            }
            return "Error"
        })
        .attr("transform", function (d) {
            return "translate(" + arcGenerator.centroid(d) + ")";
        })
        .style("text-anchor", "middle")
        .style("font-size", 19)

});




