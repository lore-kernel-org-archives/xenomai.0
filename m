Message-ID: <4DC96142.7020008@domain.hid>
Date: Tue, 10 May 2011 18:01:06 +0200
From: Roberto Bielli <roberto.bielli@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] SWITCH TASK TO SECONDARY MODE DURING GDB SESSION
	DOESN'T WORK
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi,

i try the next C code in a gdb session on a ARM target with brakpoints 
and i found a strange behaviour.
I expected that the task 'tsk1' never execute instead if i put a 
breakpoint on the instruction 'varInt += 1;' i see that it's executed.
I sospect that there is this behavior:

1. i start gdb with application. The application is not running.
2. i enable the breakpoint on the instruction 'err = 
rt_task_start(&tsk1, &test_tsk1, NULL );'
3. i enable the breakpoint on the instruction 'varInt += 1;' in tsk1
4. run the application that stop on the instruction 'err = 
rt_task_start(&tsk1, &test_tsk1, NULL );'
so the task is in secondary mode for the breakpoint hit if i understand 
correctly .
5. i make a single step and do the rt_task_start in main, so i see that 
i break in the task on the instruction 'varInt += 1;' in tsk1
this is strange because main has shadow and has a priority equal o 99, 
instead  tsk1 has a priority equal to 49.
6, the program execute the instruction  'varInt += 1;' and then return 
to main.
7 then the main has always the control.

The question is:
Why the priority is not respected ? I think this. Maybe the main is in 
secondary mode for the breakpoint and when make a rt_task_create the new 
task is in primary
mode for the initial instruction. Then receive the signal ( verified 
with rt_task_set_mode(0, T_WARNSW, NULL); ) and switch to secondary mode 
but initially the task tsk is in primary mode and execute before main.

Is a known problem ?

Best Regards



CODE---------------------------------


int varInt = 0;
RT_TASK tsk1, tskMain;

int main (int argc, char *argv[])
{
     int err;
     mlockall(MCL_CURRENT|MCL_FUTURE);

     rt_task_shadow(&tskMain, "main", 99, 0);

     err  = rt_task_create( &tsk1, "tsk1", 0, 49, T_FPU );
     err = rt_task_start(&tsk1, &test_tsk1, NULL );

     for (;;)
     {
         if( varInt > 1 )
             break;
     }


     printf("Task started\n");

     return 0;
}

void test_tsk1( void * args )
{

     for( ;;)
     {
         varInt += 1;
         rt_task_sleep( 100000000 );
     }
}

-- 
+------------------------------------------------------------------------------------------------+
							
Roberto Bielli
Sviluppo Software					
Axel S.r.l.					
							
Via Del Cannino, 3 				
21020 Crosio Della Valle			
Varese - Italy					
							
Telefono: +39 0332 949600			
Fax:      +39 0332 969315			
							
E-mail:   roberto.bielli@domain.hid	
Web Site: www.axelsw.it

+------------------------------------------------------------------------------------------------+

Si precisa che le informazioni contenute in questo messaggio sono riservate e ad uso esclusivo del destinatario.
Qualora il messaggio in parola Le fosse pervenuto per errore, La preghiamo di eliminarlo senza copiarlo e di non inoltrarlo a terzi,
dandocene gentilmente comunicazione. Grazie.
Informativa sul trattamento dei dati personali (D. Lgs. 196/2003).
I dati utilizzati per la spedizione del presente messaggio sono utilizzati da Axel S.r.l., titolare del trattamento,
per l'invio delle comunicazioni dei diversi settori aziendali, non essendo autorizzata la divulgazione a terzi.
Potrete rivolgere alla seguente mail richieste di verifica, rettifica o cancellazione dei Vostri dati: info@domain.hid

This e-mail and any attachments is confidential and may contain privileged information
intended for the addressee(s) only. Dissemination, copying, printing or use by anybody
else is unauthorised. If you are not the intended recipient,
please delete this message and any attachments and advise the sender
by return e-mail.Thank you.  			
							
+------------------------------------------------------------------------------------------------+


