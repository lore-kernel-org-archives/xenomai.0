Message-ID: <48E22F37.2000903@domain.hid>
Date: Tue, 30 Sep 2008 09:52:55 -0400
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
References: <48C1053E.4010507@domain.hid> <48E20246.7060406@domain.hid>
In-Reply-To: <48E20246.7060406@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Oops with ifconfig on Sequioa AMCC 440EPX board
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-help <xenomai@xenomai.org>

Philippe Gerum wrote:
> Wolfgang Grandegger wrote:
>> Hello,
>>
>> I get the following Oops with a Xenomai patch kernel when configuring
>> the EEPRO100 on the PCI slot:
...
>> Any idea where the problem could be?
>>
> 
> As you pointed out, there was an issue with cascaded UICs. The following patch
> should fix it (will be merged in the upcoming 2.2-05):

Thanks!  The patch does indeed fix it.  One comment, though.  I had
turned on spinlock debugging as well as adding your patch.  That
combination produces the bugs below.  Once I turn off spinlock
debugging (with the patch still included), then things work properly.

So, I don't know if this bug is totally unrelated to Ipipe.  I'll
investigate and post again with the results.

	Steve


PPC 4xx OCP EMAC driver, version 3.54
MAL v2 /plb/mcmal, 2 TX channels, 2 RX channels
ZMII /plb/opb/emac-zmii@domain.hid initialized
RGMII /plb/opb/emac-rgmii@domain.hid initialized with MDIO support
/plb/opb/emac-rgmii@domain.hid: input 0 in RGMII mode
BUG: spinlock bad magic on CPU#0, swapper/1
 lock: cf8161ac, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
Call Trace:
[cf82dc20] [c000651c] show_stack+0x44/0x1ac (unreliable)
[cf82dc60] [c01823fc] spin_bug+0x7c/0xc4
[cf82dc80] [c0182608] _raw_spin_lock+0x94/0x180
[cf82dcb0] [c02ab880] _spin_lock_bh+0x20/0x34
[cf82dcd0] [c0240048] dev_mc_add+0x2c/0x84
[cf82dcf0] [c01ac7a8] emac_configure+0x32c/0x588
[cf82dd20] [c02b17c0] 0xc02b17c0
[cf82de10] [c022a0d4] of_platform_device_probe+0x5c/0x84
[cf82de30] [c01a5bd4] driver_probe_device+0xb8/0x1e8
[cf82de50] [c01a5d88] __driver_attach+0x84/0x88
[cf82de70] [c01a50b0] bus_for_each_dev+0x5c/0x98
[cf82dea0] [c01a59dc] driver_attach+0x24/0x34
[cf82deb0] [c01a5708] bus_add_driver+0x1d8/0x258
[cf82dee0] [c01a5f98] driver_register+0x5c/0x158
[cf82df00] [c0229fa8] of_register_driver+0x54/0x70
[cf82df10] [c036d0d0] emac_init+0x1a8/0x1d4
[cf82df50] [c03561b4] kernel_init+0xac/0x294
[cf82dff0] [c000eb60] kernel_thread+0x44/0x60
BUG: spinlock lockup on CPU#0, swapper/1, cf8161ac
Call Trace:
[cf82dc40] [c000651c] show_stack+0x44/0x1ac (unreliable)
[cf82dc80] [c01826c4] _raw_spin_lock+0x150/0x180
[cf82dcb0] [c02ab880] _spin_lock_bh+0x20/0x34
[cf82dcd0] [c0240048] dev_mc_add+0x2c/0x84
[cf82dcf0] [c01ac7a8] emac_configure+0x32c/0x588
[cf82dd20] [c02b17c0] 0xc02b17c0
[cf82de10] [c022a0d4] of_platform_device_probe+0x5c/0x84
[cf82de30] [c01a5bd4] driver_probe_device+0xb8/0x1e8
[cf82de50] [c01a5d88] __driver_attach+0x84/0x88
[cf82de70] [c01a50b0] bus_for_each_dev+0x5c/0x98
[cf82dea0] [c01a59dc] driver_attach+0x24/0x34
[cf82deb0] [c01a5708] bus_add_driver+0x1d8/0x258
[cf82dee0] [c01a5f98] driver_register+0x5c/0x158
[cf82df00] [c0229fa8] of_register_driver+0x54/0x70
[cf82df10] [c036d0d0] emac_init+0x1a8/0x1d4
[cf82df50] [c03561b4] kernel_init+0xac/0x294
[cf82dff0] [c000eb60] kernel_thread+0x44/0x60

