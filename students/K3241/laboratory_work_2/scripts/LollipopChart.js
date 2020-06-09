let margin = {top: 50, right: 100, bottom: 50, left: 150}

let width = 1200 - margin.left - margin.right
let height = 1400 - margin.top - margin.bottom


let svg = d3.select("div")
    .append("svg")
    .attr("margin-left", $(window).width() / 2)
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")")


let tooltip = svg.append("text");


d3.csv("./data/master.csv", function (row) {
    row.year = Number(row.year)
    row.suicides_no = Number(row.suicides_no)
    return row;
}, function (data) {

    let countries = d3.map(data, function (d) {
        return (d.country)
    }).keys()

    let data_dict = []
    countries.forEach((value, index) => {
        data_dict[value] = 0;
    });


    data.forEach((row, index) => {
        data_dict[row.country] += row.suicides_no;
    });


    let dataset = []
    countries.forEach((row, index) => {
        dataset.push({"country": row, "value": data_dict[row]})
    });

    dataset.sort(function (b, a) {
        return a.value - b.value;
    });
    dataset.reverse()

    // Add X axis
    let x = d3.scaleLinear()
        .domain([0, dataset[dataset.length - 1].value])
        .range([0, width]);
    svg.append("g")
        .attr("transform", "translate(0," + height + ")")
        .call(d3.axisBottom(x))
        .selectAll("text")
        .attr("transform", "translate(-10,0)rotate(-45)")
        .style("text-anchor", "end");

    // Y axis
    var y = d3.scaleBand()
        .range([0, height])
        .domain(dataset.map(function (d) {
            return d.country;
        }))
        .padding(1);
    svg.append("g")
        .call(d3.axisLeft(y))


    // Lines
    svg.selectAll("myline")
        .data(dataset)
        .enter()
        .append("line")
        .attr("x1", x(0))
        .attr("x2", x(0))
        .attr("y1", function (d) {
            return y(d.country);
        })
        .attr("y2", function (d) {
            return y(d.country);
        })
        .attr("stroke", "grey")

    // Circles -> start at X=0
    svg.selectAll("mycircle")
        .data(dataset)
        .enter()
        .append("circle")
        .attr("cx", x(0))
        .attr("cy", function (d) {
            return y(d.country);
        })
        .attr("r", "7")
        .style("fill", "#69b3a2")
        .attr("stroke", "black")
        .on("mouseover", function () {
        })
        .on("mouseout", function () {
            tooltip.text("");
        })
        .on("mousemove", function (d) {
            var xPosition = d3.mouse(this)[0] + 15;
            var yPosition = d3.mouse(this)[1] - 10;
            tooltip.attr("transform", "translate(" + xPosition + "," + yPosition + ")");
            tooltip.text(d.value);
        });


    // Change the X coordinates of line and circle
    svg.selectAll("circle")
        .transition()
        .duration(2000)
        .attr("cx", function (d) {
            return x(d.value);
        })

    svg.selectAll("line")
        .transition()
        .duration(2000)
        .attr("x1", function (d) {
            return x(d.value);
        })


});