Message-ID: <4DF74D3C.4020303@domain.hid>
Date: Tue, 14 Jun 2011 13:59:56 +0200
From: Roberto Bielli <roberto.bielli@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Fwd: Re:  rt_task_delete doesn't work
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org



Here is the example and the command.

RT_TASK pippo;
RT_TASK pluto;

void test1()
{
     int err;

     err = rt_task_delete(&pippo );
     if( err != 0 )
         printf("error task delete\n");

}

int main (int argc, char *argv[])
{
     //    Porta di comunicazione
     //int s;

     mlockall(MCL_CURRENT|MCL_FUTURE);

     // gestione signal handler
     //struct sigaction sa;
     //sa.sa_sigaction = (void *)sigHandler;
     //sigemptyset (&sa.sa_mask);
     //sa.sa_flags = SA_SIGINFO;

     //sigaction(SIGTERM,&sa, NULL);
     //sigaction(SIGINT,&sa, NULL);
     //sigaction(SIGPIPE,&sa, NULL);
     //sigaction(SIGFPE,&sa, NULL);
     //sigaction(SIGSEGV,&sa, NULL);


     char * namePippo = "pippo";
     char * namePluto = "pluto";
     int err;
     err = rt_task_create(&pippo, namePippo, 0x2000, 20, T_FPU );
     if( err != 0 )
         printf("error task create %s\n", namePippo );
     err = rt_task_create(&pluto, namePluto, 0x2000, 20, T_FPU );
     if( err != 0 )
         printf("error task create %s\n", namePluto );

     err = rt_task_start(&pluto, (void *)test1, NULL );
     if( err != 0 )
         printf("error task start %s\n", namePluto );

}

--COMMAND--

# gdb --args ./apgs -D
GNU gdb (GDB) 6.8.50.20080821-cvs
Copyright (C) 2008 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later
<http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "arm-mv5sft-linux-gnueabi".
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>...
(gdb) r
`/flash/apgs' has disappeared; keeping its symbols.
Starting program: /flash/apgs -D
[Thread debugging using libthread_db enabled]
[New Thread 0x2acf7490 (LWP 537)]
[New Thread 0x2acfc490 (LWP 538)]

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x2acfc490 (LWP 538)]
0x2aab9d74 in _dl_catch_error () from /lib/ld-linux.so.3
(gdb)


Il 10/06/2011 19:32, Gilles Chanteperdrix ha scritto:
>  On 06/10/2011 06:51 PM, Roberto Bielli wrote:
>>  The segmentation fault was not on this code line.
>>  i upgraded the version to 2.5.6 but the error is the same.
>>
>>  The fault is when i try to delete a realtime task from another realtime
>>  task.
>>
>>  It's possible to do that  ?
>  Please post a self-contained testcase. A self-contained test case is
>  worth a thousand words.
>



-----
Nessun virus nel messaggio.
Controllato da AVG - www.avg.com
Versione: 10.0.1382 / Database dei virus: 1513/3699 -  Data di rilascio: 12/06/2011


