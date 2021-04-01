From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
MIME-Version: 1.0
Date: Thu, 01 Apr 2021 23:42:42 +0200
Subject: =?utf-8?q?Re=3A?= How to use RTnet on =?utf-8?q?xenomai3=3F?=
Message-ID: <4e03-60663e80-47-10b42340@50501997>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Le Jeudi, Avril 01, 2021 20:09 CEST, ashwin damle via Xenomai <xenomai@=
xenomai.org> a =C3=A9crit: 
 
> Hello Support,
> 
> I was able to locate the drivers for rtnet (/lib/modules/uname
> -r/kernel/drivers/xenomai/net/drivers) and rtnet.conf is located at
> /usr/xenomai/etc. It did not require compiling RTnet separately.
> 
> I tried following steps mentioned at
> https://source.denx.de/Xenomai/xenomai/-/wikis/RTnet=5FSetup. The
> non-realtime driver is e100 for my Ethernet controller. I followed th=
e
> steps and also loaded the rt=5Feepro100 hoping that is the real-time =
driver I
> should use. The ethernet controller I have is Intel Corporation PRO/1=
00 VE.
> 
> Output of sudo lspci -nn
> *04:08.0 Ethernet controller [0200]: Intel Corporation PRO/100 VE Net=
work
> Connection [8086:1094] (rev 01)*
> 
> However, when I unload the e100 driver, loading the rt=5Feepro100 dri=
ver, and
> configuring rtnet.conf as mentioned on the RTnet=5FSetup page, I coul=
d only
> see the loopback.
> from running sudo ../sbin/rtifconfig
> 
> rtlo      Medium: Local Loopback
>           IP address: 127.0.0.1
>           UP LOOPBACK RUNNING  MTU: 1500
> 
> There was a solution posted at
> https://www.mail-archive.com/rtnet-users@lists.sourceforge.net/msg027=
66.html
> is
> 
> diff --git a/drivers/rt=5Feepro100.c b/drivers/rt=5Feepro100.c
> index 15282e4..c6a1c93 100644
> --- a/drivers/rt=5Feepro100.c
> +++ b/drivers/rt=5Feepro100.c
> @@ -1975,6 +1975,7 @@ static struct pci=5Fdevice=5Fid eepro100=5Fpci=5F=
tbl[]
> =5F=5Fdevinitdata =3D {
>         { PCI=5FVENDOR=5FID=5FINTEL, 0x103C, PCI=5FANY=5FID, PCI=5FAN=
Y=5FID, },
>         { PCI=5FVENDOR=5FID=5FINTEL, 0x103D, PCI=5FANY=5FID, PCI=5FAN=
Y=5FID, },
>         { PCI=5FVENDOR=5FID=5FINTEL, 0x103E, PCI=5FANY=5FID, PCI=5FAN=
Y=5FID, },
> +       { PCI=5FVENDOR=5FID=5FINTEL, 0x1092, PCI=5FANY=5FID, PCI=5FAN=
Y=5FID, },
>         { PCI=5FVENDOR=5FID=5FINTEL, 0x1227, PCI=5FANY=5FID, PCI=5FAN=
Y=5FID, },
>         { PCI=5FVENDOR=5FID=5FINTEL, 0x1228, PCI=5FANY=5FID, PCI=5FAN=
Y=5FID, },
>         { PCI=5FVENDOR=5FID=5FINTEL, 0x2449, PCI=5FANY=5FID, PCI=5FAN=
Y=5FID, },
> I seems to work for Breno, but I cannot understand what to do with it=
.
> 
> I am using Trisquel Linux kernel Linux gnu 4.19.89 with Xenomai 3.1.
> 
> I think I am close to running RTnet and would appreciate it if some
> guidance is provided.
> 
> Ashwin Damle
> 
> 
> On Mon, 29 Mar 2021 at 23:51, ashwin damle <ashwindamle@gmail.com> wr=
ote:
> 
> >
> > Dear Xenomai support,
> >
> > I am successfully able to run xenomai3.1 on 4.19.89 on my core-2-du=
o
> > machine. Xenomai works nice. Further I want to use RTnet.
> >
> > From
> > https://source.denx.de/Xenomai/xenomai/-/wikis/RTnet#installation-f=
older-overview
> > I learnt that RTNet is built into Xenomai 3 and so I need not downl=
oad from
> > the rtnet page and build it separately. If so then where do I start=
 using
> > RTNET? Is there any example? The folder mentioned at
> > https://source.denx.de/Xenomai/xenomai/-/wikis/RTnet=5FSetup do app=
ear on
> > my computer.
> >
> > From https://source.denx.de/Xenomai/xenomai/-/wikis/RTnet=5FSetup I=
> > understand that /usr/local/rtnet/ is the directory where the RTNET =
files
> > including documentation would be, but this folder is not created on=
 my
> > system. Therefore, I tried building RTNET from source using the
> > instructions in the README: I get the error as below
> >
> > I request your help with an error.
> > "checking for RT-extension... configure: error: *** RT-extended ker=
nel not
> > found in /lib/modules/4.19.89=5Fxenomai/build
> > makefile:51: recipe for target 'config.status' failed
> > "
> > I found that many have resolved the problems from by searching for =
the
> > error and 5 pages direct to the same solution and that is
> >
> >  ./configure --with-linux=3D/path/to/linux-source-with-xenomai-exte=
nsion
> >  --with-rtext-config=3D/path/to/xeno-config
> >
> > My doubts are
> >
> > 1. Is it necessary to build RTNet from source or is it built in Xen=
omai 3?
> > If it is built in then how do I use it. Some steps will be helpful.=
> >
> > 2. If the RTNet is to be built from source then how to solve the ab=
ove
> > error. I pointed to the Linux source tree I used to build the xenom=
ai
> > kernel but it throws the same error.
> >
> > 3. What does " /path/to/linux-source-with-xenomai-extension mean th=
e Linux
> > source folder of Xenomai patched kernel? or does it mean
> > "/lib/modules/uname-r/build"....None works for me. /path/to/xeno-co=
nfig
> > seems to be /usr/xenomai on my machine since xeno-config resides th=
ere.
> >
> > Please help with this. Let me know if you require any more informat=
ion.
> >
> > --
> > Ashwin Damle
> >
> 
> 
> -- 
> Ashwin Damle
 
Hi Ashwin,

you might want to try to modify the patch like 
+       { PCI=5FVENDOR=5FID=5FINTEL, 0x1094, PCI=5FANY=5FID, PCI=5FANY=5F=
ID, },*

rebuild the module and try again

Fran=C3=A7ois


