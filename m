Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04351C02
	for <xenomai@lists.linux.dev>; Tue, 18 Apr 2023 08:02:42 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 73BC71C001B
	for <xenomai@lists.linux.dev>; Tue, 18 Apr 2023 08:02:35 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
	by spool.mail.gandi.net (Postfix) with ESMTP id 82CE6D8142D
	for <xenomai@xenomai.org>; Tue, 18 Apr 2023 08:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:From:Subject:
	Content-Type; bh=PLtcOCvRTTEEZWxHfzBw5MVO7m4GEOKltU0fyAPPOPU=;
	b=lJXq6bh7gnC986ulomYEnVu1ZKSLP9fwzZTCHoSz/R4AckMzFajuI1nAUZfy0M
	CloymkSIalLtEpp3jQCCrbBmWMp1Iy2GsA02MTT3RDt4iGJVI2D3lfoeKsqxu6Qf
	kUlvxjfWtx6U1PJxfeuJMxFRmqEqD0x5AnXjx94l+VVvM=
Received: from [10.10.80.199] (unknown [117.121.60.17])
	by zwqz-smtp-mta-g3-1 (Coremail) with SMTP id _____wAnnq5STj5kxvI4Bw--.52794S2;
	Tue, 18 Apr 2023 16:01:22 +0800 (CST)
Message-ID: <0c88a90d-1a24-15c5-21e3-bd0a6d9c18aa@163.com>
Date: Tue, 18 Apr 2023 16:01:22 +0800
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: xenomai@xenomai.org
From: linz <powertree@163.com>
Subject: Repeat initialization for wd_data->dev
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnnq5STj5kxvI4Bw--.52794S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr4fJw1DKrW3KFyUWw18AFb_yoW5Gw4xpa
	45Ca15tr4UtrWDZrsrAw4DuFn5Ca97Kr47G3WxK343ZFs0kr98tr40kFyruayDGrZxWF9x
	tF1UXryFgan8tr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zROtxhUUUUU=
X-Originating-IP: [117.121.60.17]
X-CM-SenderInfo: psrzv2pwuhvqqrwthudrp/xtbCfgtVlWDcNomUUwAAsx
Received-SPF: pass (spool5: domain of 163.com designates 220.181.12.215 as permitted sender) client-ip=220.181.12.215; envelope-from=powertree@163.com; helo=m12.mail.163.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=163.com header.s=s110527 header.b=lJXq6bh7;
	dmarc=pass (policy=none) header.from=163.com;
	spf=pass (spool.mail.gandi.net: domain of powertree@163.com designates 220.181.12.215 as permitted sender) smtp.mailfrom=powertree@163.com

Hi, I find a Call trace when arm64 kernel is booting when I use 
remotes/origin/ipipe/4.19.y-cip branch, the Call trace is as follows

[    2.085125] kobject (000000007a365c50): tried to init an initialized 
object, something is seriously wrong.
[    2.094809] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G S                
4.19.209-cip59
[    2.104190] Hardware name: E2000Q DEMO DDR4 (DT)
[    2.108797] I-pipe domain: Linux
[    2.112014] Call trace:
[    2.114458]  dump_backtrace+0x0/0x150
[    2.118112]  show_stack+0x14/0x20
[    2.121419]  dump_stack+0xd0/0x110
[    2.124812]  kobject_init+0x8c/0xa0
[    2.128294]  device_initialize+0x3c/0xd0
[    2.132209]  watchdog_dev_register+0xd4/0x2e0
[    2.136557]  __watchdog_register_device+0xd0/0x2a0
[    2.141338]  watchdog_register_device+0x70/0x90
[    2.145858]  sbsa_gwdt_probe+0x160/0x310
[    2.149772]  platform_drv_probe+0x50/0xa0
[    2.153771]  really_probe+0x248/0x3b0
[    2.157423]  driver_probe_device+0x54/0xf0
[    2.161509]  __driver_attach+0x104/0x120
[    2.165423]  bus_for_each_dev+0x70/0xcc
[    2.169248]  driver_attach+0x20/0x30
[    2.172813]  bus_add_driver+0x164/0x20c
[    2.176638]  driver_register+0x74/0x120
[    2.180463]  __platform_driver_register+0x44/0x50
[    2.185160]  sbsa_gwdt_driver_init+0x18/0x20
[    2.189421]  do_one_initcall+0x50/0x160
[    2.193248]  kernel_init_freeable+0x19c/0x23c
[    2.197596]  kernel_init+0x10/0x100
[    2.201074]  ret_from_fork+0x14/0x24

The reason is that there is repeat initialization for wd_data->dev in 
function watchdog_cdev_register on remotes/origin/ipipe/4.19.y-cip branch.

The fixed up patch is as follows:

diff --git a/drivers/watchdog/watchdog_dev.c 
b/drivers/watchdog/watchdog_dev.c
index 863b2dfc9..8fe59b7d8 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -958,15 +958,6 @@ static int watchdog_cdev_register(struct 
watchdog_device *wdd)
      dev_set_drvdata(&wd_data->dev, wdd);
      dev_set_name(&wd_data->dev, "watchdog%d", wdd->id);

-    device_initialize(&wd_data->dev);
-    wd_data->dev.devt = MKDEV(MAJOR(watchdog_devt), wdd->id);
-    wd_data->dev.class = &watchdog_class;
-    wd_data->dev.parent = wdd->parent;
-    wd_data->dev.groups = wdd->groups;
-    wd_data->dev.release = watchdog_core_data_release;
-    dev_set_drvdata(&wd_data->dev, wdd);
-    dev_set_name(&wd_data->dev, "watchdog%d", wdd->id);
-
      kthread_init_work(&wd_data->work, watchdog_ping_work);
      hrtimer_init(&wd_data->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
      wd_data->timer.function = watchdog_timer_expired;


Thank you


