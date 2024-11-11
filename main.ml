(* src/main.ml *)

open Todo

let rec main_loop () =
  print_endline "\n--- To-Do List ---";
  print_endline "1. Add a task";
  print_endline "2. Remove a task";
  print_endline "3. Mark a task as completed";
  print_endline "4. List all tasks";
  print_endline "5. Show completed tasks";
  print_endline "6. Show pending tasks";
  print_endline "7. Save tasks to file";
  print_endline "8. Load tasks from file";
  print_endline "0. Exit";
  print_string "Choose an option: ";
  match read_line () with
  | "1" ->
      print_string "Enter task description: ";
      let description = read_line () in
      let task = Todo.add_task description in
      Printf.printf "Added Task %d: %s\n" task.id task.description;
      main_loop ()
  | "2" ->
      print_string "Enter task ID to remove: ";
      let id = read_int () in
      Todo.remove_task id;
      Printf.printf "Removed Task %d\n" id;
      main_loop ()
  | "3" ->
      print_string "Enter task ID to mark as completed: ";
      let id = read_int () in
      Todo.mark_task_completed id;
      Printf.printf "Marked Task %d as completed\n" id;
      main_loop ()
  | "4" ->
      print_endline "All Tasks:";
      Todo.list_tasks ();
      main_loop ()
  | "5" ->
      print_endline "Completed Tasks:";
      let completed_tasks = Todo.filter_tasks true in
      List.iter Todo.display_task completed_tasks;
      main_loop ()
  | "6" ->
      print_endline "Pending Tasks:";
      let pending_tasks = Todo.filter_tasks false in
      List.iter Todo.display_task pending_tasks;
      main_loop ()
  | "7" ->
      print_string "Enter filename to save tasks: ";
      let filename = read_line () in
      Todo.save_tasks filename;
      Printf.printf "Tasks saved to %s\n" filename;
      main_loop ()
  | "8" ->
      print_string "Enter filename to load tasks: ";
      let filename = read_line () in
      Todo.load_tasks filename;
      Printf.printf "Tasks loaded from %s\n" filename;
      main_loop ()
  | "0" ->
      print_endline "Goodbye!"
  | _ ->
      print_endline "Invalid option, please try again.";
      main_loop ()

let () = main_loop ()

