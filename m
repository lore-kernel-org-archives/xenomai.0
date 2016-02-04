Sender: Michael Welling <mwelling79@gmail.com>
Date: Thu, 4 Feb 2016 16:20:30 -0600
From: Michael Welling <mwelling@ieee.org>
Message-ID: <20160204222030.GA9910@deathstar>
References: <20160203145146.GB25464@deathstar>
 <20160203150448.GF32138@hermes.click-hack.org>
 <20160203151802.GC25464@deathstar>
 <20160203153341.GG32138@hermes.click-hack.org>
 <20160204195805.GA31015@deathstar>
 <20160204220729.GD11143@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160204220729.GD11143@hermes.click-hack.org>
Subject: Re: [Xenomai] RT FEC net driver for IMX6Q
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, Feb 04, 2016 at 11:07:29PM +0100, Gilles Chanteperdrix wrote:
> As indicated by the message: the code at line 158 in
> arch/arm/kernel/ipipe.c
> Which is:
> if (WARN_ON_ONCE(irq_get_chip(irq)->irq_set_affinity == NULL))
> 		return;
> 
> That is, the fact that the irq chip does not have an
> irq_set_affinity callback.
> 

Hmmm ...

Perhaps it has to do with the fact that the irq is -1.

[   35.013157] rteth0: Freescale FEC PHY driver [Micrel KSZ9031 Gigabit PHY] (mii_bus:phy_addr=2188000.ethernet:01, irq=-1)

I will take a look at my device tree.

> > 
> > What would cause the ioctl to fail?
> 
> The fact that you are missing this commit:
> https://git.xenomai.org/xenomai-3.git/commit/kernel/drivers/net/drivers/loopback.c?h=next&id=04df10d1fdc32e719b66f02da9117d2783a24bd2
> 

Excellent the ping appears to work now:
root@somimx6:/usr/xenomai/sbin# ./rtifconfig
rteth0    Medium: Ethernet  Hardware address: 00:14:2D:00:01:02
          IP address: 127.0.0.2  Broadcast address: 127.0.0.255
          UP BROADCAST RUNNING  MTU: 1500
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1283 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 
          RX bytes:0 (0.0 b)  TX bytes:54256 (52.9 Kb)

rtlo      Medium: Local Loopback
          IP address: 127.0.0.1  
          UP LOOPBACK RUNNING  MTU: 1500

root@somimx6:/usr/xenomai/sbin# ./rtping 127.0.0.1
Real-time PING 127.0.0.1 56(84) bytes of data.
64 bytes from 127.0.0.1: icmp_seq=1 time=25.7 us
64 bytes from 127.0.0.1: icmp_seq=2 time=18.0 us
64 bytes from 127.0.0.1: icmp_seq=3 time=16.7 us
64 bytes from 127.0.0.1: icmp_seq=4 time=19.0 us
64 bytes from 127.0.0.1: icmp_seq=5 time=18.3 us
64 bytes from 127.0.0.1: icmp_seq=6 time=17.3 us
64 bytes from 127.0.0.1: icmp_seq=7 time=16.7 us
64 bytes from 127.0.0.1: icmp_seq=8 time=18.0 us
64 bytes from 127.0.0.1: icmp_seq=9 time=18.7 us

> -- 
> 					    Gilles.
> https://click-hack.org

