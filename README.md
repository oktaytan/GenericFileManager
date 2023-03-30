<a name="readme-top"></a>

<!-- PROJECT LOGO -->
<div align="center">
  <h1 align="center">Generic File Manager</h1>
</div>


<!-- ABOUT THE PROJECT -->
## About The Project

A generic file manager where you can write and read different types of data in your application's document system.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- USAGE -->
## Usage

* Model
  ```swift
  struct Person: Codable {
    let name: String
    let age: Int
  }
  ```


* Write
  ```swift
  let john = Person(name: "John Doe", age: 34)
  let jane = Person(name: "Jane Doe", age: 30)

  GenericFileManager.shared.write(to: "people", value: [john, jane]) { result in
      switch result {
      case .success(let success):
          if success {
              print("People written to file.")
          }
      case .failure(let error):
          print(error)
      }
  }
  ```
  
* Read
  ```swift
  GenericFileManager.shared.readJSON(from: "people") { (result: Result<[Person], FileError>) in
      switch result {
      case .success(let people):
          print(people) // Output: [Person(name: "John Doe", age: 34), Person(name: "Jane Doe", age: 30)]
      case .failure(let error):
          print(error)
      }
  }
  ```  
  

