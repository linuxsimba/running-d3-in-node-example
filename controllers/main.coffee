exports.index = (req, res) ->
  d3 = req.app.d3
  html = '<!doctype html><html></html>'
  # jsdom magic to get d3 to work within a DOM
  document = req.app.jsdom.jsdom(html)

  width =  300
  height = 450

  ###
  # draw a few circles
  ###
  circleData = [
    { cx: 20, cy: 25, r: 20, fill: 'blue' },
    { cx: 60, cy: 25, r: 20, fill: 'green'}
  ]
  layoutRoot = d3.select(document.body)
    .append('svg')
  layoutRoot.attr('width', width)
            .attr('height', height)
            .append('g')
            .selectAll('circle')
            .data(circleData)
            .enter()
            .append('circle')
            .attr('cx', (d) ->  d.cx)
            .attr('cy', (d) ->  d.cy)
            .attr('r', (d) -> d.r)
            .attr('fill', (d) -> d.fill)

  # only render text in and include the <svg></svg> tags only
  # draws it in the pug template where !{svgstuff} is defined
  res.render 'index', svgstuff: layoutRoot.node().outerHTML
