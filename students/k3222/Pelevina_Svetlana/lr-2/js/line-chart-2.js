const margin = {top: 20, right: 160, bottom: 35, left: 30};
const width = 960 - margin.left - margin.right, height = 500 - margin.top - margin.bottom;
const xNudge = 50, yNudge = 20;
let data = {};
let tooltip = { width: 100, height: 100, x: 10, y: -30 };
let bisectCount = d3.bisector(function(d) { return d.ratings_count; }).left;

books = d3.csv("data/books.csv")
books.row(function (d) {
    return {
        title: d.title,
        ratings_count: Number(d.ratings_count),
        text_reviews_count: Number(d.text_reviews_count)
    };
})
    .get(function (error, rows) {

        data = Object(rows).map(function (a) {
            if (a.ratings_count > 2500000) {return { ratings_count: 0, text_reviews_count: 0, title: a.title};}
            else return { ratings_count: a.ratings_count, text_reviews_count: a.text_reviews_count, title: a.title};
        });

        data.sort(function(a,b) {return a.ratings_count - b.ratings_count});

        const y = d3.scale.linear().domain([0, 90000]).range([height, 0]);
        const x = d3.scale.linear().domain([0, 2500000]).range([0, width]);
        const yAxis = d3.svg.axis().orient("left").scale(y);
        const xAxis = d3.svg.axis().scale(x).orient("bottom");

        let line = d3.svg.line()
            .x(function (d) {return x(d.ratings_count);})
            .y(function (d) {return y(d.text_reviews_count);})
            .interpolate("cardinal");

        const svg = d3.select("h2").append("div").attr("class", "svg-containter").append("svg")
            .attr("height", "100%").attr("width", width + margin.left + margin.right);

        let chartGroup = svg.append("g").attr("class", "chartGroup").attr("transform", "translate(" + xNudge + "," + yNudge + ")");

        chartGroup.append("path").attr("class", "line").attr("d", function (d) {
            return line(data);
        });

        chartGroup.append("g").attr("class", "axis x").attr("transform", "translate(0," + height + ")").call(xAxis);
        chartGroup.append("g").attr("class", "axis y").call(yAxis);

        var focus = svg.append("g")
            .attr("class", "focus")
            .style("display", "none");

        focus.append("circle")
            .attr("r", 2);

        focus.append("rect")
            .attr("class", "tooltip")
            .attr("x", 10)
            .attr("y", -22)
            .attr("rx", 4)
            .attr("ry", 4)

        focus.append("text")
            .attr("x", 18)
            .attr("y", -2)
            .text("Название: ");

        focus.append("text")
            .attr("class", "tooltip-ratings_count")
            .attr("x", 90)
            .attr("y", -2);

        focus.append("text")
            .attr("x", 18)
            .attr("y", 18)
            .text("Отзывов:");

        focus.append("text")
            .attr("class", "tooltip-reviews")
            .attr("x", 90)
            .attr("y", 18);

        svg.append("rect")
            .attr("class", "overlay")
            .attr("width", width + margin.bottom + margin.top)
            .attr("height", "100%")
            .on("mouseover", function() { focus.style("display", null); })
            .on("mouseout", function() { focus.style("display", "none"); })
            .on("mousemove", mousemove);

        function mousemove() {

            var x0 = x.invert(d3.mouse(this)[0] - xNudge),
                i = bisectCount(data, x0, 1),
                d0 = data[i - 1],
                d1 = data[i],
                d = x0 - d0.ratings_count > d1.ratings_count - x0 ? d1 : d0;
            focus.attr("transform", "translate(" + (x(d.ratings_count) + xNudge) + "," + (y(d.text_reviews_count) + yNudge) + ")");
            focus.select(".tooltip-ratings_count").text(d.title.toLocaleString());
            focus.select(".tooltip-reviews").text(d.text_reviews_count.toLocaleString());
        }
    });