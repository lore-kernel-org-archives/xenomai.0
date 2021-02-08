MIME-Version: 1.0
From: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Date: Mon, 8 Feb 2021 16:45:34 +0200
Message-ID: <CAPm8-H53-z1ZGekQRHFQ667CRkSgZG7n_Z3Wya8pz9N88racAQ@mail.gmail.com>
Subject: Announce RTnet on PREEMPT_RT Linux
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Dear friends,

  Please let me announce the port of the RTnet core on PREEMPT_RT Linux 5.9.
  Features:
- ported raspberry pi 4 (bcmgenet), orange pi one (stmmac),
realtek (8139too), ticpsw (beaglebone black), microchip (enc28j60)
- rtnet UDP socket, bind, recvmsg, sendto, recvfrom, sendmsg, select,
poll system calls;
- sockets with AF_INET (UDP) or AF_PACKET (raw) family;
- rtnetproxy for ssh and scp (but uses RT driver bandwidth)

  The project is available on my github [1].
I've made the code available although it needs some polishing.

Best regards,
L-C. Duca

[1] https://github.com/laurentiuduca/rtnet-preempt_rt

