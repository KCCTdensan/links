import std;

enum targets=[
  "301",
  "302",
  "303",
  "307",
  "308",
];
enum ext=".txt";
enum dir="dist";
enum file="_redirects";

void main() {
  if(!dir.exists) dir.mkdir;
  auto f=File(dir~"/"~file, "w");
  foreach(target; targets) {
    auto path=target~ext;
    if(!path.exists) continue;
    auto rules=path.readText
      .splitter(regex("\n"))
      .map!strip
      .filter!`a!=""&&a[0]!='#'`;
    foreach(rule; rules) {
      auto row=rule.split(regex(r"\s+"));
      if(row.length!=2) continue;
      f.writefln("%s %s "~target, row[0], row[1]);
    }
  }
}
