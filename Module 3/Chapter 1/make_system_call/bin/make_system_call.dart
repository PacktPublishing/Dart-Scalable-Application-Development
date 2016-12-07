import 'dart:io';

main() {
  // running an external program or process without interaction:
  Process.run('notepad', ['tst.txt']).then((ProcessResult rs){
    print(rs.exitCode);
    print(rs.stdout);
    print(rs.stderr);
  });
  Process.run('dir', [], runInShell:true).then((ProcessResult rs){
     print(rs.exitCode);
     print(rs.stdout);
     print(rs.stderr);
   });
}
