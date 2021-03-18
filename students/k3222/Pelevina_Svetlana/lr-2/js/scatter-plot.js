const margin = {top: 20, right: 160, bottom: 35, left: 30};
const width = 960 - margin.left - margin.right, height = 500 - margin.top - margin.bottom;
const xNudge = 50, yNudge = 20;
// let data = {};
// let tooltip = { width: 100, height: 100, x: 10, y: -30 };
// let bisectCount = d3.bisector(function(d) { return d.ratings_count; }).left;

books = d3.csv("data/books.csv")
books.row(function (d) {
    return {
        rating: Number(d.average_rating),
        ratings_count: Number(d.text_reviews_count),
        pages: Number(d.num_pages),
        title : d.title,
        rb : d.Rowling_books
    };
})
    .get(function (error, rows) {

        data = Object(rows).map(function (a) {
            return { rating: a.rating, ratings_count: a.ratings_count, pages: a.pages, title :a.title, rb: a.rb};
        });

        data.sort(function(a,b) {return b.ratings_count - a.ratings_count} ).reverse();

        const svg = d3.select("h2").append("div").attr("class", "svg-containter").append("svg")
            .attr("height", "100%").attr("width", width + margin.left + margin.right)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

        let y = d3.scaleLinear().domain([0, 5]).range([height, 0]);
        let x = d3.scaleLinear().domain([0, 2000]).range([0, width]);
        svg.append("g")
            .call(d3.axisLeft(y));
        svg.append("g")
            .attr("transform", "translate(0," + height + ")")
            .call(d3.axisBottom(x));
        let z = d3.scaleLinear().domain([0, 100000]).range([3, 40]);


        var tooltip = d3.select("h2")
            .select('div')
            .style("position", "relative")
            .append("tooltip")
            // .attr("class", "tooltip")
            .style("background-color", "black")
            .style("border-radius", "5px")
            .style("padding", "10px")
            .style("color", "white")
            .style("font-size", "12px")
            .style("line-height", "12px")
            .style("position", 'absolute')

        window.setInterval(() => tooltip.style('display', 'none'), 3000)
        var showTooltip = function(d) {
            tooltip
                .html(d.title)
                .style("display", "block")
                .style("left", (d3.mouse(this)[0]+margin.left) + "px")
                .style("top", (d3.mouse(this)[1]+margin.top-30) + "px")
        }
        var moveTooltip = function(d) {
            tooltip
                .style("display", "block")
                .style("left", (d3.mouse(this)[0]+margin.left) + "px")
                .style("top", (d3.mouse(this)[1]+margin.top-30) + "px")
        }

        svg.append('g')
            .selectAll("dot")
            .data(data)
            .enter()
            .append("circle")
            .attr("cx", function (d) { return x(d.pages); } )
            .attr("cy", function (d) { return y(d.rating); } )
            .attr("r", function (d) { return z(d.ratings_count); } )
            .style("fill", function (d) { return ("True" === d.rb) ? "#BA55D3" : z(d.ratings_count)>10 ? "#69b3a2" : "#D3D3D3"})
            .style("opacity", "0.7")
            .attr("stroke", function (d) { return  z(d.ratings_count)>10 ? "black" : "white"})
            .on("mouseover", showTooltip )
            .on("mousemove", moveTooltip )
            // .on("mouseleave", hideTooltip )

        let colors = ["#d3d3d3","#69b3a2", "#BA55D3"]

        // Add legend: circles
        var valuesToShow = [10000, 100000]
        var xCircle = width - 200
        var xLabel = width - 200
        svg
            .selectAll("legend")
            .data(valuesToShow)
            .enter()
            .append("circle")
            .attr("cx", xCircle)
            .attr("cy", function(d){ return height - 100 - z(d) } )
            .attr("r", function(d){ return z(d) })
            .style("fill", "none")
            .attr("stroke", "black")

        // Add legend: segments
        svg
            .selectAll("legend")
            .data(valuesToShow)
            .enter()
            .append("line")
            .attr('x1', function(d){ return xCircle + z(d) } )
            .attr('x2', xLabel)
            .attr('y1', function(d){ return height - 100 - z(d) } )
            .attr('y2', function(d){ return height - 100 - z(d) } )
            .attr('stroke', 'black')
            .style('stroke-dasharray', ('2,2'))

        // Add legend: labels
        svg
            .selectAll("legend")
            .data(valuesToShow)
            .enter()
            .append("text")
            .attr('x', xLabel)
            .attr('y', function(d){ return height - 105 - z(d) } )
            .text( function(d){ return d } )
            .style("font-size", 10)
            .attr('alignment-baseline', 'middle')

        // Legend title
        svg.append("text")
            .attr('x', xCircle)
            .attr("y", height - 100 + 30)
            .text("Количество отзывов")
            .attr("text-anchor", "middle")

        // Add one dot in the legend for each name.
        // var highlight = function(d){
        //     // reduce opacity of all groups
        //     d3.selectAll(".bubbles").style("opacity", .05)
        //     // expect the one that is hovered
        //     d3.selectAll("."+d).style("opacity", 1)
        // }
        // var noHighlight = function(d){
        //     d3.selectAll(".bubbles").style("opacity", 1)
        // }
        var size = 20
        var allgroups = ["<15", ">15", "Harry Potter"]
        var myColor = d3.scaleOrdinal()
            .domain(allgroups)
            .range(colors);

        svg.selectAll("rect")
            .data(allgroups)
            .enter()
            .append("circle")
            .attr("cx", width-200)
            .attr("cy", function(d,i){ return 150 + i*(size+5)}) // 100 is where the first dot appears. 25 is the distance between dots
            .attr("r", 7)
            .style("fill", function(d){ return myColor(d)})
            // .on("mouseover", highlight)
            // .on("mouseleave", noHighlight)

        // Add labels beside legend dots
        svg.selectAll("labels")
            .data(allgroups)
            .enter()
            .append("text")
            .attr("x", width - 200 + size*.8)
            .attr("y", function(d,i){ return 150 + i * (size + 5) }) // 100 is where the first dot appears. 25 is the distance between dots
            .style("fill", function(d){ return  myColor(d)})
            .text(function(d){ return d})
            .attr("text-anchor", "left")
            .style("alignment-baseline", "middle")
            // .on("mouseover", highlight)
            // .on("mouseleave", noHighlight)
    });