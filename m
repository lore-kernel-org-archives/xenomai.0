Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99601FD5
	for <xenomai@lists.linux.dev>; Tue, 12 Jul 2022 01:11:44 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::225])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id C9BEBC9B04
	for <xenomai@lists.linux.dev>; Tue, 12 Jul 2022 01:10:46 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay.mail.gandi.net (Postfix) with ESMTPS id ADE081C0004
	for <xenomai@lists.linux.dev>; Tue, 12 Jul 2022 01:10:38 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	by spool.mail.gandi.net (Postfix) with ESMTPS id B988AD8050D
	for <xenomai@xenomai.org>; Tue, 12 Jul 2022 01:10:37 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id r10so2953503wrv.4
        for <xenomai@xenomai.org>; Mon, 11 Jul 2022 18:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=u47vGTLU+3gyHYWwiKeN4wP1qBLjnMGAhZBeSiCT+j4=;
        b=UNyy5XHw+RW4MphTO52mydB7m5ehi0y0uQ7lEgtSBMrP9Gz2uUOaLKeRgGvOXZx602
         pT3jpG569EhdjOdquZIhsqGeG/5RH+Fm/At4RTA4rvx7KX3wouEufod3dXBpC8/WX/Ff
         KTjQNobdYAYvmD6NcgytYiZzDFjOchtb9U5mo3nnRiD/8KUu26LMygcjs9BRO+nwQNdt
         McBr54iqKHsD17+LaO+ty/RJRppQJDMR4+d2w7FtEXspcaKn5VcRJjpR7Tsk0Bx71Q3X
         neTGchsJlN/PuWxunSL3gWNPhfpN6Kur73MPo98TvBWWgY/BylOV7Mfk9NTPRT9d5ET3
         EZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=u47vGTLU+3gyHYWwiKeN4wP1qBLjnMGAhZBeSiCT+j4=;
        b=YNqqV0d/pZiIDZwMqnJtrslm+8rtMPUKS+MQC0FpHDQ4k+JIi4CTy5M+RRQRF3YCUn
         WGBaqfw/uIsJt3X9D8L8xgRh+eUOrwSb0mcn+QqnNYoFNQTqfn10/4ax2UEpxAU6UxhM
         ekkEMqt+gyj7ojq14OEE8UkMezi5D9I19M6Vc9dP8dxkoFw5RqLAHMAseeJwVPjSlJ7r
         2w5eS6TggC2SDEsipIXWrifc70TTpg7sBEQblpkKvX2052FrKS/YKtyR0IW9tZ8T5MJ5
         oZE8+qPmgM31Ky4ltTLHUvpAfvamd9AsD+KXe9J9+1xXRswM1R/RSp3UCfriHBHAYgV2
         N0yQ==
X-Gm-Message-State: AJIora85P3eL/V+LrGu/GwT4xBgXDOL57Ngu648yyvPUBlIhGjWSiwHd
	zXrFZDYBQfBxlHK+EPGiGcTpoRsVfgjuat+Gnjt7ilMUJ/o=
X-Google-Smtp-Source: AGRyM1sdShurEMVAVJiQ1DBq2ZllprTrkGOUGw+7n4DX/MIHTB9LLF04OBd8tpzhvQuXiaWQFfUfVm4i8aO7HfEbric=
X-Received: by 2002:a05:6000:1d1:b0:21d:6673:9894 with SMTP id
 t17-20020a05600001d100b0021d66739894mr19475561wrx.640.1657588237191; Mon, 11
 Jul 2022 18:10:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Sri Subramanian <sridhar.subramanian@gmail.com>
Date: Mon, 11 Jul 2022 18:10:26 -0700
Message-ID: <CAAm9oxrn5pTSPH_AqrZ_0QakrL1LDsAW2GfA=ckejhnYFPOrFA@mail.gmail.com>
Subject: Xenomai 4 / oob_sendmsg crashes kernel from tidbits/oob-net-icmp
To: xenomai@xenomai.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass (spool5: domain of gmail.com designates 209.85.221.43 as permitted sender) client-ip=209.85.221.43; envelope-from=sridhar.subramanian@gmail.com; helo=mail-wr1-f43.google.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=gmail.com header.s=20210112 header.b=UNyy5XHw;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (spool.mail.gandi.net: domain of sridharsubramanian@gmail.com designates 209.85.221.43 as permitted sender) smtp.mailfrom=sridharsubramanian@gmail.com

Hello,

I am trying to optimize sending ethernet raw packets (for an Ethercat
fieldbus application) on a RaspberryPi/CM4 environment.

Before implementing the application, I thought I'd try getting an ICMP
echo using the "tidbits" sample program oob-net-icmp.

I am using eth0 from a RaspberryPI (used to ping) connected to another
PI device (CM4 on an IO board) also on eth0, which is echoing back the
pings using oob-net-icmp. I set up vlan 42 as documented in the
program, for both the devices. (I verify the network connection is
good  prior to this by sending pings and verifying the echo responses,
through the standard Linux stack on eth0).

I also set up the ping-receiving device so the Xenomai kernel can
route the packets up the Xenomai mini stack, setting:

echo 1> /sys/class/net/eth0.42/oob_port
echo 42 > /sys/class/evl/control/net_vlans

On the first ping, the kernel crashes with the stack as below. I've
tested on both versions 5.15 and 5.17 (both with CONFIG_NET_OOB=y).
Thanks for any help or guidance.

-Sri Subramanian

Crash stack:

[1569.557819] Unable to handle kernel paging request at virtual
address 0000000008ab2428
[1569.656294] Mem abort info:
[1569.692521] ESR = 0x96000005 [1569.731885] EC 0x25: DABT (current
EL), IL = 32 bits
[1569.798702] SET = 0, FnV = 0
[1569.838099] EA = 0, S1PTH = 0
[1569.878560] FSC 0x05: level 1 translation fault
[1569.940162] Data abort info:
[1569.977535) ISV = 0, ISS = 0x00000005
[1570.026534] CH= 0, HnR = 0
[1570.064995] user pgtable: 4k pages, 39-bit Vis, pgdp=0000000101a1f000
[1570.1457331 [0000000008ab2428] pgd=0000000000000000,
p4d:0000000000000000, pud:0000000000000000
[1570,253996] Internal error: Oops: 960000005 [#1] PREEMPT SMP
Modules linked in: bluetooth ecdh_generic ecc rfkill squashfs dm_md
snd_soc_hdmi_codec spidev
cdc_mbim cdc_wdm cdc_ncm cdc_ether ax88179_178a vc4 cec
raspberrypi_hwmon drm_cma_helper
12c_brcmstb 12c_bcm2835 drm_kms_helper sp_bcm2835 snd_soc_core
snd_pcm_dmaengine snd_pcm snd_timer
snd syscopyarea sysfillrect sysimgblt fb_sys_fops nvnem_rmem
uio_pdrv_genirq uio sch_fq_codel
fuse drm drm_panel_orientation_quirks backlight configfs ip_tables x_tables ipv6
[1570.254135] CPU: O PID: 1007 Comm: kworker/u8:0 Not tainted
5.17.0-xeno-5.17+cob-net+ #7
[1570.254148] Hardware name: Raspberry Pi Compute Module 4 Rev 1.0 (DT)
[1570.254153] IRQ stage: Linux
[1570.254163] Workqueue: 0x0 (events unbound)
[1570.254179] pstate: 00000005 (nzev dalf -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[1570.254189] pc skb clone+0x28/0xe0
[1570.254207] Ir dev_queue mit nit+0x130/0x298
[1570.254221] sp : ffffffc00941b9c0
[1570.254225] x29: ffffffc00941b9c0 x28: 0000000000000000 x27: ffffffc008b23000
[1570.254240] x26: ffffff8101800000 x25: ffffffc00ed6af90 x24: 0000000000000004
[1570.254253] x23: 0000000000000001 x22: ffffff8103124e00 x21: ffffff8101a00080
[1570.254265] x20: 0000000000000820 x19: ffffff8103124e00 x18: 0000000000000000
[1570.2542771 x17: 0000000000000000 x16: 0000000000000000 x15: 0000000062cc76c8
[1570.254289] x14: 010002002c120000 x13: e2ce38387840bd21 x12: 0acc300000000002
[1570.254301] x11: 0000000000000000 x10: ffffffc1f632e000 x9 : 00000000000001f0
[1570.254314] x8 : 0000000000000000 x7 : ffffff8100b90000 x6 : 0000000000000010
[1570.254326] x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffffffc00941bb14
[1570.254337] x2 : 0000000008ab2428 x1 : 0000000000000000 x0 : 0000000008ab2428
[1570.254350] Call trace:
[1570.254353] skb_clone+0x28/0xe0
[1570.254364] dev_queue_mit_nit+0x130/0x298
[1570.254376] dev_hard_start_xmit+0xib0/0xids
[1570.254388] sch direct mit+0x94/0x1e8
[1570.254400] __qdisc_run+0x120/0x6b0
[1570.254410] net_tx_action+0x138/0x210 [1570.254417] stext+0x11c/0x260
[1570.254426] irq exit+0xb0/0xf0
[1570.254436] arch_do_IRQ pipelined+0x48/0x70
[1570.254446] sync_current_irq_stage+0x1ec/0x280
[1570.254460] __inband_irq_enable+0x78/0x90
[1570.254471] inband_irq_enable+0x10/0x20
[1570.254482] finish_task_switch+0x98/0x228
[1570.254494] __schedule+0x288/0x710
[1570.2545071 schedule+0x54/0xf0
[1570.254518] worker thread+0xbc/0x420
[1570.254526] kthread+0x110/0x120
[1570.254538) ret_from_fork+0x10/0x20
[1570.254553] Code: b4000100 b940b800 19406261 86000022 (36606620)
[1573.224950]---[ end trace 0000000000000000]---
[1573.224958) Kernel panic- not syncing: Oops: Fatal exception in interrupt
[1573.224963] SMP: stopping secondary CPUS
[1573.2249821 Kernel Offset: disabled
[1573.224984] CPU features: 0x40,00000342,00000842
[1573.224991] Memory Limit: none
