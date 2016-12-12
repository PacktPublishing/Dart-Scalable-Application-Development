library job;

// model:
class Job {
  String type;
  int salary;
  String company;
  DateTime posted; // date of publication of job
  bool open = true; // is job still vacant?
  List<String> skills;
  String info;
  Job(this.type, this.salary, this.company, this.posted, this.skills, this.info);

  int get rate_salary => salary~/1000;
}