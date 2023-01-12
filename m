Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2040.outbound.protection.outlook.com [40.107.6.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9EF79C9
	for <xenomai@lists.linux.dev>; Thu, 12 Jan 2023 15:26:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoY5fEXBDeZnCgBUAdKE44zqsBhLfXbGG5N02gw1CZiFHL/gsBp2gjbkqriATAFTn9V3CpOi0pGhP5FC6zb/SWaClREOWMq/p+gNXTqtZ7+X3/kaQmGLTU1z5TUbeh8WV5y1rwj2FMuv2I5FQMaOM/HHaIRTTq5dtlaV9wMk5TDtmaX3ChmGP1Y0cpMzE1O3H783Xe7edtGqi4i9tu7BWKekDPEn1Wbd+ar5Ts3juoGn9Mn9VLgUzOcPo2INOxoq71WcCBnhe43PVo4Ah1bXVMadWM0r+JU09ZzqfpU0fDQ9izmHBLYk/jcBAClw667is9Q1+uhpCstn8ByasKROeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jI8H/Ju4RiJiXywSZ0Hk/vm0+PyXQW+NM3grvzerL40=;
 b=T8oeiYJNHdPuesuQn4KHEAAjMtpUkEMDNNPh9lA7SQ5FrP17OQpmbd7E/DzKWK9TaQBCZYfQ4/vc/CG22wRNiUSAAfXqL9O15MKJyojDeoV83J9Ns/Be9C7i1M+PPFwEPqoiMPCBb1nWNdUBkmZ0OK5yjE+uefQgfChuu3S6OBTTNrARlbVxZeJHzZf51OmM1CthZVSde4My/KHPqAPszEDRtZRCJPiyQt3TrmhKxLJ/0oX59dpKVERSvgY6SBxO9tSCuaHxB7UIyNU5bskvqHCALwUBX1bwWvDahA6NuC4Svg2hoQZBML8Hi8xzHJNbJZbXvpomOQRlXdmPfoIK7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=boschrexroth.nl; dmarc=pass action=none
 header.from=boschrexroth.nl; dkim=pass header.d=boschrexroth.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=boschrexroth.nl;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jI8H/Ju4RiJiXywSZ0Hk/vm0+PyXQW+NM3grvzerL40=;
 b=WWBr6XjtIYQJqPNx9meAIUOotqjfyI9ie1IVzoRJyoCztLg6DCnnXymwgsVqBcTF746ifhCbrVsE1T8L5ni2lsH1zmk7Bv1Q+6NR3b9ufSeqhVO+ruqsJ78BvZpmm6DI9hu0pfzItvLbNMHqRypXvYEXVAkWDUI1lZVGaaKkfwQ=
Received: from DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4f::29)
 by DB9PR10MB5329.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:339::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 15:26:24 +0000
Received: from DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dd8e:ce70:2cb:b314]) by DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dd8e:ce70:2cb:b314%4]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 15:26:24 +0000
From: "Schuman Eelco (DC-AE/ESW5)" <Eelco.Schuman@boschrexroth.nl>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Process hangs after upgrade
Thread-Topic: Process hangs after upgrade
Thread-Index: AdkmmhngNDTyhWzyQbyfaaWtTlh5Hw==
Date: Thu, 12 Jan 2023 15:26:24 +0000
Message-ID:
 <DB7PR10MB245971E67E0E4183BD4D4F5CECFD9@DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=boschrexroth.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR10MB2459:EE_|DB9PR10MB5329:EE_
x-ms-office365-filtering-correlation-id: b3488801-e88f-4e21-1fae-08daf4b15dee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GZrswe6cLrWuzeMqxjd9vYVj7vSZycQA5eC9CkZjT4sBT75XYOFlfyHl6sr74+OJWrEjUcVQ2uwO1JSrB7e1779D2AHi1ebD+PTtCbHPwmi11+gw3TPqNG9BRS3Tw7wXT4EdIDh7uJzJCVts3rIEwRQt4Ol1A1zd0vWTFtFJF5o1wwXQ4grxfQBKbo6OpRurRttG0lvLDOqJr6X4nlKf7v5FbF/bWDqaWHKO5tLytbcuJKqaIYx7B76rJLELiuRXR85zUZbdFqd3u6Hm5vcEfDutoQbO+mFyvqCaRLrmlz72feh0M0RUctq0v2CIQBrK37CRgg6MotyQiIFSA/FeBH7nrecVhMbDKfePUZsSyQbs3fjk0jbd3E4/GGlYtrxfYdK8FOKYbn+qLuSEw+pcZprIEVTDjwb1NLgHLA6sz2szOZ8qXo/He+7ubmv+bt8ZDhiHYdMeKvaXuIsounrV1Z653/36r5gsyEmoX7LUy5ZFA2Ds9vg0xE9Pjb7v6L6aKsP3oL228xryIjQ58hhkYcu89nIz9usmrmiowT009z8FWZwiQDJJa4SnwPaRV566DDDidWc5/SH92yz5AO+GyUKueyv2MxQS0iwkzt49AxUP3ZgEqZpABfJKdhKNPgisUAIdoNsd6ZclVvQakqV1yhpDxqOy5eEZLxsVk5/2GuVKVOSUIHQgiij7AuukKolCqac3xT9aHiMa/U6W8ys+GQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199015)(33656002)(186003)(9686003)(5660300002)(316002)(7696005)(26005)(71200400001)(66476007)(8676002)(64756008)(45080400002)(66446008)(76116006)(66556008)(6916009)(66946007)(41300700001)(55016003)(8936002)(86362001)(38070700005)(83380400001)(52536014)(478600001)(6506007)(122000001)(82960400001)(38100700002)(2906002)(3480700007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QXqKGOnCtxQ10bjyAL0mSqbGLV1KzdsUjFZeHHO2g97JLE6XUZvR3fspMZ0M?=
 =?us-ascii?Q?tSwNptnNmyBMbFXxAFmDtaInvCpWWhjmWI/ox//DyQxr3iZxkLPv1QKb1nWy?=
 =?us-ascii?Q?ViT1ndD9JkYhfSYfiuF5vXIJLZNwk+4wbmBapv6e8BoI9qdgxqgYerwXM5xe?=
 =?us-ascii?Q?TIVV+fTc1TNkeNbVvVaRzDknjma1vHjZBirqdyOVY9VT4HiCjkIMwJl09iRU?=
 =?us-ascii?Q?66kZ4fVA05wG8kIMduUqn936yBD/u5j6qmsti0PNnmVX+z+i+F+xVZJH1k5e?=
 =?us-ascii?Q?iIgEwJ66pT1Syp4Kjh6qJl8/Z+am98Hw9DYP/5eedX/KyB4N8MTnTBZYwngI?=
 =?us-ascii?Q?xEY/Hgx2sc4Z/5op/O5VzMWNKMrdDOfoC0uu4YS1Z3IqyaO+s0EiXa9hatJF?=
 =?us-ascii?Q?R6slpNFsmcKuI0yT55qiTJKFVEARpJ2Qx3w+j96to9QG7rcy5W9o/fbAqyr2?=
 =?us-ascii?Q?4of+xojnki1TJc8HGEpUimjelapy5f5dEohdRQs/B0NH5MbGTfA8kI9zN88Q?=
 =?us-ascii?Q?W2lNY7Vk0kV9LVQInWfOTOye+DHMJ5rfx0T3UwzQxOPMdX9iQysaZzHRGWW/?=
 =?us-ascii?Q?4kIwZu9AUZYr/MGbnq0YdYlyJmgs2KQgwW7rVUEivYxN0Jyz2JgUWfwQLFfu?=
 =?us-ascii?Q?CQMZu0bksaHcQoemR3nMWS/H+j/SKk0AK2bjF3QP5fQ8iIzE2SIt2b0KP+XI?=
 =?us-ascii?Q?sGYAluVMDuUE/9CR6NYVHvXDDyX5DxVj3oDYsQpv8Hm5Uw3dDdkiq37nAwic?=
 =?us-ascii?Q?BXie5JRJcmNa41aawv793umDN7PlLqeo3+G3zrvb7dtGRkvm2FR4mlabFtes?=
 =?us-ascii?Q?80/iWy4pjB3og6gOU+NX0X0iHlzhfSlq2HuyusiwWWLAsllhQ70sieg9qTPc?=
 =?us-ascii?Q?iZCo/xvIpNxxEkF3Dz3tdZs3z0KIb39WSpjz9KcSBdMv1TDL68LjozG5wM67?=
 =?us-ascii?Q?aHEDNb7dXJS7tYsZzOsbouJan0+8lveAAcnYI7o06fNX/3uUZv4Z3BGvkED3?=
 =?us-ascii?Q?8D6Q/sJzMGvLWZBDZ4R+9bqxDxs0YjisJ3998ydzsaBfH5Vr+wkdWwdXYQf7?=
 =?us-ascii?Q?ss/rJ/4Ya+5/ai/kmMLRpHot86ujBb270IC5PpVl1trspktSuhQ+dPyMLwHg?=
 =?us-ascii?Q?+WFoimsamJE5Uly/ykIj3d/LRjUC9csQEJwfbVPRcjvG9iCnIyvf4YdUd5bo?=
 =?us-ascii?Q?MF9AlLAWUhzn94VdQX7GagK3it6Ohz7haVclPE6dhEqpWQ+c+8a/PtxglSGp?=
 =?us-ascii?Q?ZN9oiiY0aesjaJhwXBIbthv/WqTP8UorzpHot3Nbkboxzv7kssH5QoDsnAeN?=
 =?us-ascii?Q?rBD30Y/LIvHs55WbQTkpLqFWzanujvj7ovwRRAZf8otTCk+PoiJ9Gz4zt23R?=
 =?us-ascii?Q?5Dz2tp7kTFobY6O7nokuCU5rIb1aPn9iQForNsmIwWR2qv3yniyhdpGfuIOd?=
 =?us-ascii?Q?bAj7RP4Evsuwvxjd/Y3NCC58ZWnOJLkxHIp4TSGSmUkg3fCBAdukrNI/UYBd?=
 =?us-ascii?Q?AdfaIdQ42xVrc3K393iaeYOAVIwk/RcdZD/Jo0MzMgf4zqe8Zl+UJNJdesoL?=
 =?us-ascii?Q?sWiLk4IfmwOcUi43cm8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b3488801-e88f-4e21-1fae-08daf4b15dee
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 15:26:24.8465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WjsPv7mta9Z/6Xktdqzwix2+aR6W8pF6WigmW6CVpb+MKbZ5quCTkQOq1zcW/WAIH3Jp2g2boSXCpBKkkrQLrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5329

Hi,

I'm trying to upgrade a system from Linux 4.4 to v5.10.y-dovetail with Xeno=
mai 3.2.2 on a Zynq 7000 ARMv7 board.
I'm seeing scheduling problems, e.g. sleep 1 does not finish.

The IRQ pipeline torture tests run OK:
[    0.992675] Starting IRQ pipeline tests...
[    0.992687] IRQ pipeline: high-priority torture stage added.
[    1.005789] irq_pipeline-torture: CPU0 initiates stop_machine()
[    1.011772] irq_pipeline-torture: CPU1 responds to stop_machine()
[    1.021390] CPU1: proxy tick device registered (325.00MHz)
[    1.026881] CPU0: proxy tick device registered (325.00MHz)
[    1.035773] irq_pipeline-torture: CPU0: irq_work handled
[    1.041099] irq_pipeline-torture: CPU0: in-band->in-band irq_work trigge=
r works
[    1.048430] irq_pipeline-torture: CPU0: stage escalation request works
[    1.048436] irq_pipeline-torture: CPU0: irq_work handled
[    1.060276] irq_pipeline-torture: CPU0: oob->in-band irq_work trigger wo=
rks
[    2.113302] CPU1: proxy tick device unregistered
[    2.117930] CPU0: proxy tick device unregistered
[    2.126014] IRQ pipeline: torture stage removed.
[    2.130654] IRQ pipeline tests OK.


There is a warning in the kernel logs:

     0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/irq/pipeline.c:1742 irq_pip=
eline_init+0x20/0x84
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.157-xenomai #=
2
[    0.000000] Hardware name: Xilinx Zynq Platform
[    0.000000] IRQ stage: Linux
[    0.000000] [<c0014460>] (unwind_backtrace) from [<c0011400>] (show_stac=
k+0x10/0x14)
[    0.000000] [<c0011400>] (show_stack) from [<c03aac8c>] (dump_stack+0xdc=
/0xfc)
[    0.000000] [<c03aac8c>] (dump_stack) from [<c03a7b08>] (__warn+0xa4/0xc=
c)
[    0.000000] [<c03a7b08>] (__warn) from [<c03a7ba8>] (warn_slowpath_fmt+0=
x78/0xb0)
[    0.000000] [<c03a7ba8>] (warn_slowpath_fmt) from [<c04d1e20>] (irq_pipe=
line_init+0x20/0x84)
[    0.000000] [<c04d1e20>] (irq_pipeline_init) from [<c04c6d4c>] (start_ke=
rnel+0x28c/0x4b8)
[    0.000000] [<c04c6d4c>] (start_kernel) from [<00000000>] (0x0)
[    0.000000] ---[ end trace 58996bc4bee07162 ]---
[    0.000000] IRQ pipeline enabled

The system and applications run OK with only one core in use.=20

Is there something missing in the Linux config or anything else I can try?

Thanks,

Eelco Schuman

