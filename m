Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3056128EC
	for <xenomai@lists.linux.dev>; Tue, 17 Jan 2023 17:03:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJi4ZDoq+PS/emDSSlxkO00gc3/3R5QgIr4DNDbWO7RosAthtTxJUCwSLLjwLEqObsS8YLH9EdpMIW8FxK/jX3NJw/0tR+lMWt6gOc4U/NO3rrCN9FSQNUP3COifpGVIQ9MyDmuHExyNEascDPOY67h7uthN+lPdCIT4Am2vrgkDm7Kg7iDMrmJkX5X6RElZN3Y1GopsS4uULiX03ggUm82WyYlC8smb0ggI0b36STSgKeNu7uVxnDVUmgmexsk+YzsF2ojjWJH9uRe9hPtZHd0+pz8yin2eWz7UbURbJOy8W9BAfoJ1YqHZRI2UdwyfFU9yQ2SiwXeNa7ywHPSdiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+2w0Q7dpe5BM+MSxU/Ic2mCZF0Y3WkCEV/0zFlZSJQ=;
 b=jOCTtODQSB/bXwfNuB7JVfP5pwHOWHcfr5kGb2QCGHNSu16WjSodHSfQ3euVa0UjB56ZWXeorOw+EpPmGnFq62c6D6vrtrlew5dkCl4O62XbZ0XvAoIXboom4OrN9Xy3aZCdh0R3BhYAw+P3o9We6ZVrWAQP6FcN61auqCHVl3laFQWD3SIHAtjBX51hbx4eXW0ckSKOglWLQUnoCNmAu9xG8PHWJrCfyKCzxTzEZyi3GvxDxjMCRwYUV/QQ1DgKZDcYqPhi0x1+2Hccn3ttihuNYiUguo1876WZWp94fLbxCagyzxJJ79aAdmh4XXFr+1X3esuVAbktMgz2CeHqoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=boschrexroth.nl; dmarc=pass action=none
 header.from=boschrexroth.nl; dkim=pass header.d=boschrexroth.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=boschrexroth.nl;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+2w0Q7dpe5BM+MSxU/Ic2mCZF0Y3WkCEV/0zFlZSJQ=;
 b=IfvO5AowT/ssvFyKW8rRnJ/vhZ36i6SW8zTpAPWe0toRLbTNR9Wj8KYaAfs7m9wVKxRyL1wG8zxccxQc0kSe/F2MW7YygxXBR03ZcUZpT07+mhRkwA1mCawO8T6enFQVMKIF8B/JEpTJcSx7la5V613Lw/LS6IvMORjyLC6SuHw=
Received: from DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4f::29)
 by AM7PR10MB3777.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 17:03:43 +0000
Received: from DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dd8e:ce70:2cb:b314]) by DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dd8e:ce70:2cb:b314%4]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 17:03:43 +0000
From: "Schuman Eelco (DC-AE/ESW5)" <Eelco.Schuman@boschrexroth.nl>
To: Greg Gallagher <greg@embeddedgreg.com>, Jan Kiszka
	<jan.kiszka@siemens.com>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Philippe Gerum
	<rpm@xenomai.org>
Subject: RE: Process hangs after upgrade
Thread-Topic: Process hangs after upgrade
Thread-Index: AdkmmhngNDTyhWzyQbyfaaWtTlh5HwAvDIgAAAZCn4AAANE2gACdjIcAACpMHCA=
Date: Tue, 17 Jan 2023 17:03:43 +0000
Message-ID:
 <DB7PR10MB245911DDA609584F8C2682D1ECC69@DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM>
References:
 <DB7PR10MB245971E67E0E4183BD4D4F5CECFD9@DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM>
 <ed5d41d3-cadc-67dd-72b7-bbe680d36134@siemens.com>
 <CALLqZ8SU192LLP+8noH1QeK1Djvi8E+xRi8r172pXhp99604eg@mail.gmail.com>
 <b401122e-7d0d-b63a-2689-81bd4284af8b@siemens.com>
 <CALLqZ8T1s9KN_s0=5u0=up-8E-KLx0L0rbRK=zZT4ybc4B9i0A@mail.gmail.com>
In-Reply-To:
 <CALLqZ8T1s9KN_s0=5u0=up-8E-KLx0L0rbRK=zZT4ybc4B9i0A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=boschrexroth.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR10MB2459:EE_|AM7PR10MB3777:EE_
x-ms-office365-filtering-correlation-id: 8a20e149-e8e2-4591-f6aa-08daf8acca3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 o98a1QwSOIKkV6Q5b/2MvIwnpTYmPDgUBkzIlnt/HlSvU+hVSSWw0KvvsEYvIJ3Q9G97w28S5BL0MGlTDYFUdhYpqS/KVwfWiRrte31u4Mgy/114kavM/+mh2T/z+ngA04MzVy0awYJHDAv2nAQu3txdIm6fco4KaFh/bUQXv3aGdiGW7x4oaXXCzcZctawIH5KVu6qxULMci8b8ETTIqLUJyQLZJC0UCdTHaSN+S8v3n/shm1X+FVsvcS/fGAWTGSwamk8y4tKcDgv0W6eUXvZJoBKUjYoPTImIo3S3mwF36VaQKIOFeluZLjHg86Zb36UQGDPC6NF+aBFpEsnLoXFdrs8ZK1jhUuhGBcAeCqDRb1XNtzk5Qf8uKnA6jooynkAga+dnmP6gx2ZxmDcto6rqAcOGMlFfny2maCv244wZdCDjD/oZDiTj6Jv+qtTDdRBQgIm3C/eF0ov4i4km9o2OcnegZfXHVNlOve/LR1hJ2m8NXlqL1S6U6noUVYQbtKpvDX08RRs0LF9/qys+3DZt4rkEShLPfTCLKWD211IfEMQCJTQJWaPorlWa6vj6AXbHoU5WBu5fiOA+PZhNI9U1E4Uvw9N7kWlOe/2ApwjMHaSb2KDr/ESREZ+zEqQ8Y24T4xC6C6Di3rGWCM1RK3nodr3/bAr2MY7/hs3EN2PiKq2FjYMy2HFr8zlrs6syJHuEQI5te6Xv3XU+upU66WFUJP6jw6TbXbnyH1qHz8Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199015)(55016003)(86362001)(33656002)(9686003)(53546011)(186003)(26005)(4326008)(8676002)(66446008)(66556008)(76116006)(41300700001)(64756008)(66476007)(66946007)(316002)(71200400001)(110136005)(54906003)(478600001)(45080400002)(6506007)(7696005)(966005)(122000001)(2906002)(38100700002)(38070700005)(82960400001)(52536014)(83380400001)(5660300002)(8936002)(3480700007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?N4g0m7cMh6tFKl4888pvcMrzM7t3qVZWDkqvnOV/bbP1a9HyQwrUkscAgSgN?=
 =?us-ascii?Q?OvrRzY3Kqu6WXSAeej6UeZAI5LCZZrVjxXrW47/Mz9OdkT4eQM28Lv2mJv1g?=
 =?us-ascii?Q?pVrd811dhV7Rq3hWsEsMGPU2GSgH9HVb7vH+adkPkDYcbbFIZD6vmcpAWSaF?=
 =?us-ascii?Q?THFErpSa/LXTCRWQR2DBcUnEOrVGcDb8cW+MZAOM7RMjX7u1SXXJUGUUtn0L?=
 =?us-ascii?Q?CaIT+R/V4Gc16eSeKyIEJJ01slWJ4ouHaYVi6k+dFuTQL9izEcblCv9+2Thg?=
 =?us-ascii?Q?9LIm3bLcYalnN8vW+XCkgG76EctcPehKXjZyUsI2vRKPsQvc6FYKHdtSt3mC?=
 =?us-ascii?Q?Y21ORr3xiJnnAICYWneeLEr3k8aHA/XtUnltwh5gWrjT6AwDbfDB8MH7RJb0?=
 =?us-ascii?Q?1cmsvKw3dsUrNwKksN05TwKuDQ/o77sO+u+zP4+KZ0HsYVy+03G8GO2CWA/U?=
 =?us-ascii?Q?S2BX6RXjPjyG0XYk/vdirSW3TR5lbV62wZcsGLPIuzNEFlY75t52Wr10Svv8?=
 =?us-ascii?Q?MMwofkmqp3KhhhLA2kjJdzefctmcBEx5mhQRBMxDLubcv4WPXy0RKhSmh+zm?=
 =?us-ascii?Q?LUe2TcVikJ0P2S9O9oUV3ZA4HBNQvaxNAvh6TmaacZND7cN/43M0IX9iO53a?=
 =?us-ascii?Q?HBUJ2beq7p6dmHCfIqXtMnPaydVxTUsiXu9/w7o6/7SM+QslGuKR/MF6+Poh?=
 =?us-ascii?Q?VKW1cdN2EfKXESK3NTXe6bfmgwoBBfv1UQc4j7+u+I+xKMrJ+2tJQH80NrMR?=
 =?us-ascii?Q?LjcM+2TcPxhNZ0sFVfup9VzYm+wyxbc308jHexw4sc6IUNEGkXoa8zMBGOMU?=
 =?us-ascii?Q?BUdNNBoQNfJEgAhcna+W/nwjoMMvPBg3O9VIvsenNqaSmBTqmXjzFt1QO80K?=
 =?us-ascii?Q?GhK16t9p2G9jFjMNFsRvKVqcT62dOlUB4AWrwfa4XdCQy/x8F2jn6RWYX5UO?=
 =?us-ascii?Q?EVKIf57qcLTSwf4UUomDh5TxxlgHFNLs3HN8MkqJW/rdWj5kEzOG0oO8nOXP?=
 =?us-ascii?Q?HUIlLuF4KFPJj4fSi5E+AUDUflKa4irEtubTlNYjML7ju3iuSu3dlgHpLrj+?=
 =?us-ascii?Q?Qkj9PROWPDpMuY1GQg7/QfOv06/aCPHALyTBa+i/lKcLIl7CISieBKDUc6WZ?=
 =?us-ascii?Q?sYy6ICQqyZ+ilmu+fVT1/OkjNO7MBhfPSpBixd7FkjS0cnv+UHn6JxQ2YBfL?=
 =?us-ascii?Q?BORjVuBbri7wswDTmlSy7jSrKOLh2c+wCXAaqs4JDzttQW8fREGk8KsKwdmp?=
 =?us-ascii?Q?c8VquMKqArfN12W5/wWLL7vNJQ8KDYyrE82tGjFTlR1ywMWtoboq6/41Ozjr?=
 =?us-ascii?Q?pPT7rgfdnlh6fpnhktegN49VIbNtbPqQMwKwh/2orLl8FiDrOekYKx5nn+NR?=
 =?us-ascii?Q?UjTpau0wEF6qJn/ivxu4Q0et5JSW5H5x17iNwsheWIiZvK9d1u6fkjpyLunv?=
 =?us-ascii?Q?a91hAIZdxuxJo6YjzI6o+Ir+vDxvAojrZ6zl85mytU2NfllT/09O/UmGc4Vk?=
 =?us-ascii?Q?sCNINl7qUXb1ej3kTX3jV/jvU31egDf0hop7Bv+bQhwIWwU8JN/obUJoQP5e?=
 =?us-ascii?Q?LfID4EXDgRpQzTfuZ/I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: boschrexroth.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a20e149-e8e2-4591-f6aa-08daf8acca3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 17:03:43.7090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ss5NoqJN+RXTu2zOlL/2JotQ95P0bzC4xd7kK4kjjVYEc91B2l99A4oKr8AEy7KyQvKyvFg5kPrqDo6OYa7vGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3777

> On Fri, Jan 13, 2023 at 12:15 PM Jan Kiszka <jan.kiszka@siemens.com> wrot=
e:
> >
> > On 13.01.23 17:51, Greg Gallagher wrote:
> > On Fri, Jan 13, 2023 at 8:52 AM Jan Kiszka <jan.kiszka@siemens.com> wro=
te:
> > >
>> > > On 12.01.23 16:26, Schuman Eelco (DC-AE/ESW5) wrote:
>> >>> Hi,
>> >>>
>> >>> I'm trying to upgrade a system from Linux 4.4 to v5.10.y-dovetail wi=
th Xenomai 3.2.2 on a Zynq 7000 ARMv7 board.
>> >>> I'm seeing scheduling problems, e.g. sleep 1 does not finish.
>> >>>
>> >>> The IRQ pipeline torture tests run OK:
>> >>> [    0.992675] Starting IRQ pipeline tests...
>> >>> [    0.992687] IRQ pipeline: high-priority torture stage added.
>> >>> [    1.005789] irq_pipeline-torture: CPU0 initiates stop_machine()
>> >>> [    1.011772] irq_pipeline-torture: CPU1 responds to stop_machine()
>> >>> [    1.021390] CPU1: proxy tick device registered (325.00MHz)
>> >>> [    1.026881] CPU0: proxy tick device registered (325.00MHz)
>> >>> [    1.035773] irq_pipeline-torture: CPU0: irq_work handled
>> >>> [    1.041099] irq_pipeline-torture: CPU0: in-band->in-band irq_work=
 trigger works
>> >>> [    1.048430] irq_pipeline-torture: CPU0: stage escalation request =
works
>> >>> [    1.048436] irq_pipeline-torture: CPU0: irq_work handled
>> >>> [    1.060276] irq_pipeline-torture: CPU0: oob->in-band irq_work tri=
gger works
>> >>> [    2.113302] CPU1: proxy tick device unregistered
>> >>> [    2.117930] CPU0: proxy tick device unregistered
>> >>> [    2.126014] IRQ pipeline: torture stage removed.
>> >>> [    2.130654] IRQ pipeline tests OK.
>> >>>
>> >>>
>> >>> There is a warning in the kernel logs:
>> >>>
>> >>>      0.000000] ------------[ cut here ]------------
>> >>> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/irq/pipeline.c:1742 =
irq_pipeline_init+0x20/0x84
>> >>
>> >> This complains that hard-IRQs would be on while they must not. All=20
>> >> that in fairly early boot code.
>> >>
>> >>> [    0.000000] Modules linked in:
>> >>> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.157-xe=
nomai #2
>> >>> [    0.000000] Hardware name: Xilinx Zynq Platform
>> >>> [    0.000000] IRQ stage: Linux
>> >>> [    0.000000] [<c0014460>] (unwind_backtrace) from [<c0011400>] (sh=
ow_stack+0x10/0x14)
>> >>> [    0.000000] [<c0011400>] (show_stack) from [<c03aac8c>] (dump_sta=
ck+0xdc/0xfc)
>> >>> [    0.000000] [<c03aac8c>] (dump_stack) from [<c03a7b08>] (__warn+0=
xa4/0xcc)
>> >>> [    0.000000] [<c03a7b08>] (__warn) from [<c03a7ba8>] (warn_slowpat=
h_fmt+0x78/0xb0)
>> >>> [    0.000000] [<c03a7ba8>] (warn_slowpath_fmt) from [<c04d1e20>] (i=
rq_pipeline_init+0x20/0x84)
>> >>> [    0.000000] [<c04d1e20>] (irq_pipeline_init) from [<c04c6d4c>] (s=
tart_kernel+0x28c/0x4b8)
>> >>> [    0.000000] [<c04c6d4c>] (start_kernel) from [<00000000>] (0x0)
>> >>> [    0.000000] ---[ end trace 58996bc4bee07162 ]---
>> >>> [    0.000000] IRQ pipeline enabled
>> >>>
>> >>> The system and applications run OK with only one core in use.
>> >>>
>> >>> Is there something missing in the Linux config or anything else I ca=
n try?
>> >>
>> >> Not sure. We don't have a Zynq in the test lab or at least as=20
>> >> reference image here. It might be that dovetail is missing some=20
>> >> bits for this SoC, e.g. a patch analogously to [1] for=20
>> >> drivers/gpio/gpio-zynq.c. Adding Philippe for possibly more insights.
>> >>
>> >> ARM multi-core is generically fine, see our QEMU target
>> >> (https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
>> >> source.denx.de%2FXenomai%2Fxenomai-images%2F-%2Fjobs%2F552798&data=3D=
05%7C01%7CEelco.Schuman%40boschrexroth.nl%7Cbde2fcb830c7453eb24e08daf7fff75=
c%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C638094975982300406%7CUnknown=
%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6=
Mn0%3D%7C3000%7C%7C%7C&sdata=3DX9HSPXZaFPte2sxFfS5OTd683dFqMhWRpRcGXX%2FtRD=
g%3D&reserved=3D0 e.g.). But our only physical armhf target in the lab is a=
 single-core beaglebone.
>> >>
>> >> Jan
>> >>
>> >> [1]
>> >> https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fs
>> >> ource.denx.de%2FXenomai%2Flinux-dovetail%2F-%2Fcommit%2F3d3e5a1659d
>> >> 69c9dc96471efa542dc05fcc58e56&data=3D05%7C01%7CEelco.Schuman%40boschr
>> >> exroth.nl%7Cbde2fcb830c7453eb24e08daf7fff75c%7C0ae51e1907c84e4bbb6d
>> >> 648ee58410f4%7C0%7C0%7C638094975982300406%7CUnknown%7CTWFpbGZsb3d8e
>> >> yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
>> >> C3000%7C%7C%7C&sdata=3DOwo4KNn2Bo6r8yKJaI0ZrJNKTQ7woM4eOjYCb74M6ZA%3D
>> >> &reserved=3D0
>> >>
>> >> --
>> >> Siemens AG, Technology
>> >> Competence Center Embedded Linux
>> >>
>> >>
>> >>
>> > If Philippe doesn't have time for an immediate answer I can try one=20
>> > of my zynq boards this weekend.  I reserved some time for ipipe=20
>> > things, I can add this to the list and see if I can help.
>>
>> That would be great! I have one zync board literally at my feet as=20
>> well, but setting all that up will take the usual time...
>>
>> Jan
>>
>> --
>> Siemens AG, Technology
>> Competence Center Embedded Linux
>>
>
>I reproduced the issue (pretty sure), I can look at it this week if that h=
elps.  Just to confirm, Eelco, to reproduce I can create a thread and call =
sleep(1) and I should see the process hang?
>
>-Greg


Hi Greg, many thanks for looking at this issue. Yes, a 'sleep(1)' in an app=
lication or thread hangs the process.  I noticed that the proxy tick does n=
ot get any interrupts:

          CPU0       CPU1
 24:          0          5     SIRQC  24 Edge          in-band work
 25:          0          0     GIC-0  27 Edge          gt
 26:      94785      94399     GIC-0  29 Edge     oob  twd
 27:          0          0     GIC-0  37 Level         arm-pmu
 28:          0          0     GIC-0  38 Level         arm-pmu
 29:         43          0     GIC-0  39 Level         f8007100.adc
 32:          0          0     GIC-0  45 Level         f8003000.dmac
 33:          0          0     GIC-0  46 Level         f8003000.dmac
 34:          0          0     GIC-0  47 Level         f8003000.dmac
 35:          0          0     GIC-0  48 Level         f8003000.dmac
 36:          0          0     GIC-0  49 Level         f8003000.dmac
 37:          0          0     GIC-0  72 Level         f8003000.dmac
 38:          0          0     GIC-0  73 Level         f8003000.dmac
 39:          0          0     GIC-0  74 Level         f8003000.dmac
 40:          0          0     GIC-0  75 Level         f8003000.dmac
 41:          0          0     GIC-0  54 Level         eth0
 43:       2840          0     GIC-0  57 Level         cdns-i2c
 45:        463          0     GIC-0  59 Level         xuartps
 46:          0          0     GIC-0  64 Level    oob  [nyce-kmod]
 48:          0          0     SIRQC  48 Edge          Inband sirq
 49:          0          0     SIRQC  49 Edge          Inband sirq
 50:          0          0     SIRQC  50 Edge          Inband sirq
 51:          0          0     SIRQC  51 Edge          proxy tick
IPI0:          0          0  CPU wakeup interrupts
IPI1:          0          0  Timer broadcast interrupts
IPI2:        321        528  Rescheduling interrupts
IPI3:          5          2  Function call interrupts
IPI4:          0          0  CPU stop interrupts
IPI5:          0          0  IRQ work interrupts
IPI6:          0          0  completion interrupts

Is this because xnintr_host_tick() is not called, e.g. from xnintr_core_clo=
ck_handler() ?=20


Best regards,

Eelco


