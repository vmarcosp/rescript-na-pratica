open Render

@react.component
let make = (~onChange, ~value, ~onAdd as onClick) =>
  <div>
    <input onChange value placeholder="New task" />
    <button onClick> {"Add"->s} </button>
  </div>
