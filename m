Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80079.outbound.protection.outlook.com [40.107.8.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504B97C
	for <xenomai@lists.linux.dev>; Thu,  7 Jul 2022 15:19:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HL9GEP77GDBJEDDfIY2VGn8iZHi/ytJPHOO6S+h9TKK0dHfMvaAJMtpPbdGmzA3V+3/y0eSLlnlGihqfHicOBMFVwzpAA5N+uYyJYgs+Z+ubewmtTKdLdvC5gtNBu/xijC3pPl5USK1Nk5rwDPqQVOZU7PDSX3h57gjjGhbcfdVHkWSSjaOqOwSUHpLLg6tl6ybhAUJyzL/eDNjvSU9zwjFJRXpH5BeI2m9MU+p/V8AVBGsN4wR8fY8f3FDKOpvR5pg6GbrMlsprKcBJpCzv6YrB8nl2m/AoPSo6xc74CaDTkWmXBZMk6rFTHgc4UIv9DlU8lS1rOK6XcbXNfExjPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQfBimZb/UHhPLgQWXX8dxjxq4hfv6eyPCMBKkq/DIc=;
 b=GovIK8mMFhdTWqn/1hefBSPSY6iuzUM4xBnN10P6nFZsqL50EThLXscymyFJDOlCPTe8X7BZiNfoDeyqZHfyM+oabvXi2eG48nlwWpxz69lZ4AzopOQdc6ZkJ6VX3zcMRu+t/UGNpwKraorwLTPg5wzL28p6eq66PdwX1gorvFULbcRFVal6RpHfLwLwlQONA/K0x9YBTJCkm43GCZHJTSuJvbAU55Zl3Cpx91eog30yYbJ09bhWMUIUm0dS/TeQfHXqgEXFhM0/2CpJAqUUoHisoG3KzQLxBI8Xhd+LRgIjaccMO90oJ4hklTzlkgMa0nYEeARhXouoG6V+GNd4Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=sigmatek.at smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQfBimZb/UHhPLgQWXX8dxjxq4hfv6eyPCMBKkq/DIc=;
 b=ycLFXdpNu3AcCQOPZQ/xrvrdNr2kpEm2iPJSMZfSKxLGyWt3vU9I3g2Oys9oZwlsrGRooN4qqJCxS+f9aTQwLbhdaJ7pEMOGHaEPbWO9PTBOP/D3bXKlde5P2/gY0STBT8uLa6SCwRyOBATOmdj1boUbXdJgJRBXfRTP1vlA+lTGUhCkcm1q8QT4GTj2PVZ7CiIC/F/r+mmgR1pDET4MwbFUft6Lt4g6wjoM/0F+O0j/T1Kk4HrWfUMq7fmto/EizmM74kcNl7Dfu9Ef+fMLNB+45wJFh7j562uqDxH5uOLZP5/LOfhWfwXrkz+VXy7zdnIjZv0itb2gH+6c9UgHow==
Received: from SV0P279CA0043.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:13::12)
 by AM5PR1001MB1025.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:203:11::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 15:19:10 +0000
Received: from HE1EUR01FT060.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:13:cafe::f0) by SV0P279CA0043.outlook.office365.com
 (2603:10a6:f10:13::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Thu, 7 Jul 2022 15:19:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.70) by
 HE1EUR01FT060.mail.protection.outlook.com (10.152.0.249) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 15:19:10 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 7 Jul 2022 17:19:09 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Thu, 7 Jul 2022
 17:19:08 +0200
Message-ID: <ca02628e-3cb5-727e-0ecf-40046963bc83@siemens.com>
Date: Thu, 7 Jul 2022 17:19:08 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] prove of concept
Content-Language: en-US
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
	<xenomai@lists.linux.dev>
References: <20220707135952.5171-1-johannes.kirchmair@sigmatek.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220707135952.5171-1-johannes.kirchmair@sigmatek.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--19.321900-8.000000
X-TMASE-MatchedRID: aZnThng3P7U5QaOxwNGfvo9bHfxDWoibnISV5mwBlcz8tJUUfQqfiBJS
	x+7Qm/dKtaHmFblIOjmGPneCOFgqRPqhlOCLQMMGWl2S4SrquwQ+1mUhx2/+TIXw6erE6oP33WF
	axVW7M2h2rnDBfCYJTAtqZTGYNzreVk32QV2rZIUPmulRAtWbQRsDEFC015iu9FQh3flUIh4nw4
	PQgteoUHy/Hx1AgJrr+uDuUyjAibyk3d3YTZBs7mJAGiBp7WzYdieePCN6t0KSJLHHb2KALXMpY
	TSKHyEINWj+ZQmmPbI/PJ8p+RzsASu0aDfjpMDQvfvlMSC+4cW8+Qw9PrZG9aLRJdE44xZwn4yd
	uYf5HlWen0qBdy7fjFpcj46AI5R2uWqIEcIJprpENK5rxarX/tUv8ntSEF32XmFVlObh0PwMq8t
	1qGggRJsoi2XrUn/JyeMtMD9QOgChMIDkR/KfwI2j49Ftap9EkGUtrowrXLg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.321900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 7691D6EB2E6ED7E90CE80DC04826D5E87154E4BFD3BA8615F5829F9CA89E5FFE2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79418c81-b09f-469f-cd1e-08da602c0abd
X-MS-TrafficTypeDiagnostic: AM5PR1001MB1025:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R7E45Zpc8SDNgDQL1y1fZMg+4CfMcKr0+LbaNoWXXBfsfxk8umU3nF4Q9vAYunWe/EDGmDSIiMTbYBmBpG+tPAw5j4WHQ4AnD1DADjgga7leqRhMfC034wHETkywQ90b9BfIzBamPXLPtXXWX7p0pTc79wWiBxknC0vPcFRnrqinG3CFl2lZHIItCdk1l/QkeV2T9wDSb5UieFHKxulM4x+GownNBxtlbmEtZb4n9W16Or0ikdL99aru94fS3NwPxD4EpgnjhHKlEX/IUx/pyRqDHK09uGw25EPbz6p9Lvwu2q7EEBnf0q1zmpz4UhkcteV+MUOiatAOLXijKQMOlbEZHPZYwBF6CkK7jqnjyCR1MnBD8MfGBQ39bYdT1Fnae77tpkcnmPs3WnbzVe76qF27Tj85dFKp0tKBsiaF/NSMP84ZtKjOXOTWfaSMWbDGeHn9bN6xvzvy+VO1O5xaTO2cLKQaJJaDxJSOL1LDSg1h6/9Xu9cNS9O2EjmgvvFCFzvzqHG5+Dh+Pj3tlm6BmhjvEzZj1lCgm7WrZwcGP16+kx8PqB6ofV3cNwRwvnJnfuTibdyvKwT97CtY4OqixSTjUBb+p6MKnVjzpqYvUg9YLKTjol7uBXCO5UeYpIJ74NQGMgjvYUZZYphIig171F0k8/lHmKig3h+XIqu1W8ObqHgILallymQhN9IqUG+1xFFX/tlFF9sjz/nHgHaFxMUJ5WKl4vpNuklqn75VIi/TglGwT9UMcYWQGlIESb1oP3gcElpvLLzjdRyWWhcI7dXvoj49v3sfuL5m3PgJADuyIJ4/bIJESJ23MCAiaIEsWK7eS8lpomZ/wcZMf2lJNHs62EbKP6AGAyJQ+70YP/RZPSv6VGEkzy7RZfipGuyD
X-Forefront-Antispam-Report:
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(376002)(346002)(40470700004)(46966006)(36840700001)(82310400005)(36860700001)(110136005)(6706004)(478600001)(70206006)(36756003)(40480700001)(40460700003)(86362001)(8676002)(5660300002)(16576012)(316002)(31686004)(31696002)(70586007)(8936002)(26005)(47076005)(186003)(956004)(2616005)(16526019)(356005)(83380400001)(7596003)(336012)(82740400003)(41300700001)(7636003)(2906002)(53546011)(44832011)(82960400001)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 15:19:10.0603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79418c81-b09f-469f-cd1e-08da602c0abd
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT060.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1025

On 07.07.22 15:59, Johannes Kirchmair wrote:
> This is a prove of concept implementation of exception handling in Xenomai real
> time.
> 
> It implements an interface similar to the posix signals but with a much smaller
> feature set.
> 
> For now, this feature can be used for handling floating point exception (fpe)
> and illegal opcode exception in user space without losing real time.
> 
> The fpe exception handling can be used for fixing division by zero errors in
> user space code without dropping out of the real time domain.
> 
> The illegal opcode exceptions can be used for implementing breakpoints. This
> can be done by replacing the breakpoints original instruction by an illegal
> opcode. At the time a task tries to execute the instruction an illegal opcode
> exception will be triggered. The thread can be  suspended in the signal handler
> in user space. There are two main advantages of having it done in real time.
> 
> The first is if a task does some time critical IO or has to meet some watchdog
> constrains, the signal handler can be used to bring the IO into a sane state
> before the task is stopped. Same for the watchdog, it can be stopped before it
> sends the whole process into an error state.
> 
> The second advantage is for processes that have several real time tasks. For
> example consider a process with rt tasks task1 and task2, where task1 is of a
> higher priority than task2. If task1 triggers an exception and is relaxed to
> the Linux domain, task2 of a lesser priority would take over and could block
> the handling of the maybe more imported work/exception handling in task1.
> 
> Disclaimer:
> This implementation is far from being ready to merge. It is mainly intended to
> be a starting point for discussions about rather we (the community) want some
> kind of exception handling interface in Xenomai and what a maintainable
> interface for this could look like.
> 

Thanks for publishing this, will be very helpful to start the discussion!

I think you forgot to mention that it depends on I-pipe for now because
of "return KEVENT_STOP" from handle_exception. And I still owe you the
dovetail patch we have for 5.10 and that I just started to port to
5.19-rebase today. Will share soon.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
