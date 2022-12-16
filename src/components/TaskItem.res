open Render

module DateFns = {
  @module("date-fns")
  external format: (Js.Date.t, string) => string = "format"
}

@react.component
let make = (~name, ~completed, ~createdAt) => {
  <li>
    <span> {name->s} </span>
    <input type_="checkbox" onChange=ignore checked=completed />
    <span> {` | ${DateFns.format(createdAt, "dd/MM/yyyy")}`->s} </span>
  </li>
}
