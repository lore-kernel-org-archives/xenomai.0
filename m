From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
MIME-Version: 1.0
Date: Thu, 01 Apr 2021 23:42:09 +0200
Subject: =?utf-8?q?Re=3A?= Help with rtnet with soem
Message-ID: <4e03-60663e00-43-10b42340@50501931>
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

Le Jeudi, Avril 01, 2021 12:47 CEST, John Ho via Xenomai <xenomai@xenom=
ai.org> a =C3=A9crit: 
 
> Hi all,
> 
> I wish to ask for some help. I was experiencing some issues with soem=
 and
> rtnet.
> 
> I was able to run rtnet with soem till now, however, recently I reali=
zed
> that rtnet is freezing up occasionally.
> 
> When i use eno1 with xenomai threading, if my ethercat fails it conti=
nues
> to the next cycle on my program. However when i switch over to rteth0=
, and
> when my ethercat fails, it freezes.
> 
> I have attached in this email the Wireshark info from both my master =
and
> sniffer pc:
> 
> 
> MASTER:
> 
> 10456 4.296601704 JetwayIn=5F09:95:50 Broadcast ECAT 293 2 Cmds, 'LRW=
': len
> 245, 'FRMW': len 8
> 10457 4.296748257 MS-NLB-PhysServer-32=5F10:18:09:95:50 Broadcast ECA=
T 293 2
> Cmds, 'LRW': len 245, 'FRMW': len 8
> 10458 4.297302548 JetwayIn=5F09:95:51 Broadcast TDMA 42 Synchronisati=
on
> 10459 4.298000197 JetwayIn=5F09:95:51 Broadcast TDMA 42 Synchronisati=
on
> 10460 4.298700307 JetwayIn=5F09:95:51 Broadcast TDMA 42 Synchronisati=
on
> 10461 4.298703155 JetwayIn=5F09:95:50 Broadcast ECAT 293 2 Cmds, 'LRW=
': len
> 245, 'FRMW': len 8
> 10462 4.299399782 JetwayIn=5F09:95:51 Broadcast TDMA 42 Synchronisati=
on
> 10463 4.300100548 JetwayIn=5F09:95:51 Broadcast TDMA 42 Synchronisati=
on
> 10464 4.300799199 JetwayIn=5F09:95:51 Broadcast TDMA 42 Synchronisati=
on
> 
> 
> 
> 
> 
> 
> SNIFFER:
> 
> 15935 4.121410 JetwayIn=5F09:95:50 Broadcast ECAT 313 2 Cmds, 'LRW': =
len 245,
> 'FRMW': len 8
> 15936 4.121410 MS-NLB-PhysServer-32=5F10:18:09:95:50 Broadcast ECAT 3=
13 2
> Cmds, 'LRW': len 245, 'FRMW': len 8
> 15937 4.122238 JetwayIn=5F09:95:51 Broadcast TDMA 80 Synchronisation
> 15938 4.122238 MS-NLB-PhysServer-32=5F10:18:09:95:51 Broadcast RTmac =
60
> Unknown (0xc83e)
> 15939 4.122822 JetwayIn=5F09:95:51 Broadcast TDMA 80 Synchronisation
> 15940 4.122822 MS-NLB-PhysServer-32=5F10:18:09:95:51 Broadcast RTmac =
60
> Unknown (0xc83e)
> 15941 4.123625 JetwayIn=5F09:95:51 Broadcast TDMA 80 Synchronisation
> 15942 4.123625 MS-NLB-PhysServer-32=5F10:18:09:95:51 Broadcast RTmac =
60
> Unknown (0xc83e)
> 15943 4.123625 JetwayIn=5F09:95:50 Broadcast ECAT 313 2 Cmds, 'LRW': =
len 245,
> 'FRMW': len 8
> 15944 4.123625 MS-NLB-PhysServer-32=5F10:18:09:95:50 Broadcast ECAT 8=
2
> [Malformed Packet]
> 15945 4.124208 JetwayIn=5F09:95:51 Broadcast TDMA 80 Synchronisation
> 15946 4.124208 MS-NLB-PhysServer-32=5F10:18:09:95:51 Broadcast RTmac =
60
> Unknown (0xc83e)
> 15947 4.125019 JetwayIn=5F09:95:51 Broadcast TDMA 80 Synchronisation
> 15948 4.125019 MS-NLB-PhysServer-32=5F10:18:09:95:51 Broadcast RTmac =
60
> Unknown (0xc83e)
> 
> 
> 
> 
> On the masterpc, i have instances like 10456 and 10457 where the mast=
er pc
> was able to send and receive the packages. but on 10461 it sends out =
a
> package but didn't receive back and freezes up.
> 
> On the snifferpc, 15935 and 15936 shows a working communication. Howe=
ver
> when it reaches 15944, there is a malformed package
> 
> as such i wish to ask if there is a way to prevent rtnet from freezin=
g and
> just skip over this malformed package?
> 
> Looking forward for any assistance available.
> 
> yours sincerely,
> John
 
Hi John,

could you be a little more specific with "rtnet is freezing".
Is the machine freezing ?
You seem to have a faulty ethercat network as the master is not seeing =
the ethercat frame it sends echoed back after reaching the end of the b=
us. I don't know how you use SOEM, but I'd say it might by endlessly po=
lling until it receives the echoed datagram back.
So you might first want to fix the network, and the problem may then di=
sappear.

Fran=C3=A7ois


