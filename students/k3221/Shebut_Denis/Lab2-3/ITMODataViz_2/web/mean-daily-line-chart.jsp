<%--
  Created by IntelliJ IDEA.
  User: Denis
  Date: 20.06.2020
  Time: 0:44
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="ru"><head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,minimum-scale=1,maximum-scale=10">
    <title>Лабораторная работа №2. ВИМ 1.2 Шебут Денис</title>
    <link rel="stylesheet" href="css/dataVisualizationStyle.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/kube/6.5.2/css/kube.css">
    <script src="https://d3js.org/d3.v3.min.js" charset="utf-8"></script>


</head>
<body>
<div class="content-wrapper">

    <header class="header">
        <p style="font-size: 30px; margin: 0; padding: 10px 1em;">Лабораторная работа №2.<br>
            Оценка периодичности в энергопотреблении за 5 лет (среднее ежечасное енергопотребление по дням)</p>
    </header>

    <div class="container clearfix">
        <main class="content">
            <p class="graph" style="text-align: center; font-size: 30px; margin: 0; padding: 1.5em 0;">
                <h2>
            <script type="text/javascript">

                const parseDate = d3.time.format("%Y-%m-%d").parse;
                const margin = {top: 20, right: 20, bottom: 35, left: 30};
                const width = 750 - margin.left - margin.right, height = 500- margin.top - margin.bottom;
                const xNudge = 50, yNudge = 20;
                let max = 0;
                let min = 0;
                let minDate = new Date(), maxDate = new Date();
                let preTotal = 0;
                d3.csv("data/mean_hourly_consumption.csv")
                    .row(function (d) {
                        return {
                            Datetime: parseDate(d.Datetime),
                            energy_total_east: d.energy_total_east,
                        };
                    })
                    .get(function (error, rows) {
                        console.log(rows);

                        max = d3.max(rows, function (d) {
                            return d.energy_total_east;
                        });
                        min = d3.min(rows, function (d) {
                            return d.energy_total_east;
                        });
                        minDate = d3.min(rows, function (d) {
                            return d.Datetime;
                        });
                        maxDate = d3.max(rows, function (d) {
                            return d.Datetime;
                        });

                        const y = d3.scale.linear().domain([60000, 140000]).range([height, 0]);
                        const x = d3.time.scale().domain([minDate, maxDate]).range([0, width]);

                        const yAxis = d3.svg.axis().orient("left").scale(y);
                        const xAxis = d3.svg.axis().scale(x).orient("bottom").tickFormat(d3.time.format("%Y-%m-%d"));

                        let line = d3.svg.line().x(function (d) {
                            return x(d.Datetime);
                        }).y(function (d) {
                            return y(d.energy_total_east);
                        }).interpolate("cardinal");

                        const svg = d3.select("h2").append("div").attr("class", "svg-container").append("svg").attr("height", "100%").attr("width", width + margin.left + margin.right);

                        let chartGroup = svg.append("g").attr("class", "chartGroup").attr("transform", "translate(" + xNudge + "," + yNudge + ")");

                        chartGroup.append("path").attr("class", "line").attr("d", function (d) {
                            return line(rows);
                        });
                        chartGroup.append("g").attr("class", "axis x").attr("transform", "translate(0," + height + ")").call(xAxis);
                        chartGroup.append("g").attr("class", "axis y").call(yAxis);
                    });
            </script>
                </h2>

            </p>



        </main>

        <aside class="sidebar sidebar1">
            <p style="text-align: center;">
            <ul id="main_menu">
            <li><a href="line-chart.jsp">Оценка периодичности в энергопотреблении за 5 лет</a></li>
            <li>Оценка периодичности в энергопотреблении за 5 лет (среднее ежечасное енергопотребление по дням)</li>
            <li><a href="bar-chart.jsp">Среднее ежечасное энергопотребление в течение дня/недели</a></li>
            <li><a href="square-chart.jsp">Суммарное энергопотребление по годам</a></li>
            <li><a href="radial-diagram.jsp">Суммарное энергопотребление по часам за весь период наблюдений</a></li>
            <li><a href="circle_diagramm.jsp">Суммарное энергопотребление по неделям года за весь период наблюдений</a></li>
            </ul>
            </p>
        </aside>
    </div>

    <footer class="footer">
        <p style="font-size: 30px; margin: 0; padding: 10px 1em;"> 2020 год. Шебут Денис ВИМ 1.2</p>
    </footer>

</div>

</body></html>

<!--
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8"/>
    <title>D3.js — samples</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/kube/6.5.2/css/kube.css">
    <script src="https://d3js.org/d3.v3.min.js" charset="utf-8"></script>

    <style type="text/css">
        text {
            font-family: arial;
            font-size: 12px;
        }

        path.line {
            fill: none;
            stroke: #ff9044;
            stroke-width: 3px;
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

        .containter {
            margin: auto;
            max-width: 1128px;
        }

        .svg-containter {
            margin: 20px auto;
            max-width: 1128px;
            height: 500px;
        }
    </style>
</head>
<body>

<div class="containter">
    <h1>Лабораторная работа №2. Энергопотребление восточного региона США</h1>

    <ul>
        <li>Оценка периодичности в энергопотреблении за 5 лет</li>
        <li>Оценка периодичности в энергопотреблении за 5 лет (среднее ежечасное енергопотребление по дням)</li>
        <li><a href="bar-chart.jsp">Среднее ежечасное энергопотребление в течение дня/недели</a></li>
        <li><a href="zoomable-bar-chart.jsp">Zoomable bar chart</a></li>
    </ul>

    <p>
        Линейные графики используются для отображения количественных показателей за непрерывный интервал или
        определенный период времени.
    </p>
    <p>
        Источник: <a href="https://datavizcatalogue.com/RU/metody/linejnyj_grafik.html" target="_blank">Каталог
        Визуализации
        Данных</a>
    </p>

    <h2>Диаграмма</h2>

    <script type="text/javascript">
        //alert("jjjjj");
        const parseDate = d3.time.format("%Y-%m-%d").parse;
        const margin = {top: 20, right: 20, bottom: 35, left: 30};
        const width = 960 - margin.left - margin.right, height = 500- margin.top - margin.bottom;
        const xNudge = 50, yNudge = 20;
        let max = 0;
        let min = 0;
        let minDate = new Date(), maxDate = new Date();
        let preTotal = 0;
        d3.csv("data/mean_hourly_consumption.csv")
            .row(function (d) {
                return {
                    Datetime: parseDate(d.Datetime),
                    energy_total_east: d.energy_total_east,
                };
            })
            .get(function (error, rows) {
                console.log(rows);

                max = d3.max(rows, function (d) {
                    return d.energy_total_east;
                });
                min = d3.min(rows, function (d) {
                    return d.energy_total_east;
                });
                minDate = d3.min(rows, function (d) {
                    return d.Datetime;
                });
                maxDate = d3.max(rows, function (d) {
                    return d.Datetime;
                });

                const y = d3.scale.linear().domain([40000, 160000]).range([height, 0]);
                const x = d3.time.scale().domain([minDate, maxDate]).range([0, width]);

                const yAxis = d3.svg.axis().orient("left").scale(y);
                const xAxis = d3.svg.axis().scale(x).orient("bottom").tickFormat(d3.time.format("%Y-%m-%d"));

                let line = d3.svg.line().x(function (d) {
                    return x(d.Datetime);
                }).y(function (d) {
                    return y(d.energy_total_east);
                }).interpolate("cardinal");

                const svg = d3.select("h2").append("div").attr("class", "svg-containter").append("svg").attr("height", "100%").attr("width", width + margin.left + margin.right);

                let chartGroup = svg.append("g").attr("class", "chartGroup").attr("transform", "translate(" + xNudge + "," + yNudge + ")");

                chartGroup.append("path").attr("class", "line").attr("d", function (d) {
                    return line(rows);
                });
                chartGroup.append("g").attr("class", "axis x").attr("transform", "translate(0," + height + ")").call(xAxis);
                chartGroup.append("g").attr("class", "axis y").call(yAxis);
            });
    </script>


    <h2>Код</h2>

</div>
</body>
</html>