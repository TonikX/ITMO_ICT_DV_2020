const margin = {top: 20, right: 160, bottom: 35, left: 30};
const width = 960 - margin.left - margin.right, height = 500 - margin.top - margin.bottom;
const xNudge = 50, yNudge = 20;

books = d3.csv("data/books.csv")
books.row(function (d) {
    return {
        rating: Number(d.average_rating),
        ratings_count: Number(d.text_reviews_count),
    };
})
    .get(function (error, rows) {

        data = Object(rows).map(function (a) {
            return { rating: a.rating, ratings_count: a.ratings_count - a.ratings_count%1000};
        });
        const same_ratings_count = {}
        const unique_ratings_count_data = data.filter((el, i , arr) =>
            arr.indexOf(
                arr.find(find_el =>
                    find_el.ratings_count === el.ratings_count
                )
            ) === i
        )
        for (let unique_ratings_count_element of unique_ratings_count_data) {
            const same_ratings_array = data.filter(data_el =>
                data_el.ratings_count === unique_ratings_count_element.ratings_count
            )
            same_ratings_count[unique_ratings_count_element.ratings_count] = [0,1,2,3,4,5].map(el =>
                    same_ratings_array.filter(arr_el => Math.round(arr_el.rating) === el).length
            )
        }
        data = data.sort(
            (a, b) =>
                same_ratings_count[a.ratings_count].reduce((r_a, r_b) => r_a + r_b)
                - same_ratings_count[b.ratings_count].reduce((r_a, r_b) => r_a + r_b)
        );

        const svg = d3.select("h2").append("div").attr("class", "svg-containter").append("svg")
            .attr("height", "100%").attr("width", width + margin.left + margin.right)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

        let arr = []
        for (let i = 0; i < 10000; i += 1000)
            arr.push(i);

        const y = d3.scaleBand().range([height, 0]).domain([0,1,2,3,4,5]).padding(0.01);
        const x = d3.scaleBand().range([0, width]).domain(arr).padding(0.01);
        svg.append("g")
            .call(d3.axisLeft(y));
        svg.append("g")
            .attr("transform", "translate(0," + height + ")")
            .call(d3.axisBottom(x));

        const myColor = d3.scaleLinear()
            .range(["#87CEEB", "#DC143C"])
            .domain([0,100])
        console.log(same_ratings_count)
        Object.keys(same_ratings_count).slice(0,arr.length).forEach((key) => {
            svg.selectAll()
                .data(same_ratings_count[key].map((el, index) => ({books: el, rating: index})))
                .enter()
                .append("rect")
                .attr("x", function(d) { return x(key) })
                .attr("y", function(d) { return y(d.rating) })
                .attr("width", x.bandwidth() )
                .attr("height", y.bandwidth() )
                .style("fill", function(d) { return myColor(d.books || -10)} )
        })


    });