<%--
  Created by IntelliJ IDEA.
  User: Denis
  Date: 25.06.2020
  Time: 22:34
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
            Суммарное энергопотребление по неделям года за весь период наблюдений</p>
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

                var radius2= Math.min(width, height) / 2 - margin + margin*6.05


                var svg = d3.select("#my_graph")
                    .append("svg")
                    .attr("width", width)
                    .attr("height", height)
                    .append("g")
                    .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

                // Create dummy data
                var data = {1:85907086.0,
                    2      :86096481.0,
                    3      :84210796.0,
                    4      :81832897.0,
                    5      :84022500.0,
                    6      :83948032.0,
                    7      :81466439.0,
                    8      :77826996.0,
                    9      :79783155.0,
                    10     :76623680.0,
                    11     :74310272.0,
                    12     :71937544.0,
                    13     :70606806.0,
                    14     :68700167.0,
                    15     :65626902.0,
                    16     :65129305.0,
                    17     :64773862.0,
                    18     :64821839.0,
                    19     :66033164.0,
                    20     :68799208.0,
                    21     :69840963.0,
                    22     :79030709.0,
                    23     :86315422.0,
                    24     :95263275.0,
                    25     :99216597.0,
                    26     :98844682.0,
                    27     :98360258.0,
                    28    :104475346.0,
                    29    :107426508.0,
                    30    :101752753.0,
                    31     :92389300.0,
                    32     :83471016.0,
                    33     :82085074.0,
                    34     :82789967.0,
                    35     :79213870.0,
                    36     :80735753.0,
                    37     :75753458.0,
                    38     :72899107.0,
                    39     :67740579.0,
                    40     :68184633.0,
                    41     :65545038.0,
                    42     :65448266.0,
                    43     :66098762.0,
                    44     :66466503.0,
                    45     :68653260.0,
                    46     :71450794.0,
                    47     :73154215.0,
                    48     :72720944.0,
                    49     :77286320.0,
                    50     :81743299.0,
                    51     :77590874.0,
                    52     :74990696.0,
                    53     :14180697.0}


                var color = d3.scaleOrdinal()
                    .domain(data)
                    .range(d3.schemeSet2);


                var pie = d3.pie()
                    .value(function(d) {return d.value; })
                var data_ready = pie(d3.entries(data))


                var arcGenerator = d3.arc()
                    .innerRadius(0)
                    .outerRadius(radius)

                var arcGenerator2 = d3.arc()
                    .innerRadius(1)
                    .outerRadius(radius2)

                svg
                    .selectAll('mySlices')
                    .data(data_ready)
                    .enter()
                    .append('path')
                    .attr('d', arcGenerator)
                    .attr('fill', function(d){ return(color(d.data.key)) })
                    .attr("stroke", "black")
                    .style("stroke-width", "2px")
                    .style("opacity", 0.7)

                svg
                    .selectAll('mySlices')
                    .data(data_ready)
                    .enter()
                    .append('text')
                    .text(function(d){ return  d.data.key})
                    .attr("transform", function(d) { return "translate(" + arcGenerator2.centroid(d) + ")";  })
                    .style("text-anchor", "middle")
                    .style("font-size", 15)


            </script>
            </div>

            </p>
        </main>

        <aside class="sidebar sidebar1">
            <p style="text-align: center;">
            <ul id="main_menu">
            <li><a href="line-chart.jsp">Оценка периодичности в энергопотреблении за 5 лет</a></li>
            <li><a href="mean-daily-line-chart.jsp">Оценка периодичности в энергопотреблении за 5 лет (среднее ежечасное енергопотребление по дням)</a></li>
            <li><a href="bar-chart.jsp">Среднее ежечасное энергопотребление в течение дня/недели</a></li>
            <li><a href="square-chart.jsp">Суммарное энергопотребление по годам</a></li>
            <li><a href="radial-diagram.jsp">Суммарное энергопотребление по часам за весь период наблюдений</a></li>
            <li>Суммарное энергопотребление по неделям года за весь период наблюдений</li>
            </ul>
            </p>
        </aside>
    </div>

    <footer class="footer">
        <p style="font-size: 30px; margin: 0; padding: 10px 1em;">2020 год. Шебут Денис ВИМ 1.2</p>
    </footer>

</div>

</body></html>