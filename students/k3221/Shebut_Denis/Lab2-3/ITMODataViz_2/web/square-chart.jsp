<%--
  Created by IntelliJ IDEA.
  User: Denis
  Date: 25.06.2020
  Time: 17:43
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
            Суммарное энергопотребление по годам</p>
    </header>

    <div class="container clearfix">
        <main class="content">
            <p class="graph" style="text-align: center; font-size: 30px; margin: 0; padding: 1.5em 0;">
            <div id="my_graph">
            <script>

                var margin = {top: 10, right: 10, bottom: 10, left: 10},
                    width = 445 - margin.left - margin.right,
                    height = 445 - margin.top - margin.bottom;

                var svg = d3.select("#my_graph")
                    .append("svg")
                    .attr("width", width + margin.left + margin.right)
                    .attr("height", height + margin.top + margin.bottom)
                    .append("g")
                    .attr("transform",
                        "translate(" + margin.left + "," + margin.top + ")");

                d3.csv('data/years_sum_correct.csv', function(data) {

                    var root = d3.stratify()
                        .id(function(d) { return d.name; })
                        .parentId(function(d) { return d.parent; })
                        (data);
                    root.sum(function(d) { return +d.value })


                    d3.treemap()
                        .size([width, height])
                        .padding(4)
                        (root)

                    console.log(root.leaves())
                    svg
                        .selectAll("rect")
                        .data(root.leaves())
                        .enter()
                        .append("rect")
                        .attr('x', function (d) { return d.x0; })
                        .attr('y', function (d) { return d.y0; })
                        .attr('width', function (d) { return d.x1 - d.x0; })
                        .attr('height', function (d) { return d.y1 - d.y0; })
                        .style("stroke", "black")
                        .style("fill", "#a700b3");

                    svg
                        .selectAll("text")
                        .data(root.leaves())
                        .enter()
                        .append("text")
                        .attr("x", function(d){ return d.x0+10})
                        .attr("y", function(d){ return d.y0+20})
                        .text(function(d){ return d.data.name})
                        .attr("font-size", "15px")
                        .attr("fill", "white")
                })
            </script>
            </div>

            </p>
        </main>

        <aside class="sidebar sidebar1">
            <p style="text-align: center;">
            <ul id="main_menu">
            <li><a href="line-chart.jsp">Оценка периодичности в энергопотреблении за 5 лет</a></li>
            <li><a href="mean-daily-line-chart.jsp">Оценка периодичности в энергопотреблении за 5 лет (среднее ежечасное енергопотребление по дням)</a></li>
            <li><a href="bar-chart.jsp">Среднее ежечасное энергопотребление в течение дня/недели</a href="bar-chart.jsp"></li>
            <li>Суммарное энергопотребление по годам</li>
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
