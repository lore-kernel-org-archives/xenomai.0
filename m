MIME-Version: 1.0
From: John Ho <johnho26@gmail.com>
Date: Thu, 1 Apr 2021 12:47:42 +0200
Message-ID: <CAMjL99KZFz3qd4tzuXERhLSnOTjG=SWZV2KtW2=3ipmvW4wuEA@mail.gmail.com>
Subject: Help with rtnet with soem
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

I wish to ask for some help. I was experiencing some issues with soem and
rtnet.

I was able to run rtnet with soem till now, however, recently I realized
that rtnet is freezing up occasionally.

When i use eno1 with xenomai threading, if my ethercat fails it continues
to the next cycle on my program. However when i switch over to rteth0, and
when my ethercat fails, it freezes.

I have attached in this email the Wireshark info from both my master and
sniffer pc:


MASTER:

10456 4.296601704 JetwayIn_09:95:50 Broadcast ECAT 293 2 Cmds, 'LRW': len
245, 'FRMW': len 8
10457 4.296748257 MS-NLB-PhysServer-32_10:18:09:95:50 Broadcast ECAT 293 2
Cmds, 'LRW': len 245, 'FRMW': len 8
10458 4.297302548 JetwayIn_09:95:51 Broadcast TDMA 42 Synchronisation
10459 4.298000197 JetwayIn_09:95:51 Broadcast TDMA 42 Synchronisation
10460 4.298700307 JetwayIn_09:95:51 Broadcast TDMA 42 Synchronisation
10461 4.298703155 JetwayIn_09:95:50 Broadcast ECAT 293 2 Cmds, 'LRW': len
245, 'FRMW': len 8
10462 4.299399782 JetwayIn_09:95:51 Broadcast TDMA 42 Synchronisation
10463 4.300100548 JetwayIn_09:95:51 Broadcast TDMA 42 Synchronisation
10464 4.300799199 JetwayIn_09:95:51 Broadcast TDMA 42 Synchronisation






SNIFFER:

15935 4.121410 JetwayIn_09:95:50 Broadcast ECAT 313 2 Cmds, 'LRW': len 245,
'FRMW': len 8
15936 4.121410 MS-NLB-PhysServer-32_10:18:09:95:50 Broadcast ECAT 313 2
Cmds, 'LRW': len 245, 'FRMW': len 8
15937 4.122238 JetwayIn_09:95:51 Broadcast TDMA 80 Synchronisation
15938 4.122238 MS-NLB-PhysServer-32_10:18:09:95:51 Broadcast RTmac 60
Unknown (0xc83e)
15939 4.122822 JetwayIn_09:95:51 Broadcast TDMA 80 Synchronisation
15940 4.122822 MS-NLB-PhysServer-32_10:18:09:95:51 Broadcast RTmac 60
Unknown (0xc83e)
15941 4.123625 JetwayIn_09:95:51 Broadcast TDMA 80 Synchronisation
15942 4.123625 MS-NLB-PhysServer-32_10:18:09:95:51 Broadcast RTmac 60
Unknown (0xc83e)
15943 4.123625 JetwayIn_09:95:50 Broadcast ECAT 313 2 Cmds, 'LRW': len 245,
'FRMW': len 8
15944 4.123625 MS-NLB-PhysServer-32_10:18:09:95:50 Broadcast ECAT 82
[Malformed Packet]
15945 4.124208 JetwayIn_09:95:51 Broadcast TDMA 80 Synchronisation
15946 4.124208 MS-NLB-PhysServer-32_10:18:09:95:51 Broadcast RTmac 60
Unknown (0xc83e)
15947 4.125019 JetwayIn_09:95:51 Broadcast TDMA 80 Synchronisation
15948 4.125019 MS-NLB-PhysServer-32_10:18:09:95:51 Broadcast RTmac 60
Unknown (0xc83e)




On the masterpc, i have instances like 10456 and 10457 where the master pc
was able to send and receive the packages. but on 10461 it sends out a
package but didn't receive back and freezes up.

On the snifferpc, 15935 and 15936 shows a working communication. However
when it reaches 15944, there is a malformed package

as such i wish to ask if there is a way to prevent rtnet from freezing and
just skip over this malformed package?

Looking forward for any assistance available.

yours sincerely,
John
