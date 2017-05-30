From: Nitin Kulkarni <nitink@kth.se>
Date: Tue, 30 May 2017 18:02:34 +0000
Message-ID: <1496167354451.78382@kth.se>
References: <mailman.117.1496166485.4225.xenomai@xenomai.org>
In-Reply-To: <mailman.117.1496166485.4225.xenomai@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] problem gpio interrupts xenomai3 on the raspberry pi
	2 (or 3)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Philippe,=0A=
>From your reply I guess its the same issue  with my SoC also. Do you think =
in my case the Intel joule pinctrl driver is not aware of Ipipe ?=0A=
Do you have any instances where an x86 based SoC was ported to solve this i=
ssue ?=0A=
Thanks for the info it explains a lot of things now.=0A=
=0A=
- Nitin =0A=
=0A=
________________________________________=0A=
From: Xenomai <xenomai-bounces@xenomai.org> on behalf of xenomai-request@xe=
nomai.org <xenomai-request@xenomai.org>=0A=
Sent: Tuesday, May 30, 2017 7:48 PM=0A=
To: xenomai@xenomai.org=0A=
Subject: Xenomai Digest, Vol 61, Issue 25=0A=
=0A=
Send Xenomai mailing list submissions to=0A=
        xenomai@xenomai.org=0A=
=0A=
To subscribe or unsubscribe via the World Wide Web, visit=0A=
        https://xenomai.org/mailman/listinfo/xenomai=0A=
or, via email, send a message with subject or body 'help' to=0A=
        xenomai-request@xenomai.org=0A=
=0A=
You can reach the person managing the list at=0A=
        xenomai-owner@xenomai.org=0A=
=0A=
When replying, please edit your Subject line so it is more specific=0A=
than "Re: Contents of Xenomai digest..."=0A=
=0A=
=0A=
Today's Topics:=0A=
=0A=
   1. Re: problem gpio interrupts xenomai3 on the raspberry pi 2=0A=
      (or 3) (Philippe Gerum)=0A=
   2. Re: problem gpio interrupts xenomai3 on the raspberry pi  2=0A=
      (or 3) (Nitin Kulkarni)=0A=
=0A=
=0A=
----------------------------------------------------------------------=0A=
=0A=
Message: 1=0A=
Date: Tue, 30 May 2017 19:30:58 +0200=0A=
From: Philippe Gerum <rpm@xenomai.org>=0A=
To: Harco Kuppens <h.kuppens@cs.ru.nl>, xenomai@xenomai.org=0A=
Subject: Re: [Xenomai] problem gpio interrupts xenomai3 on the=0A=
        raspberry pi 2 (or 3)=0A=
Message-ID: <cb912c40-1247-6395-9a84-a3203dd5f022@xenomai.org>=0A=
Content-Type: text/plain; charset=3Dutf-8=0A=
=0A=
On 05/30/2017 06:38 PM, Harco Kuppens wrote:=0A=
> So I decided to also  test these wiringpi test programs on mine build=0A=
> xenomai 3 image for the rpi2. Unfortunately the isr.c wiringpi program=0A=
> didn't work anymore on mine build image. So even without using xenomai3,=
=0A=
> but just using linux the pi2 just hangs and a hard reset was needed.=0A=
>=0A=
> Thus I guess there is still something wrong with mine image?=0A=
> Does anybody know what I'm doing wrong?=0A=
> Or is this still a bug in the gpio library or in the patches applied?=0A=
>=0A=
=0A=
It looks obvious that you tried hard and got your feet wet with Xenomai=0A=
already, so let's go straight to the point: the lockup issue when using=0A=
GPIO interrupts is most likely due to the I-pipe patch not properly=0A=
adapting the GPIO chip driver for dealing with IRQ virtualization.=0A=
=0A=
In short, each IRQ controller which may be active on a SoC must be=0A=
driven by I-pipe aware code. For instance, the bcm2835 family has common=0A=
GPIOs controlled by the driver at drivers/pinctrl/pinctrl-bcm2835.c. If=0A=
that driver has not been patched specifically for supporting the IRQ=0A=
pipeline, then this won't work with Xenomai, and may well end up with=0A=
painful IRQ storms causing a machine hang. The same goes for any other=0A=
chip serving as an IRQ controller you might need on your platform.=0A=
=0A=
So, first and foremost, I would recommend to make sure the I-pipe code=0A=
is right for your kernel, then build on top of that. A good way to=0A=
figure out which IRQ controllers are active is look at the output of=0A=
/proc/interrupts on a kernel that disables the interrupt pipeline.=0A=
Each IRQ information mentions the label of the controller which deals=0A=
with it. With that information, you need to cross-check whether the=0A=
corresponding IRQ chip driver (the one that bears this label in the=0A=
irq_chip descriptor structure) was made I-pipe aware.=0A=
=0A=
Some time ago, I ported Xenomai 3 to the PI Zero (kernel 4.1.18), which=0A=
is based on the bcm2835 SoC like the PI 1 series. That code is available=0A=
from the vendors/raspberry/ipipe-4.1 branch at=0A=
git://git.xenomai.org/ipipe.git. This may be a good starting point, at=0A=
least for testing with a PI 1, before working on the required fixups for=0A=
supporting other Broadcom SoCs.=0A=
=0A=
IIRC, RPI 2B and RPI 3 are based on the bcm2836, bcm2837 SoCs resp.,=0A=
which are not covered by the port just mentioned. You may find some=0A=
preliminary I-pipe related changes in the bcm2836 core interrupt support=0A=
code, but those have never been tested. By preliminary, I mean that=0A=
there is likely a few more IRQ controllers to make I-pipe aware on these=0A=
SoCs, aside of testing the initial changes.=0A=
=0A=
Bottom line: using a stock I-pipe patch is unlikely to work out of the=0A=
box. The fact that such patch does support several SoCs equipped with=0A=
Cortex A7/A9 CPUs is by no mean a guarantee that all Cortex-based SoCs=0A=
are supported by the same code.=0A=
=0A=
--=0A=
Philippe.=0A=
=0A=
=0A=
=0A=
------------------------------=0A=
=0A=
Message: 2=0A=
Date: Tue, 30 May 2017 17:47:58 +0000=0A=
From: Nitin Kulkarni <nitink@kth.se>=0A=
To: "xenomai@xenomai.org" <xenomai@xenomai.org>, "h.kuppens@cs.ru.nl"=0A=
        <h.kuppens@cs.ru.nl>=0A=
Subject: Re: [Xenomai] problem gpio interrupts xenomai3 on the=0A=
        raspberry pi    2 (or 3)=0A=
Message-ID: <1496166479457.35714@kth.se>=0A=
Content-Type: text/plain; charset=3D"iso-8859-1"=0A=
=0A=
Hi Harco,=0A=
Even I have a similar issue which I posted yesterday. Subject was "GPIO Int=
errupt is registered in Xenomai but handler is not=0A=
invoked when triggered". In my case I am not using an Intel Joule module.=
=0A=
I have searched a bit and I think its an issue with the ipipe patch and GPI=
O irq handling. My rtdm irq is registered and it shows in the /proc/xenomai=
/irq file but it is not triggered.=0A=
=0A=
I am waiting for someone to reply, I am sure I missing something here or it=
s an issue with few of the GPIO drivers not being aware of Ipipe.=0A=
=0A=
@Others: If you have experienced similar issues please let me know.=0A=
=0A=
-Nitin=0A=
=0A=
________________________________________=0A=
From: Xenomai <xenomai-bounces@xenomai.org> on behalf of xenomai-request@xe=
nomai.org <xenomai-request@xenomai.org>=0A=
Sent: Tuesday, May 30, 2017 6:38 PM=0A=
To: xenomai@xenomai.org=0A=
Subject: Xenomai Digest, Vol 61, Issue 24=0A=
=0A=
Send Xenomai mailing list submissions to=0A=
        xenomai@xenomai.org=0A=
=0A=
To subscribe or unsubscribe via the World Wide Web, visit=0A=
        https://xenomai.org/mailman/listinfo/xenomai=0A=
or, via email, send a message with subject or body 'help' to=0A=
        xenomai-request@xenomai.org=0A=
=0A=
You can reach the person managing the list at=0A=
        xenomai-owner@xenomai.org=0A=
=0A=
When replying, please edit your Subject line so it is more specific=0A=
than "Re: Contents of Xenomai digest..."=0A=
=0A=
=0A=
Today's Topics:=0A=
=0A=
   1. Re: dlopen failing when using shared library on xenomai 3.0.4=0A=
      (Fyleo)=0A=
   2. Re: dlopen failing when using shared library on xenomai 3.0.4=0A=
      (Fyleo)=0A=
   3. Re: dlopen failing when using shared library on xenomai 3.0.4=0A=
      (Philippe Gerum)=0A=
   4. vortex86dx (ali hagigat)=0A=
   5. Re: Problem with the T_LOCK (Philippe Gerum)=0A=
   6. problem gpio interrupts xenomai3 on the raspberry pi 2    (or 3)=0A=
      (Harco Kuppens)=0A=
=0A=
=0A=
----------------------------------------------------------------------=0A=
=0A=
Message: 1=0A=
Date: Tue, 30 May 2017 12:17:59 +0200=0A=
From: Fyleo <fyleo45@gmail.com>=0A=
To: xenomai@xenomai.org=0A=
Subject: Re: [Xenomai] dlopen failing when using shared library on=0A=
        xenomai 3.0.4=0A=
Message-ID: <bbc4317c-2238-b9f1-0e4d-10a683618af8@gmail.com>=0A=
Content-Type: text/plain; charset=3Dutf-8; format=3Dflowed=0A=
=0A=
=0A=
> Le 29/05/2017 ? 23:19, Fyleo a ?crit :=0A=
>> Hello all,=0A=
>>=0A=
>> I'm trying to port machinekit (machinekit.io) to xenomai 3.0.4 which=0A=
>> support only xenomai 2.6.4 for the moment.=0A=
>>=0A=
>> This software is design this way :=0A=
>>=0A=
>> A : main executable=0A=
>>=0A=
>> B : shared library abstracting thread API, with one library for=0A=
>> posix, for xenomai, ...=0A=
>>=0A=
>> The xenomai B library is linked against alchemy, copperplate, ...=0A=
>> (xeno-config --ldflags --auto-init-solib --skin=3Dalchemy)=0A=
>>=0A=
>> The program works in a way that, at start time, it load with dlopen=0A=
>> the configured API (B).=0A=
>>=0A=
>> My problem is that dlopen(with RTLD_GLOBAL|RTLD_NOW) fail with the=0A=
>> error : "/usr/lib/libcopperplate.so.0: undefined symbol: main"=0A=
>>=0A=
>> Here is the simplified test case to reproduce the problem :=0A=
>>=0A=
>> main.c:=0A=
>>     #include <stdio.h>=0A=
>>     #include <stdlib.h>=0A=
>>     #include <dlfcn.h>=0A=
>>=0A=
>>     int main(int argc, char *const argv[])=0A=
>>     {=0A=
>>         void *handle;=0A=
>>=0A=
>>         handle =3D dlopen("./ulapi-xenomai.so", RTLD_GLOBAL|RTLD_NOW);=
=0A=
>>         if (!handle) {=0A=
>>             fprintf(stderr, "%s\n", dlerror());=0A=
>>             exit(EXIT_FAILURE);=0A=
>>         }=0A=
>>=0A=
>>         dlclose(handle);=0A=
>>         exit(EXIT_SUCCESS);=0A=
>>     }=0A=
>>=0A=
>> gcc main.c -o testcase -ldl=0A=
>> gcc -Wl,-soname,ulapi-xenomai.so -shared -o ulapi-xenomai.so=0A=
>> `xeno-config --ldflags --auto-init-solib --skin=3Dalchemy`=0A=
>>=0A=
>> run testcase=0A=
>>=0A=
>> I am missing something or is there a solution that doesn't imply to=0A=
>> use RTLD_LAZY ?=0A=
>>=0A=
>> my xeno-config --info=0A=
>> Xenomai version: Xenomai/cobalt v3.0.4=0A=
>> Linux beaglebone 4.4.62-ti-xenomai-r105 #1 SMP Wed May 24 00:09:09=0A=
>> UTC 2017 armv7l GNU/Linux=0A=
>> Kernel parameters: console=3DttyO0,115200n8=0A=
>> capemgr.disable_partno=3DBB-BONELT-HDMI=0A=
>> bone_capemgr.uboot_capemgr_enabled=3D1 root=3D/dev/mmcblk0p1 ro=0A=
>> rootfstype=3Dext4 rootwait coherent_pool=3D1M net.ifnames=3D0 quiet=0A=
>> I-pipe release #7 detected=0A=
>> Cobalt core 3.0.4 detected=0A=
>> Compiler: gcc version 4.9.2 (Debian 4.9.2-10)=0A=
>> Build args: --prefix=3D/usr --includedir=3D/usr/include/xenomai=0A=
>> --mandir=3D/usr/share/man --with-testdir=3D/usr/lib/xenomai/testsuite=0A=
>> --enable-dlopen-libs --enable-smp --build arm-linux-gnueabihf=0A=
>> build_alias=3Darm-linux-gnueabihf=0A=
>>=0A=
>> Regards,=0A=
>>=0A=
>> Fyleo=0A=
>>=0A=
>> _______________________________________________=0A=
>> Xenomai mailing list=0A=
>> Xenomai@xenomai.org=0A=
>> https://xenomai.org/mailman/listinfo/xenomai=0A=
On 30/05/2017 09:22, St?phane Ancelot wrote:=0A=
> Hi,=0A=
>=0A=
> Why don't you link the shared lib at compilation ?=0A=
>=0A=
> Regards,=0A=
> S.Ancelot=0A=
Hi,=0A=
=0A=
Because there is multiple ulapi that can be loaded at execution time to=0A=
switch between posix (non-xenomai) thread, xenomai thread, rtai thread=0A=
and so on, depending on environnement variable.=0A=
It is not my program so i want to be less invasive as possible.=0A=
=0A=
Regards,=0A=
Fyleo=0A=
=0A=
=0A=
=0A=
=0A=
------------------------------=0A=
=0A=
Message: 2=0A=
Date: Tue, 30 May 2017 12:23:01 +0200=0A=
From: Fyleo <fyleo45@gmail.com>=0A=
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org=0A=
Subject: Re: [Xenomai] dlopen failing when using shared library on=0A=
        xenomai 3.0.4=0A=
Message-ID: <90600d56-7dfa-7726-f25b-d9301a915820@gmail.com>=0A=
Content-Type: text/plain; charset=3Dutf-8; format=3Dflowed=0A=
=0A=
On 30/05/2017 09:12, Philippe Gerum wrote:=0A=
> On 05/29/2017 11:19 PM, Fyleo wrote:=0A=
>> Hello all,=0A=
>>=0A=
>> I'm trying to port machinekit (machinekit.io) to xenomai 3.0.4 which=0A=
>> support only xenomai 2.6.4 for the moment.=0A=
>>=0A=
>> This software is design this way :=0A=
>>=0A=
>> A : main executable=0A=
>>=0A=
>> B : shared library abstracting thread API, with one library for posix,=
=0A=
>> for xenomai, ...=0A=
>>=0A=
>> The xenomai B library is linked against alchemy, copperplate, ...=0A=
>> (xeno-config --ldflags --auto-init-solib --skin=3Dalchemy)=0A=
>>=0A=
>> The program works in a way that, at start time, it load with dlopen the=
=0A=
>> configured API (B).=0A=
>>=0A=
>> My problem is that dlopen(with RTLD_GLOBAL|RTLD_NOW) fail with the error=
=0A=
>> : "/usr/lib/libcopperplate.so.0: undefined symbol: main"=0A=
>>=0A=
> Could you pick the change below and retry? Feedback welcome.=0A=
>=0A=
> http://git.xenomai.org/xenomai-3.git/commit/?id=3D48b2e57e29ca1c33eba14ab=
b4b5eaa15431130fa=0A=
>=0A=
Hi,=0A=
=0A=
This fix works, thanks.=0A=
=0A=
But will it always work in executable auto init ? The symbol=0A=
"__real_main" have to be defined in user code if linked with bootstrap.o ?=
=0A=
=0A=
Fyleo=0A=
=0A=
=0A=
=0A=
=0A=
------------------------------=0A=
=0A=
Message: 3=0A=
Date: Tue, 30 May 2017 12:39:46 +0200=0A=
From: Philippe Gerum <rpm@xenomai.org>=0A=
To: Fyleo <fyleo45@gmail.com>, xenomai@xenomai.org=0A=
Subject: Re: [Xenomai] dlopen failing when using shared library on=0A=
        xenomai 3.0.4=0A=
Message-ID: <5f442ab6-0cf8-2c5d-bfca-53a0c2fa5ecd@xenomai.org>=0A=
Content-Type: text/plain; charset=3Dutf-8=0A=
=0A=
On 05/30/2017 12:23 PM, Fyleo wrote:=0A=
> On 30/05/2017 09:12, Philippe Gerum wrote:=0A=
>> On 05/29/2017 11:19 PM, Fyleo wrote:=0A=
>>> Hello all,=0A=
>>>=0A=
>>> I'm trying to port machinekit (machinekit.io) to xenomai 3.0.4 which=0A=
>>> support only xenomai 2.6.4 for the moment.=0A=
>>>=0A=
>>> This software is design this way :=0A=
>>>=0A=
>>> A : main executable=0A=
>>>=0A=
>>> B : shared library abstracting thread API, with one library for posix,=
=0A=
>>> for xenomai, ...=0A=
>>>=0A=
>>> The xenomai B library is linked against alchemy, copperplate, ...=0A=
>>> (xeno-config --ldflags --auto-init-solib --skin=3Dalchemy)=0A=
>>>=0A=
>>> The program works in a way that, at start time, it load with dlopen the=
=0A=
>>> configured API (B).=0A=
>>>=0A=
>>> My problem is that dlopen(with RTLD_GLOBAL|RTLD_NOW) fail with the erro=
r=0A=
>>> : "/usr/lib/libcopperplate.so.0: undefined symbol: main"=0A=
>>>=0A=
>> Could you pick the change below and retry? Feedback welcome.=0A=
>>=0A=
>> http://git.xenomai.org/xenomai-3.git/commit/?id=3D48b2e57e29ca1c33eba14a=
bb4b5eaa15431130fa=0A=
>>=0A=
>>=0A=
> Hi,=0A=
>=0A=
> This fix works, thanks.=0A=
>=0A=
> But will it always work in executable auto init ? The symbol=0A=
> "__real_main" have to be defined in user code if linked with bootstrap.o =
?=0A=
>=0A=
=0A=
__real_main() stands for the actual main as generated by the linker when=0A=
the auto-bootstrap feature is in effect (i.e. --wrap=3Dmain=0A=
--dynamic-list=3D...), and bootstrap.o is glued to executables/DSOs only=0A=
in such a case. IOW, __real_main() is guaranteed to exist if bootstrap.o=0A=
is part of the binary image.=0A=
=0A=
So yes, we should be safe. This change has been tested with the alchemy=0A=
testsuite which is copperplate-based, a C++ application enabling=0A=
auto-init-solib, and Xenomai's base utility programs enabling the=0A=
auto-bootstrap, so far so good.=0A=
=0A=
--=0A=
Philippe.=0A=
=0A=
=0A=
=0A=
------------------------------=0A=
=0A=
Message: 4=0A=
Date: Tue, 30 May 2017 17:32:09 +0430=0A=
From: ali hagigat <hagigatali@gmail.com>=0A=
To: xenomai@xenomai.org=0A=
Subject: [Xenomai] vortex86dx=0A=
Message-ID:=0A=
        <CAKKWdtfpTs1O5b-ihm2JP8vSm7KxZn7YAaOGO6Zy3H7we=3DSAYw@mail.gmail.c=
om>=0A=
Content-Type: text/plain; charset=3D"UTF-8"=0A=
=0A=
I use xenomai for vortex86dx and cpc307 board. the kernel hangs. why?=0A=
=0A=
=0A=
Linux version 2.6.30 (am@localhost.localdomain) (gcc version 4.9.3=0A=
(Buildroot 2016.05) ) #6 Tue May 30 12:41:26 IRDT 2017=0A=
KERNEL supported cpus:**************************************=0A=
  Intel GenuineIntel*      Please select boot device:      *=0A=
  AMD AuthenticAMD  ****************************************=0A=
  NSC Geode by NSC  * HDD:PM-Fastwel Embedded ATA Fla      *=0A=
  Cyrix CyrixInstead* USB:JetFlash Transcend               *=0A=
  Centaur CentaurHauls<Enter Setup>                        *=0A=
  Transmeta GenuineTMx86                                   *=0A=
  Transmeta TransmetaCPU                                   *=0A=
  UMC UMC UMC UMC   *                                      *=0A=
CPU: vendor_id 'Vortex86 SoC' unknown, using generic init. *=0A=
CPU: Your system may be unstable.                          *=0A=
BIOS-provided physical RAM map:*****************************=0A=
 BIOS-e820: 0000000000000000 - 000000000009a000 (usable)   *=0A=
 BIOS-e820: 000000000009a000 - 00000000000a0000 (reserved) *=0A=
 BIOS-e820: 00000000000efff0 - 0000000000100000 (reserved) *=0A=
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)****=0A=
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)=0A=
DMI not present or invalid.=0A=
last_pfn =3D 0x10000 max_arch_pfn =3D 0x100000=0A=
init_memory_mapping: 0000000000000000-0000000010000000=0A=
256MB LOWMEM available.=0A=
  mapped low ram: 0 - 100000004 bytes nvram=0A=
  low ram: 0 - 10000000 interface driver hiddev=0A=
  node 0 low ram: 00000000 - 10000000ver usbhid=0A=
  node 0 bootmap 00001000 - 00003000=0A=
(6 early reservations) =3D=3D> bootmem [0000000000 - 0010000000]=0A=
  #0 [0000000000 - 0000001000]   BIOS data page =3D=3D> [0000000000 - 00000=
01000]=0A=
  #1 [0000100000 - 000043e824]    TEXT DATA BSS =3D=3D> [0000100000 - 00004=
3e824]=0A=
  #2 [000009a000 - 0000100000]    BIOS reserved =3D=3D> [000009a000 - 00001=
00000]=0A=
  #3 [000043f000 - 0000441000]              BRK =3D=3D> [000043f000 - 00004=
41000]4)=0A=
  #4 [0000007000 - 0000045000]          PGTABLE =3D=3D> [0000007000 - 00000=
45000]=0A=
  #5 [0000001000 - 0000003000]          BOOTMAP =3D=3D> [0000001000 - 00000=
03000]=0A=
Zone PFN ranges:correct "root=3D" boot option; here are the available parti=
tions:=0A=
  DMA      0x00000000 -> 0x00001000e-gd=0A=
  Normal   0x00001000 -> 0x00010000=0A=
Movable zone start PFN for each node=0A=
early_node_map[2] active PFN rangesable to mount root fs on unknown-block(0=
,0)=0A=
    0: 0x00000000 -> 0x0000009aed 2.6.30 #5=0A=
    0: 0x00000100 -> 0x00010000=0A=
Allocating PCI resources starting at 20000000 (gap: 10000000:ef000000)=0A=
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64922=
=0A=
Kernel command line: root=3D/dev/sda2 nosmp tsc=3Dreliable rootdelay=3D15 r=
w=0A=
console=3DttyS0,115200n8 init=3D/bin/busybox init BOOT_IMAGE=3Dbzima=0A=
Initializing CPU#0t_root+0x4f/0x57=0A=
Experimental hierarchical RCU implementation.=0A=
Experimental hierarchical RCU init done.=0A=
NR_IRQS:167>] ? kernel_init+0x0/0xb2=0A=
PID hash table entries: 1024 (order: 10, 4096 bytes)=0A=
Fast TSC calibration using PIT=0A=
Detected 599.908 MHz processor.=0A=
I-pipe 2.4-05: pipeline enabled.=0A=
Console: colour dummy device 80x25=0A=
console [ttyS0] enabled=0A=
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)=0A=
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)=0A=
Memory: 255720k/262144k available (2056k kernel code, 5832k reserved,=0A=
873k data, 188k init, 0k highmem)=0A=
virtual kernel memory layout:=0A=
    fixmap  : 0xfffeb000 - 0xfffff000   (  80 kB)=0A=
    vmalloc : 0xd0800000 - 0xfffe9000   ( 759 MB)=0A=
    lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)=0A=
      .init : 0xc03e0000 - 0xc040f000   ( 188 kB)=0A=
      .data : 0xc030224b - 0xc03dc85c   ( 873 kB)=0A=
      .text : 0xc0100000 - 0xc030224b   (2056 kB)=0A=
Checking if this processor honours the WP bit even in supervisor mode...Ok.=
=0A=
Calibrating delay loop (skipped), value calculated using timer=0A=
frequency.. 1199.81 BogoMIPS (lpj=3D5999080)=0A=
Mount-cache hash table entries: 512=0A=
CPU: Vortex86 SoC 05/02 stepping 02=0A=
Checking 'hlt' instruction... OK.=0A=
net_namespace: 296 bytes=0A=
NET: Registered protocol family 16=0A=
PCI: Using configuration type 1 for base access=0A=
bio: create slab <bio-0> at 0=0A=
SCSI subsystem initialized=0A=
usbcore: registered new interface driver usbfs=0A=
usbcore: registered new interface driver hub=0A=
usbcore: registered new device driver usb=0A=
PCI: Probing PCI hardware=0A=
pci 0000:00:07.0: default IRQ router [17f3:6031]=0A=
NET: Registered protocol family 2=0A=
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)=0A=
TCP established hash table entries: 8192 (order: 4, 65536 bytes)=0A=
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)=0A=
TCP: Hash tables configured (established 8192 bind 8192)=0A=
TCP reno registered=0A=
NET: Registered protocol family 1=0A=
platform rtc_cmos: registered platform RTC device (no PNP device found)=0A=
I-pipe: Domain Xenomai registered.=0A=
Xenomai: hal/i386 started.=0A=
Xenomai: scheduling class idle registered.=0A=
Xenomai: scheduling class rt registered.=0A=
Xenomai: real-time nucleus v2.6.5 (Lost in a Memory) loaded.=0A=
Xenomai: debug mode enabled.=0A=
Xenomai: starting native API services.=0A=
Xenomai: starting POSIX services.=0A=
Xenomai: starting RTDM services.=0A=
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).=0A=
msgmni has been set to 499=0A=
io scheduler noop registered=0A=
io scheduler anticipatory registered=0A=
io scheduler deadline registered (default)=0A=
isapnp: Scanning for PnP cards...=0A=
isapnp: No Plug & Play device found=0A=
Serial: 8250/16550 driver, 12 ports, IRQ sharing enabled=0A=
?serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A=0A=
serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A=0A=
serial8250: ttyS2 at I/O 0x3e8 (irq =3D 4) is a 16550A=0A=
serial8250: ttyS3 at I/O 0x2e8 (irq =3D 3) is a 16550A=0A=
brd: module loaded=0A=
loop: module loaded=0A=
usbcore: registered new interface driver ub=0A=
Uniform Multi-Platform E-IDE driver=0A=
piix 0000:00:0c.0: IDE controller (0x17f3:0x1011 rev 0x01)=0A=
PIIX_IDE 0000:00:0c.0: guessed PCI INT A -> IRQ 14=0A=
piix 0000:00:0c.0: IDE port disabled=0A=
piix 0000:00:0c.0: not 100% native mode: will probe irqs later=0A=
    ide0: BM-DMA at 0xfb00-0xfb07=0A=
hda: Fastwel Embedded ATA Flash Disk, ATA DISK drive=0A=
=0A=
=0A=
=0A=
------------------------------=0A=
=0A=
Message: 5=0A=
Date: Tue, 30 May 2017 17:04:23 +0200=0A=
From: Philippe Gerum <rpm@xenomai.org>=0A=
To: Aur?lien Le Floc'h <le.floch.aurelien94@gmail.com>,=0A=
        xenomai@xenomai.org=0A=
Subject: Re: [Xenomai] Problem with the T_LOCK=0A=
Message-ID: <f8e492cb-9b0a-ff9b-da48-5cd86a27ccb1@xenomai.org>=0A=
Content-Type: text/plain; charset=3Dutf-8=0A=
=0A=
On 05/22/2017 05:45 PM, Aur?lien Le Floc'h wrote:=0A=
> Hello everyone,=0A=
>=0A=
>=0A=
> I am working on task priority with Xenomai. I am trying to create some=0A=
> example of preemption depending on the task priority. For now I have=0A=
> some example which works thanks to new patch on Xenomai-3.0.5. To work=0A=
> on this example I work on a single core hardware (in my case a=0A=
> Raspberry Pi B+) which runs Xenomai 3 generated by Buildroot.=0A=
>=0A=
> On all this program you have one father thread which creates two=0A=
> childrens threads (child1 and child2). We are on a single core so two=0A=
> thread can?t run at the same time. In this configuration it is=0A=
> possible to provide an order of apparition of my printf. To execute=0A=
> all my program the priority order to give in entry is ./Program_name=0A=
> prio_thread_father prio_thread_child1 prio_thread_child2=0A=
>=0A=
>=0A=
> In this program (attached in this email) I am trying to use the T_LOCK=0A=
> in rt_task_create. My goal is to create the thread_father with T_LOCK=0A=
> the child1 and child2 with T_JOINABLE.=0A=
> The goal is that the father is always terminating before the child=0A=
> even if his priority is lower than the child.=0A=
>=0A=
> For example if prio_father < prio_child2 < prio_child1 this is the output=
=0A=
> Entry in task_father!=0A=
> End of task_father!=0A=
> Entry in task_child2!=0A=
> Entry in task_child1!=0A=
>=0A=
> Now the output is like this :=0A=
> DEBUG=0A=
> Entry in task_father!=0A=
> Entry in task_child1!=0A=
> Entry in task_child2!=0A=
> End of task_father!=0A=
>=0A=
> It's seems that the T_LOCK argument in rt_task_create has no effect=0A=
> and only the priority keeps the effect. I try to lock the scheduler=0A=
> with mutex and it's work. But my goal is to have the same result with=0A=
> T_LOCK.=0A=
> Do you have some advices ?=0A=
>=0A=
=0A=
This pattern cannot work. As part of the start up protocol for a thread,=0A=
the parent explicitly blocks waiting for the child to handshake=0A=
internally, as explained earlier. A thread that blocks relinquishes the=0A=
scheduler lock while it sleeps.=0A=
=0A=
My advice would be to forget about T_LOCK, this turns out to be=0A=
error-prone, especially in complex applications, not to speak of the=0A=
performance issue. If you really need some kind of thread factory,=0A=
explicit synchronization (sems, condvars) is a better option.=0A=
=0A=
Besides, I would recommend to stick with POSIX if using the alchemy API=0A=
is not a requirement.=0A=
=0A=
--=0A=
Philippe.=0A=
=0A=
=0A=
=0A=
------------------------------=0A=
=0A=
Message: 6=0A=
Date: Tue, 30 May 2017 18:38:30 +0200=0A=
From: Harco Kuppens <h.kuppens@cs.ru.nl>=0A=
To: xenomai@xenomai.org=0A=
Subject: [Xenomai] problem gpio interrupts xenomai3 on the raspberry=0A=
        pi 2    (or 3)=0A=
Message-ID: <46850988-a862-b747-f11d-1191f7e13458@cs.ru.nl>=0A=
Content-Type: text/plain; charset=3Dutf-8; format=3Dflowed=0A=
=0A=
note: all resources referred to  in this email can be found in the=0A=
public repository at https://github.com/harcokuppens/xenomai3_rpi2_gpio/=0A=
=0A=
At the  Radboud University Nijmegen we are already succesfully using=0A=
xenomai 2 for several years in a course about embedded systems.=0A=
Currently we are using old intel pc's which need to be replaced. The=0A=
idea is to replace them with the raspberry pi2 or pi3. We already=0A=
managed to get xenomai2 to work on the raspberry pi1 but installing=0A=
xenomai3 seems problematic and is becoming replace with the pi2 and pi3,=0A=
so we deciced to  go for the pi2 or pi3.=0A=
=0A=
We found on the internet several descriptions pages which describe how=0A=
to install xenomai on a raspberry pi2/3.=0A=
An overview of these links can  be found at :=0A=
https://github.com/harcokuppens/xenomai3_rpi2_gpio/blob/master/install/over=
view_xenomai3_installations_found_online.txt=0A=
=0A=
note: some instructions are in japanese or french but with the help of=0A=
google translate they are easy to read.=0A=
=0A=
I managed to install xenomai3 on the rpi2, you can find mine=0A=
installation instructions at :=0A=
=0A=
https://github.com/harcokuppens/xenomai3_rpi2_gpio/blob/master/install/inst=
all_xenomai-3-3.0.5_on_rpi2.txt=0A=
=0A=
Everything seems fine except for the interrupt handling!=0A=
=0A=
In=0A=
https://github.com/harcokuppens/xenomai3_rpi2_gpio/blob/master/circuit/butt=
on_toggles_led.png=0A=
is displayed the electronic=0A=
circuit I build to do my tests. It consists of two simple circuits :=0A=
=0A=
 1.   led circuit :=0A=
    https://github.com/harcokuppens/xenomai3_rpi2_gpio/blob/master/circuit/=
led.png=0A=
 2. pullup circuit with a switch to trigger an interrupt :=0A=
    https://github.com/harcokuppens/xenomai3_rpi2_gpio/blob/master/circuit/=
pullup.png=0A=
=0A=
I tried both a xenomai program in user space and kernel space=0A=
(gpiotest).  In user space the pi just hangs, and I need a hard reboot.=0A=
In kernel space no interrupt happens at all. Maybe I do something wrong=0A=
in kernel space.=0A=
=0A=
At some point I was afraid that maybe my pi was broke, so I installed=0A=
the standard raspbian image, which is just linux, and runned some=0A=
interrupt test program within linux in userspace using the wiringpi=0A=
library. These programs just worked fine. My pi2 wasn't broken :)=0A=
You can find the programs at :=0A=
https://github.com/harcokuppens/xenomai3_rpi2_gpio/tree/master/examples/wir=
ingpi_examples/=0A=
=0A=
So I decided to also  test these wiringpi test programs on mine build=0A=
xenomai 3 image for the rpi2. Unfortunately the isr.c wiringpi program=0A=
didn't work anymore on mine build image. So even without using xenomai3,=0A=
but just using linux the pi2 just hangs and a hard reset was needed.=0A=
=0A=
Thus I guess there is still something wrong with mine image?=0A=
Does anybody know what I'm doing wrong?=0A=
Or is this still a bug in the gpio library or in the patches applied?=0A=
=0A=
Hope someone can help me, so that we can switch to xenomai3 on the=0A=
rpi2/3  in the course next semester.=0A=
=0A=
Best regards,=0A=
Harco Kuppens=0A=
=0A=
ps. there is a newer version of the rpi2 called v1.2  which has the same=0A=
cpu as the rpi3. But if the problem can be solved for the pi3 I'm also=0A=
very happy. I tried the same procedure for the pi3 based on the=0A=
instructions linked in=0A=
https://github.com/harcokuppens/xenomai3_rpi2_gpio/blob/master/install/over=
view_xenomai3_installations_found_online.txt=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
------------------------------=0A=
=0A=
Subject: Digest Footer=0A=
=0A=
_______________________________________________=0A=
Xenomai mailing list=0A=
Xenomai@xenomai.org=0A=
https://xenomai.org/mailman/listinfo/xenomai=0A=
=0A=
=0A=
------------------------------=0A=
=0A=
End of Xenomai Digest, Vol 61, Issue 24=0A=
***************************************=0A=
=0A=
=0A=
=0A=
------------------------------=0A=
=0A=
Subject: Digest Footer=0A=
=0A=
_______________________________________________=0A=
Xenomai mailing list=0A=
Xenomai@xenomai.org=0A=
https://xenomai.org/mailman/listinfo/xenomai=0A=
=0A=
=0A=
------------------------------=0A=
=0A=
End of Xenomai Digest, Vol 61, Issue 25=0A=
***************************************=0A=

