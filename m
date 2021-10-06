Subject: Re: RTnet failed setup
References: <CAK6DXL2cWYOuFMHkm6tdzxcRzKehgnKyzTF1iid63QOVBQgLNw@mail.gmail.com>
 <31054073-d935-3218-9985-9b68aac0ebf7@siemens.com>
 <CAK6DXL385hOFto37fCFNmYyU7kDqWVoK970p5z6Fp3P9zi4w1Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e451fe75-ce20-1362-54b5-6463da7ee1bf@siemens.com>
Date: Wed, 6 Oct 2021 12:29:41 +0200
MIME-Version: 1.0
In-Reply-To: <CAK6DXL385hOFto37fCFNmYyU7kDqWVoK970p5z6Fp3P9zi4w1Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marco Barletta <barlettamarco8@gmail.com>
Cc: xenomai@xenomai.org

On 05.10.21 17:33, Marco Barletta wrote:
> I changed my setup to avoid time problems: I went bare metal with two
> machines with e1000e driver (I217-LM controller) with linux 5.4.77,
> xenomai 3.1.1. I managed to got a RTcfg handshake between the two
> machines, however I got that after the "ready" packet from both master
> and slave, no more sync frame are received and after 30-40 seconds it
> starts logging "failed to transmit sync frame", because of full rtskbs.
> It seems buffers become full of sync packet never transmitted. It also
> seems to detect a connection dead (anyway no connection dead packet is
> detected in wireshark) end in wireshark there is no heartbeat packet.
> May be a related problem that after the ready stage the TX IRQ come
> disabled? I tried also with a e100 card and with the e100 as master the

Do you get interrupts for the card at all? See /proc/xenomai/irq. Does
the kernel console (dmesg) report any errors, IRQ problems?

Jan

> handshake is not completed, while with the card as a slave I see an arp
> reply packet that I couldn't see with the e1000e. Anyaway after the
> ready in both cases no packet is received. I saw on the mailing list
> someone had a similar problems with RTAI a few years ago, but the
> resolution was not clear. Moreover I sometime can read that the slave
> receives a wrong version RTmac packet (0x2 expected 0x0, or viceversa).
> You will encounter similar mails from mine in the mailing list, just
> trash it, this is the up to date state.
> Thanks a lot for helping
> 
> Il giorno mar 5 ott 2021 alle ore 16:15 Jan Kiszka
> <jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>> ha scritto:
> 
>     On 18.09.21 16:55, Marco Barletta via Xenomai wrote:
>     > Hi everyone;
>     > since my NIC is not supported by rt_e1000e I wanted to test the
>     RTnet setup
>     > on a couple of VMs talking to each other. I created a NAT network (
>     > 10.0.2.0/24 <http://10.0.2.0/24>) and I attached the two VMs on
>     it. Emulated controller is a
>     > Intel 82540EM with e1000. The test with the loopback device works
>     fine,
>     > but when I try to make the multi node test something fails. The rteth0
>     > device is correctly brought up on both the VMs, however the rtnet
>     start
>     > command stucks at  "waiting for slaves..." master side and
>     "searching for
>     > master" on slave side. Obviously they can't exchange packets but I
>     don't
>     > know why. In dmesg I get
>     > [ 1652.922885] RTnet: registered rteth0
>     > [ 1652.922888] e1000: rteth0: e1000_probe: Intel(R) PRO/1000 Network
>     > Connection
>     > [ 1652.930730] rt_loopback: initializing loopback interface...
>     > [ 1652.930764] RTnet: registered rtlo
>     > [ 1652.935057] RTcfg: init real-time configuration distribution
>     protocol
>     > [ 1652.938784] RTmac: init realtime media access control
>     > [ 1652.942199] RTmac/TDMA: init time division multiple access control
>     > mechanism
>     > [ 1654.983533] e1000: rteth0: e1000_watchdog: NIC Link is Up 1000
>     Mbps Full
>     > Duplex
>     > [ 1730.758684] TDMA: Failed to transmit sync frame!
>     > [ 1730.758848] TDMA: Failed to transmit sync frame!
>     > [ 1805.723757] TDMA: Failed to transmit sync frame!
>     > [ 1805.723774] TDMA: Failed to transmit sync frame!
>     > [ 1805.723777] TDMA: Failed to transmit sync frame!
>     > [ 1805.723779] TDMA: Failed to transmit sync frame!
>     > [ 1805.723781] TDMA: Failed to transmit sync frame!
>     > [ 1805.723783] TDMA: Failed to transmit sync frame!
>     > [ 1805.723785] TDMA: Failed to transmit sync frame!
>     >
>     > and on the other side I noticed in dmesg
>     > [ 1625.966260] RTnet: dropping packet in rtnetif_rx()
>     > [ 1625.966262] RTnet: dropping packet in rtnetif_rx()
>     > [ 1625.966263] RTnet: dropping packet in rtnetif_rx()
>     > [ 1625.966265] RTnet: dropping packet in rtnetif_rx()
>     >
>     > If I try a manual rtping after the rtroute I get "ioctl: Resource
>     > temporarily unavailable" and in dmesg
>     > [   72.314451] hard_start_xmit returned -11.
>     > Can someone help me to understand what is going on?
>     >
> 
>     A common cause for such an error pattern is that the (TX) IRQ is not
>     working, thus packets are not released after submission. Check that
>     first. What's your Xenomai/kernel version?
> 
>     Jan
> 
>     > rtconf files are:
>     >
>     > RT_DRIVER="rt_e1000"
>     > RT_DRIVER_OPTIONS=""
>     > REBIND_RT_NICS="0000:00:03.0"
>     > IPADDR="10.0.2.4"
>     > NETMASK="255.255.255.0"
>     > RT_LOOPBACK="yes"
>     > RT_PROTOCOLS="udp packet"
>     > RTCAP="no"
>     > STAGE_2_SRC=""
>     > STAGE_2_DST=""
>     > STAGE_2_CMDS=""
>     > TDMA_MODE="master"
>     > TDMA_SLAVES="10.0.2.15"
>     > TDMA_CYCLE="5000"
>     > TDMA_OFFSET="200"
>     >
>     > for master and the same with slave instead of master and
>     ipaddr=10.0.2.15
>     > for slave. VMs run Linux mint 20.1 5.4.77 patched with 3.1
>     > Thank you for helping.
>     >
> 
>     -- 
>     Siemens AG, T RDA IOT
>     Corporate Competence Center Embedded Linux
> 
> 
> 
> -- 
> Marco Barletta

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

