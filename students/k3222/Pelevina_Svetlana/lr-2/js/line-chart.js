const parseDate = d3.time.format("%m/%d/%Y").parse;
const margin = {top: 20, right: 160, bottom: 35, left: 30};
const width = 960 - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom;
const xNudge = 50, yNudge = 0;
let maxYear = 0; let minYear = 0;
let counts = {};
let counts1 = {};
let pages1 = {};
let tooltip = { width: 100, height: 100, x: 10, y: -30 };
let bisectDate = d3.bisector(function(d) { return d.year; }).left;

books = d3.csv("data/books.csv")
books.row(function (d) {
        return {
            year: parseDate(d.publication_date).getFullYear()
        };
    })
    .get(function (error, rows) {
        maxYear = d3.max(rows, function (d) {
            return d.year;
        });

        minYear = d3.min(rows, function (d) {
            return d.year;
        });

        rows.forEach(function (a) {
            if (counts[a.year] === undefined) counts[a.year] = 1;
            else counts[a.year]++;
        })

        counts1 = Object.keys(counts).map(function (key) {
            return { year: key, count: counts[key]};
        });

        const y = d3.scale.linear().domain([0, 1800]).range([height, 0]);
        const x = d3.scale.linear().domain([minYear, maxYear]).range([0, width]);
        const yAxis = d3.svg.axis().orient("left").scale(y);
        const xAxis = d3.svg.axis().scale(x).orient("bottom");

        let line = d3.svg.line()
            .x(function (d) {return x(d.year);})
            .y(function (d) {return y(d.count);})
            .interpolate("cardinal");

        const svg = d3.select("h2").append("div").attr("class", "svg-containter").append("svg")
            .attr("height", "100%").attr("width", width + margin.left + margin.right);

        let chartGroup = svg.append("g").attr("class", "chartGroup").attr("transform", "translate(" + xNudge + "," + yNudge + ")");

        chartGroup.append("path").attr("class", "line").attr("d", function (d) {
            return line(counts1);
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
            .attr("width", 140)
            .attr("height", 50)
            .attr("x", 10)
            .attr("y", -22)
            .attr("rx", 4)
            .attr("ry", 4)

        focus.append("text")
            .attr("x", 18)
            .attr("y", -2)
            .text("Год:");

        focus.append("text")
            .attr("class", "tooltip-date")
            .attr("x", 50)
            .attr("y", -2);

        focus.append("text")
            .attr("x", 18)
            .attr("y", 18)
            .text("Количество:");

        focus.append("text")
            .attr("class", "tooltip-likes")
            .attr("x", 110)
            .attr("y", 18);

        svg.append("rect")
            .attr("class", "overlay")
            .attr("width", '100%')
            .attr("height", "100%")
            .on("mouseover", function() { focus.style("display", null); })
            .on("mouseout", function() { focus.style("display", "none"); })
            .on("mousemove", mousemove);

        function mousemove() {
            var x0 = x.invert(d3.mouse(this)[0] - xNudge),
                i = bisectDate(counts1, x0, 1),
                d0 = counts1[i - 1],
                d1 = counts1[i],
                d = x0 - d0.year > d1.year - x0 ? d1 : d0;
            focus.attr("transform", "translate(" + (x(d.year) + xNudge) + "," + (y(d.count) + yNudge) + ")");
            focus.select(".tooltip-date").text(d.year);
            focus.select(".tooltip-likes").text(d.count);
        }
    });
