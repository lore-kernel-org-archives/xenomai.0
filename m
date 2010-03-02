From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B8D079B.1090008@domain.hid>
References: <4B8D079B.1090008@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 02 Mar 2010 15:01:45 +0100
Message-ID: <1267538505.3405.135.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] PCI cause system freeze
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alex Monti <alexmonti_82@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2010-03-02 at 13:42 +0100, Alex Monti wrote:
> Hi all,
> I'm testing realtime linux on Powerpc and I'm finding some serious problem with Adeos patch.
> My platform is mpc5121e rev 4 based one and I'm using 2.6.29.4 DENX kernel with Xenomai patch.
> My board boots, Xenomai works, but when I try to enable a Network Pci card, system always freeze.
> 
> In details:
> 
> With only 2.6.29.4 DENX kernel (without Xenomai patch) all works fine: board boots, all peripherals work (included network card).
> 
> When I apply the Xenomai patch, board boots,  Xenomai works and loading module of the network adapter (insmod .../module_name) has no problems but when I try to enable the interface (ifconfig eth1 up), system always freeze.
> 
> I've tried two network adapters (Intel e100 and Realtek r8169) so problem is not the driver.
> I've tried RTAI patch but result is always the same.
> 
> I think problem is in the ADEOS patch because it is the only thing common to all tests (same version for both patch).

Except that RTAI patches are different from vanilla Adeos patches, but
this not the issue.

The issue is that mpc5121 has been validated over 2.6.24.6, not 2.6.29.
In short, mpc5121 is not officially supported over anything > 2.6.24
yet.

> 
> Modifing driver of e100 I realize that system crash enabling irq (I think, not sure: I added some printk within the driver and the last function call that I see is e100_enable_irq).
> 
> Any suggestion? Any help is very usefull!!!
> Thanks
> 
> 
> 
>  <http://lxr.free-electrons.com/ident?i=e100_enable_irq>
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



