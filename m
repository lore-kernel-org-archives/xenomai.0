Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80050.outbound.protection.outlook.com [40.107.8.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498BD28ED
	for <xenomai@lists.linux.dev>; Thu,  4 Aug 2022 16:28:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpdhgT9TZI5y4QYxcnk3/YmXt+wqez34DQsM5js2jcRmR+UKi5OJBiyEpAJqH4nm33dueA8ttDpNd1qFkB3jPUf1Zzmc5Qp9Igv95JsO1OczPJoMPcFDFiM8jhmr97w3kfMJUrct99gC6aeJzOEZp/CObQoc9TZxa2gyfXpJ0Mb332UfejstqMCuxwyOfCKgqRpvQk0VkjqxIj1qo0aCoQam4HsBWZHzPSvue0LWLmeNLXxjP54JjgOAgoK0bAHFX4oUImEb3Vz+qvSYlBeev7u9OFBMOvQ9WCF0B6yjMgdTloevWq/r9cImS6fyDvTOO8QJl1rGYrrBaK55jstw1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7fVZOlt/glbh1JwC9pTgq+6Ie9y7p63TLhJs9zqfLI=;
 b=JKYuheItVpOIon7GpEQDSNoLAWx/VTOGE4QwmJIbk7dgK42EYwVDeapBakuPysbbcwcQCYWo51DixxlW7B9+Z2hki4SdfDtiCVp/A3cDUq8TzA1hAMObYnk5eWIBvcrXrlS1yMT6qKEoaIm1BKyYFKFsodDR5+0vM1mLIOkeTP2pcGcvqBpNVfrVkc6An35FEAG9qVYU3vQSA5xsBg8HWIU77c+4iYGh/RFN8MEA38EU8OLIBVB3LXAo9/vhx6LmZwpH55SwWo4rR6Ulfbln17SNgBgJ/xSiUBCcVvO4V0dbNM9yJr7otSjK32Nf49V3lTaOMbSXVJ/xucnVMCi1Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7fVZOlt/glbh1JwC9pTgq+6Ie9y7p63TLhJs9zqfLI=;
 b=wd/Mr21jQjSL3aY46LYH1l1sP55iOZNJsmlup0z6YIJGVIP6rIisXE7hhtoUWpHvJyWPVeYIkAjgekxh8vI4jEVyOucUVbIkDCm4mwzETLgfTR0vNns1UfYsMeTpuKO1/i4HDBFlVVXw9wfgHmz4TJYhK4QRJc9BqaAPQ4UeahVnmnqlz++gKD4kI2s8sJZvrA+kx02HT3SYFL6NwVe38o2mDvPtXqa/VUqAuX6Y43TG3Bk/s0hQ+MeFjBRDqhl1Jk+XgpUgqw6qCSGjJ499tDGA9eTQfMriNY+0j0Z0umeiSu9QTfpIHPiOYEfSv7gs5EWYlfl23YVN+Z2doAxkrg==
Received: from DB6PR0301CA0076.eurprd03.prod.outlook.com (2603:10a6:6:30::23)
 by HE1PR10MB1595.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:7:57::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Thu, 4 Aug
 2022 16:27:56 +0000
Received: from DB5EUR01FT070.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:30:cafe::55) by DB6PR0301CA0076.outlook.office365.com
 (2603:10a6:6:30::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Thu, 4 Aug 2022 16:27:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 DB5EUR01FT070.mail.protection.outlook.com (10.152.5.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14 via Frontend Transport; Thu, 4 Aug 2022 16:27:56 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 4 Aug 2022 18:27:56 +0200
Received: from [167.87.44.170] (167.87.44.170) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 4 Aug 2022 18:27:55 +0200
Message-ID: <7ca3f9af-7ff4-2718-6df8-2fca5fde903f@siemens.com>
Date: Thu, 4 Aug 2022 18:27:53 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai 3.2.2 released
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [167.87.44.170]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.014800-8.000000
X-TMASE-MatchedRID: T9uN1H73JIykr61nqmJmSg4MQA8/69wFQBI3/CURWxwBnSWdyp4eoaiT
	QIPlScvr/+uCP2dxbP1wrf1CH9UZ+YPhzrQ0nLPY846q3BIpmAYDFgoHQs6fmkiQO8rG9a3+frT
	t+hmA5bK6moy0qGULCyXjtnu2lwmLzg2NZRYtOas7SMcnD2qszKhc3wZW8ga+qhcdnP91eXG8RL
	+SWMdQmFHpIy6wt5UwG/FFWvz6lY5bTlRHpCSZcmX6cv5WYBPlTH5yphiX6uyLdOs6EBREocRWg
	25fFZMoC1y1ZwD+mE+Pvz7W6xxPknO2B2RLfEcUoeBknBwKVYZb3gJNOjkirHzmmMD/HXF+VJDk
	8Puq1RQkzZrRRyEZHuRgEMvCxuZn5yyJNwYSHNCGDu7ShAWPZzi80gTpPdTOsyNb+yeIRApfSE/
	4DeM1FUqtM+8MRsshlDxB4nweK9uF4MkB3rCuMi8cRwTHQ3O6Mu8LwvFHOh2eAiCmPx4NwHJnzN
	w42kCxxEHRux+uk8h+ICquNi0WJMRnXSqHoNLIzmtrPsBtJUUkng+BaP728tM69wZ4LAM9ftwZ3
	X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.014800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 B7313EBD2F9972A2A63DD9C48675750F23298E8B55706A04862109023B95385F2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6238b6fa-beb8-452a-46fe-08da763649d0
X-MS-TrafficTypeDiagnostic: HE1PR10MB1595:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NZfmlhM6ul9HvtKkJMXxqUPGCTJ7iRn9HSeD5BwoKVHLUo9v0A7ikI73ODWFXHFDm/POLuP6Rz8o2QptHpu9mqKnqmk/NKVyNr0oCLCLl2PjBwglBTOoTTXw9g161mkPRo4QxeUHd+E0icVwCMWNvd/VOhrvGA4mNqJovazysKYi5rBTg1h7WEtxPwt7zkwZcrpITAhqKzm2QLB96NUN1yVumCIF/Gt4ELpGD1S6GmLEHPzNkj856LO00mB5OEAdDfDLIj8JWatCV3cEFo2NCjSjgBf67n5mMrHe3bEUTthI/q8BEPLr0wPBxSTndQt6kYdoW4LEqLpBTS4ZxKlpW4bQuavXUPSViS4SfJPF6AuBkne+DlcvCpUghWYvI1cPw13M/lqB6i/vjbwpdaEJ6Nz/39ej8AvmjDKArJjhq0aohsEXbQeKG+n47TjoZdv054qcN27jSzixIg/Yax+d2a0Ik6KFlvZYLIov3thqpFVLSbTyI4AmT/l/j8x14JsZ/oD2KeMr7gaiAIk/DWLYTSWJzdPhMI/qVrSbv5zWitAsFOFV4/c42jIpSHABPiwQw/2VXmWCtdOWxTe2RvPcgxS0Xh04c9J/gp0gPJIUx/zoVWcbajH08qtcW6Qmb2oPEHswmNo+9HCpOxF7PbM4SwqSXraoWGnzedB0n2vpcu5ie0n79wtWwleLpuPIvaRhcqBY4mkJ7DbIFkDfDNo4kTo4cdmFPiY1fRgIY5E+ZU3wutq0puD45+IjmYMbQ3MUBvAqEjQxSBj2XAyMIuNtIsBzaRJ2Y8tsiuiOYfMbGsVRyqH3kkUvHi2ZHM2ylQe1ctvTuzq9fYHZ7J2diSstwG6FlecCO5nt3mX5hFWNLeP88msMCsG6A+yqycTinYTm+PtylE9PUaWs9z8NEwBS6g==
X-Forefront-Antispam-Report:
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(39860400002)(36840700001)(46966006)(40470700004)(2906002)(16576012)(2616005)(47076005)(16526019)(8936002)(31696002)(336012)(956004)(44832011)(186003)(66574015)(36756003)(86362001)(6916009)(31686004)(316002)(8676002)(6706004)(70586007)(82740400003)(70206006)(356005)(82310400005)(82960400001)(478600001)(83380400001)(36860700001)(81166007)(5660300002)(41300700001)(40460700003)(26005)(40480700001)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 16:27:56.4419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6238b6fa-beb8-452a-46fe-08da763649d0
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT070.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR10MB1595

This starts a round of updates for Xenomai stable versions.

Changes since 3.2.1:

Dario Binacchi (1):
      drivers/can: fix updating of tx_count statistics

Florian Bezdeka (4):
      lib: Fix fallback signature of pthread_mutexattr_setrobust
      cobalt: Fix resource leak of cobalt_monitor
      x86: ipipe: Fix testing issue due to uninitialized FPU
      x86: ipipe: Enable FPU tests unconditionally

Gunter Grau (2):
      cobalt: ipipe: intr: Fix return value check of ipipe_set_irq_affinity
      atomic: Use __typeof__ to be compatible with c++

Hongzhan Chen (4):
      cobalt/trace: dovetail: improve xntrace_user_stop and xntrace_user_start
      cobalt/trace: dovetail: remove TODO and return -ENOSYS for unportable features
      cobalt/trace: dovetail: drop unnecessary helpers
      Revert "cobalt/assert: pipeline: add TODO() marker"

Jan Kiszka (11):
      cobalt/dovetail: Resolve pipeline_clock_name TODO
      drivers/can: Fix lock initialization
      cobalt/thread: Export __xnthread_discard
      xeno-config: Fix reporting of system information on Dovetail kernels
      lib/cobalt: x86: Fix include guard names
      debian: Update to compat level 10, resolve deprecation warnings
      cobalt/thread: Keep IRQs off longer during in-band migration
      lib: Re-add "static" to pthread_mutexattr_setrobust fallback stub
      cobalt/x86: Account for changes to switch_fpu_finish in 5.4.182
      cobalt: Account for mmap lock API extension in 5.4.208
      config: Bump version number

Jean-Baptiste Trédez (1):
      net/drivers: fec: Update fec driver for xenomai 3 + linux kernel 5.10 and add I.MX8 support

Konstantin Smola (1):
      Documentation improvements for rtdm_mmap_to_user(), rtdm_mmap_vmem(), rtdm_mmap_kmem(), rtdm_mmap_iomem()

Norbert Lange (1):
      fix build with clang

Richard Weinberger (1):
      cobalt/sched: Use nr_cpumask_bits instead of BITS_PER_LONG

Thanks to all contributors!

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
