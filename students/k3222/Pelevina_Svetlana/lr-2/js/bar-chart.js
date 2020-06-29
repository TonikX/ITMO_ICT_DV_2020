const margin = {top: 20, right: 160, bottom: 35, left: 30};
const width = 960 - margin.left - margin.right, height = 500 - margin.top - margin.bottom;
let publishers = []
let max_publishers = []


d3.csv("data/books.csv", function (error, data) {
    const svg = d3.select("h2")
        .append("div").attr("class", "svg-containter")
        .append("svg").attr("height", "100%").attr("width", width + margin.left + margin.right);

    data.forEach(function (a) {
        if (publishers.find(function(d) { return a.publisher === d.publisher}) === undefined)
            publishers.push({ publisher: a.publisher, count : 1});
        else ++publishers.find(function(d) { return a.publisher === d.publisher}).count;
    })

    publishers.sort(function(a,b) {return b.count - a.count} );

    max_publishers = publishers.slice(0,7);

    const dataset = d3.layout.stack()([1, 2, 3, 4, 5].map(function (rating) {
        return max_publishers.map(function (pub, i) {
            return {
                x: pub.publisher,
                y: data.filter(function(d) {
                    return (d.publisher === pub.publisher) && (rating-1 <= d.average_rating) && (d.average_rating < rating)})
                    .length};
        });
    }));



    /**
     * Строим бар-чарт
     */
    const x = d3.scale.ordinal()
        .domain(dataset[0].map(function (d) {
            return d.x;
        }))
        .rangeRoundBands([30, width - 10], 0.03);

    const y = d3.scale.linear()
        .domain([0, 50 + d3.max(dataset, function (d) {
            return d3.max(d, function (d) {
                return d.y0 + d.y;
            });
        })])
        .range([height, 0]);

    // let barWidth = (width / dataset.length);
    //
    // let text = svg.selectAll("text")
    //     .data(dataset)
    //     .enter()
    //     .append("text")
    //     .text(function(d) {
    //         return d;
    //     })
    //     .attr("y", function(d, i) {
    //         return 500 - d - 2;
    //     })
    //     .attr("x", function(d, i) {
    //         return barWidth * i;
    //     })
    //     .attr("fill", "#A64C38");

    const colors = ["#FF0000", "#FEB019", "#FFFF00", "#00FF30", "#00AA00"];

    const yAxis = d3.svg.axis().scale(y).orient("left").ticks(10).tickSize(-width, 0, 0);

    const xAxis = d3.svg.axis().scale(x).orient("bottom");

    svg.append("g").attr("class", "y axis").attr("transform", "translate(" + 30 + ",0)").call(yAxis);

    svg.append("g").attr("class", "x axis").attr("transform", "translate(0," + height + ")").call(xAxis);

    const groups = svg.selectAll("g.cost").data(dataset).enter().append("g").attr("class", "cost").style("fill", function (d, i) {
        return colors[i];
    });

    const rect = groups.selectAll("rect").data(function (d) {
        return d;
    }).enter().append("rect").attr("x", function (d) {
        return x(d.x);
    }).attr("y", function (d) {
        return y(d.y0 + d.y);
    }).attr("height", function (d) {
        return y(d.y0) - y(d.y0 + d.y);
    }).attr("width", x.rangeBand()).on("mouseover", function () {
        tooltip.style("display", null);
    }).on("mouseout", function () {
        tooltip.style("display", "none");
    }).on("mousemove", function (d) {
        var xPosition = d3.mouse(this)[0] - 15;
        var yPosition = d3.mouse(this)[1] - 25;
        tooltip.attr("transform", "translate(" + xPosition + "," + yPosition + ")");
        tooltip.select("text").text(d.y);
    })

    const legend = svg.selectAll(".legend")
        .data(colors)
        .enter().append("g")
        .attr("class", "legend")
        .attr("transform", function (d, i) {
            return "translate(30," + i * 19 + ")";
        });

    legend.append("rect").attr("x", width - 18).attr("width", 18).attr("height", 18).style("fill", function (d, i) {
        return colors.slice().reverse()[i];
    });

    legend.append("text")
        .attr("x", width + 5).attr("y", 9).attr("dy", ".35em")
        .style("text-anchor", "start")
        .text(function (d, i) { return (4-i) + " - " + (4-i+1); });

    const tooltip = svg.append("g").attr("class", "my-tooltip").style("display", "none");
    tooltip.append("rect")
        .attr("width", 30).attr("height", 20).attr("fill", "white")
        .style("opacity", 0.5);
    tooltip.append("text")
        .attr("x", 15).attr("dy", "1.2em")
        .style("text-anchor", "middle").attr("font-size", "12px").attr("font-weight", "bold");
});