<%--
  Created by IntelliJ IDEA.
  User: Denis
  Date: 25.06.2020
  Time: 21:59
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
    <script src="https://d3js.org/d3-scale-chromatic.v1.min.js"></script>


</head>
<body>
<div class="content-wrapper">

    <header class="header">
        <p style="font-size: 30px; margin: 0; padding: 10px 1em;">Лабораторная работа №2.<br>
            Суммарное энергопотребление по часам за весь период наблюдений</p>
    </header>

    <div class="container clearfix">
        <main class="content">
            <p class="graph" style="text-align: center; font-size: 30px; margin: 0; padding: 1.5em 0;">
            <div id="my_graph">
            <script>

                var width = 450
                height = 450
                margin = 40

                var radius = Math.min(width, height) / 2 - margin

                var svg = d3.select("#my_graph")
                    .append("svg")
                    .attr("width", width)
                    .attr("height", height)
                    .append("g")
                    .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

                var data = {0: 160204145.0 ,1:150717605.0, 2: 144905583.0,
                    3:140892789.0,
                    4: 139860661.0, 5:141366371.0, 6:147712565.0,
                    7:158610537.0, 8:167245096.0, 9:172292420.0,
                    10:176176780.0,11:179512389.0, 12:181736707.0,
                    13:183230785.0, 14:184433522.0, 15: 185105801.0,
                    16:185808895.0, 17:187932966.0, 18:191302963.0,
                    19:191753109.0, 20:190129505.0, 21:188071834.0,
                    22:182603712.0, 23:171969329.0, }

                var color = d3.scaleOrdinal()
                    .domain(["0","1","2","3",
                        "4","5","6","7","8","9",
                        "10","11","12","13","14","15","16","17",
                        "18","19","20","21","22","23"])
                    .range(d3.schemeDark2);

                var pie = d3.pie()
                    .sort(null)
                    .value(function(d) {return d.value; })
                var data_ready = pie(d3.entries(data))

                var arc = d3.arc()
                    .innerRadius(radius * 0.5)
                    .outerRadius(radius * 0.8)

                var outerArc = d3.arc()
                    .innerRadius(radius * 0.9)
                    .outerRadius(radius * 0.9)

                svg
                    .selectAll('allSlices')
                    .data(data_ready)
                    .enter()
                    .append('path')
                    .attr('d', arc)
                    .attr('fill', function(d){ return(color(d.data.key)) })
                    .attr("stroke", "white")
                    .style("stroke-width", "2px")
                    .style("opacity", 0.7)

                svg
                    .selectAll('allPolylines')
                    .data(data_ready)
                    .enter()
                    .append('polyline')
                    .attr("stroke", "black")
                    .style("fill", "none")
                    .attr("stroke-width", 1)
                    .attr('points', function(d) {
                        var posA = arc.centroid(d) // line insertion in the slice
                        var posB = outerArc.centroid(d) // line break: we use the other arc generator that has been built only for that
                        var posC = outerArc.centroid(d); // Label position = almost the same as posB
                        var midangle = d.startAngle + (d.endAngle - d.startAngle) / 2 // we need the angle to see if the X position will be at the extreme right or extreme left
                        posC[0] = radius * 0.95 * (midangle < Math.PI ? 1 : -1); // multiply by 1 or -1 to put it on the right or on the left
                        return [posA, posB, posC]
                    })

                svg
                    .selectAll('allLabels')
                    .data(data_ready)
                    .enter()
                    .append('text')
                    .text( function(d) { console.log(d.data.key) ; return d.data.key } )
                    .attr('transform', function(d) {
                        var pos = outerArc.centroid(d);
                        var midangle = d.startAngle + (d.endAngle - d.startAngle) / 2
                        pos[0] = radius * 0.99 * (midangle < Math.PI ? 1 : -1);
                        return 'translate(' + pos + ')';
                    })
                    .style('text-anchor', function(d) {
                        var midangle = d.startAngle + (d.endAngle - d.startAngle) / 2
                        return (midangle < Math.PI ? 'start' : 'end')
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
            <li><a href="bar-chart.jsp">Среднее ежечасное энергопотребление в течение дня/недели</li>
            <li><a href="square-chart.jsp">Суммарное энергопотребление по годам</a></li>
            <li>Суммарное энергопотребление по часам за весь период наблюдений</li>
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