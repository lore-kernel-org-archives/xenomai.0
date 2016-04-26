From: Alex Plits <alex_plits@radwin.com>
Date: Tue, 26 Apr 2016 08:10:13 +0000
Message-ID: <DB5PR06MB1287AAAB54A1ED746511CF628F630@DB5PR06MB1287.eurprd06.prod.outlook.com>
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
[Alex Plits]=20
We're not getting the symbols correctly although everything seems to be in =
place (debugging info, correct symbol file loaded etc.)
According to the following memory mapping dump and gdb address backtrace it=
 seems the issue is in cooperplate but again we can't seem
to find the corresponding symbol/function.

GDB
#0  0xb6fc455c in ?? ()
Cannot access memory at address 0x6e6f6e58

Memory Mapping
00008000-00009000 r-xp 00000000 00:0c 4841       /tmp/posixvx
00010000-00011000 r--p 00000000 00:0c 4841       /tmp/posixvx
00011000-00012000 rw-p 00001000 00:0c 4841       /tmp/posixvx
00012000-00013000 rw-p 00000000 00:00 0          [heap]
b6e27000-b6e2a000 r-xp 00000000 00:01 2556       /lib/libdl-0.9.33.2.so
b6e2a000-b6e31000 ---p 00000000 00:00 0=20
b6e31000-b6e32000 r--p 00002000 00:01 2556       /lib/libdl-0.9.33.2.so
b6e32000-b6e33000 rw-p 00003000 00:01 2556       /lib/libdl-0.9.33.2.so
b6e33000-b6e7a000 r-xp 00000000 00:01 2941       /lib/libuClibc-0.9.33.2.so
b6e7a000-b6e82000 ---p 00000000 00:00 0=20
b6e82000-b6e83000 r--p 00047000 00:01 2941       /lib/libuClibc-0.9.33.2.so
b6e83000-b6e84000 rw-p 00048000 00:01 2941       /lib/libuClibc-0.9.33.2.so
b6e84000-b6e88000 rw-p 00000000 00:00 0=20
b6e88000-b6e93000 r-xp 00000000 00:01 2621       /lib/libgcc_s.so.1
b6e93000-b6e9b000 ---p 00000000 00:00 0=20
b6e9b000-b6e9c000 r--p 0000b000 00:01 2621       /lib/libgcc_s.so.1
b6e9c000-b6e9d000 rw-p 0000c000 00:01 2621       /lib/libgcc_s.so.1
b6e9d000-b6eab000 r-xp 00000000 00:01 2942       /lib/libm-0.9.33.2.so
b6eab000-b6eb3000 ---p 00000000 00:00 0=20
b6eb3000-b6eb4000 r--p 0000e000 00:01 2942       /lib/libm-0.9.33.2.so
b6eb4000-b6eb5000 rw-p 0000f000 00:01 2942       /lib/libm-0.9.33.2.so
b6eb5000-b6f4e000 r-xp 00000000 00:01 1248       /usr/lib/libstdc++.so.6.0.=
19
b6f4e000-b6f55000 ---p 00000000 00:00 0=20
b6f55000-b6f59000 r--p 00098000 00:01 1248       /usr/lib/libstdc++.so.6.0.=
19
b6f59000-b6f5b000 rw-p 0009c000 00:01 1248       /usr/lib/libstdc++.so.6.0.=
19
b6f5b000-b6f62000 rw-p 00000000 00:00 0=20
b6f62000-b6f72000 r-xp 00000000 00:01 1185       /usr/lib/libz.so.1.2.8
b6f72000-b6f73000 r--p 00010000 00:01 1185       /usr/lib/libz.so.1.2.8
b6f73000-b6f74000 rw-p 00011000 00:01 1185       /usr/lib/libz.so.1.2.8
b6f74000-b6f7c000 r-xp 00000000 00:01 494        /usr/lib/libvxworks.so.0.0=
.0
b6f7c000-b6f83000 ---p 00000000 00:00 0=20
b6f83000-b6f84000 r--p 00007000 00:01 494        /usr/lib/libvxworks.so.0.0=
.0
b6f84000-b6f85000 rw-p 00008000 00:01 494        /usr/lib/libvxworks.so.0.0=
.0
b6f85000-b6f88000 r-xp 00000000 00:01 2610       /lib/librt-0.9.33.2.so
b6f88000-b6f8f000 ---p 00000000 00:00 0=20
b6f8f000-b6f90000 r--p 00002000 00:01 2610       /lib/librt-0.9.33.2.so
b6f90000-b6f91000 rw-p 00003000 00:01 2610       /lib/librt-0.9.33.2.so
b6f91000-b6fa1000 r-xp 00000000 00:01 2622       /lib/libpthread-0.9.33.2.s=
o
b6fa1000-b6fa8000 ---p 00000000 00:00 0=20
b6fa8000-b6fa9000 r--p 0000f000 00:01 2622       /lib/libpthread-0.9.33.2.s=
o
b6fa9000-b6faa000 rw-p 00010000 00:01 2622       /lib/libpthread-0.9.33.2.s=
o
b6faa000-b6fac000 rw-p 00000000 00:00 0=20
b6fac000-b6faf000 r-xp 00000000 00:01 498        /usr/lib/libffi.so.6.0.0
b6faf000-b6fb6000 ---p 00000000 00:00 0=20
b6fb6000-b6fb7000 r--p 00002000 00:01 498        /usr/lib/libffi.so.6.0.0
b6fb7000-b6fb8000 rw-p 00003000 00:01 498        /usr/lib/libffi.so.6.0.0
b6fb8000-b6fc7000 r-xp 00000000 00:01 1688       /usr/lib/libcopperplate.so=
.0.0.0
b6fc7000-b6fce000 ---p 00000000 00:00 0=20
b6fce000-b6fcf000 r--p 0000e000 00:01 1688       /usr/lib/libcopperplate.so=
.0.0.0
b6fcf000-b6fd0000 rw-p 0000f000 00:01 1688       /usr/lib/libcopperplate.so=
.0.0.0
b6fd0000-b6fe7000 r-xp 00000000 00:01 513        /usr/lib/libcobalt.so.2.0.=
0
b6fe7000-b6fef000 ---p 00000000 00:00 0=20
b6fef000-b6ff0000 r--p 00017000 00:01 513        /usr/lib/libcobalt.so.2.0.=
0
b6ff0000-b6ff1000 rw-p 00018000 00:01 513        /usr/lib/libcobalt.so.2.0.=
0
b6ff1000-b6ff7000 r-xp 00000000 00:01 2607       /lib/ld-uClibc-0.9.33.2.so
b6ffa000-b6ffd000 rw-p 00000000 00:00 0=20
b6ffd000-b6ffe000 r-xp 00000000 00:00 0          [sigpage]
b6ffe000-b6fff000 r--p 00005000 00:01 2607       /lib/ld-uClibc-0.9.33.2.so
b6fff000-b7000000 rw-p 00006000 00:01 2607       /lib/ld-uClibc-0.9.33.2.so
befdf000-bf000000 rw-p 00000000 00:00 0          [stack]
ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]


>=20
> The output of posixvx --dump-config is needed as well.
>=20
> --
> Philippe.

