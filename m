Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE1D10F5
	for <xenomai@lists.linux.dev>; Mon, 15 Aug 2022 06:15:05 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::224])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 6CBC9D06EA
	for <xenomai@lists.linux.dev>; Mon, 15 Aug 2022 06:14:36 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay.mail.gandi.net (Postfix) with ESMTPS id A7EF3E0002
	for <xenomai@lists.linux.dev>; Mon, 15 Aug 2022 06:14:27 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
X-Envelope-To: rpm@xenomai.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 1ACAAD80144;
	Mon, 15 Aug 2022 06:14:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rj4jvMPnXuwid0NEFljra3xhc0uw1XO9m5hdJt7gbB+qc+WqhSeK3KdlCDILSb6+rWfHey3fB8f8/lSe7ySEaaDBe5so187G04BpZRM7ybQ4r6EWBCgrzIyAZvqEN79EgYF7oxt22T17lt4FnACkX1Y8l+QnDgYUiHSsao0ZMOQXLBRuSjpuELI/K/adpnppWQ3TA/6Jv9/xubMvrXLBCdokMIbWmim/xygdv2KD1VDfkC+gyGJC8px5r7EHK10DUxE90Rr1WV6DTxmc3nAonYNcYbDWkIFduDyE64ISoos+vOZ4aTr59keXb7raaLFIY1yAyf/jxZk8W6rCcpHHHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBOQVVBX4bW7IHvya+v+LBjbBvCpxXAhN5nE7ZEuBWg=;
 b=bssupilklP/TH1cq9nr4/f21BjkqY2kNy8H3X/D6L71GERTGrRBihDit9pT52LdcdY+++4xbiH/9uGSKCzJ5DplbLL0teIKoqFXTYxER7fhGip6vAlD6hp+7QmnnvJZJgo6XqKT73lvIRQx1oFVFyAf7+WlQWLVU4QDT43smOUzU6offp5+GlCtlzjEUlz+ZkFxYoevdJ/2sXZ0Glqv5twEbWmZApolyFg3YFqJxv8NFSrpIhds2lWD/5AO0EsByfrWjI2VI1GSAj6sR1jruprYVWKEQZgqdFe921BZRaOlG37qdqQ8rTfsVKkJCgLa7c2uJjZ/pQk+jKNqsCdyZIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=gmail.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBOQVVBX4bW7IHvya+v+LBjbBvCpxXAhN5nE7ZEuBWg=;
 b=Vy29z48OrSMePU7BkKYVi/FyMPBLBSlaAvABVvsEL1kunBtH5DLrBGa6z+51d6EntRo08n84Mn+rvKPO1WdEYG4qEAR3293pv2ITVXTxBMFWp5a71lDv4VPlKQQfHKU0e/dKZ63cYoKl7sbq5G4tfTgU93EVT0BZ0P/05L5NzW37jhNWY5PIpzHxOWr6UxO+Uq3IGOceTY2GekYkUl9NSyqxIYMYVnD8cy5WDlxWwM4gS+pA45pUEUtVAMLfskKFEP1baIMAsbeDCeoE8iZlQeuTNOKMzmbzjt2eVApVhe6qasT2SrlFzRIF8FrMeP6DV/+WByP5jnzFYEDoIFEztg==
Received: from GV3P280CA0073.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::12) by
 DB9PR10MB4714.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:254::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.10; Mon, 15 Aug 2022 06:14:25 +0000
Received: from HE1EUR01FT055.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:a:cafe::ee) by GV3P280CA0073.outlook.office365.com
 (2603:10a6:150:a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10 via Frontend
 Transport; Mon, 15 Aug 2022 06:14:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT055.mail.protection.outlook.com (10.152.1.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11 via Frontend Transport; Mon, 15 Aug 2022 06:14:25 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 15 Aug 2022 08:14:24 +0200
Received: from [167.87.45.91] (167.87.45.91) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Mon, 15 Aug
 2022 08:14:23 +0200
Message-ID: <646b8cce-c73e-4976-3787-b3b337679915@siemens.com>
Date: Mon, 15 Aug 2022 09:14:21 +0300
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: Linux-xenomai hangs at "Starting kernel ..." on Jetson TX1
Content-Language: en-US
To: Yucong Chen <slaoub@gmail.com>, <xenomai@xenomai.org>, Philippe Gerum
	<rpm@xenomai.org>
References: <CAGjgvr9G4JpZ+krfnX9xWwbTiT6JbtG_2jUWiFJyqVtvFk=MKg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAGjgvr9G4JpZ+krfnX9xWwbTiT6JbtG_2jUWiFJyqVtvFk=MKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.45.91]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--21.197400-8.000000
X-TMASE-MatchedRID: jHaaRReu0S/PhQMrvkSA3k+KfaRNwmRcoRhq4uL6L1jx5KZMlKYS/fiH
	64jt3FfEYtJaVJe/wLGgrkHr6pdTsP5eQGC0xHl/0mLNNa6mblm3pdlpOCmDCvRUId35VCIe2FA
	7wK9mP9dOsq/n2Kz29F7sNBsTuYtU2Fpil90e7xQgZe7JCZgsCvs9SDPkW26pfOaYwP8dcX74qC
	LIu0mtICCGMdYyqZjk5z54dP+IdryVJ1N1yBIzZPuL2jw7QJji5neCrx57xxoD2WXLXdz+AX607
	foZgOWyBCzD0Dc8iUvIZhKKkwQd1vxBHRuKq8ZzhmZWBnxHZ3m6h4cjlhpqm/NctuQlbOgkqb3/
	o5s+OcNZ+M9E/Hx6KFLiA4WBV3WfBHY11KaDvlWNKX6Ls5D/UyNNPqT1mYtxF+qQpCWTUjlQby3
	Ra2CEIJ4Q+L3BXIWueqIbgKELG8Ir59u/gzv5MLUzq8RBkJuGSSOWVJeuO1A5f9Xw/xqKXVkMvW
	Auahr8+gD2vYtOFhgqtq5d3cxkNQP90fJP9eHt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.197400-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 F93A515C02EB9A561F3A275365C84164F8AE8D9A7707E6D6641CA64E666297712000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 972bb751-8b5a-473a-cb0a-08da7e856721
X-MS-TrafficTypeDiagnostic: DB9PR10MB4714:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mTeukvyrwCIjzjfZoqjJrKJZk/9bZT6jNnjCrBPP5RVPtm0Dv+5KQriDzmuqW2mqaGXfTsNLeFsd9BEtziXaT1BP2UGdznJB2kazpQUEP9n6Fxi26/LhrEdq59FkAozV1jAX5b4YOx4gVQx/KcK7jQLtG/v1T6HNtLkcbg5mfvrfCZ4jD4D5LUwinFNpv97kI3YBeqJEJuSKqz/oEY5w35jmK3O9w124R3lQuKO7x01snqPw8SeNHqweDT7pJqV9rALGvn43iuQKZ1HSQU4UTff0sVjjrMO06BxxrHVJS/DLSCaoHFhsm29RXhL29Bt5vD6McuDpvpE0DRGE5v1lXTSUxRkn6WoYIaYp8po7zjOd24vxUKnh3gWlbKQvl9RR1JguJIWYnIAZDI0BbH8uZAC5Ex+HkG+FXU9wBOui10DToUnWkg3wIdjs43uP6z1G+CjG5beYZ6A+MysRELaqSXjn8t32KYe0qYZw3FHR2J3HuAUkdIYldU082/qyK04nEwCNXWVIXd+roIGKfpBKLTsEQlk3iWkhSy0rRP1gNKx12kAYs0Bb9TR+/LqiAtL2VhHzmW9Mqxv6tv63DJkPqpj1Qare+OWvupZ/Pr1Sw0+Zn9cIoOtb0pDJyuhfQVWTSEw1aQub+Xixgk2Wgi5jnw3Ceh3MbAlC8ZCFvBAcEi1mpkTh59BbIaneDtWoRfPH7m0UWakmBwdt85bMkS2IjfQMjFJ+IvgV1mKmgP6LTmJIh6c4p21sqOHFxLfbzr6InR3suUY8rCnVs9ExfOwEtOikruWTzqQZXOLQboVcWqpnOOtEE0OGyJ7l5TLfM5kx2+pkE18ObetDxnJn0DcBCzAXKtHUWvH0Ti+k+zlljWnM05OBaH291TEAqTye/4nptO5lb3QVBBgzYfN3ROFkUkVm9zHDbWOCKepXaO/BJVM=
X-Forefront-Antispam-Report:
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(39860400002)(376002)(40470700004)(46966006)(36840700001)(44832011)(316002)(31696002)(82740400003)(41300700001)(40480700001)(8676002)(83380400001)(2906002)(36756003)(336012)(70586007)(6706004)(2616005)(36860700001)(956004)(110136005)(31686004)(16576012)(47076005)(16526019)(186003)(70206006)(356005)(82310400005)(82960400001)(26005)(81166007)(40460700003)(8936002)(86362001)(478600001)(5660300002)(966005)(53546011)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 06:14:25.1376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 972bb751-8b5a-473a-cb0a-08da7e856721
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT055.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4714
Received-SPF: pass (spool5: domain of siemens.com designates 40.107.20.50 as permitted sender) client-ip=40.107.20.50; envelope-from=jan.kiszka@siemens.com; helo=EUR05-DB8-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=Vy29z48O;
	arc=pass ("microsoft.com:s=arcselector9901:i=1");
	dmarc=pass (policy=none) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 40.107.20.50 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com

On 11.08.22 11:03, Yucong Chen wrote:
> Hi all,
> I'm very sorry to bother you, I'm currently working on xenomai
> evaluation, mainly to observe the real-time performance of xenomai on
> different hardware platforms. Recently, I encountered some problems
> when porting Xenomai to Nvidia Jetson TX1. We tried for a while and
> couldn't locate the problem, so please help me analyze the root cause
> of the following problems. The specific problem is described as
> follows:
>        1. Kernel version: 5.15-dovetail,
> https://source.denx.de/Xenomai/linux-dovetail
>        2. Compile the kernel method:
> https://elinux.org/Jetson/TX1_Upstream_Kernel
>        3. The kernel of 5.15-dovetail can be successfully started, but
> xenomai is not enabled, and the dtb file in the 5.15-dovetail
> directory is used to replace the official dtb (Corresponding kernel
> version is 4.4) file provided by Nvidia
>        4. Recompile the 5.15 kernel, but enable xenomai and use the
> dtb file in the 5.15-dovetail directory
>        5. The 5.15-xenomai kernel compiled in step 4 cannot be
> started, and stays in the "Starting kernel ..." stage
> (linux-5.15-xenomai+upstream dtb combination cannot be started)
>        6. On the basis of step 5, we used the official dtb file
> provided by nvidia. The kernel can be started, but it will be stuck in
> other places (linux-5.15-xenomai+nvidia dtb). In any case, the kernel
> can be loaded and executed. The reason why the system does not start
> normally is the mismatch between the linux kernel and the dtb file.
> 

It's likely more complex than that. If the kernel/dtb tuple starts with
Xenomai off but not with Xenomai on, you have something IRQ or timer
related not working as expected. The reason might be that some irqchip
or timer needed on that platform has not yet been enabled for use with
Dovetail. Philippe, was the Jetson platform enabled/tested already?

>        Question: Why does 5.15-dovetail get stuck in the "Starting
> kernel ..." stage after enabling xenomai and matching the
> corresponding dtb file? We analyzed the dts files in the upstream and
> the dts files officially provided by Nvidia, and mainly focused on
> interrupts, memory, CPU and other related content, but still did not
> locate the problem. Here we have another question: what is the
> relationship between xenomai and the device tree on the arm64
> platform?

Xenomai has no own business in the dtbs. What you see as difference is
downstream Nvidia compared to upstream device tree bindings.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
