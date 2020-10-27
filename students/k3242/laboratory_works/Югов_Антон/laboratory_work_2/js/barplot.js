var margin = {top: 10, right: 30, bottom: 120, left: 100},
    width = 900 - margin.left - margin.right,
    height = 450 - margin.top - margin.bottom;


var svg = d3.select("#my_dataviz")
  .append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform",
          "translate(" + margin.left + "," + margin.top + ")");


d3.csv("data/top_developers_paid.csv", function(data) {


var x = d3.scaleBand()
  .range([ 0, width ])
  .domain(data.map(function(d) { return d.developer; }))
  .padding(0.3);
svg.append("g")
  .attr("transform", "translate(0," + height + ")")
  .call(d3.axisBottom(x))
  .selectAll("text")
    .attr("transform", "translate(-10,0)rotate(-45)")
    .style("text-anchor", "end");


var y = d3.scaleLinear()
  .domain([0, 260000000])
  .range([ height, 0]);
svg.append("g")
  .call(d3.axisLeft(y));


svg.append("text")
.attr("transform", "rotate(-90)")
.attr("y", 0 - margin.left)
.attr("x",0 - (height / 2))
.attr("dy", "1em")
.style("text-anchor", "middle")
.text("Owners");   


svg.selectAll("mybar")
  .data(data)
  .enter()
  .append("rect")
    .attr("x", function(d) { return x(d.developer); })
    .attr("width", x.bandwidth())
    .attr("fill", "#69b3a2")
    .attr("height", function(d) { return height - y(0); })
    .attr("y", function(d) { return y(0); })


svg.selectAll("rect")
  .transition()
  .duration(1000)
  .attr("y", function(d) { return y(d.owners); })
  .attr("height", function(d) { return height - y(d.owners); })
  .delay(function(d,i){console.log(i) ; return(i*100)})

})