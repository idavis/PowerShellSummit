 gem list | % { $_.split()[0] } | % { gem uninstall -aIx $_ }
 
 filter xargs { & $args[0] ($args[1..$args.length] + $_) }
 
 gem list | % { $_.split()[0] } | xargs gem uninstall -aIx
 
 ls function:\g* | xargs Write-Host