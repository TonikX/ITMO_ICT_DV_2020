let margin = {top: 50, right: 50, bottom: 50, left: 50}

let width = 1000 - margin.left - margin.right
let height = 500 - margin.top - margin.bottom


let svg = d3.select("div")
    .append("svg")
    .attr("margin-left", $(window).width() / 2)
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")")


d3.csv("./data/master.csv", function (row) {
    row.year = Number(row.year)
    row.suicides_no = Number(row.suicides_no)
    return row;
}, function (data) {
    let countries = d3.map(data, function (d) {
        return (d.country)
    }).keys()
    let years = d3.map(data, function (d) {
        return d.year;
    }).keys()

    d3.select("#selectButton")
        .selectAll('myOptions')
        .data(countries)
        .enter()
        .append('option')
        .text(function (d) {
            return d;
        }) // text showed in the menu
        .attr("value", function (d) {
            return d;
        }) // corresponding value returned by the button


    let myColor = d3.scaleOrdinal()
        .domain(countries)
        .range(d3.schemeSet2);


    let x = d3.scaleLinear()
        .domain(d3.extent(years))
        .range([0, width]);

    svg.append("g")
        .attr("transform", "translate(0," + height + ")")
        .attr("class", "myXaxis")
        .call(d3.axisBottom(x));

    let y = d3.scaleLinear().range([height, 0]);
    let yAxis = d3.axisLeft().scale(y);
    svg.append("g").attr("class", "myYaxis")

    let data_f = data.filter(function (d) {
        return d.country === countries[0]
    })

    let dataset_f = []
    let k = 0;
    years.forEach((value, index) => {
        dataset_f.push({"year": Number(value), suicides_no: 0})
    })

    function sortByYear(arr) {
        arr.sort((a, b) => a.year > b.year ? 1 : -1);
    }

    sortByYear(dataset_f)

    data_f.forEach((data, index1) => {
        dataset_f.forEach((value, index2) => {
            if (data.year === value.year) {
                dataset_f[index2].suicides_no += data.suicides_no
            }
        })
    })


    y.domain([0, d3.max(dataset_f, function (d) {
        return d.suicides_no
    })]);
    svg.selectAll(".myYaxis")
        .transition()
        .duration(1000)
        .call(yAxis);

    let line = svg.append('g')
        .append("path")
        .datum(dataset_f)
        .attr("d", d3.line()
            .x(function (d) {
                return x(d.year)
            })
            .y(function (d) {
                return y(+d.suicides_no)
            })
        )
        .attr("stroke", function (d) {
            return myColor("valueA")
        })
        .style("stroke-width", 4)
        .style("fill", "none")


    function update(selectedGroup) {

        // Create new data with the selection?
        let dataFilter = data.filter(function (d) {
            return d.country === selectedGroup
        })

        let dataset = []
        let k = 0;
        years.forEach((value, index) => {
            dataset.push({"year": Number(value), suicides_no: 0})
        })

        function sortByYear(arr) {
            arr.sort((a, b) => a.year > b.year ? 1 : -1);
        }

        sortByYear(dataset)

        dataFilter.forEach((data, index1) => {
            dataset.forEach((value, index2) => {
                if (data.year === value.year) {
                    dataset[index2].suicides_no += data.suicides_no
                }
            })
        })

        console.log(dataset)

        y.domain([0, d3.max(dataset, function (d) {
            return d.suicides_no
        })]);
        svg.selectAll(".myYaxis")
            .transition()
            .duration(1000)
            .call(yAxis);


        line.datum(dataset)
            .transition()
            .duration(1000)
            .attr("d", d3.line()
                .x(function (d) {
                    return x(d.year)
                })
                .y(function (d) {
                    return y(+d.suicides_no)
                })
            )
            .attr("stroke", function (d) {
                return myColor(selectedGroup)
            })
    }


    d3.select("#selectButton").on("change", function (d) {
        let selectedOption = d3.select(this).property("value")
        update(selectedOption)
    })
});