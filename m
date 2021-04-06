From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <CAMjL99+4bL1XM0yohWSp=jcMR3eoNc_tVCTMc6nxLk5Jn+ofoA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Date: Tue, 06 Apr 2021 11:01:58 +0200
MIME-Version: 1.0
Message-ID: <4e03-606c2380-4b-10b42340@50503350>
Subject: =?utf-8?q?Re=3A?= Help with rtnet with soem
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Ho <johnho26@gmail.com>
Cc: xenomai@xenomai.org

Le Samedi, Avril 03, 2021 22:20 CEST, John Ho <johnho26@gmail.com> a =C3=
=A9crit: 
 
> Hi Francois,
> 
> No the machine didnt freeze, it is only the Ethercat thread hangs.
> I will try to find the faulty ethercat network.
> Thank you for your reply
> 
> yours sincerely,
> John
> 
> On Thu, Apr 1, 2021 at 10:56 PM Fran=C3=A7ois Legal <devel@thom.fr.eu=
.org> wrote:
> 
> > Le Jeudi, Avril 01, 2021 12:47 CEST, John Ho via Xenomai <
> > xenomai@xenomai.org> a =C3=A9crit:
> >
> > > Hi all,
> > >
> > > I wish to ask for some help. I was experiencing some issues with =
soem and
> > > rtnet.
> > >
> > > I was able to run rtnet with soem till now, however, recently I r=
ealized
> > > that rtnet is freezing up occasionally.
> > >
> > > When i use eno1 with xenomai threading, if my ethercat fails it c=
ontinues
> > > to the next cycle on my program. However when i switch over to rt=
eth0,
> > and
> > > when my ethercat fails, it freezes.
> > >
> > > I have attached in this email the Wireshark info from both my mas=
ter and
> > > sniffer pc:
> > >
> > >
> > > MASTER:
> > >
> > > 10456 4.296601704 JetwayIn=5F09:95:50 Broadcast ECAT 293 2 Cmds, =
'LRW': len
> > > 245, 'FRMW': len 8
> > > 10457 4.296748257 MS-NLB-PhysServer-32=5F10:18:09:95:50 Broadcast=
 ECAT 293
> > 2
> > > Cmds, 'LRW': len 245, 'FRMW': len 8
> > > 10458 4.297302548 JetwayIn=5F09:95:51 Broadcast TDMA 42 Synchroni=
sation
> > > 10459 4.298000197 JetwayIn=5F09:95:51 Broadcast TDMA 42 Synchroni=
sation
> > > 10460 4.298700307 JetwayIn=5F09:95:51 Broadcast TDMA 42 Synchroni=
sation
> > > 10461 4.298703155 JetwayIn=5F09:95:50 Broadcast ECAT 293 2 Cmds, =
'LRW': len
> > > 245, 'FRMW': len 8
> > > 10462 4.299399782 JetwayIn=5F09:95:51 Broadcast TDMA 42 Synchroni=
sation
> > > 10463 4.300100548 JetwayIn=5F09:95:51 Broadcast TDMA 42 Synchroni=
sation
> > > 10464 4.300799199 JetwayIn=5F09:95:51 Broadcast TDMA 42 Synchroni=
sation
> > >
> > >
> > >
> > >
> > >
> > >
> > > SNIFFER:
> > >
> > > 15935 4.121410 JetwayIn=5F09:95:50 Broadcast ECAT 313 2 Cmds, 'LR=
W': len
> > 245,
> > > 'FRMW': len 8
> > > 15936 4.121410 MS-NLB-PhysServer-32=5F10:18:09:95:50 Broadcast EC=
AT 313 2
> > > Cmds, 'LRW': len 245, 'FRMW': len 8
> > > 15937 4.122238 JetwayIn=5F09:95:51 Broadcast TDMA 80 Synchronisat=
ion
> > > 15938 4.122238 MS-NLB-PhysServer-32=5F10:18:09:95:51 Broadcast RT=
mac 60
> > > Unknown (0xc83e)
> > > 15939 4.122822 JetwayIn=5F09:95:51 Broadcast TDMA 80 Synchronisat=
ion
> > > 15940 4.122822 MS-NLB-PhysServer-32=5F10:18:09:95:51 Broadcast RT=
mac 60
> > > Unknown (0xc83e)
> > > 15941 4.123625 JetwayIn=5F09:95:51 Broadcast TDMA 80 Synchronisat=
ion
> > > 15942 4.123625 MS-NLB-PhysServer-32=5F10:18:09:95:51 Broadcast RT=
mac 60
> > > Unknown (0xc83e)
> > > 15943 4.123625 JetwayIn=5F09:95:50 Broadcast ECAT 313 2 Cmds, 'LR=
W': len
> > 245,
> > > 'FRMW': len 8
> > > 15944 4.123625 MS-NLB-PhysServer-32=5F10:18:09:95:50 Broadcast EC=
AT 82
> > > [Malformed Packet]
> > > 15945 4.124208 JetwayIn=5F09:95:51 Broadcast TDMA 80 Synchronisat=
ion
> > > 15946 4.124208 MS-NLB-PhysServer-32=5F10:18:09:95:51 Broadcast RT=
mac 60
> > > Unknown (0xc83e)
> > > 15947 4.125019 JetwayIn=5F09:95:51 Broadcast TDMA 80 Synchronisat=
ion
> > > 15948 4.125019 MS-NLB-PhysServer-32=5F10:18:09:95:51 Broadcast RT=
mac 60
> > > Unknown (0xc83e)
> > >
> > >
> > >
> > >
> > > On the masterpc, i have instances like 10456 and 10457 where the =
master
> > pc
> > > was able to send and receive the packages. but on 10461 it sends =
out a
> > > package but didn't receive back and freezes up.
> > >
> > > On the snifferpc, 15935 and 15936 shows a working communication. =
However
> > > when it reaches 15944, there is a malformed package
> > >
> > > as such i wish to ask if there is a way to prevent rtnet from fre=
ezing
> > and
> > > just skip over this malformed package?
> > >
> > > Looking forward for any assistance available.
> > >
> > > yours sincerely,
> > > John
> >
> > Hi John,
> >
> > could you be a little more specific with "rtnet is freezing".
> > Is the machine freezing ?
> > You seem to have a faulty ethercat network as the master is not see=
ing the
> > ethercat frame it sends echoed back after reaching the end of the b=
us. I
> > don't know how you use SOEM, but I'd say it might by endlessly poll=
ing
> > until it receives the echoed datagram back.
> > So you might first want to fix the network, and the problem may the=
n
> > disappear.
> >
> > Fran=C3=A7ois
> >
> >
 
Have you tried to get that thread through GDB to see what happens ?
Also, I'm not sure I fully understand "hangs" what does it mean ? The t=
hread is running 100% on a CPU ?

Fran=C3=A7ois


