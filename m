Date: Fri, 25 May 2018 11:18:15 +0200 (CEST)
From: Paal Tamas <paal_to@freemail.hu>
In-Reply-To: <ed2939b9-1410-f562-fe2b-680d8ef1f616@siemens.com>
Message-ID: <freemail.20180525111815.26788.1@fmxmldata05.freemail.hu>
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

=0A=0AJan Kiszka <jan.kiszka@siemens.com> =C3=ADrta:=0A>On 2018-05-24 16:18=
, Jan Kiszka wrote:=0A>> Again, re-adding the list - please always use "rep=
ly to all".=0A>> =0A>> On 2018-05-24 13:56, Paal Tamas wrote:=0A>>>=0A>>>=
=0A>>> Jan Kiszka <jan.kiszka@siemens.com> =C3=ADrta:=0A>>>> [re-adding the=
 list]=0A>>>>=0A>>>> On 2018-05-24 13:35, Paal Tamas wrote:=0A>>>>>=0A>>>>>=
=0A>>>>> Jan Kiszka <jan.kiszka@siemens.com> =C3=ADrta:=0A>>>>>> On 2018-05=
-24 10:50, Paal Tamas wrote:=0A>>>>>>> I would like to use the same named s=
emaphore in two separate Xenomai binaries. I am using the Posix skin. It do=
es not work as I am expecting it. =0A>>>>>>> The first instance of my test =
application creates a named semaphore. It goes to sleep after that. The sec=
ond instance of the same applications starts than. It realizes that the sem=
aphore with the name already exists, so it opens it. The sem_open() returns=
 a valid (like) pointer. After that all semaphore functions in this second =
application return EINVAL (22) (Invalid argument). Both the sem_wait() and =
the sem_close() function behave this way.=0A>>>>>>>=0A>>>>>>> The same proc=
edure worked fine in 2.6.2.1 (the previous version I used). I tried 3.0.5 a=
nd the latest git repository too. The same bad behavior there.=0A>>>>>>>=0A=
>>>>>>=0A>>>>>> Did you configure userspace with --enable-pshared?=0A>>>>>>=
=0A>>>>>=0A>>>>> Yes. I invoked the "configure" script this way:=0A>>>>>=0A=
>>>>> ./configure --with-core=3Dcobalt --enable-smp --enable-pshared=0A>>>>=
=0A>>>> OK.=0A>>>>=0A>>>>>=0A>>>>> This is my configuration:=0A>>>>>=0A>>>>=
> /xeno-config --info=0A>>>>> Xenomai version: Xenomai/cobalt v3.0.6 -- #50=
ef005 (2018-05-13 16:21:13 +0200)=0A>>>>> Linux clickandmove-NUC 4.9.51xeno=
 #1 SMP Wed May 23 05:14:47 PDT 2018 x86_64 x86_64 x86_64 GNU/Linux=0A>>>>>=
 Kernel parameters: BOOT_IMAGE=3D/boot/vmlinuz-4.9.51xeno root=3DUUID=3D7e9=
0a17b-1ea0-4b84-849f-7d621fe6d580 ro quiet splash vt.handoff=3D7=0A>>>>> I-=
pipe release #5 detected=0A>>>>> Cobalt core 3.0.6 detected=0A>>>>> Compile=
r: gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.5)=0A>>>>> Build=
 args: --with-core=3Dcobalt --enable-smp --enable-pshared=0A>>>>>=0A>>>>> W=
hen I tried the git repository I cheated a bit. I could not find the config=
ure script (neither some others) and all the makefile.in files were missing=
, so I copied these files from the xenomai-3.0.6.tar.bz2. I've never tried =
the git  repositore before, always used the bz2 file(s). In case of the 3.0=
.5 version I used the bz2 file for the tests.=0A>>>>=0A>>>> Just run script=
s/bootstrap when using a git checkout.=0A>>>=0A>>> Do I need any parameters=
 to the scripts/bootstrap script in this case or I should simply run it?=0A=
>>>=0A>>>>=0A>>>> To ensure that we are truly hunting a Xenomai issue: Does=
 your testcase=0A>>>> work with plain Linux?=0A>>>>=0A>>>=0A>>> Yes, it wor=
ks fine under plain Linux. Sorry that I forgot to mention this...=0A>> =0A>=
> Confirmed.=0A>> =0A>> In fact, your test also exposes some cleanup issue:=
 When terminating a=0A>> process, Xenomai does not remove the semaphore, an=
d you need to reboot=0A>> to remove the object.=0A>=0A>Correction: This is =
not a wrong behavior, Linux does the same. The test=0A>code just has no cha=
nce to clean up a preexisting sem because of the=0A>other problem (EINVAL).=
=0A>=0A>Jan=0A>=0A>> =0A>> Will look into these problems.=0A>> =0A>> Jan=0A=
>> =0A>=0AI saw that you created some patches on this issue and modified th=
e git repository. I cloned the latest one, rebuilt Xenomai and my test appl=
ication but the original EINVAL, Invalid Argument error in case of the seco=
nd instance of the test application still exists. In other words I do not s=
ee any change in the behavior.=0AShould I rebuild the Linux kernel too?=0A=
=0AThank you,=0ATamas=0A

