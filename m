Message-ID: <43F5D57A.5060809@domain.hid>
Date: Fri, 17 Feb 2006 14:54:02 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Newbie Question  : Compile test programm
References: <5D63919D95F87E4D9D34FF7748CE2C2A1C34FE@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A1C34FE@ARVMAIL1.mra.roland-man.biz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik_Wildenburg@domain.hid
Cc: Xenomai-help@domain.hid

Roderik_Wildenburg@domain.hid wrote:
> Dear Gurus,
>=20
> I simply try to compile a straightforward Xenomai example for the vxWor=
ks-skin like this :
>=20
> --------------------------------------------------
> #include <nucleus/thread.h>
> #include <nucleus/xenomai.h>
> #include <vxworks/vxworks.h>
> #include <stdio.h>
>=20
> int testtask (int a1, int a2,int a3,int a4,int a5,int a6,int a7,int a8,=
int a9,int a10)
> {
>    for(;;)
>    {
>       printf("Hello World\n");
>       taskDelay(sysClkRateGet()*1);
>    }
> }
>=20
> main(int argc, char **argv)
> {
>    int taskid;
>=20
>    taskid=3DtaskSpawn( "vxTestTask", 0, 0, 1000, testtask, 0,0,0,0,0,0,=
0,0,0,0);
>    taskDelay(sysClkRateGet()*20);
>=20
> }
>=20
> --------------------------------------------------
>=20
> Not very useful, but good enough as an example.
>=20
> When I try to (cross-)compile (for PowerPC) this code with the followin=
g statement :
>=20
>=20
>>ppc-linux-gcc -I ~/xenomai/_install/include test.c
>=20
>=20
> (_install/include is the directory of the installed (make install) Xeno=
mai header files.) I get the following errormessage (and much more):
>=20
> In file included from ~/xenomai/_install/include/nucleus/xenomai.h:23,
>                  from test.c:2:
> ~/xenomai/_install/include/xenomai/nucleus/pod.h:125: parse error befor=
e "xnthread_t"
> ~/xenomai/_install/include/xenomai/nucleus/pod.h:125: warning: no semic=
olon at end of struct or union
> ~/xenomai/_install/include/xenomai/nucleus/pod.h:127: warning: data def=
inition has no type or storage class
>=20
>=20
> I tried to find a simple example code for vxworks-skin, but I wasn=B4t =
succesfull (is there such a code at all and where ?).=20
> Could you please give me a hint, what I is wrong with my code, or where=
 I can find some Xenomai examples (vxWorks-skin).
>=20

Try ksrc/skins/vxworks/demos/

> Thank you in advance=20
> Roderik
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20


--=20

Philippe.

