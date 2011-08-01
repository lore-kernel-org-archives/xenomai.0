Message-ID: <4E367A11.3050001@domain.hid>
Date: Mon, 01 Aug 2011 12:04:01 +0200
From: Roberto Bielli <roberto.bielli@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] rt_task_suspend, rt_task_delete chooses wrong tasks
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

i see a big problem in xenomai. Aftear a certain number of task deletion 
(rt_task_delete) and re-create task
the RT_TASK descriptors that i have in my application don't match with 
the correct task.

1. function for deleting the task.

int mtsuspendtask( int idTsk )
{
   int err;
   RT_TASK_INFO tskInfo;
   RT_TASK_INFO tskInfoD;

   rt_task_inquire( rt_task_self(), &tskInfo );

     //non sospendo task che non esistono
   if((err = (rt_task_inquire (tabRtTask[idTsk].rtDesc, NULL ))) != 0)
   {
       AltTraceInN(ALTRACE_LEV_OS_TASK, "rt_task_inquire (ts): %s - err 
%d (caller: %s)", tabRtTask[idTsk].name, err, tskInfo.name );
       return err;
   }

   err  = rt_task_suspend ( tabRtTask[idTsk].rtDesc );
   AltTraceInN(ALTRACE_LEV_OS_TASK, "rt_task_suspend : %s - err %d 
(caller: %s)", tabRtTask[idTsk].name, err, tskInfo.name );
   if( err != 0 )
   {
       return err;
   }

   err  = rt_task_delete (tabRtTask[idTsk].rtDesc);
   AltTraceInN(ALTRACE_LEV_OS_TASK, "rt_task_delete  : %s - err %d 
(caller: %s)", tabRtTask[idTsk].name, err, tskInfo.name );
   if ((err != 0) && (err != -3))
   {
       return (err);
   }

   while ((err = (rt_task_inquire (tabRtTask[idTsk].rtDesc, &tskInfoD))) 
== 0)
   {
       AltTraceInN(ALTRACE_LEV_OS_TASK, "idTsk in tabella: %d", idTsk );
       AltTraceInN(ALTRACE_LEV_OS_TASK, "rt_task_inquire : %s", 
tskInfoD.name );
       AltTraceInN(ALTRACE_LEV_OS_TASK, "rt_task_inquire : %s - err %d 
(caller: %s)", tabRtTask[idTsk].name, err, tskInfo.name );
       mtsleep (2); //...rt_task_sleep( 4 milliseconds );
   }

     return (err);
}


2. function for creating the task

int mtresettask( int idTsk )
{
     int err;
     RT_TASK_INFO tskInfo;

     rt_task_inquire( rt_task_self(), &tskInfo );

     memset( tabRtTask[idTsk].rtDesc, 0, sizeof( RT_TASK ) );

     err = rt_task_create( tabRtTask[idTsk].rtDesc, 
tabRtTask[idTsk].name, 
tabRtTask[idTsk].stkSize,tabRtTask[idTsk].priority,tabRtTask[idTsk].mode);
     AltTraceInN(ALTRACE_LEV_OS_TASK, "rt_task_create  : %s - err %d 
(caller: %s)", tabRtTask[idTsk].name, err, tskInfo.name );
     if( err != 0 )
         return err;

     err = rt_task_start( tabRtTask[idTsk].rtDesc, (void 
(*)(void*))tabRtTask[idTsk].fnAddr, tabRtTask[idTsk].tskArgs );
     AltTraceInN(ALTRACE_LEV_OS_TASK, "rt_task_start   : %s - err %d 
(caller: %s)", tabRtTask[idTsk].name, err, tskInfo.name );


     return (err);
}

Thanks in advance

Best Regards


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


