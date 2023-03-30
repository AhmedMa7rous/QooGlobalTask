<h1 align="center"> iOS Interview Challenge </h1>

## Note that:

- Start your review from [Solution Steps](#solution-steps) section because the first and the second I wrote it from the task documentation but I wrote it here to document this work for myself.
- check each commit message.
- check task [jira project](https://iostask.atlassian.net/jira/software/projects/II/boards/1/backlog).
- Don't forget to send me your feedback I really want this feedback.

# Table of Content
- [About Task](#about-task)
- [Requirements](#requirements)
- [Solution Steps](#solution-steps)
- [Resources](#resources)
- [My Feedback](#my-feedback)

# About Task
- Check this [Figma Link](https://www.figma.com/file/FcnHzJl60ajd0ac9fHgoFi/Great-Sports?node-id=0%3A1&t=olXMhi0Vg7sT04Zw-0) and make the design for players and player details section.

- Integrate API for players listing and details. The APIs are given below. 

    - https://ios.app99877.com/api/sc/players      
      - Request : GET

    - https://ios.app99877.com/api/sc/player/details
      - Request : POST
      - Parameter : slug, pass it as json.
 

# Requirements
### Design Archeticture
- [MVVM](https://www.geeksforgeeks.org/mvvm-model-view-viewmodel-architecture-pattern-in-android/)

# Solution Steps
### Code Linting
I used code linting in this task, this what I made:
- Each file has sections made by "MARK:" comment each section contains the data for it's role.
- Each file related with UI contains a function named "updateUi()" this function responsible for any thing related with UI and beside it there's many support functions that support it to achieve its role.
- Naming: used [camel Case style](https://en.wikipedia.org/wiki/Camel_case).
    - Functions Naming: should start with verb that explain it's role. 
    - Functions Body: should be 10 or 20 lines if it exceed should split the code to 2 functions.
- If a UI class contains Table or Collection View you will find its functions it an extension at the bottom of that file.
- Pattern: MVVM because it cleanly separates the business logic of an application from the user interface.
- Software Development Methodologies: Agile Methodologies (SRUM Methodology)
- Version Control: Github.

### Agile Methodology
They said that "Success comes from good planning" and after reading and understanding it, I decided to plan well for solve the task here's my solution steps in detail:
1. I used Jira Software for this task you can check the project [iOS Interview](https://iostask.atlassian.net/jira/software/projects/II/boards/1/backlog) in this task I Choosed [SRUM Methodology](https://www.infoworld.com/article/3237508/what-is-agile-methodology-modern-software-development-explained.html#:~:text=developers%20without%20micromanaging%20%5D-,Scrum%20and%20kanban,-Once%20a%20product)
2. Divide the project to stories tasks.
3. create project Backlog Stories and set the priority, estimated time and assign it to team member.
4. Each story contains subtasks with assigned member to do it and estimate time(by hours).
5. create sprint from one or more story.
6. Complete each sprint successfully.

### Start write code with strait and clear way.

# Resources
After reading the task document carefully and set plan for solution as mentioned above, I found out that I must solve it in a best way, So I used every piece of information i know and there're resources I used for some informations Like:
- [Stack Overflow](https://stackoverflow.com/)
- [Kodeco](https://www.kodeco.com/home)
- [Medium](https://medium.com/)

# My Feedback
- In this task I really gain alote of knowledge and informations and refreshed my informations and knowledge. 


<h1 align="center"> Thank you for this awesome task and I will do my best to be the choosen one to give you all i have and learn a lote from you. Thanks again</h1>
