Subject: Re: [Xenomai-help] Howto catch SEGV signals in Xenomai
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <11906791.1173797505269.JavaMail.ngmail@domain.hid>
References: <11906791.1173797505269.JavaMail.ngmail@domain.hid>
Content-Type: text/plain; charset="utf-8"
Date: Tue, 13 Mar 2007 16:19:33 +0100
Message-Id: <1173799174.16997.47.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2007-03-13 at 15:51 +0100, M. Koehrer wrote:
> Hi all,
> 
> I have a problem to catch segment violations with Xenomai:
> For demonstration I use the following program:
> ------------------------------------------
> #include <stdio.h>
> #include <sys/mman.h>
> 
> #include <native/task.h>
> #include <native/sem.h>
> RT_TASK taska_desc;
> volatile int *pointer = 0;
> 
> void mytaska(void *cookie)
> {
>     int i;
>     for (i=0; i < 50; i++)
>     {
>         rt_task_sleep(50000000);
>         if (i > 20)
>         {
>             *pointer = 123;
>         }
>         printf("Hello %i\n", i);
>     }
>     printf("Hi, this is task A\n");
> }
> 
> int main(void)
> {
>     mlockall(MCL_CURRENT|MCL_FUTURE);
> 
>     rt_task_create(&taska_desc, "mytaska", 0, 81, T_JOINABLE);
>     rt_task_start(&taska_desc, &mytaska, NULL);
> 
>     rt_task_join(&taska_desc);
>     printf("Main: A joined\n");
> 
>     return 0;
> }
> ---------------------------------------
> Whenever i is greater than 20 a segment violation occurs, as I must not write
> to address 0 (the pointer is always NULL).
> However, what happens is, that my system freezes after printing out 18 or 19.
> I have to reset the PC to continue.
> When I write a printf() directly before the invalid assignment I get the usual linux
> "segmentation fault" error message.

This would be the the sign that a problem exists at the I-pipe level
with your current patch. The fault should have been propagated form
primary to secondary domain, and obviously it's not.

> 
> How can I catch a signal in a Xenomai real time task?
> 

There is no difference with any regular Linux application.

> I am running Xenomai 2.3.0 + NOCOW patch.
> I have enclosed the .c file and a Makefile in a .tgz file.

Can't reproduce the issue with 1.7-03 here.
Please make sure to use a recent and official I-pipe patch if it's not
already the case, and not a testing patch as published on this list, so
that we don't start chasing wild gooses.
http://download.gna.org/adeos/patches/v2.6/

> Thanks for any feedback on that issue
> 
> Regards
> 
> Mathias
> ~
> ~
> 
> 
> 
> -- 
> Mathias Koehrer
> mathias_koehrer@domain.hid
> 
> 
> Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
> ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: günstig
> und schnell mit DSL - das All-Inclusive-Paket für clevere Doppel-Sparer,
> nur  39,85 €  inkl. DSL- und ISDN-Grundgebühr!
> http://www.arcor.de/rd/emf-dsl-2
> _______________________________________________ Xenomai-help mailing list Xenomai-help@domain.hid https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



