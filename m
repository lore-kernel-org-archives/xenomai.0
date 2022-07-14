Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A9F4A38
	for <xenomai@lists.linux.dev>; Thu, 14 Jul 2022 15:35:52 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::226])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 41AB0D0412
	for <xenomai@lists.linux.dev>; Thu, 14 Jul 2022 15:32:10 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 625CEC0003
	for <xenomai@lists.linux.dev>; Thu, 14 Jul 2022 15:32:02 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 476CF9418F4
	for <xenomai@xenomai.org>; Thu, 14 Jul 2022 15:32:01 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id E4F3FFF802;
	Thu, 14 Jul 2022 15:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1657812721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dIMhioKbBAZ56+aneVJTsF2Q8h836BrQwZYrbKuCqmQ=;
	b=DJcck0/A4mDvleCL7ELq5h2c4pPfojv+nqqtBeKPronM8/xcqD605ymRS4eOznBJ5zt3vy
	YjWiVoxNelA1sjEjpS87IWYasFK0hXvnevT90MLdBncvRqLZpZq0B4tBOhettuNHUHUJnM
	mBdrTrAc7jDt1Jgv8sT/ZBJtpssCu3N1nQth45dpoUKt2QxfvxLu7F8piVic0W8+BbnJUN
	eGYhfdTURe33mt84/rE8VJzOOl5VPV9HWKQYG/Iy8dd0OUjVvP98nPOOhqp3sJxuQl3QVu
	DyKZSyd4EuGKJL8c6cg4RZ0W8ClhEw16DSn3s4KC/lvx0Ah85cuj7P4NISKRxA==
References: <CAAm9oxrn5pTSPH_AqrZ_0QakrL1LDsAW2GfA=ckejhnYFPOrFA@mail.gmail.com>
User-agent: mu4e 1.6.6; emacs 27.2
From: Philippe Gerum <rpm@xenomai.org>
To: Sri Subramanian <sridhar.subramanian@gmail.com>
Cc: xenomai@xenomai.org
Subject: Re: Xenomai 4 / oob_sendmsg crashes kernel from tidbits/oob-net-icmp
Date: Thu, 14 Jul 2022 17:18:21 +0200
In-reply-to: <CAAm9oxrn5pTSPH_AqrZ_0QakrL1LDsAW2GfA=ckejhnYFPOrFA@mail.gmail.com>
Message-ID: <87fsj3d827.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass (spool1: domain of xenomai.org designates 217.70.183.199 as permitted sender) client-ip=217.70.183.199; envelope-from=rpm@xenomai.org; helo=relay9-d.mail.gandi.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.s=gm1 header.b="DJcck0/A";
	spf=pass (spool.mail.gandi.net: domain of rpm@xenomai.org designates 217.70.183.199 as permitted sender) smtp.mailfrom=rpm@xenomai.org;
	dmarc=none


Sri Subramanian <sridhar.subramanian@gmail.com> writes:

> Hello,
>
> I am trying to optimize sending ethernet raw packets (for an Ethercat
> fieldbus application) on a RaspberryPi/CM4 environment.
>

No NIC driver currently implements the EVL out-of-band protocol fully
yet, so at the moment, although the EVL network stack does improve the
timings, there is still some work on the device side to get a full
real-time path from the application to the wire.

i.e. today we have:

(app) <---> EVL netstack <--/ non-rt /--> (NIC driver via in-band context)

we aim at a full real-time path next:

(app) <---> EVL netstack <-------> (NIC driver via out-of-band context)


> Before implementing the application, I thought I'd try getting an ICMP
> echo using the "tidbits" sample program oob-net-icmp.
>
> I am using eth0 from a RaspberryPI (used to ping) connected to another
> PI device (CM4 on an IO board) also on eth0, which is echoing back the
> pings using oob-net-icmp. I set up vlan 42 as documented in the
> program, for both the devices. (I verify the network connection is
> good  prior to this by sending pings and verifying the echo responses,
> through the standard Linux stack on eth0).
>
> I also set up the ping-receiving device so the Xenomai kernel can
> route the packets up the Xenomai mini stack, setting:
>
> echo 1> /sys/class/net/eth0.42/oob_port
> echo 42 > /sys/class/evl/control/net_vlans
>
> On the first ping, the kernel crashes with the stack as below. I've
> tested on both versions 5.15 and 5.17 (both with CONFIG_NET_OOB=y).
> Thanks for any help or guidance.
>
> -Sri Subramanian
>
> Crash stack:
>
> [1569.557819] Unable to handle kernel paging request at virtual
> address 0000000008ab2428
> [1569.656294] Mem abort info:
> [1569.692521] ESR = 0x96000005 [1569.731885] EC 0x25: DABT (current
> EL), IL = 32 bits
> [1569.798702] SET = 0, FnV = 0
> [1569.838099] EA = 0, S1PTH = 0
> [1569.878560] FSC 0x05: level 1 translation fault
> [1569.940162] Data abort info:
> [1569.977535) ISV = 0, ISS = 0x00000005
> [1570.026534] CH= 0, HnR = 0
> [1570.064995] user pgtable: 4k pages, 39-bit Vis, pgdp=0000000101a1f000
> [1570.1457331 [0000000008ab2428] pgd=0000000000000000,
> p4d:0000000000000000, pud:0000000000000000
> [1570,253996] Internal error: Oops: 960000005 [#1] PREEMPT SMP
> Modules linked in: bluetooth ecdh_generic ecc rfkill squashfs dm_md
> snd_soc_hdmi_codec spidev
> cdc_mbim cdc_wdm cdc_ncm cdc_ether ax88179_178a vc4 cec
> raspberrypi_hwmon drm_cma_helper
> 12c_brcmstb 12c_bcm2835 drm_kms_helper sp_bcm2835 snd_soc_core
> snd_pcm_dmaengine snd_pcm snd_timer
> snd syscopyarea sysfillrect sysimgblt fb_sys_fops nvnem_rmem
> uio_pdrv_genirq uio sch_fq_codel
> fuse drm drm_panel_orientation_quirks backlight configfs ip_tables x_tables ipv6
> [1570.254135] CPU: O PID: 1007 Comm: kworker/u8:0 Not tainted
> 5.17.0-xeno-5.17+cob-net+ #7
> [1570.254148] Hardware name: Raspberry Pi Compute Module 4 Rev 1.0 (DT)
> [1570.254153] IRQ stage: Linux
> [1570.254163] Workqueue: 0x0 (events unbound)
> [1570.254179] pstate: 00000005 (nzev dalf -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [1570.254189] pc skb clone+0x28/0xe0
> [1570.254207] Ir dev_queue mit nit+0x130/0x298
> [1570.254221] sp : ffffffc00941b9c0
> [1570.254225] x29: ffffffc00941b9c0 x28: 0000000000000000 x27: ffffffc008b23000
> [1570.254240] x26: ffffff8101800000 x25: ffffffc00ed6af90 x24: 0000000000000004
> [1570.254253] x23: 0000000000000001 x22: ffffff8103124e00 x21: ffffff8101a00080
> [1570.254265] x20: 0000000000000820 x19: ffffff8103124e00 x18: 0000000000000000
> [1570.2542771 x17: 0000000000000000 x16: 0000000000000000 x15: 0000000062cc76c8
> [1570.254289] x14: 010002002c120000 x13: e2ce38387840bd21 x12: 0acc300000000002
> [1570.254301] x11: 0000000000000000 x10: ffffffc1f632e000 x9 : 00000000000001f0
> [1570.254314] x8 : 0000000000000000 x7 : ffffff8100b90000 x6 : 0000000000000010
> [1570.254326] x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffffffc00941bb14
> [1570.254337] x2 : 0000000008ab2428 x1 : 0000000000000000 x0 : 0000000008ab2428
> [1570.254350] Call trace:
> [1570.254353] skb_clone+0x28/0xe0
> [1570.254364] dev_queue_mit_nit+0x130/0x298
> [1570.254376] dev_hard_start_xmit+0xib0/0xids
> [1570.254388] sch direct mit+0x94/0x1e8
> [1570.254400] __qdisc_run+0x120/0x6b0
> [1570.254410] net_tx_action+0x138/0x210 [1570.254417] stext+0x11c/0x260
> [1570.254426] irq exit+0xb0/0xf0
> [1570.254436] arch_do_IRQ pipelined+0x48/0x70
> [1570.254446] sync_current_irq_stage+0x1ec/0x280
> [1570.254460] __inband_irq_enable+0x78/0x90
> [1570.254471] inband_irq_enable+0x10/0x20
> [1570.254482] finish_task_switch+0x98/0x228
> [1570.254494] __schedule+0x288/0x710
> [1570.2545071 schedule+0x54/0xf0
> [1570.254518] worker thread+0xbc/0x420
> [1570.254526] kthread+0x110/0x120
> [1570.254538) ret_from_fork+0x10/0x20
> [1570.254553] Code: b4000100 b940b800 19406261 86000022 (36606620)
> [1573.224950]---[ end trace 0000000000000000]---
> [1573.224958) Kernel panic- not syncing: Oops: Fatal exception in interrupt
> [1573.224963] SMP: stopping secondary CPUS
> [1573.2249821 Kernel Offset: disabled
> [1573.224984] CPU features: 0x40,00000342,00000842
> [1573.224991] Memory Limit: none


This patch may help:
https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/2ad6b2207f9f1669f64f6816428a20e1bbd6357c

Feedback on this fix welcome, so that we may assume the issue is closed.

PS: EVL is maintained for the latest LTS and SLTS releases, and follows
the mainline development tip closely too. This means v5.10-stable,
v5.15-stable and v5.19 at the moment. Other releases published may not
include all available patches: if you want to use them nevertheless, you
will need to cherry-pick fixes from maintained trees.

Thanks,

-- 
Philippe.
