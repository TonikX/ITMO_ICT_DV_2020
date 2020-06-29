<%--
  Created by IntelliJ IDEA.
  User: Denis
  Date: 24.06.2020
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>Лабораторная работа №3. Шебут Денис ВИМ 1.2</title>
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <link href="css/dataVisualizationStyle.css" rel="stylesheet">
</head>

<body>

<div class="wrapper">

    <header class="header">
        <div id="demotext" align="center"><h1>Анализ энергопотребления восточного региона США
        06.2013-08.2018</h1></div>
    </header><!-- .header-->

    <main class="content_landing">
        <div align="center">
            <p align="left"> О датасете - <a>https://www.kaggle.com/robikscube/hourly-energy-consumption/data</a><br>
                В датасете представлены данные о почасовом потреблении электроэнергии (МВт) в США<br>
                Данные разделены по компаниям, предоставляющим услги электроснабжения в разных регионах страны<br>
                Данные от каждой компании охватывают свой период наблюдений<br>
                Однако все они охватываю перод с 2013 по 2018 гг.(кроме PJM_load - 1998 - 2002 гг. и NI - 2004 - 2011 гг.)<br>
                Структура данных в датасете:<br>
                <b>
                    RangeIndex: 178262 entries, 0 to 178261<br>
                    Data columns (total 13 columns):<br>
                    #   Column    Non-Null Count   Dtype<br>
                    ---  ------    --------------   -----<br>
                    0   Datetime  178262 non-null  object<br>
                    1   AEP       121273 non-null  float64<br>
                    2   COMED     66497 non-null   float64<br>
                    3   DAYTON    121275 non-null  float64<br>
                    4   DEOK      57739 non-null   float64<br>
                    5   DOM       116189 non-null  float64<br>
                    6   DUQ       119068 non-null  float64<br>
                    7   EKPC      45334 non-null   float64<br>
                    8   FE        62874 non-null   float64<br>
                    9   NI        58450 non-null   float64<br>
                    10  PJME      145366 non-null  float64<br>
                    11  PJMW      143206 non-null  float64<br>
                    12  PJM_Load  32896 non-null   float64<br>
                </b>
                Перед началом работы с данными было выдвинуто 4 гипотезы:<br>
            </p>
                <ul >
                    <li>В выходные дни (суббота, воскресенье - 5,6 дни недели) среднее энергопотребление падает по сравнению с рабочей неделей (+)</li>
                    <li>Среднесуточное энергопотребление в летний период ниже, чем в другие времена года (-)</li>
                    <li>Энергопотребление в среднем растет из года в год (-)</li>
                    <li>Пик энергопотребления приходится на время после окончания рабочего дня (17:00 - 23:00) (+)</li>
                </ul>
            <p align="left">
                Затем была начата подготовка данных. В первую очередь было выяснено, что представленные метрики описывают один
                и тот же часовой пояс.
                <br>
                <br>
                Сначала проверим гипотезу об изменении тенденции энргопотребления из года в год. Для этого найдем сумму наших метрик,
                описывающих один регион, находящийся в одном часовом поясе. Запишем результат в новый столбец energy_total_east.
                Найдем среднее энергопотребление в час по каждому дню. Эта характеристика будет основной на нашем первом графике.
            </p>


            <iframe title="Среднее энергопотребление восточного региона США в час по дням. Июль 2013 - Август 2018гг." aria-label="Interactive area chart" id="datawrapper-chart-YquoQ" src="https://datawrapper.dwcdn.net/YquoQ/2/" scrolling="no" frameborder="0" style="width: 0; min-width: 100% !important; border: none;" height="504"></iframe>
            <script type="text/javascript">!function(){"use strict";
            window.addEventListener("message",(function(a){if(void 0!==a.data["datawrapper-height"])
                for(var e in a.data["datawrapper-height"]){var t=document.getElementById("datawrapper-chart-"+e)||document.querySelector("iframe[src*='"+e+"']");
                    t&&(t.style.height=a.data["datawrapper-height"][e]+"px")}}))}();
            </script>
            <p>
                <b>
                Максимумы энергопотребления приходятся на: <br>
                    <i>
                (-1-)  2013/06/12---2013/08/29 (~79 дней)<br>
                (-2-)  2013/12/10---2014/03/04 (~85 дней)<br>
                (-3-)  2014/06/14---2014/09/09 (~88 дней)<br>
                (-4-)  2015/01/01---2015/03/06 (~65 дней)<br>
                (-5-)  2015/06/08---2015/09/14 (~99 дней)<br>
                (-6-)  2015/12/29---2016/03/02 (~65 дней)<br>
                (-7-)  2016/06/10---2016/09/21 (~104 дней)<br>
                (-8-)  2016/12/02---2017/03/24 (~113 дней)<br>
                (-9-)  2017/06/04---2017/08/26 (~84 дней)<br>
                (-10-) 2017/11/26---2018/03/23 (~118 дней)<br>
                (-11-) 2018/06/01---2018/08/01 (~62 дней - конец периода наблюдений)<br>
                    </i>
                </b>
            </p>
            <p align="left">
                Количественного роста энергопотребления не наблюдается. Можно заметить некоторое увеличение длительности
                максимумов. Однако, как мне кажется, так как разметка промежутков производилась вручную, сказать что-то определенное
                об изменении их длительности нельзя. Изменение находится в пределах погрешности.
            </p>

            <p align="left">
                Чтобы проверить гипотезу №2, отобразим второй график, на котором среднее энергопотребление в час по дням
                в разные года можно сопоставить более наглядно. Также выделим промежутками времена года.
            </p>

            <iframe title="Среднее энергопотребление восточного региона США в час по дням. Июль 2013 - Август 2018гг." aria-label="Interactive line chart" id="datawrapper-chart-jnGH0" src="https://datawrapper.dwcdn.net/jnGH0/1/" scrolling="no" frameborder="0" style="width: 0; min-width: 100% !important; border: none;" height="400"></iframe>
            <script type="text/javascript">!function(){
                "use strict";
                window.addEventListener("message",(function(a){if(void 0!==a.data["datawrapper-height"])
                    for(var e in a.data["datawrapper-height"]){
                        var t=document.getElementById("datawrapper-chart-"+e)||document.querySelector("iframe[src*='"+e+"']");
                        t&&(t.style.height=a.data["datawrapper-height"][e]+"px")}}))}();
            </script>

            <p align="left"> Распределение значений в исхожных данных по годам:</p>
            <table border= "0">
                <tr align="center">
                    <td ><img width="300px" height="210px" src="data/images/2013.PNG">
                     <p> 2013 год</p></td>
                    <td><img width="300px" height="210px" src="data/images/2014.PNG">
                        <p> 2014 год</p></td>
                    <td><img width="300px" height="210px" src="data/images/2015.PNG">
                        <p> 2015 год</p></td>
                </tr>
                <tr align="center">
                    <td><img width="300px" height="210px" src="data/images/2016.PNG">
                        <p> 2016 год</p></td>
                    <td> <img  width="300px" height="210px" src="data/images/2017.PNG">
                        <p> 2017 год</p></td>
                    <td> <img width="300px" height="210px" src="data/images/2018.PNG">
                        <p> 2018 год</p></td>
                </tr>
            </table>
            <p align="left">
                Занимательный факт. Если взглянуть внимательнее на распределение значений, то видно, что 2016 год
                выделяется отклонением в сторону больших значений (для 2013 и 2018 годов предоставлены данные только
                по первому и второму полугодию соответсвенно). Предположительно, такое отклонение вызвано тем, что в какие-то определенные
                дни энергопотребление резко возрастало и таких дней было больше чем обычно. Можно попробовать объяснить данное отклонение
                президентскими выборами в США в 2016 году.
            </p>
            <p align="left">
                Чтобы проверить гипотезу №4, посчитаем среднее энергопотребление в каждый час дня. Для этого сгруппируем
                наши данные по номеру часа в сутках и посчитаем среднее значение.
            </p>

            <iframe title="Среднее энергопотребление в час восточного региона США. Ночь-Утро-День-Вечер" aria-label="chart" id="datawrapper-chart-nRw1Q" src="https://datawrapper.dwcdn.net/nRw1Q/1/" scrolling="no" frameborder="0" style="width: 0;
        min-width: 100% !important; border: none;" height="621">
            </iframe>
            <script type="text/javascript">!function(){
                "use strict";
                window.addEventListener("message",(function(a){if(void 0!==a.data["datawrapper-height"])
                    for(var e in a.data["datawrapper-height"]){
                        var t=document.getElementById("datawrapper-chart-"+e)||document.querySelector("iframe[src*='"+e+"']");
                        t&&(t.style.height=a.data["datawrapper-height"][e]+"px")}}))}();
            </script>

            <p align="left"> Отчетливо видно, что максимум энергопотребления приходится на 18-19 часов вечера, а минимум на 3-5 часов ночи.</p>
            <p align="left"> Теперь, чтобы проверить гипотезу №1, проведем те же манипуляции, но сгруппировав исходные данные по дню недели:</p>

            <iframe title="Среднее энергопотребление в час восточного региона США. По дням недели" aria-label="chart" id="datawrapper-chart-edWRL" src="https://datawrapper.dwcdn.net/edWRL/2/" scrolling="no" frameborder="0" style="width: 0; min-width: 100% !important; border: none;" height="400"></iframe>
            <script type="text/javascript">!function(){
                "use strict";
            window.addEventListener("message",(function(a){
                if(void 0!==a.data["datawrapper-height"])
                    for(var e in a.data["datawrapper-height"]){
                        var t=document.getElementById("datawrapper-chart-"+e)||document.querySelector("iframe[src*='"+e+"']");
                        t&&(t.style.height=a.data["datawrapper-height"][e]+"px")}}))}();
        </script>

            <p align="left"> По столбчатой диагрмме видно, что среднее энергпотребление в час в выходные дни меньше чем в будние дни</p>

            <p align="left"> Чтобы получить более полное представление об исходных данных и выявить величину колебаний энергопотребления
            в течение дня, построим дополнительно пятый график. Разобъем исходные данные по годам, сгруппируем по номеру
            дня в году и найдем минимальное и максимальное значения электропотребления в час. Затем склеим данные и
            отобразим на графике:</p>

            <iframe title="Сравнение максимумов и  минимумов энергопотребления восточного региона США в час по дням" aria-label="Interactive area chart" id="datawrapper-chart-AlI30" src="https://datawrapper.dwcdn.net/AlI30/1/" scrolling="no" frameborder="0" style="width: 0; min-width: 100% !important; border: none;" height="484"></iframe>
            <script type="text/javascript">!function(){"use strict";
                window.addEventListener("message",(function(a){if(void 0!==a.data["datawrapper-height"])
                    for(var e in a.data["datawrapper-height"]){
                        var t=document.getElementById("datawrapper-chart-"+e)||document.querySelector("iframe[src*='"+e+"']");
                        t&&(t.style.height=a.data["datawrapper-height"][e]+"px")}}))}();
            </script>
            <p>
                <br>
                <br>
            </p>
            <table border= "0">
                <tr align="center">
                    <td ><img width="350px" height="230px" src="data/images/maxes.PNG">
                        <p> Распределение значений максимумов</p></td>
                    <td><img width="350px" height="230px" src="data/images/mins.PNG">
                        <p> Распределение значений минимумов</p></td>
                </tr>
            </table>

            <p align="left"> Из этого графика мы можем узнать еще одну особенность исходных данных. Видно, что наибольшая разница между максимумами
            и минимумами наблюдается в (+-) летний период. Учитывая ранее выясненные закономерности, можно предположить, что в теплый период
            года дневное энергопотребление в будние дни заметно выше чем в остальное время года.
            <br>
            <br></p>
        </div>
    </main>

    <footer class="footer">
        Шебут Денис ВИМ 1.2
    </footer>

</div><!-- .wrapper -->

</body>
</html>
