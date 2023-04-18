Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120E31FA0
	for <xenomai@lists.linux.dev>; Tue, 18 Apr 2023 08:43:14 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay.mail.gandi.net (Postfix) with ESMTPS id DE1792000A
	for <xenomai@lists.linux.dev>; Tue, 18 Apr 2023 08:43:12 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
	by spool.mail.gandi.net (Postfix) with ESMTP id 8648FD8026F
	for <xenomai@xenomai.org>; Tue, 18 Apr 2023 08:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=Odh2l5vxG5y0sAYA22k8cecisRTFY4G2OXa3kQXXtg8=;
	b=Ij5jy3oojBNBYozetPEroc8VAXd9w69/WdfYWtONqRN87NjKrewe7+hl01hjSX
	HRD7r0F0NsdfSBZka/wj+sXn5m9lp7mNau2CGW40vac1Y76uinnsMX3D4bnif9b9
	SOJ8qcp8Pu/cYwFqiJ5An2Tf8XTsOIm/i27Xcs8KB520Q=
Received: from [10.10.80.199] (unknown [117.121.60.17])
	by zwqz-smtp-mta-g0-0 (Coremail) with SMTP id _____wDH+jD8Vz5kAYj_Bg--.52979S2;
	Tue, 18 Apr 2023 16:42:37 +0800 (CST)
Message-ID: <abddba56-37d3-6fb7-be98-2f6ed64c2f97@163.com>
Date: Tue, 18 Apr 2023 16:42:36 +0800
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Repeat initialization for wd_data->dev
Content-Language: en-US
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 "xenomai@xenomai.org" <xenomai@xenomai.org>
References: <0c88a90d-1a24-15c5-21e3-bd0a6d9c18aa@163.com>
 <MN2PR11MB42858E0D781BE863F9FD4F40F29D9@MN2PR11MB4285.namprd11.prod.outlook.com>
From: linz <powertree@163.com>
In-Reply-To: <MN2PR11MB42858E0D781BE863F9FD4F40F29D9@MN2PR11MB4285.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDH+jD8Vz5kAYj_Bg--.52979S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WrWDGr1fZw4kJr1rtw1UKFg_yoWxJr1kp3
	4UCa15tr4Utr4DXry7JwsF9rykCa97tr1xK3WUK343C3Z0kry5tr4FkFyFkayvkws3WF18
	Zr1jvrWF9a98tr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRpnmiUUUUU=
X-Originating-IP: [117.121.60.17]
X-CM-SenderInfo: psrzv2pwuhvqqrwthudrp/1tbiTAJVlWI0Y7sfyQAAsW
Received-SPF: pass (spool5: domain of 163.com designates 220.181.12.198 as permitted sender) client-ip=220.181.12.198; envelope-from=powertree@163.com; helo=m12.mail.163.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=163.com header.s=s110527 header.b=Ij5jy3oo;
	dmarc=pass (policy=none) header.from=163.com;
	spf=pass (spool.mail.gandi.net: domain of powertree@163.com designates 220.181.12.198 as permitted sender) smtp.mailfrom=powertree@163.com
X-Spam-Flag: yes
X-Spam-Level: ********************
X-GND-Spam-Score: 300
X-GND-Status: SPAM

Hi,  the issue does not happen with common Linux kernel after you 
disable I-PIPE, because it may be IPIPE bug.

We can see that the function is as follows from 
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/tree/drivers/watchdog/watchdog_dev.c?h=v4.19.209-cip59

static  int  watchdog_cdev_register(struct  watchdog_device  *wdd)
{
	struct  watchdog_core_data  *wd_data;
	int  err;

	wd_data  =  kzalloc(sizeof(struct  watchdog_core_data),  GFP_KERNEL);
	if  (!wd_data)
		return  -ENOMEM;
	mutex_init(&wd_data->lock);

	wd_data->wdd  =  wdd;
	wdd->wd_data  =  wd_data;

	if  (IS_ERR_OR_NULL(watchdog_kworker))  {
		kfree(wd_data);
		return  -ENODEV;
	}

	device_initialize(&wd_data->dev);
	wd_data->dev.devt  =  MKDEV(MAJOR(watchdog_devt),  wdd->id);
	wd_data->dev.class  =  &watchdog_class;
	wd_data->dev.parent  =  wdd->parent;
	wd_data->dev.groups  =  wdd->groups;
	wd_data->dev.release  =  watchdog_core_data_release;
	dev_set_drvdata(&wd_data->dev,  wdd);
	dev_set_name(&wd_data->dev,  "watchdog%d",  wdd->id);

	kthread_init_work(&wd_data->work,  watchdog_ping_work);
	hrtimer_init(&wd_data->timer,  CLOCK_MONOTONIC,  HRTIMER_MODE_REL);
	wd_data->timer.function  =  watchdog_timer_expired;

	if  (wdd->id  ==  0)  {

                  ... ....

}

But  the function is as follows from 
https://source.denx.de/Xenomai/ipipe-arm64/-/blob/ipipe/4.19.y-cip/drivers/watchdog/watchdog_dev.c

We can see the lines 19 to 26 are duplicated with the lines 28 to 35. I 
guess the lines 28 to 35 may be added mistakenly.

1 static int watchdog_cdev_register(struct watchdog_device *wdd)
2 {
3     struct watchdog_core_data *wd_data;
4    int err;
5
6    wd_data = kzalloc(sizeof(struct watchdog_core_data), GFP_KERNEL);
7    if (!wd_data)
8        return -ENOMEM;
9    mutex_init(&wd_data->lock);
10
11    wd_data->wdd = wdd;
12    wdd->wd_data = wd_data;
13
14    if (IS_ERR_OR_NULL(watchdog_kworker)) {
15        kfree(wd_data);
16        return -ENODEV;
17    }
18
19 device_initialize(&wd_data->dev);
20    wd_data->dev.devt = MKDEV(MAJOR(watchdog_devt), wdd->id);
21    wd_data->dev.class = &watchdog_class;
22    wd_data->dev.parent = wdd->parent;
23    wd_data->dev.groups = wdd->groups;
24    wd_data->dev.release = watchdog_core_data_release;
25    dev_set_drvdata(&wd_data->dev, wdd);
26    dev_set_name(&wd_data->dev, "watchdog%d", wdd->id);
27
28 device_initialize(&wd_data->dev);
29    wd_data->dev.devt = MKDEV(MAJOR(watchdog_devt), wdd->id);
30    wd_data->dev.class = &watchdog_class;
31    wd_data->dev.parent = wdd->parent;
32    wd_data->dev.groups = wdd->groups;
33    wd_data->dev.release = watchdog_core_data_release;
34    dev_set_drvdata(&wd_data->dev, wdd);
35    dev_set_name(&wd_data->dev, "watchdog%d", wdd->id);
36
37    kthread_init_work(&wd_data->work, watchdog_ping_work);
38    hrtimer_init(&wd_data->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
39    wd_data->timer.function = watchdog_timer_expired;
40
41    if (wdd->id == 0) {

           ... ...

}


在 2023/4/18 16:20, Chen, Hongzhan 写道:
>
>> -----Original Message-----
>> From: linz <powertree@163.com>
>> Sent: Tuesday, April 18, 2023 4:01 PM
>> To: xenomai@xenomai.org
>> Subject: Repeat initialization for wd_data->dev
>>
>> Hi, I find a Call trace when arm64 kernel is booting when I use
>> remotes/origin/ipipe/4.19.y-cip branch, the Call trace is as follows
>>
>> [    2.108797] I-pipe domain: Linux
>> [    2.112014] Call trace:
>> [    2.114458]  dump_backtrace+0x0/0x150
>> [    2.118112]  show_stack+0x14/0x20
>> [    2.121419]  dump_stack+0xd0/0x110
>> [    2.124812]  kobject_init+0x8c/0xa0
>> [    2.128294]  device_initialize+0x3c/0xd0
>> [    2.132209]  watchdog_dev_register+0xd4/0x2e0
>> [    2.136557]  __watchdog_register_device+0xd0/0x2a0
>> [    2.141338]  watchdog_register_device+0x70/0x90
>> [    2.145858]  sbsa_gwdt_probe+0x160/0x310
>> [    2.149772]  platform_drv_probe+0x50/0xa0
>> [    2.153771]  really_probe+0x248/0x3b0
>> [    2.157423]  driver_probe_device+0x54/0xf0
>> [    2.161509]  __driver_attach+0x104/0x120
>> [    2.165423]  bus_for_each_dev+0x70/0xcc
>> [    2.169248]  driver_attach+0x20/0x30
>> [    2.172813]  bus_add_driver+0x164/0x20c
>> [    2.176638]  driver_register+0x74/0x120
>> [    2.180463]  __platform_driver_register+0x44/0x50
>> [    2.185160]  sbsa_gwdt_driver_init+0x18/0x20
>> [    2.189421]  do_one_initcall+0x50/0x160
>> [    2.193248]  kernel_init_freeable+0x19c/0x23c
>> [    2.197596]  kernel_init+0x10/0x100
>> [    2.201074]  ret_from_fork+0x14/0x24
>>
>> The reason is that there is repeat initialization for wd_data->dev in
>> function watchdog_cdev_register on remotes/origin/ipipe/4.19.y-cip branch.
> Thanks for your email. Does the issue happen with common Linux kernel after you disable I-PIPE? If not , it should be common kernel issue and you may like to report it to Linux kernel community.
>
> Regards
>
> Hongzhan Chen
>> The fixed up patch is as follows:
>>
>> diff --git a/drivers/watchdog/watchdog_dev.c
>> b/drivers/watchdog/watchdog_dev.c
>> index 863b2dfc9..8fe59b7d8 100644
>> --- a/drivers/watchdog/watchdog_dev.c
>> +++ b/drivers/watchdog/watchdog_dev.c
>> @@ -958,15 +958,6 @@ static int watchdog_cdev_register(struct
>> watchdog_device *wdd)
>>       dev_set_drvdata(&wd_data->dev, wdd);
>>       dev_set_name(&wd_data->dev, "watchdog%d", wdd->id);
>>
>> -    device_initialize(&wd_data->dev);
>> -    wd_data->dev.devt = MKDEV(MAJOR(watchdog_devt), wdd->id);
>> -    wd_data->dev.class = &watchdog_class;
>> -    wd_data->dev.parent = wdd->parent;
>> -    wd_data->dev.groups = wdd->groups;
>> -    wd_data->dev.release = watchdog_core_data_release;
>> -    dev_set_drvdata(&wd_data->dev, wdd);
>> -    dev_set_name(&wd_data->dev, "watchdog%d", wdd->id);
>> -
>>       kthread_init_work(&wd_data->work, watchdog_ping_work);
>>       hrtimer_init(&wd_data->timer, CLOCK_MONOTONIC,
>> HRTIMER_MODE_REL);
>>       wd_data->timer.function = watchdog_timer_expired;
>>
>>
>> Thank you
>>
>>

