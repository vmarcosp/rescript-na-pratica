open Render

type task = {
  name: string,
  completed: bool,
  createdAt: Js.Date.t,
}

type action = AddTask(string) | RemoveTask | CompleteTask

let tasksReducer = (tasks, action) =>
  switch action {
  | AddTask(taskName) =>
    tasks->Belt.Array.concat([
      {
        name: taskName,
        completed: false,
        createdAt: Js.Date.make(),
      },
    ])

  | RemoveTask => []
  | CompleteTask => []
  }

@react.component
let make = () => {
  let (tasks, dispatch) = React.useReducer(tasksReducer, [])
  let (taskName, setTaskName) = React.useState(() => "")

  let handleChange = event => {
    let value = ReactEvent.Form.target(event)["value"]
    setTaskName(_ => value)
  }

  let addNewTask = _ => dispatch(AddTask(taskName))

  <div>
    <TaskInput onChange={handleChange} value=taskName onAdd=addNewTask />
    <br />
    <ul>
      {tasks->map(({name, createdAt, completed}, key) => <TaskItem key name createdAt completed />)}
    </ul>
  </div>
}
