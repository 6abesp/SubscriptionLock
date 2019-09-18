Connect-AzAccount
  
Get-AzContext

$Subs=Get-AzSubscription

foreach($Sub in $Subs)
        {
            Write-Output 'Ingresando a'
            Write-Output $Sub.Name
            Set-AzContext -SubscriptionId $Sub.Id
                        
            $lock= Get-AzResourceLock  
            Write-Output 'El valor de lock es'
            Write-Output $lock
            #$lock.name -ne "LockSubscription" Or+


            if( $lock -eq $NULL )
            {Write-Output 'Creando Bloqueo en la suscripción'}
                Write-Output 'Creando Bloqueo en la suscripción'
                $scopeId="/subscriptions/"+$Sub.Id
                Write-Output $scopeId
                
                $locktype = read-host "¿Que tipo de lock quieres? CanNotDelete=1, ReadOnly=2"
                switch ($locktype) 
                {
                   "1"  {$locktype="CanNotDelete"; break}
                   "2"   {$locktype="ReadOnly"; break}
                   default {$host.Exit(); break}
                }
                New-AzResourceLock -LockLevel $locktype -LockName "LockSubscription" -Scope $scopeId -Force
                $lock2= Get-AzResourceLock -LockName "LockSubscription"
                Write-Output $lock2.name
            }     
     

