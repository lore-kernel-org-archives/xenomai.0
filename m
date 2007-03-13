Message-ID: <45F6C278.4040709@domain.hid>
Date: Tue, 13 Mar 2007 16:25:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Howto catch SEGV signals in Xenomai
References: <11906791.1173797505269.JavaMail.ngmail@domain.hid>
In-Reply-To: <11906791.1173797505269.JavaMail.ngmail@domain.hid>
Content-Type: multipart/mixed; boundary="------------010605080807090006090702"
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

This is a multi-part message in MIME format.
--------------010605080807090006090702
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit

M. Koehrer wrote:
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
> 
> How can I catch a signal in a Xenomai real time task?
> 
> I am running Xenomai 2.3.0 + NOCOW patch.
> 
> I have enclosed the .c file and a Makefile in a .tgz file.
> 
> Thanks for any feedback on that issue

It looks like the "relaxing a kicked thread" issue again. Could you try
the attached patch ?


-- 
                                                 Gilles Chanteperdrix

--------------010605080807090006090702
Content-Type: text/x-patch;
 name="xeno-relax-kicked-thread.diff"
Content-Disposition: inline;
 filename="xeno-relax-kicked-thread.diff"
Content-Transfer-Encoding: Quoted-Printable

Index: ksrc/nucleus/pod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/pod.c	(r=C3=A9vision 2293)
+++ ksrc/nucleus/pod.c	(copie de travail)
@@ -1398,7 +1398,7 @@
 		   and return immediately. Note: a relaxed shadow never has
 		   the KICKED bit set, so that xnshadow_relax() is never
 		   prevented from blocking the current thread. */
-		if (xnthread_test_info(thread, XNKICKED)) {
+		if (xnthread_test_info(thread, XNKICKED) && !xnthread_test_info(thread=
, XNRELAX)) {
 			xnthread_clear_info(thread, XNRMID | XNTIMEO);
 			xnthread_set_info(thread, XNBREAK);
 			if (wchan)

--------------010605080807090006090702--

