Received: from mx0a-001f5801.pphosted.com (mx0a-001f5801.pphosted.com [148.163.157.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCE1320C
	for <xenomai@lists.linux.dev>; Fri, 28 Apr 2023 22:29:28 +0000 (UTC)
Received: from pps.filterd (m0090334.ppops.net [127.0.0.1])
	by mx0a-001f5801.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SKlhjv022159
	for <xenomai@lists.linux.dev>; Fri, 28 Apr 2023 13:47:53 -0700
Received: from usg02-cy1-obe.outbound.protection.office365.us (mail-cy1usg02lp0177.outbound.protection.office365.us [23.103.199.177])
	by mx0a-001f5801.pphosted.com (PPS) with ESMTPS id 3q8j8c0fe6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <xenomai@lists.linux.dev>; Fri, 28 Apr 2023 13:47:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=d4Zw7MQ/6CZVqfH9jO3R2UGHri4OJKJw43Q6TctbUtv/N4cSfmk9lpOxo3Wuo7Wb5CFc7bw80LUbZfYDddAPCkg36gFvYEeUvSPH3MFm0yTiF/QMlaXIceGuh/enyWJJyj+cQ79pQV0ozE6yEfSzeJTnWgE+7AtoBFbdXTwnSwuOWmnefZQDZvMql2oKW7zzFsBUdivPDRPajACUyO+5/7+afWIYjYbiJWWmcpau4DZvWTgZiEQt8p/FktCsBEneHBuOz/kTjJBShNxraj1JJTtLcJmioaDmnqw4A6G0p3oj8PXn474ysnlW4KSeDGYlXKs2iqatT6AuFtBPcueb/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cP/EkH+CXMwsrbjs5Bq9jOe3gUBfYi78YjWmn+qWdXk=;
 b=d6zzkljqntIrzPjBmaAhgyWdYuOE8bWtp6531rwlKiwHJE4BF24uMSmHtdj74XkC5Y6uitd7xHxBfxi4wAobcehlQcJx4HdIcKVMDGgD4/aRjXihS406e+ScmGllnb9GgK0rGUEs0ZdQdJ1bE2qdmnKHXzmbQ5bKvvSPVcX8CXP5Z94rMkZCBl2bui6Q2t1y5m03ObmiA3h8+CodicF0ji41bYYyQZFzgyTaCeyvHDvlZm4Emw9Vqg+1BELWV8jUl4kftcZvVLviFO7WLBbsTOX8DBPrGCPDLxc7qRl9g8ynoFLTi1AoIBYKyTUW91CmgD6Y16iRFxBs3lnFUMy7oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cP/EkH+CXMwsrbjs5Bq9jOe3gUBfYi78YjWmn+qWdXk=;
 b=DRmjV+8LQm41bXmACfO07yA7a9Za2TePG2gfHb9+Q/t5bMBIgenbOhgr6NFH6XGeQ8HHOANQ7HEwyc8UXRFh+eg6K+fqgvsfynWS+UuMO7NOMlY3g9rc5Y2AWU4gZrMG1rJOr7usof+vwPLWySUrjqZwTtwDKRvG8CXzZLEE2kXwCoF3XyJI4hYrBKwsp4G4t1NE4YePBRsw342mMdnnQO3LXJM0CfGdtbRcZYD8aWwWvWmA2P3Rm3bf2Qw00bzYmooeMvg8oUv+7/9Za3k9Ln4GtUPlXtwMMF5X9iWD88GAmrTx7sG7PJwR4bm+y/NjVDC2VIwe8DLu/YN5vl889Q==
Received: from PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:188::21)
 by PH1P110MB1132.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:174::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Fri, 28 Apr
 2023 20:47:50 +0000
Received: from PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM
 ([fe80::c96e:5bd5:5363:2999]) by PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM
 ([fe80::c96e:5bd5:5363:2999%5]) with mapi id 15.20.6319.037; Fri, 28 Apr 2023
 20:47:50 +0000
From: Dave Rolenc <Dave.Rolenc@kratosdefense.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: Russell Johnson <russell.johnson@kratosdefense.com>
Subject: Re: EVL Kernel Debugging
Thread-Topic: EVL Kernel Debugging
Thread-Index: AQHZehKyzv2OZiOdmUu0PHGOX4OOsA==
Date: Fri, 28 Apr 2023 20:47:50 +0000
Message-ID: 
 <PH1P110MB1666BA1533E0614496E7B678FE6B9@PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM>
References: 
 <PH1P110MB1050E3792D231FD98FD707B7E2659@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <871qk5zqpp.fsf@xenomai.org>
In-Reply-To: <871qk5zqpp.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1666:EE_|PH1P110MB1132:EE_
x-ms-office365-filtering-correlation-id: e08aee45-096b-43f7-525e-08db4829d4b1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 z9nuCYzkKpHcs0jLG9hYWTXaYSsj5O3Df5PurD2b68uNSzxFIwf3KwCS8Lj/nSgDDXpJ6yKZFL4Kb7QgpeW4jfU3tpgJkWv+LPxjkZMsHOdX6ZJw521TEPhnklTjC0PoIM//5dQi0oVEEazopN79p/hsqS/u83sWLtTJDNEXYHKVE2/yZ1wP2OfgMw/NwQICpoipLSO9KDz22yz6bfS44Hh+9OkzAgqj58KaTfQNCUF3ogvVMxmCMDSv2dUSX19iErt+hn5RqaJOGRE3dbe66HpbUcxguJ9NZZWjp3THinKOfPMqc/UZGRRRPc+dOb45OfaU6CTsK47zPFsvoFlc46GLlKzLNq+ELDQKI8NvS5xy77WVWViDd0p1XSjKGV/sBa6a5bxq6S9TxHQM0fr7uB03WYhVTnkOLqtO2E2vClFQ5za2B89SjVBshZKl7sbUsun9ZGhHBfZAqRwDUDXOLDJFEYU84wlHvAa3uFqeLVLVEM4nTILzmWyL3mX+9KAxI43yjmSGxuHYZi6kSBzeS7KwveUglZe93R9tdnfOtm6DAsuD1Jms6jPqeM9KwGnR09XxRhccHEvL1F0e/8KwzegTtiW3oKNDfkUywYZuJ4ghSlfZ82qK8dTzdOO+UKpf
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(39830400003)(451199021)(107886003)(122000001)(9686003)(71200400001)(26005)(6506007)(41320700001)(7696005)(38100700002)(3480700007)(83380400001)(186003)(2906002)(8676002)(66556008)(66946007)(508600001)(33656002)(86362001)(64756008)(66476007)(76116006)(38070700005)(66446008)(5660300002)(55016003)(8936002)(7116003)(52536014)(6916009)(41300700001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 dvkqxpLo5wbqjHAheqK86oKW07bxXpfLcki1j3q5qSjOENWfaEhx20SpAom163viZ0kdgUsSBNGkHnHDqHJ2fmvH8fBSNTxm9n02RMq4/pwbWg1UzOB9qE6IS3G3TbTKEVGhUnbaW3+CjkaiW1RYY1h5bhaAt8HHR0Q4hppF4/3zAYF6Rmi2cxFBA4M25jhidXSjY3jYdt2y+x74UG0ynPUroi4iblpNcSMC6BkmlnmmwxwpqCI566AROC/CpZ+8y0o+RoMTFENkVxzHH4t4eNSY/QZPNnTe/v1yjiOuYmb/Zbe2jQyAjk578YM6lCaKPCSfBrxJ0vT/8e1DCTeuq8sgs2zW3F0MQr5hvKSetIK/ZBe2uaIoX57OAs0A4RuyGaHgpCG5yVsOyhKileEErUNhbsh+OVO+7NN4qoRnrqI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Nw3cA9uQrSLjGvkaMae3ftECSbBmRNtQJChKIIKHFuUgRpQ7P1OXUjIBP6s234gf0UHs/089IQ2xrc5wknjioIh2JZEeTszuHaPenayGDeuib7TOCwa9j0G3Ggqx6EPbllhF9WvbBKaXSRtlMbwbQUgnTmwZzqPZqNtfKeltikN649l5CncAucYJwmJp3X6Er+OgamKrPt46tlffuzetTJmPbQsmU0mj+BFfaV8kNDLFz4HZBmOMc79zuIg/btfxsQZpZSQUwt5818PldOhOcfZmmD/RO+/41wuS1mfvq8049Q6tSLIGN+bGkI3HSxcDBMctQN00dWFk2JOk34YAUh/Hw3M2JN2T+JbKq7C1c6+8AD8JQhvlDp/igOnL2LzN5E9s7W3lku7ja/EljVmYNqY/5nG++JTN+3YO2HcvyFY6v7bYfkUpJgu6cy/hD3crN1V0FHh2PPEevrunsRJRf/XIkMz4rdcf+nf5JrDFJ3dBaVK+As7xsE2yhlPJbtq5rdJvapOAAFyw521woKg/pAd1ceUUKg+sFi5GFGO/afwGYQsCmQDyHdt1lpAT9HfiU/BSK/6FJYo6gka3UsdYWkQS5Hk5qswJLJotbO4ReYKEm1ffqhQvtMFvYvhExIa1X/T2/sDxB05jYegNpCems8m6A98s12TKBYGEyAw+pMYeV2PTfXrh6EcopNJvxpY1gVaCLvX1NkcogZRyon8r0tnDPUxfkZus8JBurE+d7O2z+7D52G5R16usYUoApNUGmYPMic8vmGaEQ1iDTlb5jQ==
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e08aee45-096b-43f7-525e-08db4829d4b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 20:47:50.1715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1132
X-Proofpoint-GUID: O6LvjKRqqRtezCSMZQzl9AIqGXV6xc3T
X-Proofpoint-ORIG-GUID: O6LvjKRqqRtezCSMZQzl9AIqGXV6xc3T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_06,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 mlxlogscore=835 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280171

>> We get a CPU STUCK when restarting an evl-enabled app multiple times,=20
>> and one way to get more insight into this problem is with a kernel debug=
ger.
>> With the kernel debugger not working, it seems difficult to get any=20
>> kernel-level insight.

> With x86, you could try passing nmi_watchdog=3D1 via the kernel cmdline
> to enable the APIC watchdog on the CPUs, _only for the purpose of
> debugging_ because this is likely going to make the latency figures
> skyrocket (setting nmi_watchdog=3D0 is a common recommendation on x86
> for a real-time configuration). But if the application logic can bear
> with degraded response time, with luck you might get a kernel
> backtrace exposing the culprit.

With this approach, we did end up with some stack traces. They mostly look =
like this:

sync_current_irq_stage (kernel/irq/pipeline.c:922 kernel/irq/pipeline.c:128=
8)
__inband_irq_enable (arch/x86/include/asm/irqflags.h:41 arch/x86/include/as=
m/irqflags.h:91 kernel/irq/pipeline.c:287)
inband_irq_enable (kernel/irq/pipeline.c:317 (discriminator 9))
_raw_spin_unlock_irq (kernel/locking/spinlock.c:203)
rwsem_down_write_slowpath (arch/x86/include/asm/current.h:15 (discriminator=
 1) kernel/locking/rwsem.c:1136 (discriminator 1))
down_write (kernel/locking/rwsem.c:1535)
kernfs_activate (fs/kernfs/dir.c:1302)
kernfs_add_one (fs/kernfs/dir.c:774)
kernfs_create_dir_ns (fs/kernfs/dir.c:1001)
sysfs_create_dir_ns (fs/sysfs/dir.c:62)
kobject_add_internal (lib/kobject.c:89 (discriminator 11) lib/kobject.c:255=
 (discriminator 11))
kobject_add (lib/kobject.c:390 lib/kobject.c:442)
? _raw_spin_unlock (kernel/locking/spinlock.c:187)
device_add (drivers/base/core.c:3329)
? __init_waitqueue_head (kernel/sched/wait.c:13)
device_register (drivers/base/core.c:3476)
create_sys_device (kernel/evl/factory.c:312)
create_element_device (kernel/evl/factory.c:439)
ioctl_clone_device (kernel/evl/factory.c:559)
 __x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:874 fs/ioctl.c:860 fs/ioctl.c:86=
0)
do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:89)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:118)

I have to dig a little deeper about the origin of the ioctl from
userspace. The top of the trace seems to vary a little bit above
the inband_irq_enable. For example, here is another trace from
the stuck CPU where the sync_current_irq_stage call is missing:

__inband_irq_enable (arch/x86/include/asm/irqflags.h:41 arch/x86/include/as=
m/irqflags.h:91 kernel/irq/pipeline.c:287)
inband_irq_enable (kernel/irq/pipeline.c:317 (discriminator 9))
_raw_spin_unlock_irq (kernel/locking/spinlock.c:203)
rwsem_down_write_slowpath (arch/x86/include/asm/current.h:15 (discriminator=
 1) kernel/locking/rwsem.c:1136 (discriminator 1))
down_write (kernel/locking/rwsem.c:1535)
kernfs_activate (fs/kernfs/dir.c:1302)
kernfs_add_one (fs/kernfs/dir.c:774)
kernfs_create_dir_ns (fs/kernfs/dir.c:1001)
sysfs_create_dir_ns (fs/sysfs/dir.c:62)
kobject_add_internal (lib/kobject.c:89 (discriminator 11) lib/kobject.c:255=
 (discriminator 11))
kobject_add (lib/kobject.c:390 lib/kobject.c:442)
? _raw_spin_unlock (kernel/locking/spinlock.c:187)
device_add (drivers/base/core.c:3329)
? __init_waitqueue_head (kernel/sched/wait.c:13)
device_register (drivers/base/core.c:3476)
create_sys_device (kernel/evl/factory.c:312)
create_element_device (kernel/evl/factory.c:439)
ioctl_clone_device (kernel/evl/factory.c:559)
__x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:874 fs/ioctl.c:860 fs/ioctl.c:860=
)
do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:89)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:118)

Any thoughts on what may be causing this?

--
David Rolenc
Principal Engineer=20
Kratos Defense & Security Solutions, Inc.





