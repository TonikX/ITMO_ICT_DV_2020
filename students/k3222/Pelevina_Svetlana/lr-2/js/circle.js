const margin = {top: 20, right: 160, bottom: 35, left: 30};
const width = 960 - margin.left - margin.right, height = 500 - margin.top - margin.bottom;
const radius = Math.min(width, height) / 2 - 50;

books = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0,6: 0, 7: 0, 8: 0, 9: 0, 10: 0};
reviews = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0,6: 0, 7: 0, 8: 0, 9: 0, 10: 0};

d3.csv("data/books.csv", function (error, data) {
    const svg = d3.select("h2")
        .append("div").attr("class", "svg-containter")
        .append("svg").attr("height", "100%").attr("width", width + margin.left + margin.right)


    data.forEach(function (a) {
        let n = Math.ceil(+a.average_rating*2);
        if (n === 0) n=1;
        books[n]++;
        books[n] += +a.ratings_count;
    });

    data1 = Object.keys(books).map(function (a) {
        return { rating: +a, counts: books[a]};
    });
    console.log(data1)

    var pie = d3.pie().value(function(d) {return d.counts; })

    var data_ready = pie(data1)

    const colors = ['#FF0000', '#FF3300', '#ff6600', '#ff9900', '#FFCC00',
        '#FFFF00', '#ccff00', '#99ff00', '#66ff00', '#33ff00']


    var color = d3.scaleLinear()
        .domain([1,2,3,4,5,6,7,8,9,10])
        .range(colors)
        .interpolate(d3.interpolateHcl);

    var segments = d3.arc()
        .innerRadius(0)
        .outerRadius(radius)
        .padAngle(.05)
        .padRadius(50);

    var circleSvg = svg.append("g").attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

    circleSvg
        .selectAll("slices")
        .data(data_ready)
        .enter()
        .append('path')
        .attr("d", segments)
        .attr('fill', function(d){ return color(d.data.rating) })
        .style("stroke-width", "2px")
        .style("opacity", 0.7)


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
        .text(function (d, i) { return (9-i)/2 + " - " + (9-i+1)/2; });

});