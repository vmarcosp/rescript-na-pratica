let s = React.string
let map = (items, fn) =>
  items->Belt.Array.mapWithIndex((index, item) => fn(item, index->Belt.Int.toString))->React.array
