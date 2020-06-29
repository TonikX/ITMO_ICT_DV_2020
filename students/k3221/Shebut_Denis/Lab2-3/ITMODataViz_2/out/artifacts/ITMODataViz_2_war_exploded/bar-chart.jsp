<%--
  Created by IntelliJ IDEA.
  User: Denis
  Date: 20.05.2020
  Time: 13:56
  To change this template use File | Settings | File Templates.
--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="ru"><head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,minimum-scale=1,maximum-scale=10">
    <title>Лабораторная работа №2. ВИМ 1.2 Шебут Денис</title>
    <link rel="stylesheet" href="css/dataVisualizationStyle.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/kube/6.5.2/css/kube.css">
    <script src="https://d3js.org/d3.v4.js"></script>


</head>
<body>
<div class="content-wrapper">

    <header class="header">
        <p style="font-size: 30px; margin: 0; padding: 10px 1em;">Лабораторная работа №2.<br>
            Среднее ежечасное энергопотребление в течение недели</p>
    </header>

    <div class="container clearfix">
        <main class="content">
                <div id="my_graph">
            <script>
                var margin = {top: 30, right: 30, bottom: 70, left: 60},
                    width = 460 - margin.left - margin.right,
                    height = 400 - margin.top - margin.bottom;

                var svg = d3.select("#my_graph")
                    .append("svg")
                    .attr("width", width + margin.left + margin.right)
                    .attr("height", height + margin.top + margin.bottom)
                    .append("g")
                    .attr("transform",
                        "translate(" + margin.left + "," + margin.top + ")");

                d3.csv('data/mean_weekly_consumption.csv', function(data) {

                    var x = d3.scaleBand()
                        .range([ 0, width ])
                        .domain(data.map(function(d) { return d.Country; }))
                        .padding(0.1);
                    svg.append("g")
                        .attr("transform", "translate(0," + height + ")")
                        .call(d3.axisBottom(x))
                        .selectAll("text")
                        .attr("transform", "translate(-10,0)rotate(-45)")
                        .style("text-anchor", "end");

                    var y = d3.scaleLinear()
                        .domain([0, 130000])
                        .range([ height, 0]);
                    svg.append("g")
                        .call(d3.axisLeft(y));

                    svg.selectAll("bar")
                        .data(data)
                        .enter()
                        .append("rect")
                        .attr("x", function(d) { return x(d.Country); })
                        .attr("y", function(d) { return y(d.Value); })
                        .attr("width", x.bandwidth())
                        .attr("height", function(d) { return height - y(d.Value); })
                        .attr("fill", "#69b3a2")

                })

            </script>
        </div>

            <div id="my_graph2">
                <script>
                    // set the dimensions and margins of the graph
                    var margin = {top: 30, right: 30, bottom: 70, left: 60},
                        width = 460 - margin.left - margin.right,
                        height = 400 - margin.top - margin.bottom;

                    // append the svg object to the body of the page
                    var svg1 = d3.select("#my_graph2")
                        .append("svg")
                        .attr("width", width + margin.left + margin.right)
                        .attr("height", height + margin.top + margin.bottom)
                        .append("g")
                        .attr("transform",
                            "translate(" + margin.left + "," + margin.top + ")");

                    // Parse the Data
                    d3.csv('data/mean_daily_consumption.csv', function(data) {

// X axis
                        var x = d3.scaleBand()
                            .range([ 0, width ])
                            .domain(data.map(function(d) { return d.Hour; }))
                            .padding(0.1);
                        svg1.append("g")
                            .attr("transform", "translate(0," + height + ")")
                            .call(d3.axisBottom(x))
                            .selectAll("text")
                            .attr("transform", "translate(-10,0)rotate(-45)")
                            .style("text-anchor", "end");

// Add Y axis
                        var y = d3.scaleLinear()
                            .domain([0, 130000])
                            .range([ height, 0]);
                        svg1.append("g")
                            .call(d3.axisLeft(y));

// Bars
                        svg1.selectAll("bar2")
                            .data(data)
                            .enter()
                            .append("rect")
                            .attr("x", function(d) { return x(d.Hour); })
                            .attr("y", function(d) { return y(d.Energy); })
                            .attr("width", x.bandwidth())
                            .attr("height", function(d) { return height - y(d.Energy); })
                            .attr("fill", "#69b3a2")

                    })

                </script>
            </div>
        </main>

        <aside class="sidebar sidebar1">
            <p style="text-align: center;">
                <ul id="main_menu">
                    <li><a href="line-chart.jsp">Оценка периодичности в энергопотреблении за 5 лет</a></li>
                    <li><a href="mean-daily-line-chart.jsp">Оценка периодичности в энергопотреблении за 5 лет (среднее ежечасное енергопотребление по дням)</a></li>
                    <li>Среднее ежечасное энергопотребление в течение недели/дня</li>
                    <li><a href="square-chart.jsp">Суммарное энергопотребление по годам</a></li>
                    <li><a href="radial-diagram.jsp">Суммарное энергопотребление по часам за весь период наблюдений</a></li>
                    <li><a href="circle_diagramm.jsp">Суммарное энергопотребление по неделям года за весь период наблюдений</a></li>
                </ul>
            </p>
        </aside>
    </div>

    <footer class="footer">
        <p style="font-size: 30px; margin: 0; padding: 10px 1em;">2020 год. Шебут Денис ВИМ 1.2</p>
    </footer>

</div>

</body></html>

<!--  _____________________________________________________________________
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
  <meta charset="UTF-8"/>

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/kube/6.5.2/css/kube.css">
  <script src="https://d3js.org/d3.v3.min.js" charset="utf-8"></script>

  <style type="text/css">
    text {
        font-family: arial, serif;
      font-size: 12px;
    }

    .axis path,
    .axis line {
      fill: none;
      stroke: slategray;
      shape-rendering: crispEdges;
    }

    .focus circle {
      fill: none;
      stroke: steelblue;
    }

    .container {
      margin: auto;
      max-width: 1128px;
    }

    .svg-container {
      margin: 20px auto;
      max-width: 1128px;
      height: 500px;
    }
  </style>
</head>
<body>

<div class="container">
  <h1></h1>



  <p>
    Классическая столбчатая диаграмма оперирует горизонтальными или вертикальными столбцами для демонстрации
    дискретных, числовых сравнений между разными категориями.
  </p>
  <p>
    Источник: <a href="https://datavizcatalogue.com/RU/metody/stolbikovaja_diagramma.html" target="_blank">Каталог
    Визуализации
    Данных</a>
  </p>






  <p>
    Описание: диаграмма показывает...
  </p>
  <h2>Код</h2>

  <pre><code>
            const margin = {top: 20, right: 160, bottom: 35, left: 30};
            const width = 960 - margin.left - margin.right, height = 500 - margin.top - margin.bottom;
            const svg = d3.select("body")
                .append("div").attr("class", "svg-containter")
                .append("svg").attr("height", "100%").attr("width", width + margin.left + margin.right);

            const dateParse = d3.time.format("%Y-%m-%d").parse;

            d3.csv("data/covid.csv", function (error, data) {

                /**
                 * Преобразуем датасет в склееный массив
                 */
                const dataset = d3.layout.stack()(["cases", "discharged", "deceased"].map(function (covidCase) {
                    return data.map(function (d) {
                        return {x: dateParse(d.day), y: +d[covidCase]};
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
                    .domain([0, d3.max(dataset, function (d) {
                        return d3.max(d, function (d) {
                            return d.y0 + d.y;
                        });
                    })])
                    .range([height, 0]);

                const colors = ["#028ffa", "#00e395", "#feb019"];

                const yAxis = d3.svg.axis().scale(y).orient("left").ticks(10).tickSize(-width, 0, 0).tickFormat(function (d) {
                    return d
                });

                const xAxis = d3.svg.axis().scale(x).orient("bottom").tickFormat(d3.time.format("%d-%B"));

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
                });

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

                legend.append("text").attr("x", width + 5).attr("y", 9).attr("dy", ".35em").style("text-anchor", "start").text(function (d, i) {
                    switch (i) {
                        case 0:
                            return "Умерли";
                        case 1:
                            return "Вылечились";
                        case 2:
                            return "Заразились";
                    }
                });

                const tooltip = svg.append("g").attr("class", "tooltip").style("display", "none");
                tooltip.append("rect").attr("width", 30).attr("height", 20).attr("fill", "white").style("opacity", 0.5);
                tooltip.append("text").attr("x", 15).attr("dy", "1.2em").style("text-anchor", "middle").attr("font-size", "12px").attr("font-weight", "bold");
            });
    </code></pre>

</div>
</body>
</html>
-->