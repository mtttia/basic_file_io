import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:basic_file_io/basic_file_io.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

void main() {
  Directory current = Directory('${Directory.current.path}/example');
  current.createSync();
  // create e expect for getLocalPath
  test('getLocalPath', () async {
    final directory = await getLocalPath();
    expect(directory, (await getApplicationDocumentsDirectory()).path);
  });
  // create a test for saveData
  test('saveData', () async {
    final file = await saveData('test.txt', 'test', local: true);
    expect('', '');
  });

  //create test for loadData
  test('loadData', () async {
    final file = await saveData('test.txt', 'testing', local: true);
    String s = (await getLocalFile('test.txt')).path;
    final data = await loadData('test.txt', local: true);
    expect(data, 'testing');
  });

  //create test for FileAssistant
  test('FileAssistant save and load', () async {
    final file = FileAssistant('test.txt');
    file.setData('test');
    String currentData = file.data;
    expect(await loadData('test.txt'), currentData);
  });

  test('FileAssistant creating loading the file', () async {
    String fileName = "test.txt";
    await saveData(fileName, 'Hello, I\'m a test');
    String value = await loadData(fileName);
    final file = FileAssistant(fileName);
    await file.load();
    expect(file.data, value);
  });

  test('FileAssistant creating not loading the file', () async {
    String fileName = "test.txt";
    await saveData(fileName, 'Hello, I\'m a test');
    final file = FileAssistant(
      fileName,
    );

    expect(file.data, "");
  });

  test('FileAssistant changing data without autosave', () async {
    String fileName = "test.txt";
    final file = FileAssistant(fileName);
    file.setData('testing2');
    file.autoSave = false;
    String exepted = await loadData(fileName);
    file.setData('changed');
    expect(file.data == exepted, false);
    expect(file.data, 'changed');
  });
}
