$(document).ready(visualizetree);

function visualizetree() {

    // Create a svg canvas
    var vis = d3.select("#treeviz").append("svg:svg")
                                   .attr("class","svg_container")
                                   .attr("width", 1000)
                                   .attr("height", 860)
                                   .style("overflow", "scroll")
                                   .append("svg:g")
                                   .attr("transform", "translate(40, 0)"); // shift everything to the right  
    
    // Create a tree "canvas"
    var tree = d3.layout.tree()
                 .nodeSize([100, 150]);
                 
    var diagonal = d3.svg.diagonal()
    
    // change x and y (for the left to right tree)
    .projection(function(d) { return [d.y, d.x]; });
    
    var trees = new Array(gon.jsontrees.length);
    var nodes = new Array(gon.jsontrees.length);
    var links = new Array(gon.jsontrees.length);
    
    var translate = 0;
    
    for (var i = 0; i < gon.jsontrees.length; i++)
    {
        if (i == 0)
        {
            trees[i] = vis.append("g");
        }
        else
        {
            trees[i] = vis.append("g").attr("transform", "translate(0," + translate + ")");
        }
        
        // Preparing the data for the tree layout, convert data into an array of nodes
        nodes[i] = tree.nodes(gon.jsontrees[i]);
        // Create an array with all the links
        links[i] = tree.links(nodes[i]);
        
        // Find the node in the current tree with the biggest x value
        var transx = -1;
        for (var j = 0; j < nodes[i].length; j++)
        {
           if (nodes[i][j].x > transx)
           {
               transx = nodes[i][j].x;
           } 
        }
        for (var j = 0; j < nodes[i].length; j++)
        {
           nodes[i][j].x += transx + 50;
        }
        
        translate += 2 * transx + 50;
        
        var link = trees[i].selectAll("pathlink")
                      .data(links[i])
                      .enter().append("svg:path")
                      .attr("class", "link")
                      .attr("d", diagonal);
         
        var node = trees[i].selectAll("g.node")
                      .data(nodes[i])
                      .enter().append("svg:g")
                      .attr("transform", function(d) { return "translate(" + d.y + "," + d.x + ")"; });
        
        //console.log(nodes[i]);
        
        // Add the dot at every node
        node.append("svg:a")
            .attr("xlink:href", function(d){ return "/events/" + d.id + "/edit"; })
            //.append("svg:circle")
            //.attr("r", 10)
            .append("svg:rect")
            .attr("width", 20)
            .attr("height", 20)
            .attr("transform", function(d) { return "translate(-10, -10)"; })
            .style("fill", function(d) { return d.filtercolor; })
            .attr("title", function(d) { return d.comment; })
            .on("click", function(d) { var url = "/events/" + d.id + "/edit"; });
    
        // place the name atribute on top of circle
        node.append("svg:a")
            .attr("xlink:href", function(d) { return "/events/" + d.id + "/edit"; })
                .append("svg:text")
                .attr("dx", 0)
                .attr("dy", -15)
                .attr("text-anchor", "middle")
                .attr("title", function(d) { return d.comment; })
                //.attr("text-anchor", function(d) { return d.children ? "end" : "start"; })
                .text(function(d) { return d.name; });
    }
};