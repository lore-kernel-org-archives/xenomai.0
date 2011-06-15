From: "cagnulein" <cagnulein@domain.hid>
Date: Wed, 15 Jun 2011 12:38:40 +0200
Message-ID: <bdZ5rCnhGWTy.SDNFd313@domain.hid>
MIME-Version: 1.0
Content-Language: i-default
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-core] R: Re:  Fwd: Re:  rt_task_delete doesn't work
Reply-To: cagnulein <cagnulein@domain.hid>
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roberto Bielli <roberto.bielli@domain.hid>
Cc: xenomai@xenomai.org

Ops sorry :)
I will try your code on my system asap.
Bye

-- msg. originale --
Oggetto: Re: [Xenomai-core] Fwd: Re:  rt_task_delete doesn't work
Da: Roberto Bielli <roberto.bielli@domain.hid>
Data: 15/06/2011 12:19

the tasks has not the same rt_task. One it's a create, one is a =
start.



Il 14/06/2011 18:27, Cagnulein ha scritto:
>>       err =3D rt_task_create(&pluto, namePluto, 0x2000, 20, T_FPU =
);
>>       if( err !=3D 0 )
>>           printf("error task create %s\n", namePluto );
>>
>>       err =3D rt_task_start(&pluto, (void *)test1, NULL );
> You've created 2 tasks with the same RT_TASK variable. Is it =
volunteer?
> Roberto Viola
>
>>
>> Here is the example and the command.
>>
>> RT_TASK pippo;
>> RT_TASK pluto;
>>
>> void test1()
>> {
>>       int err;
>>
>>       err =3D rt_task_delete(&pippo );
>>       if( err !=3D 0 )
>>           printf("error task delete\n");
>>
>> }
>>
>> int main (int argc, char *argv[])
>> {
>>       //    Porta di comunicazione
>>       //int s;
>>
>>       mlockall(MCL_CURRENT|MCL_FUTURE);
>>
>>       // gestione signal handler
>>       //struct sigaction sa;
>>       //sa.sa_sigaction =3D (void *)sigHandler;
>>       //sigemptyset (&sa.sa_mask);
>>       //sa.sa_flags =3D SA_SIGINFO;
>>
>>       //sigaction(SIGTERM,&sa, NULL);
>>       //sigaction(SIGINT,&sa, NULL);
>>       //sigaction(SIGPIPE,&sa, NULL);
>>       //sigaction(SIGFPE,&sa, NULL);
>>       //sigaction(SIGSEGV,&sa, NULL);
>>
>>
>>       char * namePippo =3D "pippo";
>>       char * namePluto =3D "pluto";
>>       int err;
>>       err =3D rt_task_create(&pippo, namePippo, 0x2000, 20, T_FPU =
);
>>       if( err !=3D 0 )
>>           printf("error task create %s\n", namePippo );
>>       err =3D rt_task_create(&pluto, namePluto, 0x2000, 20, T_FPU =
);
>>       if( err !=3D 0 )
>>           printf("error task create %s\n", namePluto );
>>
>>       err =3D rt_task_start(&pluto, (void *)test1, NULL );
>>       if( err !=3D 0 )
>>           printf("error task start %s\n", namePluto );
>>
>> }
>>
>> --COMMAND--
>>
>> # gdb --args ./apgs -D
>> GNU gdb (GDB) 6.8.50.20080821-cvs
>> Copyright (C) 2008 Free Software Foundation, Inc.
>> License GPLv3+: GNU GPL version 3 or later
>> <http://gnu.org/licenses/gpl.html>
>> This is free software: you are free to change and redistribute it.
>> There is NO WARRANTY, to the extent permitted by law.  Type "show =
copying"
>> and "show warranty" for details.
>> This GDB was configured as "arm-mv5sft-linux-gnueabi".
>> For bug reporting instructions, please see:
>> <http://www.gnu.org/software/gdb/bugs/>...
>> (gdb) r
>> `/flash/apgs' has disappeared; keeping its symbols.
>> Starting program: /flash/apgs -D
>> [Thread debugging using libthread_db enabled]
>> [New Thread 0x2acf7490 (LWP 537)]
>> [New Thread 0x2acfc490 (LWP 538)]
>>
>> Program received signal SIGSEGV, Segmentation fault.
>> [Switching to Thread 0x2acfc490 (LWP 538)]
>> 0x2aab9d74 in _dl_catch_error () from /lib/ld-linux.so.3
>> (gdb)
>>
>>
>> Il 10/06/2011 19:32, Gilles Chanteperdrix ha scritto:
>>>   On 06/10/2011 06:51 PM, Roberto Bielli wrote:
>>>>   The segmentation fault was not on this code line.
>>>>   i upgraded the version to 2.5.6 but the error is the same.
>>>>
>>>>   The fault is when i try to delete a realtime task from another
>>>> realtime
>>>>   task.
>>>>
>>>>   It's possible to do that  ?
>>>   Please post a self-contained testcase. A self-contained test case =
is
>>>   worth a thousand words.
>>>
>>
>>
>> -----
>> Nessun virus nel messaggio.
>> Controllato da AVG - www.avg.com
>> Versione: 10.0.1382 / Database dei virus: 1513/3699 -  Data di =
rilascio:
>> 12/06/2011
>>
>>
>> _______________________________________________
>> Xenomai-core mailing list
>> Xenomai-core@domain.hid
>> https://mail.gna.org/listinfo/xenomai-core
>>
>
>
> -----
> Nessun virus nel messaggio.
> Controllato da AVG - www.avg.com
> Versione: 10.0.1382 / Database dei virus: 1513/3703 -  Data di rilascio: =
14/06/2011


--=20
+---------------------------------------------------------------------------=
---------------------+
						=09
Roberto Bielli
Sviluppo Software				=09
Axel S.r.l.				=09
						=09
Via Del Cannino, 3 			=09
21020 Crosio Della Valle		=09
Varese - Italy				=09
						=09
Telefono: +39 0332 949600		=09
Fax:      +39 0332 969315		=09
						=09
E-mail:   roberto.bielli@domain.hid
Web Site: www.axelsw.it

+---------------------------------------------------------------------------=
---------------------+

Si precisa che le informazioni contenute in questo messaggio sono riservate =
e ad uso esclusivo del destinatario.
Qualora il messaggio in parola Le fosse pervenuto per errore, La preghiamo =
di eliminarlo senza copiarlo e di non inoltrarlo a terzi,
dandocene gentilmente comunicazione. Grazie.
Informativa sul trattamento dei dati personali (D. Lgs. 196/2003).
I dati utilizzati per la spedizione del presente messaggio sono utilizzati =
da Axel S.r.l., titolare del trattamento,
per l'invio delle comunicazioni dei diversi settori aziendali, non essendo =
autorizzata la divulgazione a terzi.
Potrete rivolgere alla seguente mail richieste di verifica, rettifica o =
cancellazione dei Vostri dati: info@domain.hid

This e-mail and any attachments is confidential and may contain privileged =
information
intended for the addressee(s) only. Dissemination, copying, printing or use =
by anybody
else is unauthorised. If you are not the intended recipient,
please delete this message and any attachments and advise the sender
by return e-mail.Thank you.  		=09
						=09
+---------------------------------------------------------------------------=
---------------------+



