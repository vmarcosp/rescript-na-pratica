type todo = {
  name: string,
  completed: bool,
  createdAt: Js.Date.t,
}

type action = AddTodo(todo) | Toggle(int, bool)

let reducer = (todos, action) =>
  switch action {
  | AddTodo(todo) => todos->Belt.Array.concat([todo])
  | Toggle(todoIndex, completed) =>
    todos->Belt.Array.mapWithIndex((index, todo) =>
      if todoIndex === index {
        {...todo, completed}
      } else {
        todo
      }
    )
  }

@react.component
let make = () => {
  let (todoName, setTodoName) = React.useState(_ => "")
  let (todos, dispatch) = React.useReducer(
    reducer,
    [{name: "Ir ao mercado", completed: false, createdAt: Js.Date.make()}],
  )

  let toggleTask = (index, e) => {
    let completed = ReactEvent.Form.target(e)["checked"]
    dispatch(Toggle(index, completed))
  }

  let handleInputChange = e => {
    let name = ReactEvent.Form.target(e)["value"]
    setTodoName(_ => name)
  }

  let addNewTodo = _ => {
    let todo = {
      name: todoName,
      completed: false,
      createdAt: Js.Date.make(),
    }

    dispatch(AddTodo(todo))
    setTodoName(_ => "")
  }

  <div>
    <div>
      <input onChange={handleInputChange} value={todoName} />
      <button onClick={addNewTodo}> {"Add"->React.string} </button>
    </div>
    {todos
    ->Belt.Array.mapWithIndex((index, todo) =>
      <label key={index->Belt.Int.toString}>
        {todo.name->React.string}
        <input type_="checkbox" checked=todo.completed onChange={toggleTask(index)} />
      </label>
    )
    ->React.array}
  </div>
}
