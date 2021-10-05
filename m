Subject: Re: RTnet failed setup
References: <CAK6DXL2cWYOuFMHkm6tdzxcRzKehgnKyzTF1iid63QOVBQgLNw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <31054073-d935-3218-9985-9b68aac0ebf7@siemens.com>
Date: Tue, 5 Oct 2021 16:15:23 +0200
MIME-Version: 1.0
In-Reply-To: <CAK6DXL2cWYOuFMHkm6tdzxcRzKehgnKyzTF1iid63QOVBQgLNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marco Barletta <barlettamarco8@gmail.com>, xenomai@xenomai.org

On 18.09.21 16:55, Marco Barletta via Xenomai wrote:
> Hi everyone;
> since my NIC is not supported by rt_e1000e I wanted to test the RTnet setup
> on a couple of VMs talking to each other. I created a NAT network (
> 10.0.2.0/24) and I attached the two VMs on it. Emulated controller is a
> Intel 82540EM with e1000. The test with the loopback device works fine,
> but when I try to make the multi node test something fails. The rteth0
> device is correctly brought up on both the VMs, however the rtnet start
> command stucks at  "waiting for slaves..." master side and "searching for
> master" on slave side. Obviously they can't exchange packets but I don't
> know why. In dmesg I get
> [ 1652.922885] RTnet: registered rteth0
> [ 1652.922888] e1000: rteth0: e1000_probe: Intel(R) PRO/1000 Network
> Connection
> [ 1652.930730] rt_loopback: initializing loopback interface...
> [ 1652.930764] RTnet: registered rtlo
> [ 1652.935057] RTcfg: init real-time configuration distribution protocol
> [ 1652.938784] RTmac: init realtime media access control
> [ 1652.942199] RTmac/TDMA: init time division multiple access control
> mechanism
> [ 1654.983533] e1000: rteth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full
> Duplex
> [ 1730.758684] TDMA: Failed to transmit sync frame!
> [ 1730.758848] TDMA: Failed to transmit sync frame!
> [ 1805.723757] TDMA: Failed to transmit sync frame!
> [ 1805.723774] TDMA: Failed to transmit sync frame!
> [ 1805.723777] TDMA: Failed to transmit sync frame!
> [ 1805.723779] TDMA: Failed to transmit sync frame!
> [ 1805.723781] TDMA: Failed to transmit sync frame!
> [ 1805.723783] TDMA: Failed to transmit sync frame!
> [ 1805.723785] TDMA: Failed to transmit sync frame!
> 
> and on the other side I noticed in dmesg
> [ 1625.966260] RTnet: dropping packet in rtnetif_rx()
> [ 1625.966262] RTnet: dropping packet in rtnetif_rx()
> [ 1625.966263] RTnet: dropping packet in rtnetif_rx()
> [ 1625.966265] RTnet: dropping packet in rtnetif_rx()
> 
> If I try a manual rtping after the rtroute I get "ioctl: Resource
> temporarily unavailable" and in dmesg
> [   72.314451] hard_start_xmit returned -11.
> Can someone help me to understand what is going on?
> 

A common cause for such an error pattern is that the (TX) IRQ is not
working, thus packets are not released after submission. Check that
first. What's your Xenomai/kernel version?

Jan

> rtconf files are:
> 
> RT_DRIVER="rt_e1000"
> RT_DRIVER_OPTIONS=""
> REBIND_RT_NICS="0000:00:03.0"
> IPADDR="10.0.2.4"
> NETMASK="255.255.255.0"
> RT_LOOPBACK="yes"
> RT_PROTOCOLS="udp packet"
> RTCAP="no"
> STAGE_2_SRC=""
> STAGE_2_DST=""
> STAGE_2_CMDS=""
> TDMA_MODE="master"
> TDMA_SLAVES="10.0.2.15"
> TDMA_CYCLE="5000"
> TDMA_OFFSET="200"
> 
> for master and the same with slave instead of master and ipaddr=10.0.2.15
> for slave. VMs run Linux mint 20.1 5.4.77 patched with 3.1
> Thank you for helping.
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

