MIME-Version: 1.0
References: <CAMjL99KZFz3qd4tzuXERhLSnOTjG=SWZV2KtW2=3ipmvW4wuEA@mail.gmail.com>
 <4e03-60663380-3f-10b42340@50501865>
In-Reply-To: <4e03-60663380-3f-10b42340@50501865>
From: John Ho <johnho26@gmail.com>
Date: Sat, 3 Apr 2021 22:20:44 +0200
Message-ID: <CAMjL99+4bL1XM0yohWSp=jcMR3eoNc_tVCTMc6nxLk5Jn+ofoA@mail.gmail.com>
Subject: Re: Help with rtnet with soem
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>, xenomai@xenomai.org

Hi Francois,

No the machine didnt freeze, it is only the Ethercat thread hangs.
I will try to find the faulty ethercat network.
Thank you for your reply

yours sincerely,
John

On Thu, Apr 1, 2021 at 10:56 PM Fran=C3=A7ois Legal <devel@thom.fr.eu.org> =
wrote:

> Le Jeudi, Avril 01, 2021 12:47 CEST, John Ho via Xenomai <
> xenomai@xenomai.org> a =C3=A9crit:
>
> > Hi all,
> >
> > I wish to ask for some help. I was experiencing some issues with soem a=
nd
> > rtnet.
> >
> > I was able to run rtnet with soem till now, however, recently I realize=
d
> > that rtnet is freezing up occasionally.
> >
> > When i use eno1 with xenomai threading, if my ethercat fails it continu=
es
> > to the next cycle on my program. However when i switch over to rteth0,
> and
> > when my ethercat fails, it freezes.
> >
> > I have attached in this email the Wireshark info from both my master an=
d
> > sniffer pc:
> >
> >
> > MASTER:
> >
> > 10456 4.296601704 JetwayIn_09:95:50 Broadcast ECAT 293 2 Cmds, 'LRW': l=
en
> > 245, 'FRMW': len 8
> > 10457 4.296748257 MS-NLB-PhysServer-32_10:18:09:95:50 Broadcast ECAT 29=
3
> 2
> > Cmds, 'LRW': len 245, 'FRMW': len 8
> > 10458 4.297302548 JetwayIn_09:95:51 Broadcast TDMA 42 Synchronisation
> > 10459 4.298000197 JetwayIn_09:95:51 Broadcast TDMA 42 Synchronisation
> > 10460 4.298700307 JetwayIn_09:95:51 Broadcast TDMA 42 Synchronisation
> > 10461 4.298703155 JetwayIn_09:95:50 Broadcast ECAT 293 2 Cmds, 'LRW': l=
en
> > 245, 'FRMW': len 8
> > 10462 4.299399782 JetwayIn_09:95:51 Broadcast TDMA 42 Synchronisation
> > 10463 4.300100548 JetwayIn_09:95:51 Broadcast TDMA 42 Synchronisation
> > 10464 4.300799199 JetwayIn_09:95:51 Broadcast TDMA 42 Synchronisation
> >
> >
> >
> >
> >
> >
> > SNIFFER:
> >
> > 15935 4.121410 JetwayIn_09:95:50 Broadcast ECAT 313 2 Cmds, 'LRW': len
> 245,
> > 'FRMW': len 8
> > 15936 4.121410 MS-NLB-PhysServer-32_10:18:09:95:50 Broadcast ECAT 313 2
> > Cmds, 'LRW': len 245, 'FRMW': len 8
> > 15937 4.122238 JetwayIn_09:95:51 Broadcast TDMA 80 Synchronisation
> > 15938 4.122238 MS-NLB-PhysServer-32_10:18:09:95:51 Broadcast RTmac 60
> > Unknown (0xc83e)
> > 15939 4.122822 JetwayIn_09:95:51 Broadcast TDMA 80 Synchronisation
> > 15940 4.122822 MS-NLB-PhysServer-32_10:18:09:95:51 Broadcast RTmac 60
> > Unknown (0xc83e)
> > 15941 4.123625 JetwayIn_09:95:51 Broadcast TDMA 80 Synchronisation
> > 15942 4.123625 MS-NLB-PhysServer-32_10:18:09:95:51 Broadcast RTmac 60
> > Unknown (0xc83e)
> > 15943 4.123625 JetwayIn_09:95:50 Broadcast ECAT 313 2 Cmds, 'LRW': len
> 245,
> > 'FRMW': len 8
> > 15944 4.123625 MS-NLB-PhysServer-32_10:18:09:95:50 Broadcast ECAT 82
> > [Malformed Packet]
> > 15945 4.124208 JetwayIn_09:95:51 Broadcast TDMA 80 Synchronisation
> > 15946 4.124208 MS-NLB-PhysServer-32_10:18:09:95:51 Broadcast RTmac 60
> > Unknown (0xc83e)
> > 15947 4.125019 JetwayIn_09:95:51 Broadcast TDMA 80 Synchronisation
> > 15948 4.125019 MS-NLB-PhysServer-32_10:18:09:95:51 Broadcast RTmac 60
> > Unknown (0xc83e)
> >
> >
> >
> >
> > On the masterpc, i have instances like 10456 and 10457 where the master
> pc
> > was able to send and receive the packages. but on 10461 it sends out a
> > package but didn't receive back and freezes up.
> >
> > On the snifferpc, 15935 and 15936 shows a working communication. Howeve=
r
> > when it reaches 15944, there is a malformed package
> >
> > as such i wish to ask if there is a way to prevent rtnet from freezing
> and
> > just skip over this malformed package?
> >
> > Looking forward for any assistance available.
> >
> > yours sincerely,
> > John
>
> Hi John,
>
> could you be a little more specific with "rtnet is freezing".
> Is the machine freezing ?
> You seem to have a faulty ethercat network as the master is not seeing th=
e
> ethercat frame it sends echoed back after reaching the end of the bus. I
> don't know how you use SOEM, but I'd say it might by endlessly polling
> until it receives the echoed datagram back.
> So you might first want to fix the network, and the problem may then
> disappear.
>
> Fran=C3=A7ois
>
>
