Message-ID: <46CE7B9F.1040607@domain.hid>
Date: Fri, 24 Aug 2007 08:33:03 +0200
From: Dirk Eibach <eibach@domain.hid>
MIME-Version: 1.0
References: <1187901933.6009.20.camel@domain.hid>
In-Reply-To: <1187901933.6009.20.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai degrades syscall time on PPC405
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: Xenomai help <xenomai@xenomai.org>

Hello Philippe,

tank you for your detailed answer.

>> Hello,
>>
>> I am trying to understand some performance problems I ran into on my=20
>> xenomai system.
>>
>> The testcode I attached performs a syscall(gettimeofday). Measuring ti=
me on=20
>> a vanilla Kernel gives the following output:
>>
>> ticks for ppc_getccounter: 116, for gettimeofday: 1479
>>
>> The same kernel with xenomai patched in gives this:
>>
>> ticks for ppc_getccounter: 116, for gettimeofday: 4278
>>
>> Is this the expected behaviour? Why is the time for a system call near=
ly 3=20
>> times as much?
>>
>=20
> When reporting figures, please report all of them. Here is your test ra=
n
> on a 405GPr, linux-2.6.14, I-pipe 1.5-03, with full output:
>=20
> bash-3.00# ./ppc405_rt=20
> ticks for ppc_getccounter: 122, for gettimeofday: 7337
> ticks for ppc_getccounter: 208, for gettimeofday: 2816
> ticks for ppc_getccounter: 210, for gettimeofday: 2512
> ticks for ppc_getccounter: 174, for gettimeofday: 2622
> ticks for ppc_getccounter: 174, for gettimeofday: 2320
> ticks for ppc_getccounter: 208, for gettimeofday: 2634
> ticks for ppc_getccounter: 174, for gettimeofday: 2344
> ticks for ppc_getccounter: 208, for gettimeofday: 2660
> ticks for ppc_getccounter: 174, for gettimeofday: 2320
> ticks for ppc_getccounter: 208, for gettimeofday: 2816
> ticks for ppc_getccounter: 208, for gettimeofday: 2734
> ticks for ppc_getccounter: 208, for gettimeofday: 2802
> ...

I certainly tried to pick a representative sample. Here is the full serie=
s=20
with xenomai patched in:
# ./syscall-test
ticks for ppc_getccounter: 92, for gettimeofday: 18375
ticks for ppc_getccounter: 116, for gettimeofday: 4250
ticks for ppc_getccounter: 116, for gettimeofday: 4416
ticks for ppc_getccounter: 116, for gettimeofday: 4372
ticks for ppc_getccounter: 116, for gettimeofday: 4486
ticks for ppc_getccounter: 116, for gettimeofday: 4376
ticks for ppc_getccounter: 116, for gettimeofday: 4446
ticks for ppc_getccounter: 116, for gettimeofday: 4434
ticks for ppc_getccounter: 116, for gettimeofday: 4368
ticks for ppc_getccounter: 116, for gettimeofday: 4418
ticks for ppc_getccounter: 116, for gettimeofday: 4404
ticks for ppc_getccounter: 116, for gettimeofday: 4384
...


And here we go without:
# ./syscall-test
ticks for ppc_getccounter: 92, for gettimeofday: 6761
ticks for ppc_getccounter: 116, for gettimeofday: 1768
ticks for ppc_getccounter: 116, for gettimeofday: 1594
ticks for ppc_getccounter: 116, for gettimeofday: 1560
ticks for ppc_getccounter: 116, for gettimeofday: 1600
ticks for ppc_getccounter: 116, for gettimeofday: 1574
ticks for ppc_getccounter: 116, for gettimeofday: 1618
ticks for ppc_getccounter: 116, for gettimeofday: 1560
ticks for ppc_getccounter: 116, for gettimeofday: 1600
ticks for ppc_getccounter: 116, for gettimeofday: 1540
ticks for ppc_getccounter: 116, for gettimeofday: 1618
ticks for ppc_getccounter: 116, for gettimeofday: 1566
ticks for ppc_getccounter: 116, for gettimeofday: 1608
...

>=20
> Only the first shot exhibits a pathological latency, and switching on
> CONFIG_XENO_OPT_DEBUG_NUCLEUS explains why:
>=20
> # dmesg
>=20
> ...
> Looking up port of RPC 100003/2 on 192.168.0.7
> Looking up port of RPC 100005/1 on 192.168.0.7
> VFS: Mounted root (nfs filesystem).
> Freeing unused kernel memory: 128k init
> Xenomai: Switching ppc405_rt to secondary mode after exception #1025 fr=
om user-space at 0xfe54f40 (pid 248)
>=20
> This is confirmed by the task stats:
>=20
> # cat /proc/xenomai/stat
>=20
> CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
>   0  0      0          2          0     00400080   99.9  ROOT
>   0  248    1          1          1*    00300380    0.0  ppc405_rt
>   0  0      0          48031      0     00000000    0.1  IRQ32: [timer]
>=20
> (*) 1 page fault caught in primary mode, causing a Xenomai mode switch.
>=20
> The test program hits a minor fault, due to a virtual memory management
> artefact, which in turn forces a Xenomai switch for your task from
> primary to secondary mode, in order to process the fault gracefully
> (basically mapping a missing page table entry). 7 us is the time needed
> to yield the control of the task to the regular kernel, then handle the
> fault in Linux context, then eventually perform the syscall. This is a
> known issue, and a solution may be available at some point, but not yet=
.
>=20
> This mailing list contains other reports of the same issue, and detaile=
d
> explanations.
>=20
> Regarding the other figures in the 2-3 us range, it is absolutely true
> that Xenomai adds some overhead to the system call path which may get
> noticeable on low-end boards. This is due to the pipelining of system
> calls to the Xenomai domain: there is more code to execute than the
> regular Linux has to run for the same task. This value may improve too
> over time, since we do have a few opportunities for optimization here.

But when I compare my values above I still get an overhead of 10us which =
is=20
at least strange and not acceptable for my application. I am asking mysel=
f=20
if it will be possible to get this fixed with xenomai or if I have to go =
a=20
completely different way.

> Last point: your measure do not take into account the possibility for
> the syscall path to be preempted by a real-time interrupt, or even by a
> plain Linux one after the task has switched to secondary mode, so you
> should always read such data with a grain of salt. In any case, you
> should never rely on a single sample.
>=20
>> #include <stdio.h>
>> #include <sys/time.h>
>> #include <time.h>
>>
>> static void
>> ppc_getcounter(unsigned long long *v)
>> {
>> 	register unsigned long tbu, tb, tbu2;
>>
>>      loop:
>> 	asm volatile ("mftbu %0" : "=3Dr" (tbu) );
>> 	asm volatile ("mftb  %0" : "=3Dr" (tb)  );
>> 	asm volatile ("mftbu %0" : "=3Dr" (tbu2));
>> 	if (__builtin_expect(tbu !=3D tbu2, 0)) goto loop;
>>
>> 	/* The slightly peculiar way of writing the next lines is
>> 	compiled better by GCC than any other way I tried. */
>> 	((long*)(v))[0] =3D tbu;
>> 	((long*)(v))[1] =3D tb;
>> }
>>
>> int main(int argc, char* argv[])
>> {
>> 	while(1) {
>> 		struct timeval tv;
>> 		unsigned long long count0, count1, count2;
>> 		ppc_getcounter(&count0);
>> 		ppc_getcounter(&count1);
>> 		gettimeofday(&tv, NULL);
>> 		ppc_getcounter(&count2);
>> 		printf("ticks for ppc_getccounter: %lld, for gettimeofday: %lld\n",
>> 			count1 - count0, count2- count1);
>> 		sleep(1);
>> 	}
>> }
>>
>>
>> Cheers


--=20
Dirk Eibach
Entwicklung
Guntermann & Drunck GmbH Systementwicklung

Telefon: +49 2739 8901-100
Fax:     +49 2739 8901-120
EMail:   mailto:eibach@domain.hid

-------------------------------------------------------------------------=
------
Guntermann & Drunck GmbH Systementwicklung
Dortmunder Str. 4a
D-57234 Wilnsdorf - Germany
Tel: +49 (0) 27 39 / 89 01 - 100  Fax: +49 (0) 27 39 / 89 01 - 120
E-Mail: mailto:sales@domain.hid Web: www.gdsys.de
-------------------------------------------------------------------------=
------
Gesch=E4ftsf=FChrer: Udo Guntermann - Martin Drunck - Reiner Ruelmann - K=
laus Tocke
HRB 2884, Amtsgericht Siegen
USt.-Id.-Nr. DE 126575222 - Steuer-Nr. 342 / 5835 / 1041
-------------------------------------------------------------------------=
------




