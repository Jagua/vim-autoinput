execute 'setglobal runtimepath^=' . expand('<sfile>:p:h:h')


call autoinput#start(readfile(expand('<sfile>:p:h') . '/sample.txt'))
