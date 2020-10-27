var margin = {top: 10, right: 30, bottom: 90, left: 100},
    width = 900 - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom;

var svg = d3.select("#my_dataviz")
  .append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform",
          "translate(" + margin.left + "," + margin.top + ")");

d3.csv("data/tag_count.csv", function(data) {

data.sort(function(b, a) {
  return a.count - b.count;
});

var x = d3.scaleLinear()
  .domain([0, 800000])
  .range([ 0, width]);
svg.append("g")
  .attr("transform", "translate(0," + height + ")")
  .call(d3.axisBottom(x))
  .selectAll("text")
    .attr("transform", "translate(-10,0)rotate(-45)")
    .style("text-anchor", "end");

  svg.append("text")             
  .attr("transform",
        "translate(" + (width/2) + " ," + 
                        (height + margin.top + 40) + ")")
  .style("text-anchor", "middle")
  .text("# of Games Associated");

var y = d3.scaleBand()
  .range([ 0, height ])
  .domain(data.map(function(d) { return d.tag; }))
  .padding(1);
svg.append("g")
  .call(d3.axisLeft(y))

svg.append("text")
  .attr("transform", "rotate(-90)")
  .attr("y", 0 - margin.left)
  .attr("x",0 - (height / 2))
  .attr("dy", "1em")
  .style("text-anchor", "middle")
  .text("SteamSpy Tag"); 

svg.selectAll("myline")
  .data(data)
  .enter()
  .append("line")
    .attr("x1", x(0))
    .attr("x2", x(0))
    .attr("y1", function(d) { return y(d.tag); })
    .attr("y2", function(d) { return y(d.tag); })
    .attr("stroke", "grey")

svg.selectAll("mycircle")
  .data(data)
  .enter()
  .append("circle")
    .attr("cx", x(0) )
    .attr("cy", function(d) { return y(d.tag); })
    .attr("r", "7")
    .style("fill", "#69b3a2")
    .attr("stroke", "black")

svg.selectAll("circle")
  .transition()
  .duration(2000)
  .attr("cx", function(d) { return x(d.count); })

svg.selectAll("line")
  .transition()
  .duration(2000)
  .attr("x1", function(d) { return x(d.count); })

})
