From: Alex Plits <alex_plits@radwin.com>
Date: Tue, 3 May 2016 13:06:52 +0000
Message-ID: <DB5PR06MB1287CBD05BE361F39DC849998F7A0@DB5PR06MB1287.eurprd06.prod.outlook.com>
References: <DB5PR06MB1287CCF7EAF55DA6F95ED4A68F9D0@DB5PR06MB1287.eurprd06.prod.outlook.com>
 <20160405070232.GI20399@hermes.click-hack.org>
 <AM3PR06MB1282EDA8459215FC1B64D3118F900@AM3PR06MB1282.eurprd06.prod.outlook.com>
 <57069F3E.3070309@xenomai.org>
 <DB5PR06MB128755E41DF13905760BB2438F620@DB5PR06MB1287.eurprd06.prod.outlook.com>
 <571DF3C0.7050502@xenomai.org> <571DF45B.7070703@xenomai.org>
 <DB5PR06MB1287AAAB54A1ED746511CF628F630@DB5PR06MB1287.eurprd06.prod.outlook.com>
 <5727A7D2.1060006@xenomai.org>
In-Reply-To: <5727A7D2.1060006@xenomai.org>
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
> Sent: Monday, May 02, 2016 10:18 PM
> To: Alex Plits; Gilles Chanteperdrix
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai] Mixing Posix RT APIs and vxWorks APIs
>=20
> On 04/26/2016 10:10 AM, Alex Plits wrote:
> >
> >
> >> -----Original Message-----
> >> From: Philippe Gerum [mailto:rpm@xenomai.org]
> >> Sent: Monday, April 25, 2016 1:42 PM
> >> To: Alex Plits; Gilles Chanteperdrix
> >> Cc: xenomai@xenomai.org
> >> Subject: Re: [Xenomai] Mixing Posix RT APIs and vxWorks APIs
> >>
> >> On 04/25/2016 12:38 PM, Philippe Gerum wrote:
> >>> On 04/25/2016 12:03 PM, Alex Plits wrote:
> >>>>
> >>>>
> >>>>> -----Original Message-----
> >>>>> From: Philippe Gerum [mailto:rpm@xenomai.org]
> >>>>> Sent: Thursday, April 07, 2016 8:56 PM
> >>>>> To: Alex Plits; Gilles Chanteperdrix
> >>>>> Cc: xenomai@xenomai.org
> >>>>> Subject: Re: [Xenomai] Mixing Posix RT APIs and vxWorks APIs
> >>>>>
> >>>>> On 04/07/2016 07:56 AM, Alex Plits wrote:
> >>>>>>
> >>>>>>
> >>>>>>> -----Original Message-----
> >>>>>>> From: Gilles Chanteperdrix
> >>>>>>> [mailto:gilles.chanteperdrix@xenomai.org]
> >>>>>>> Sent: Tuesday, April 05, 2016 10:03 AM
> >>>>>>> To: Alex Plits
> >>>>>>> Cc: xenomai@xenomai.org
> >>>>>>> Subject: Re: [Xenomai] Mixing Posix RT APIs and vxWorks APIs
> >>>>>>>
> >>>>>>> On Mon, Apr 04, 2016 at 01:42:11PM +0000, Alex Plits wrote:
> >>>>>>>> Hi,
> >>>>>>>>
> >>>>>>>> We are currently porting some of our vxWorks  xenomai
> >>>>>>>> (copperplate) APIs we use in our application to Posix (cobalt I
> guess).
> >>>>>>>
> >>>>>>> Well, if you do not know whether you are using Cobalt or
> >>>>>>> Mercury, we can not know it for you...
> >>>>>> [Alex Plits]
> >>>>>> Cobalt :)
> >>>>>>>
> >>>>>>>> We have started with the VxWorks "tasks" but it seems that
> >>>>>>>> we're getting strange behavior on The remaining VxWorks APIs
> >>>>>>>> when used from
> >>>>>>> the POSIX generated tasks (threads is the right word in posix) e.=
g.
> >>>>>>> MsqQRecv function gets segfault but when it is used From a
> >>>>>>> VxWorks generated task it works fine.
> >>>>>>>> I understand from the comments in code it should work but I was
> >>>>>>> wondering if there are known issues.
> >>>>>>>>
> >>>>>>>> We are using currently xenomai 3 rc-6 (I saw there were fixes
> >>>>>>>> in xenomai
> >>>>>>> 3.0.2).
> >>>>>>>
> >>>>>>> Could you send a self-contained, simplest possible test case
> >>>>>>> which causes the problem for you, that we can test on the latest
> >>>>>>> Xenomai release to see if the problem has not been already fixed?
> >>>>>>>
> >>>>>> [Alex Plits]
> >>>>>> Attached code that is ripped from xenomai examples and initiates
> >>>>>> 2
> >>>>> threads using posix api then uses VxWorks MsgQ to communicate.
> >>>>>> Please advise if this code works as expected -  it seems that
> >>>>>> when we use
> >>>>> WAIT_FOREVER flag we have an issue.
> >>>>>>
> >>>>>> Sorry in advance for the #ifdef's and comments in code -
> >>>>>
> >>>>> For the record, 3.0-rc6 won't work properly with --enable-pshared
> >> setups.
> >>>>> For sane shared processing involving multiple copperplate-based
> >>>>> APIs (such as VxWorks), you do need 3.0.2.
> >>>> [Alex Plits]
> >>>> We have configured --enable-pshared on xenomai 3.0.2 and now
> >>>> compiling empty application (just empty main routine) using non
> >>>> posix
> >> skin e.g. vxworks or even alchemy causes the "Bus error" in
> >> runtime(see below). Removing --enable-pshared bootstrap completes
> successfully.
> >>>>
> >>>> # ./posixvx --trace=3D1
> >>>> --  xenomai_init() running
> >>>> --  cobalt->init()
> >>>> --  connected to Cobalt
> >>>> --  memory locked
> >>>> --  memory heaps mapped
> >>>> --  boilerplate->init()
> >>>> --  copperplate->init()
> >>>> Bus error
> >>>
> >>> gdb backtrace?
> >>>
> >>>
> > [Alex Plits]
> > We're not getting the symbols correctly although everything seems to
> > be in place (debugging info, correct symbol file loaded etc.)
> > According to the following memory mapping dump and gdb address
> backtrace it seems the issue is in cooperplate but again we can't seem to=
 find
> the corresponding symbol/function.
> >
> > GDB
> > #0  0xb6fc455c in ?? ()
> > Cannot access memory at address 0x6e6f6e58
> >
>=20
> This looks like a random ascii sequence ("nonX"), not a valid pointer.
> Can you strace this executable?
>=20
[Alex Plits]=20
Sure. See below


# strace ./posixvx=20
execve("./posixvx", ["./posixvx"], [/* 7 vars */]) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x4000000=
, -1, 0) =3D 0xb6fb2000
stat("/etc/ld.so.cache", 0xbebf3b10)    =3D -1 ENOENT (No such file or dire=
ctory)
open("/lib/libcobalt.so.2", O_RDONLY)   =3D -1 ENOENT (No such file or dire=
ctory)
open("/usr/lib/libcobalt.so.2", O_RDONLY) =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D90595, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x4000000=
, -1, 0) =3D 0xb6fb1000
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0t\214\0\0004\0\0\0".=
.., 4096) =3D 4096
mmap2(NULL, 126976, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0xb6f8=
8000
mmap2(0xb6f88000, 87052, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) =
=3D 0xb6f88000
mmap2(0xb6fa5000, 4579, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x1=
5) =3D 0xb6fa5000
close(3)                                =3D 0
munmap(0xb6fb1000, 4096)                =3D 0
open("/lib/libcopperplate.so.0", O_RDONLY) =3D -1 ENOENT (No such file or d=
irectory)
open("/usr/lib/libcopperplate.so.0", O_RDONLY) =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D36951, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x4000000=
, -1, 0) =3D 0xb6fb1000
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\264?\0\0004\0\0\0".=
.., 4096) =3D 4096
mmap2(NULL, 73728, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0xb6f76=
000
mmap2(0xb6f76000, 33820, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) =
=3D 0xb6f76000
mmap2(0xb6f86000, 4183, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x8=
) =3D 0xb6f86000
close(3)                                =3D 0
munmap(0xb6fb1000, 4096)                =3D 0
open("/lib/libffi.so.6", O_RDONLY)      =3D -1 ENOENT (No such file or dire=
ctory)
open("/usr/lib/libffi.so.6", O_RDONLY)  =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D12290, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x4000000=
, -1, 0) =3D 0xb6fb1000
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\270\r\0\0004\0\0\0"=
..., 4096) =3D 4096
mmap2(NULL, 49152, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0xb6f6a=
000
mmap2(0xb6f6a000, 9108, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) =
=3D 0xb6f6a000
mmap2(0xb6f74000, 4098, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x2=
) =3D 0xb6f74000
close(3)                                =3D 0
munmap(0xb6fb1000, 4096)                =3D 0
open("/lib/libpthread.so.0", O_RDONLY)  =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D65563, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x4000000=
, -1, 0) =3D 0xb6fb1000
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\260C\0\0004\0\0\0".=
.., 4096) =3D 4096
mmap2(NULL, 110592, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0xb6f4=
f000
mmap2(0xb6f4f000, 64160, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) =
=3D 0xb6f4f000
mmap2(0xb6f66000, 4123, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xf=
) =3D 0xb6f66000
mmap2(0xb6f68000, 4328, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANO=
NYMOUS, -1, 0) =3D 0xb6f68000
close(3)                                =3D 0
munmap(0xb6fb1000, 4096)                =3D 0
open("/lib/librt.so.0", O_RDONLY)       =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D12292, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x4000000=
, -1, 0) =3D 0xb6fb1000
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0`\16\0\0004\0\0\0"..=
., 4096) =3D 4096
mmap2(NULL, 49152, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0xb6f43=
000
mmap2(0xb6f43000, 8260, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) =
=3D 0xb6f43000
mmap2(0xb6f4d000, 4100, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x2=
) =3D 0xb6f4d000
close(3)                                =3D 0
munmap(0xb6fb1000, 4096)                =3D 0
open("/lib/libvxworks.so.0", O_RDONLY)  =3D -1 ENOENT (No such file or dire=
ctory)
open("/usr/lib/libvxworks.so.0", O_RDONLY) =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D28729, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x4000000=
, -1, 0) =3D 0xb6fb1000
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0H)\0\0004\0\0\0"...,=
 4096) =3D 4096
mmap2(NULL, 65536, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0xb6f33=
000
mmap2(0xb6f33000, 24768, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) =
=3D 0xb6f33000
mmap2(0xb6f41000, 4153, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x6=
) =3D 0xb6f41000
close(3)                                =3D 0
munmap(0xb6fb1000, 4096)                =3D 0
open("/lib/libz.so.1", O_RDONLY)        =3D -1 ENOENT (No such file or dire=
ctory)
open("/usr/lib/libz.so.1", O_RDONLY)    =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D69693, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x4000000=
, -1, 0) =3D 0xb6fb1000
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\320\25\0\0004\0\0\0=
"..., 4096) =3D 4096
mmap2(NULL, 73728, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0xb6f21=
000
mmap2(0xb6f21000, 65348, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) =
=3D 0xb6f21000
mmap2(0xb6f31000, 4157, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x1=
0) =3D 0xb6f31000
close(3)                                =3D 0
munmap(0xb6fb1000, 4096)                =3D 0
open("/lib/libstdc++.so.6", O_RDONLY)   =3D -1 ENOENT (No such file or dire=
ctory)
open("/usr/lib/libstdc++.so.6", O_RDONLY) =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D645079, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x4000000=
, -1, 0) =3D 0xb6fb1000
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\244u\4\0004\0\0\0".=
.., 4096) =3D 4096
mmap2(NULL, 708608, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0xb6e7=
4000
mmap2(0xb6e74000, 623772, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0)=
 =3D 0xb6e74000
mmap2(0xb6f14000, 22487, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x=
98) =3D 0xb6f14000
mmap2(0xb6f1a000, 25420, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_AN=
ONYMOUS, -1, 0) =3D 0xb6f1a000
close(3)                                =3D 0
munmap(0xb6fb1000, 4096)                =3D 0
open("/lib/libm.so.0", O_RDONLY)        =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D61444, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x4000000=
, -1, 0) =3D 0xb6fb1000
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0<\23\0\0004\0\0\0"..=
., 4096) =3D 4096
mmap2(NULL, 98304, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0xb6e5c=
000
mmap2(0xb6e5c000, 57247, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) =
=3D 0xb6e5c000
mmap2(0xb6e72000, 4100, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xe=
) =3D 0xb6e72000
close(3)                                =3D 0
munmap(0xb6fb1000, 4096)                =3D 0
open("/lib/libgcc_s.so.1", O_RDONLY)    =3D 3
fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D49155, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x4000000=
, -1, 0) =3D 0xb6fb1000
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0000=3D\0\0004\0\0\0"=
..., 4096) =3D 4096
mmap2(NULL, 86016, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0xb6e47=
000
mmap2(0xb6e47000, 44656, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) =
=3D 0xb6e47000
mmap2(0xb6e5a000, 4099, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xb=
) =3D 0xb6e5a000
close(3)                                =3D 0
munmap(0xb6fb1000, 4096)                =3D 0
open("/lib/libc.so.0", O_RDONLY)        =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D295683, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x4000000=
, -1, 0) =3D 0xb6fb1000
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\220\237\0\0004\0\0\=
0"..., 4096) =3D 4096
mmap2(NULL, 348160, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0xb6df=
2000
mmap2(0xb6df2000, 290708, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0)=
 =3D 0xb6df2000
mmap2(0xb6e41000, 4867, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x4=
7) =3D 0xb6e41000
mmap2(0xb6e43000, 14576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_AN=
ONYMOUS, -1, 0) =3D 0xb6e43000
close(3)                                =3D 0
munmap(0xb6fb1000, 4096)                =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x4000000=
, -1, 0) =3D 0xb6fb1000
stat("/lib/ld-uClibc.so.0", {st_mode=3DS_IFREG|0755, st_size=3D24581, ...})=
 =3D 0
open("/lib/librt.so.0", O_RDONLY)       =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D12292, ...}) =3D 0
close(3)                                =3D 0
open("/lib/libpthread.so.0", O_RDONLY)  =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D65563, ...}) =3D 0
close(3)                                =3D 0
open("/lib/libgcc_s.so.1", O_RDONLY)    =3D 3
fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D49155, ...}) =3D 0
close(3)                                =3D 0
open("/lib/libc.so.0", O_RDONLY)        =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D295683, ...}) =3D 0
close(3)                                =3D 0
open("/lib/libpthread.so.0", O_RDONLY)  =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D65563, ...}) =3D 0
close(3)                                =3D 0
open("/lib/librt.so.0", O_RDONLY)       =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D12292, ...}) =3D 0
close(3)                                =3D 0
open("/lib/libgcc_s.so.1", O_RDONLY)    =3D 3
fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D49155, ...}) =3D 0
close(3)                                =3D 0
open("/lib/libc.so.0", O_RDONLY)        =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D295683, ...}) =3D 0
close(3)                                =3D 0
open("/lib/libgcc_s.so.1", O_RDONLY)    =3D 3
fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D49155, ...}) =3D 0
close(3)                                =3D 0
open("/lib/libc.so.0", O_RDONLY)        =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D295683, ...}) =3D 0
close(3)                                =3D 0
open("/lib/libdl.so.0", O_RDONLY)       =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D12301, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x4000000=
, -1, 0) =3D 0xb6fb0000
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0H\v\0\0004\0\0\0"...=
, 4096) =3D 4096
mmap2(NULL, 49152, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0xb6de6=
000
mmap2(0xb6de6000, 8523, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) =
=3D 0xb6de6000
mmap2(0xb6df0000, 4109, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x2=
) =3D 0xb6df0000
close(3)                                =3D 0
munmap(0xb6fb0000, 4096)                =3D 0
open("/lib/libc.so.0", O_RDONLY)        =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D295683, ...}) =3D 0
close(3)                                =3D 0
open("/lib/libc.so.0", O_RDONLY)        =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D295683, ...}) =3D 0
close(3)                                =3D 0
open("/lib/libdl.so.0", O_RDONLY)       =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D12301, ...}) =3D 0
close(3)                                =3D 0
open("/lib/libpthread.so.0", O_RDONLY)  =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D65563, ...}) =3D 0
close(3)                                =3D 0
open("/lib/libgcc_s.so.1", O_RDONLY)    =3D 3
fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D49155, ...}) =3D 0
close(3)                                =3D 0
open("/lib/libc.so.0", O_RDONLY)        =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D295683, ...}) =3D 0
close(3)                                =3D 0
open("/lib/libc.so.0", O_RDONLY)        =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D295683, ...}) =3D 0
close(3)                                =3D 0
open("/lib/libgcc_s.so.1", O_RDONLY)    =3D 3
fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D49155, ...}) =3D 0
close(3)                                =3D 0
open("/lib/libm.so.0", O_RDONLY)        =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D61444, ...}) =3D 0
close(3)                                =3D 0
open("/lib/libc.so.0", O_RDONLY)        =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D295683, ...}) =3D 0
close(3)                                =3D 0
open("/lib/libgcc_s.so.1", O_RDONLY)    =3D 3
fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D49155, ...}) =3D 0
close(3)                                =3D 0
open("/lib/libc.so.0", O_RDONLY)        =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D295683, ...}) =3D 0
close(3)                                =3D 0
open("/lib/libc.so.0", O_RDONLY)        =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D295683, ...}) =3D 0
close(3)                                =3D 0
open("/lib/libc.so.0", O_RDONLY)        =3D 3
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D295683, ...}) =3D 0
close(3)                                =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x4000000=
, -1, 0) =3D 0xb6fb0000
set_tls(0xb6fb0430, 0xb6fb0ae0, 0xb6fb0ae8, 0xb6fb0430, 0xb6fb4f74) =3D 0
gettimeofday({1462279873, 50496}, NULL) =3D 0
mprotect(0x11000, 4096, PROT_READ)      =3D 0
mprotect(0xb6fa5000, 4096, PROT_READ)   =3D 0
mprotect(0xb6f86000, 4096, PROT_READ)   =3D 0
mprotect(0xb6f74000, 4096, PROT_READ)   =3D 0
mprotect(0xb6f66000, 4096, PROT_READ)   =3D 0
mprotect(0xb6f4d000, 4096, PROT_READ)   =3D 0
mprotect(0xb6f41000, 4096, PROT_READ)   =3D 0
mprotect(0xb6f31000, 4096, PROT_READ)   =3D 0
mprotect(0xb6f14000, 16384, PROT_READ)  =3D 0
mprotect(0xb6e72000, 4096, PROT_READ)   =3D 0
mprotect(0xb6e5a000, 4096, PROT_READ)   =3D 0
mprotect(0xb6e41000, 4096, PROT_READ)   =3D 0
mprotect(0xb6fb4000, 4096, PROT_READ)   =3D 0
mprotect(0xb6df0000, 4096, PROT_READ)   =3D 0
set_tid_address(0xb6fb0068)             =3D 1951
set_robust_list(0xb6fb0070, 12)         =3D 0
rt_sigaction(SIGRTMIN, {0xb6f57730, [], SA_SIGINFO|0x4000000}, NULL, 8) =3D=
 0
rt_sigaction(SIGRT_1, {0xb6f575f0, [], SA_RESTART|SA_SIGINFO|0x4000000}, NU=
LL, 8) =3D 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) =3D 0
getrlimit(RLIMIT_STACK, {rlim_cur=3D8192*1024, rlim_max=3DRLIM_INFINITY}) =
=3D 0
ioctl(0, SNDCTL_TMR_TIMEBASE or SNDRV_TIMER_IOCTL_NEXT_DEVICE or TCGETS, {B=
115200 opost isig icanon echo ...}) =3D 0
ioctl(1, SNDCTL_TMR_TIMEBASE or SNDRV_TIMER_IOCTL_NEXT_DEVICE or TCGETS, {B=
115200 opost isig icanon echo ...}) =3D 0
brk(0)                                  =3D 0x37b000
brk(0x37c000)                           =3D 0x37c000
write(1, "init Xenomai\n", 13init Xenomai
)          =3D 13
gettid()                                =3D 1951
rt_sigaction(SIGILL, {0xb6f921e8, [ILL], SA_RESTART|0x4000000}, {SIG_DFL, [=
], 0}, 8) =3D 0
rt_sigaction(SIGILL, {SIG_DFL, [ILL], SA_RESTART|0x4000000}, {0xb6f921e8, [=
ILL], SA_RESTART|0x4000000}, 8) =3D 0
mlockall(MCL_CURRENT|MCL_FUTURE)        =3D 0
open("/dev/mem", O_RDONLY|O_SYNC)       =3D 3
mmap2(NULL, 4096, PROT_READ, MAP_SHARED, 3, 0) =3D 0xb6fae000
close(3)                                =3D 0
futex(0xb6fa634c, FUTEX_WAKE_PRIVATE, 2147483647) =3D 0
futex(0xb6fa61f0, FUTEX_WAKE_PRIVATE, 2147483647) =3D 0
rt_sigaction(SIGXCPU, {0xb6f92be8, [], SA_SIGINFO|0x4000000}, {SIG_DFL, [],=
 0}, 8) =3D 0
brk(0x38c000)                           =3D 0x38c000
mmap2(NULL, 2097152, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_ST=
ACK, -1, 0) =3D 0xb6bc6000
mprotect(0xb6bc6000, 4096, PROT_NONE)   =3D 0
clone(child_stack=3D0xb6dc50e8, flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|CLONE=
_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_=
CHILD_CLEARTID, parent_tidptr=3D0xb6dc5588, tls=3D0xb6dc5950, child_tidptr=
=3D0xb6dc5588) =3D 1952
sched_getparam(1951, { 0 })             =3D 0
sched_getscheduler(1951)                =3D 0 (SCHED_OTHER)
sched_get_priority_max(SCHED_FIFO)      =3D 99
sched_setscheduler(1951, SCHED_OTHER, { 0 }) =3D 0
rt_sigprocmask(SIG_BLOCK, [WINCH], [], 8) =3D 0
rt_sigaction(SIGWINCH, {0xb6f96550, [], SA_RESTART|SA_SIGINFO|0x4000000}, {=
SIG_DFL, [], 0}, 8) =3D 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) =3D 0
futex(0xb6fa62c4, FUTEX_WAKE_PRIVATE, 2147483647) =3D 0
mmap2(NULL, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0xb6bc3000
mmap2(NULL, 1052672, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0xb6ac2000
geteuid32()                             =3D 0
open("/etc/passwd", O_RDONLY)           =3D 3
ioctl(3, SNDCTL_TMR_TIMEBASE or SNDRV_TIMER_IOCTL_NEXT_DEVICE or TCGETS, 0x=
bebf3acc) =3D -1 ENOTTY (Inappropriate ioctl for device)
brk(0x38d000)                           =3D 0x38d000
read(3, "root:x:0:0:root:/root:/bin/ash\nd"..., 4096) =3D 190
close(3)                                =3D 0
prctl(PR_GET_NAME, 0xb6bc3d04, 0, 0, 0) =3D 0
gettid()                                =3D 1951
write(1, "Create msgQ\n", 12Create msgQ
)           =3D 12
write(1, "start server\n", 13start server
)          =3D 13
sched_getaffinity(1951, 128, {1})       =3D 4
sched_get_priority_min(SCHED_FIFO)      =3D 1
sched_get_priority_max(SCHED_FIFO)      =3D 99
mmap2(NULL, 65536, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_STAC=
K, -1, 0) =3D 0xb6ab2000
mprotect(0xb6ab2000, 4096, PROT_NONE)   =3D 0
clone(child_stack=3D0xb6ac10e8, flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|CLONE=
_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_=
CHILD_CLEARTID, parent_tidptr=3D0xb6ac1588, tls=3D0xb6ac1950, child_tidptr=
=3D0xb6ac1588) =3D 1953
sched_setaffinity(1953, 128, {2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, =
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}) =3D 0
futex(0xb6ac1734, FUTEX_WAKE_PRIVATE, 1) =3D 1
clock_gettime(CLOCK_REALTIME, {1462279873, 549992977}) =3D 0
write(1, "server is up\n", 13server is up
)          =3D 13
write(1, "start sender\n", 13start sender
)          =3D 13
sched_get_priority_min(SCHED_FIFO)      =3D 1
sched_get_priority_max(SCHED_FIFO)      =3D 99
mmap2(NULL, 65536, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_STAC=
K, -1, 0) =3D 0xb6aa2000
mprotect(0xb6aa2000, 4096, PROT_NONE)   =3D 0
clone(child_stack=3D0xb6ab10e8, flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|CLONE=
_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_=
CHILD_CLEARTID, parent_tidptr=3D0xb6ab1588, tls=3D0xb6ab1950, child_tidptr=
=3D0xb6ab1588) =3D 1954
clock_gettime(CLOCK_REALTIME, {1462279873, 555642310}) =3D 0
gettimeofday({1462279873, 556216}, NULL) =3D 0
futex(0xbebf3b78, FUTEX_WAIT_PRIVATE, 0, {4, 443784000}) =3D 0
futex(0xb6ab1588, FUTEX_WAIT, 1954, NULLsender is up
send msg
<unfinished ...>
+++ killed by SIGSEGV +++
Segmentation fault


Thanks,
Alex Plits.

> --
> Philippe.

