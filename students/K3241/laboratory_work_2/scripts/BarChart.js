let margin = {top: 50, right: 50, bottom: 50, left: 60}

let width = 1000 - margin.left - margin.right
let height = 500 - margin.top - margin.bottom


let svg = d3.select("div")
    .append("svg")
    .attr("margin-left", $(window).width() / 2)
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .attr("class", "text-center")
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")")


d3.csv('./data/master.csv', function (row) {
    row.year = Number(row.year)
    row.suicides_no = Number(row.suicides_no)
    return row;
}, function (data) {

    let groups = d3.map(data, function (d) {
        return (d.age)
    }).keys()
    groups.sort()
    groups.unshift(groups.splice(groups.indexOf('5-14 years'), 1)[0])

    let dataset = []
    groups.forEach((d, index) => {
        dataset.push({"group": d, "value": 0})
    });
    data.forEach((d, index1) => {
        dataset.forEach((item, index2) => {
            if (item.group === d.age) {
                dataset[index2].value += d.suicides_no
            }
        });
    });


    // X axis
    let x = d3.scaleBand()
        .range([0, width])
        .domain(dataset.map(function (d) {
            return d.group;
        }))
        .padding(0.2);
    svg.append("g")
        .attr("transform", "translate(0," + height + ")")
        .call(d3.axisBottom(x))
        .selectAll("text")
        .attr("transform", "translate(-10,0)rotate(-45)")
        .style("text-anchor", "end");

    let y = d3.scaleLinear()
        .domain([0, d3.max(dataset, function (d) {
            return d.value
        })])
        .range([height, 0]);
    svg.append("g")
        .call(d3.axisLeft(y));

    svg.selectAll("mybar")
        .data(dataset)
        .enter()
        .append("rect")
        .attr("x", function (d) {
            return x(d.group);
        })
        .attr("width", x.bandwidth())
        .attr("fill", "#69b3a2")
        // no bar at the beginning thus:
        .attr("height", function (d) {
            return height - y(0);
        }) // always equal to 0
        .attr("y", function (d) {
            return y(0);
        })

    // Animation
    svg.selectAll("rect")
        .transition()
        .duration(800)
        .attr("y", function (d) {
            return y(d.value);
        })
        .attr("height", function (d) {
            return height - y(d.value);
        })
        .delay(function (d, i) {
            return (i * 100)
        })

});




