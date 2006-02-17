Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Feb 2006 14:41:36 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A1C34FE@ARVMAIL1.mra.roland-man.biz>
From: <Roderik_Wildenburg@domain.hid>
Subject: [Xenomai-help] Newbie Question  : Compile test programm
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

Dear Gurus,

I simply try to compile a straightforward Xenomai example for the =
vxWorks-skin like this :

--------------------------------------------------
#include <nucleus/thread.h>
#include <nucleus/xenomai.h>
#include <vxworks/vxworks.h>
#include <stdio.h>

int testtask (int a1, int a2,int a3,int a4,int a5,int a6,int a7,int =
a8,int a9,int a10)
{
   for(;;)
   {
      printf("Hello World\n");
      taskDelay(sysClkRateGet()*1);
   }
}

main(int argc, char **argv)
{
   int taskid;

   taskid=3DtaskSpawn( "vxTestTask", 0, 0, 1000, testtask, =
0,0,0,0,0,0,0,0,0,0);
   taskDelay(sysClkRateGet()*20);

}

--------------------------------------------------

Not very useful, but good enough as an example.

When I try to (cross-)compile (for PowerPC) this code with the following =
statement :

> ppc-linux-gcc -I ~/xenomai/_install/include test.c

(_install/include is the directory of the installed (make install) =
Xenomai header files.) I get the following errormessage (and much more):

In file included from ~/xenomai/_install/include/nucleus/xenomai.h:23,
                 from test.c:2:
~/xenomai/_install/include/xenomai/nucleus/pod.h:125: parse error before =
"xnthread_t"
~/xenomai/_install/include/xenomai/nucleus/pod.h:125: warning: no =
semicolon at end of struct or union
~/xenomai/_install/include/xenomai/nucleus/pod.h:127: warning: data =
definition has no type or storage class


I tried to find a simple example code for vxworks-skin, but I wasn=B4t =
succesfull (is there such a code at all and where ?).=20
Could you please give me a hint, what I is wrong with my code, or where =
I can find some Xenomai examples (vxWorks-skin).

Thank you in advance=20
Roderik


