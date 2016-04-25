From: Alex Plits <alex_plits@radwin.com>
Date: Mon, 25 Apr 2016 11:42:23 +0000
Message-ID: <DB5PR06MB128784C4F8B0B3FAE38C0B358F620@DB5PR06MB1287.eurprd06.prod.outlook.com>
References: <DB5PR06MB1287CCF7EAF55DA6F95ED4A68F9D0@DB5PR06MB1287.eurprd06.prod.outlook.com>
 <20160405070232.GI20399@hermes.click-hack.org>
 <AM3PR06MB1282EDA8459215FC1B64D3118F900@AM3PR06MB1282.eurprd06.prod.outlook.com>
 <57069F3E.3070309@xenomai.org>
 <DB5PR06MB128755E41DF13905760BB2438F620@DB5PR06MB1287.eurprd06.prod.outlook.com>
 <571DF3C0.7050502@xenomai.org> <571DF45B.7070703@xenomai.org>
In-Reply-To: <571DF45B.7070703@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Mixing Posix RT APIs and vxWorks APIs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>



> -----Original Message-----
> From: Philippe Gerum [mailto:rpm@xenomai.org]
> Sent: Monday, April 25, 2016 1:42 PM
> To: Alex Plits; Gilles Chanteperdrix
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai] Mixing Posix RT APIs and vxWorks APIs
>=20
> On 04/25/2016 12:38 PM, Philippe Gerum wrote:
> > On 04/25/2016 12:03 PM, Alex Plits wrote:
> >>
> >>
> >>> -----Original Message-----
> >>> From: Philippe Gerum [mailto:rpm@xenomai.org]
> >>> Sent: Thursday, April 07, 2016 8:56 PM
> >>> To: Alex Plits; Gilles Chanteperdrix
> >>> Cc: xenomai@xenomai.org
> >>> Subject: Re: [Xenomai] Mixing Posix RT APIs and vxWorks APIs
> >>>
> >>> On 04/07/2016 07:56 AM, Alex Plits wrote:
> >>>>
> >>>>
> >>>>> -----Original Message-----
> >>>>> From: Gilles Chanteperdrix
> >>>>> [mailto:gilles.chanteperdrix@xenomai.org]
> >>>>> Sent: Tuesday, April 05, 2016 10:03 AM
> >>>>> To: Alex Plits
> >>>>> Cc: xenomai@xenomai.org
> >>>>> Subject: Re: [Xenomai] Mixing Posix RT APIs and vxWorks APIs
> >>>>>
> >>>>> On Mon, Apr 04, 2016 at 01:42:11PM +0000, Alex Plits wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> We are currently porting some of our vxWorks  xenomai
> >>>>>> (copperplate) APIs we use in our application to Posix (cobalt I gu=
ess).
> >>>>>
> >>>>> Well, if you do not know whether you are using Cobalt or Mercury,
> >>>>> we can not know it for you...
> >>>> [Alex Plits]
> >>>> Cobalt :)
> >>>>>
> >>>>>> We have started with the VxWorks "tasks" but it seems that we're
> >>>>>> getting strange behavior on The remaining VxWorks APIs when used
> >>>>>> from
> >>>>> the POSIX generated tasks (threads is the right word in posix) e.g.
> >>>>> MsqQRecv function gets segfault but when it is used From a VxWorks
> >>>>> generated task it works fine.
> >>>>>> I understand from the comments in code it should work but I was
> >>>>> wondering if there are known issues.
> >>>>>>
> >>>>>> We are using currently xenomai 3 rc-6 (I saw there were fixes in
> >>>>>> xenomai
> >>>>> 3.0.2).
> >>>>>
> >>>>> Could you send a self-contained, simplest possible test case which
> >>>>> causes the problem for you, that we can test on the latest Xenomai
> >>>>> release to see if the problem has not been already fixed?
> >>>>>
> >>>> [Alex Plits]
> >>>> Attached code that is ripped from xenomai examples and initiates 2
> >>> threads using posix api then uses VxWorks MsgQ to communicate.
> >>>> Please advise if this code works as expected -  it seems that when
> >>>> we use
> >>> WAIT_FOREVER flag we have an issue.
> >>>>
> >>>> Sorry in advance for the #ifdef's and comments in code -
> >>>
> >>> For the record, 3.0-rc6 won't work properly with --enable-pshared
> setups.
> >>> For sane shared processing involving multiple copperplate-based APIs
> >>> (such as VxWorks), you do need 3.0.2.
> >> [Alex Plits]
> >> We have configured --enable-pshared on xenomai 3.0.2 and now
> >> compiling empty application (just empty main routine) using non posix
> skin e.g. vxworks or even alchemy causes the "Bus error" in runtime(see
> below). Removing --enable-pshared bootstrap completes successfully.
> >>
> >> # ./posixvx --trace=3D1
> >> --  xenomai_init() running
> >> --  cobalt->init()
> >> --  connected to Cobalt
> >> --  memory locked
> >> --  memory heaps mapped
> >> --  boilerplate->init()
> >> --  copperplate->init()
> >> Bus error
> >
> > gdb backtrace?
> >
> >
>=20
> The output of posixvx --dump-config is needed as well.
[Alex Plits]=20
See below --dump-config , working to get the gdb backtrace.

# ./posixvx=20
Bus error
# ./posixvx --dump-config=20
based on Xenomai/cobalt v3.0.2
CONFIG_MMU=3D1
CONFIG_SMP=3D1
CONFIG_XENO_BUILD_ARGS=3D" '--target=3Darm-openwrt-linux' '--host=3Darm-ope=
nwrt-linux' '--build=3Dx86_64-linux-gnu' '--program-prefix=3D' '--program-s=
uffix=3D' '--prefix=3D/usr' '--exec-prefix=3D/usr' '--bindir=3D/usr/bin' '-=
-sbindir=3D/usr/sbin' '--libexecdir=3D/usr/lib' '--sysconfdir=3D/etc' '--da=
tadir=3D/usr/share' '--localstatedir=3D/var' '--mandir=3D/usr/man' '--infod=
ir=3D/usr/info' '--disable-nls' '--with-core=3Dcobalt' '--enable-smp' '--en=
able-lores-clock' '--enable-pshared' 'build_alias=3Dx86_64-linux-gnu' 'host=
_alias=3Darm-openwrt-linux' 'target_alias=3Darm-openwrt-linux' 'CC=3Darm-op=
enwrt-linux-uclibcgnueabi-gcc' 'CFLAGS=3D-Os -pipe -march=3Darmv7-a -mtune=
=3Dcortex-a7 -fno-caller-saves -fstack-protector -Wl,-z,relro,-z,now -fhono=
ur-copts -Wno-error=3Dunused-but-set-variable -mfloat-abi=3Dsoft ' 'LDFLAGS=
=3D-L/media/HD/SDK/PLATFORM/SDK/staging_dir/target-arm_cortex-a7_uClibc-0.9=
.33.2_eabi/usr/lib -L/media/HD/SDK/PLATFORM/SDK/staging_dir/target-arm_cort=
ex-a7_uClibc-0.9.33.2_eabi/lib -Wl,-z,relro,-z,now -L/media/HD/SDK/PLATFORM=
/SDK/staging_dir/toolchain-arm_cortex-a7_gcc-4.8-linaro_uClibc-0.9.33.2_eab=
i/usr/lib -L/media/HD/SDK/PLATFORM/SDK/staging_dir/toolchain-arm_cortex-a7_=
gcc-4.8-linaro_uClibc-0.9.33.2_eabi/lib ' 'CPPFLAGS=3D-I/media/HD/SDK/PLATF=
ORM/SDK/staging_dir/target-arm_cortex-a7_uClibc-0.9.33.2_eabi/usr/include -=
I/media/HD/SDK/PLATFORM/SDK/staging_dir/target-arm_cortex-a7_uClibc-0.9.33.=
2_eabi/include -I/media/HD/SDK/PLATFORM/SDK/staging_dir/toolchain-arm_corte=
x-a7_gcc-4.8-linaro_uClibc-0.9.33.2_eabi/usr/include -I/media/HD/SDK/PLATFO=
RM/SDK/staging_dir/toolchain-arm_cortex-a7_gcc-4.8-linaro_uClibc-0.9.33.2_e=
abi/include ' 'PKG_CONFIG=3D/media/HD/SDK/PLATFORM/SDK/staging_dir/host/bin=
/pkg-config' 'PKG_CONFIG_PATH=3D/media/HD/SDK/PLATFORM/SDK/staging_dir/targ=
et-arm_cortex-a7_uClibc-0.9.33.2_eabi/usr/lib/pkgconfig:/media/HD/SDK/PLATF=
ORM/SDK/staging_dir/target-arm_cortex-a7_uClibc-0.9.33.2_eabi/usr/share/pkg=
config' 'PKG_CONFIG_LIBDIR=3D/media/HD/SDK/PLATFORM/SDK/staging_dir/target-=
arm_cortex-a7_uClibc-0.9.33.2_eabi/usr/lib/pkgconfig:/media/HD/SDK/PLATFORM=
/SDK/staging_dir/target-arm_cortex-a7_uClibc-0.9.33.2_eabi/usr/share/pkgcon=
fig'"
CONFIG_XENO_BUILD_STRING=3D"x86_64-pc-linux-gnu"
CONFIG_XENO_COBALT=3D1
CONFIG_XENO_COMPILER=3D"gcc version 4.8.3 (OpenWrt/Linaro GCC 4.8-2014.01 r=
43761) "
CONFIG_XENO_DEFAULT_PERIOD=3D1000000
CONFIG_XENO_HOST_STRING=3D"arm-openwrt-linux-gnu"
CONFIG_XENO_PREFIX=3D"/usr"
CONFIG_XENO_PSHARED=3D1
CONFIG_XENO_RAW_CLOCK_ENABLED=3D1
CONFIG_XENO_REVISION_LEVEL=3D2
CONFIG_XENO_SANITY=3D1
CONFIG_XENO_TLSF=3D1
CONFIG_XENO_TLS_MODEL=3D"initial-exec"
CONFIG_XENO_UAPI_LEVEL=3D14
CONFIG_XENO_VERSION_MAJOR=3D3
CONFIG_XENO_VERSION_MINOR=3D0
CONFIG_XENO_VERSION_NAME=3D"Exact Zero"
CONFIG_XENO_VERSION_STRING=3D"3.0.2"
CONFIG_XENO_X86_VSYSCALL=3D1
---
CONFIG_XENO_ASYNC_CANCEL is OFF
CONFIG_XENO_COPPERPLATE_CLOCK_RESTRICTED is OFF
CONFIG_XENO_DEBUG is OFF
CONFIG_XENO_DEBUG_FULL is OFF
CONFIG_XENO_FORTIFY is OFF
CONFIG_XENO_LIBS_DLOPEN is OFF
CONFIG_XENO_LORES_CLOCK_DISABLED is OFF
CONFIG_XENO_MERCURY is OFF
CONFIG_XENO_REGISTRY is OFF
CONFIG_XENO_REGISTRY_ROOT is OFF
CONFIG_XENO_VALGRIND_API is OFF
CONFIG_XENO_WORKAROUND_CONDVAR_PI is OFF
---
PTHREAD_STACK_DEFAULT=3D65536

>=20
> --
> Philippe.

