Date: Thu, 22 Aug 2019 09:47:19 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <382769722.821292.1566485239775.JavaMail.zimbra@wolfram.com>
In-Reply-To: <CAPm8-H53Xb8HSU6xT33su+K_2Q5gzhCFXibKxuY+43j_E6WdoQ@mail.gmail.com>
References: <CAPm8-H6txhsFDDepfGEG48S1anF03F1=tBsEiLfkRiPHi7KKxA@mail.gmail.com>
 <7f20a51d-e1c2-b95e-ab17-d18338bbcec2@siemens.com>
 <CAPm8-H47+st-pOpFT_MZ+KMoyzuYB6XtLgdf7DyeOC5wV8yfrQ@mail.gmail.com>
 <CAPm8-H7kP3AO0xLP5tJ_EcOzCX-0qtPaJK2soS0yW9pdk+DHHg@mail.gmail.com>
 <CAPm8-H5iGMJZd++E3Ln07O9=kUy=at1bvnegrFr6RUaDkbo_Xg@mail.gmail.com>
 <676297850.725433.1566475845016.JavaMail.zimbra@wolfram.com>
 <CAPm8-H53Xb8HSU6xT33su+K_2Q5gzhCFXibKxuY+43j_E6WdoQ@mail.gmail.com>
Subject: Re: RTNet - vnic0 question
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Cc: xenomai <xenomai@xenomai.org>



----- Den 22 aug 2019, p=C3=A5 kl 16:27, Laurentiu-Cristian Duca laurentiu.=
duca@gmail.com skrev:

> Hi,

> I have used rtifconfig, rtroute and rtping and I mentioned that worked,
> I have written that rtt-sender and rtt-responder which use posix skin
> worked only on vnic0 and not on rteth0.

> I have ported frag-ip.c (from rtnet 0.9.13 to xenomai 3)
> which uses alchemy instead of posix and it works on rteth0 link
> between two qemu-x86_64-rt_8139too virtual machines,
> but do not work on bbb (I think the drivers I use have problems on bbb).

Sorry for the blunt answer. I obviously didn't read enough of the discussio=
n and I didn't provide a good explanation of my thoughts.=20

My thoughts were basically these:
What I have found myself is that the routing table for rteth0 needed extern=
al poking (using ping from other source) to be set up properly, and "Networ=
k unreachable" seems to me like a failure in lookup. Perhaps when using vir=
tual devices there are some messages sent in the virtual environment that p=
okes it for you?

You write that you had it working and already tried rtping, so maybe it's a=
lready taken care of. But otherwise it would have been a good idea trying r=
troute and see if there is a valid mac-address in the table.


> Thx

> On 8/22/19, Per Oberg <pero@wolfram.com> wrote:


> > ----- Den 22 aug 2019, p=C3=A5 kl 13:21, xenomai xenomai@xenomai.org sk=
rev:

> >> Hi,

> >> I have made a test between two qemu-x86_64-rt_8139too with different
> >> mac and IP addresses,
> >> one is master one is slave. In each of them I do:
> >> /usr/xenomai/sbin/rtnet start
> >> Then the applications rtt-sender and rtt-responder (taken from rtnet
> >> 0.9.13 release) work,
> >> but if I turn off vnic0, then rtt-sender reports error: "sendto
> >> failed: Network is unreachable",
> >> even if rteth0 is up and fully configured.
> >> Do you have any simple apps that work on rtnet?

> > You have :
> > rtping
> > rtifconfig
> > rtroute

> > Perhaps these can be of assistance?

> >> Thank you,
> >> Kind regards

> >> On 8/22/19, Laurentiu-Cristian Duca <laurentiu.duca@gmail.com> wrote:
> >> > The rt drivers for bbb are taken from:
> >> > https://github.com/G-Ray/xenomai-boneblack-rtnet-drivers
> >> > and I am not 100% sure that they are working correctly.

> >> > On 8/22/19, Laurentiu-Cristian Duca <laurentiu.duca@gmail.com> wrote=
:
> >> >> Hello Jan and friends

> >> >> Thank you for your fast answer. Please find below the details.

> >> >> On 8/21/19, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >> >>> On 21.08.19 16:20, Laurentiu-Cristian Duca via Xenomai wrote:
> >> >>>> Hello rtnet community,

> >> >>>> I successfully tested the examples rtt-sender and rtt-responder
> >> >>>> within a rtnet made from one beaglebone black and one
> >> >>>> qemu-x86_64-8139too,
> >> >>>> with tdma and also with nomac.

> >> >>> Are we talking about some legacy Xenomai or even RTnet version? Or
> >> >>> where
> >> >>> did
> >> >>> you
> >> >>> get the examples from? They are not part of RTnet in Xenomai 3.

> >> >> I got the examples from rtnet-0.9.13. I know they are quite old, bu=
t
> >> >> I needed a start point.
> >> >> Are these obsolete? Do you have any examples for Xenomai 3?
> >> >> rtnet-0.9.13/examples/xenomai/posix/rtt-sender.c
> >> >> rtnet-0.9.13/examples/xenomai/posix/rtt-responder.c


> >> >>>> I have noted that the presence of vnic0 as an up and fully
> >> >>>> configured interface is mandatory,
> >> >>>> even if rteth0 is up and fully configured.
> >> >>>> Otherwise the rtt-sender announces "sendto failed: Network is
> >> >>>> unreachable".
> >> >>>> Could anybody tell me why is this happening?

> >> >>>> I have also noted that if I disable vnic0 (ifconfig vnic0 down),
> >> >>>> rtping works if rteth0 is up and fully configured.
> >> >>>> Why does not work rtt-sender in this case?
> >> >>>> Could it be a problem with rtnet drivers?

> >> >>> I bet your examples are falling back to normal network here, and t=
hat
> >> >>> is
> >> >>> provided between your test nodes via the vnics. This leads to my
> >> >>> first
> >> >>> question:
> >> >>> Where did you pick the examples up, how did you build them etc.?
> >> >>> Also,
> >> >>> did
> >> >>> you
> >> >>> make sure that rtudp was loaded?

> >> >> I am 100% sure that rtudp was loaded. The modules were loaded by a
> >> >> script:
> >> >> modprobe rt_smsc && modprobe rt_davinci_mdio && modprobe rt_ticpsw
> >> >> modprobe rtipv4 && modprobe rtpacket && modprobe rtudp
> >> >> modprobe rtmac
> >> >> modprobe nomac
> >> >> #modprobe tdma

> >> >> I used robertcnelson Xenomai 3.0.9 patch for beaglebone black linux
> >> >> 4.14.108. It's on github.
> >> >> I have also copied the rtnet header files to xenomai-userspace
> >> >> include. The files compile without warnings.
> >> >> The makefile is:
> >> >> # Tested with linaro toolchain
> >> >> (gcc-linaro-7.4.1-2019.02-x86_64_arm-linux-gnueabihf)
> >> >> CC =3D arm-linux-gnueabihf-gcc
> >> >> XENO_INSTALL =3D
> >> >> /home/laur/lucru/raspberry-pi/robertcnelson/ti-linux-kernel-dev/ign=
ore/xenomai-userspace
> >> >> RTNET_INSTALL =3D
> >> >> /home/laur/lucru/raspberry-pi/robertcnelson/rtnet-hiddeate2m

> >> >> #XENO_CONFIG :=3D
> >> >> /home/laur/lucru/raspberry-pi/robertcnelson/ti-linux-kernel-dev/ign=
ore/xenomai-userspace/usr/xenomai/bin/xeno-config
> >> >> #/usr/xenomai/bin/xeno-config
> >> >> #CFLAGS :=3D $(shell $(XENO_CONFIG) --posix --alchemy --cflags)
> >> >> #LDFLAGS :=3D $(shell $(XENO_CONFIG) --posix --alchemy --ldflags)

> >> >> LIBCFLAGS =3D -Wall -I$(XENO_INSTALL)/usr/xenomai/include/cobalt
> >> >> LIBCFLAGS +=3D -I$(XENO_INSTALL)/usr/xenomai/include

> >> >> CFLAGS =3D -Wall -I$(XENO_INSTALL)/usr/xenomai/include/cobalt
> >> >> CFLAGS +=3D -I$(XENO_INSTALL)/usr/xenomai/include/alchemy
> >> >> -I$(XENO_INSTALL)/usr/xenomai/include
> >> >> CFLAGS +=3D -march=3Darmv7-a -mfpu=3Dvfpv4 -D_GNU_SOURCE -D_REENTRA=
NT
> >> >> -D__COBALT__ -D__COBALT_WRAP_
> >> >> CFLAGS +=3D -I$(RTNET_INSTALL)/stack/include

> >> >> LFLAGS =3D -lalchemy -lcopperplate
> >> >> $(XENO_INSTALL)/usr/xenomai/lib/xenomai/bootstrap.o
> >> >> LFLAGS +=3D -Wl,--wrap=3Dmain -Wl,--wrap=3Dmalloc -Wl,--wrap=3Dfree
> >> >> #-Wl,--dynamic-list=3D$(XENO_INSTALL)/usr/xenomai/lib/dynlist.ld
> >> >> LFLAGS +=3D -L$(XENO_INSTALL)/usr/xenomai/lib -lcobalt -lpthread -l=
rt
> >> >> LFLAGS +=3D -march=3Darmv7-a -mfpu=3Dvfpv4 -Llib

> >> >> all: rtt-sender rtt-responder
> >> >> rtt-sender: rtt-sender.o
> >> >> $(CC) -o rtt-sender rtt-sender.o $(LFLAGS)
> >> >> rtt-sender.o: rtt-sender.c
> >> >> $(CC) -c -o rtt-sender.o rtt-sender.c $(CFLAGS) $(LIBCFLAGS)
> >> >> (same for rtt-responder)


> >> >> Kind regards,
> >> >> L-C.


> > Per =C3=96berg

Per =C3=96berg=20

