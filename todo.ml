(* src/todo.ml *)

module Todo = struct
  type task = { id : int; description : string; completed : bool }

  let task_list = ref []

  let add_task description =
    let id = List.length !task_list + 1 in
    let new_task = { id; description; completed = false } in
    task_list := new_task :: !task_list;
    new_task

  let remove_task id =
    task_list := List.filter (fun task -> task.id <> id) !task_list

  let mark_task_completed id =
    task_list := List.map (fun task ->
      if task.id = id then { task with completed = true } else task
    ) !task_list

  let list_tasks () =
    List.iter (fun task ->
      Printf.printf "Task %d: %s [%s]\n" task.id task.description
        (if task.completed then "Completed" else "Incomplete")
    ) !task_list

  (* Display a single task (helper function for filtering) *)
  let display_task task =
    Printf.printf "Task %d: %s [%s]\n" task.id task.description
      (if task.completed then "Completed" else "Incomplete")

  let filter_tasks completed =
    List.filter (fun task -> task.completed = completed) !task_list

  (* Optional: Save tasks to a file *)
  let save_tasks filename =
    let oc = open_out filename in
    List.iter (fun task ->
      Printf.fprintf oc "%d|%s|%b\n" task.id task.description task.completed
    ) !task_list;
    close_out oc

  (* Optional: Load tasks from a file *)
  let load_tasks filename =
    let ic = open_in filename in
    try
      task_list := [];
      while true do
        let line = input_line ic in
        match String.split_on_char '|' line with
        | [id_str; description; completed_str] ->
            let id = int_of_string id_str in
            let completed = bool_of_string completed_str in
            task_list := { id; description; completed } :: !task_list
        | _ -> ()
      done
    with End_of_file ->
      close_in ic
end

