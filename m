Date: Wed, 25 Feb 2015 11:36:04 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150225103604.GN14148@hermes.click-hack.org>
References: <CAB6vvj=9Mt0tq-=kNhv+Agr6WTH3j0+3F3kPNcMKspNzXr0NKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB6vvj=9Mt0tq-=kNhv+Agr6WTH3j0+3F3kPNcMKspNzXr0NKg@mail.gmail.com>
Subject: Re: [Xenomai] rtnet issue with xenomai-3.git next branch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Antoine Hoarau <hoarau.robotics@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On Wed, Feb 25, 2015 at 10:23:24AM +0000, Antoine Hoarau wrote:
> This works:
> modprobe rtnet
> modprobe rt_e1000e
> modprobe rtipv4
> modprobe rtudp
> 
> I get :
> 
> [  282.200776] *** RTnet for Xenomai v3.0-rc3 ***
> [  282.200776]
> [  282.200778] RTnet: initialising real-time networking
> [  289.201612] rt_e1000e: Intel(R) PRO/1000 Network Driver - 1.5.1-k-rt
> [  289.201614] rt_e1000e: Copyright(c) 1999 - 2011 Intel Corporation.
> [  289.201630] rt_e1000e 0000:05:00.0: Disabling ASPM L0s
> [  289.201842] rt_e1000e 0000:05:00.0: irq 48 for MSI/MSI-X
> [  289.201845] rt_e1000e 0000:05:00.0: irq 49 for MSI/MSI-X
> [  289.201847] rt_e1000e 0000:05:00.0: irq 50 for MSI/MSI-X
> [  289.317567] RTnet: registered rteth0
> [  289.317570] rt_e1000e: (PCI Express:2.5GT/s:Width x1) 68:05:ca:32:c9:ab
> [  289.317571] rt_e1000e: Intel(R) PRO/1000 Network Connection
> [  289.317582] rt_e1000e: MAC: 3, PHY: 8, PBA No: E46981-008
> 
> I can unload/load them without any problems.
> Then I can do :
> 
> ./rtifconfig rteth0 up 192.168.100.101
> ./rtifconfig
> 
> rteth0    Medium: Ethernet  Hardware address: 68:05:CA:32:C9:AB
>           IP address: 192.168.100.101  Broadcast address: 192.168.100.255
>           UP BROADCAST RUNNING  MTU: 1500
> 
> Then I plug the cable and turn on the slave:
> [  572.581589] e1000e: rteth0 NIC Link is Up 1000 Mbps Full Duplex, Flow
> Control: Rx/Tx
> 
> I need to 'solicit' it by launching :
> ./rtroute solicit 192.168.100.102 dev rteth0
> 
> I can see the slave:
> ./rtroute
> Host Routing Table
> Hash Destination HW Address Device
> 26 192.168.100.102 90:E2:BA:26:72:15 rteth0
> 3F 192.168.100.255 FF:FF:FF:FF:FF:FF rteth0
> 
> But I can't ping :
> 
> ./rtping 192.168.100.102
> Real-time PING 192.168.100.102 56(84) bytes of data.
> ioctl: Inappropriate ioctl for device

Run this with strace to see which ioctl is failing.

> 
> And wireshark does not see the rteth0 interface.

You need to load rtcap.ko (after the interface) to have the capture
interface.

-- 
					    Gilles.

