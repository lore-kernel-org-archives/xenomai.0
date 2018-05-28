Date: Mon, 28 May 2018 13:10:22 +0200 (CEST)
From: Paal Tamas <paal_to@freemail.hu>
In-Reply-To: <2325d3e2-26a7-f32a-5611-166eb22d5f03@web.de>
Message-ID: <freemail.20180528131022.81320.1@fmxmldata03.freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Subject: Re: [Xenomai] Posix named semaphore used by two separate
	applications
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

=0A=0AJan Kiszka <jan.kiszka@web.de> =C3=ADrta:=0A>On 2018-05-25 11:18, Paa=
l Tamas wrote:=0A>> =0A>> =0A>> Jan Kiszka <jan.kiszka@siemens.com> =C3=ADr=
ta:=0A>>> On 2018-05-24 16:18, Jan Kiszka wrote:=0A>>>> Again, re-adding th=
e list - please always use "reply to all".=0A>>>>=0A>>>> On 2018-05-24 13:5=
6, Paal Tamas wrote:=0A>>>>>=0A>>>>>=0A>>>>> Jan Kiszka <jan.kiszka@siemens=
.com> =C3=ADrta:=0A>>>>>> [re-adding the list]=0A>>>>>>=0A>>>>>> On 2018-05=
-24 13:35, Paal Tamas wrote:=0A>>>>>>>=0A>>>>>>>=0A>>>>>>> Jan Kiszka <jan.=
kiszka@siemens.com> =C3=ADrta:=0A>>>>>>>> On 2018-05-24 10:50, Paal Tamas w=
rote:=0A>>>>>>>>> I would like to use the same named semaphore in two separ=
ate Xenomai binaries. I am using the Posix skin. It does not work as I am e=
xpecting it. =0A>>>>>>>>> The first instance of my test application creates=
 a named semaphore. It goes to sleep after that. The second instance of the=
 same applications starts than. It realizes that the semaphore with the nam=
e already exists, so it opens it. The sem_open() returns a valid (like) poi=
nter. After that all semaphore functions in this second application return =
EINVAL (22) (Invalid argument). Both the sem_wait() and the sem_close() fun=
ction behave this way.=0A>>>>>>>>>=0A>>>>>>>>> The same procedure worked fi=
ne in 2.6.2.1 (the previous version I used). I tried 3.0.5 and the latest g=
it repository too. The same bad behavior there.=0A>>>>>>>>>=0A>>>>>>>>=0A>>=
>>>>>> Did you configure userspace with --enable-pshared?=0A>>>>>>>>=0A>>>>=
>>>=0A>>>>>>> Yes. I invoked the "configure" script this way:=0A>>>>>>>=0A>=
>>>>>> ./configure --with-core=3Dcobalt --enable-smp --enable-pshared=0A>>>=
>>>=0A>>>>>> OK.=0A>>>>>>=0A>>>>>>>=0A>>>>>>> This is my configuration:=0A>=
>>>>>>=0A>>>>>>> /xeno-config --info=0A>>>>>>> Xenomai version: Xenomai/cob=
alt v3.0.6 -- #50ef005 (2018-05-13 16:21:13 +0200)=0A>>>>>>> Linux clickand=
move-NUC 4.9.51xeno #1 SMP Wed May 23 05:14:47 PDT 2018 x86_64 x86_64 x86_6=
4 GNU/Linux=0A>>>>>>> Kernel parameters: BOOT_IMAGE=3D/boot/vmlinuz-4.9.51x=
eno root=3DUUID=3D7e90a17b-1ea0-4b84-849f-7d621fe6d580 ro quiet splash vt.h=
andoff=3D7=0A>>>>>>> I-pipe release #5 detected=0A>>>>>>> Cobalt core 3.0.6=
 detected=0A>>>>>>> Compiler: gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubu=
ntu1~16.04.5)=0A>>>>>>> Build args: --with-core=3Dcobalt --enable-smp --ena=
ble-pshared=0A>>>>>>>=0A>>>>>>> When I tried the git repository I cheated a=
 bit. I could not find the configure script (neither some others) and all t=
he makefile.in files were missing, so I copied these files from the xenomai=
-3.0.6.tar.bz2. I've never tried the git  repositore before, always used th=
e bz2 file(s). In case of the 3.0.5 version I used the bz2 file for the tes=
ts.=0A>>>>>>=0A>>>>>> Just run scripts/bootstrap when using a git checkout.=
=0A>>>>>=0A>>>>> Do I need any parameters to the scripts/bootstrap script i=
n this case or I should simply run it?=0A>>>>>=0A>>>>>>=0A>>>>>> To ensure =
that we are truly hunting a Xenomai issue: Does your testcase=0A>>>>>> work=
 with plain Linux?=0A>>>>>>=0A>>>>>=0A>>>>> Yes, it works fine under plain =
Linux. Sorry that I forgot to mention this...=0A>>>>=0A>>>> Confirmed.=0A>>=
>>=0A>>>> In fact, your test also exposes some cleanup issue: When terminat=
ing a=0A>>>> process, Xenomai does not remove the semaphore, and you need t=
o reboot=0A>>>> to remove the object.=0A>>>=0A>>> Correction: This is not a=
 wrong behavior, Linux does the same. The test=0A>>> code just has no chanc=
e to clean up a preexisting sem because of the=0A>>> other problem (EINVAL)=
.=0A>>>=0A>>> Jan=0A>>>=0A>>>>=0A>>>> Will look into these problems.=0A>>>>=
=0A>>>> Jan=0A>>>>=0A>>>=0A>> I saw that you created some patches on this i=
ssue and modified the git repository. I cloned the latest one, rebuilt Xeno=
mai and my test application but the original EINVAL, Invalid Argument error=
 in case of the second instance of the test application still exists. In ot=
her words I do not see any change in the behavior.=0A>> Should I rebuild th=
e Linux kernel too?=0A>=0A>Yes, the fix is targeting the kernel code.=0A>=
=0A>Jan=0A>=0A=0AAfter rebuilding the kernel the problem is disappeared. No=
w my test program works as expected.=0AThank you very much!=0A=0ATamas=0A

