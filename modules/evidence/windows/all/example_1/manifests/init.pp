$evidence_path = 'c:\evidence_test_1'

file { 'evidence-file-example_1':
  content => template('example_1\example_1.erb'),
  path => $evidence_path
}