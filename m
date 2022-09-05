Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2051.outbound.protection.outlook.com [40.107.104.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB487E
	for <xenomai@lists.linux.dev>; Mon,  5 Sep 2022 13:56:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYEPHYeZoe6IpAuQxK7VLDJs7kmoAjQ7PY2MuOnPC+v6KDVIiBU1wISDz+GOMeM/EsDCbyvTjpXcGTSOy/i363Iqw5dAwqDU2U0dwTcYBRdnRmI3Ux8Npe7Hekl5yQwOBLni+UMwmIzI+pYFGoQbH0aslxnow46wwmWki76dDC89Yikgm2ztYpV06k4AG6+fEk0Z4VWXN80TSLHw5Uixz266Ho+jDPU6HxXJ7np43NxRuvNNGenPYqox3GRjdMKCluomh08GQGVbGi6mwQTvSPn9xnQjDfqpO3GUBbTNf1Q89QuIf4g6Z8AT5qoazqNbCiqOVJHOwa52DL1faB7wXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKSlUcRYy0S7OhrSMwTmmUyG8hOdZx+8O1jDA92W8T8=;
 b=lICndJk1jUK9qtBqN18XQKBej8PbykHBi8zF5onXMbny7Vg9kUzY7KDMks0FEgjnuzEuuG5JCCnNqpLcPqJA+mzhH3XH0SNzIyIDHY1RSIbI6dcPHIR8mm9EeGQB9toYSiRm1WPYgAeB9iL6A2ADQENUgi/S6Psp6mtMHlNaqTq5ZWr2QygFd8B6457p7smY6t9Vp/xzgHzd/ZKChxlgiAuo7LxE0Eheg3lm1LlcO4WJZxSte/ByvYuO51bqGqyWElkW0xT9JHBDkYOiBCbmJLJw/m5eauqPI2RlP3cs1YWJ5+bWhwnGiz+CVfxJ7byiJIZKzk2qeMoJF7T03TgzkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=intel.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKSlUcRYy0S7OhrSMwTmmUyG8hOdZx+8O1jDA92W8T8=;
 b=QZhca+0dgLUPDTpvMPNLUmaSIgFB8xE1iPKzcE3MGujG6yveD3TV5AZxa7uM+luFWyGntNgLj4YD+Yx5bVVqCkiYD/abWf2ODcFSC34eA8Vat/U8T3W3z9IdXhaXgXH8GAX7wk2/F8WeGSHNgUv54DfunH9ZdcBgy/HhbRszHNp0bFzMPrtHjNGPocI7neElKYyRBfgmv72ho929zkqY+wpfzn2uOIx3g4cF80f3tp7U9FJqU0Qjh49QpL2cLmegRR0WJiLnYFfPhepilCSnyz9zu62YBdSrqHuzxQfRkJIYNgnUKlVopqC+Itf/XYDFfLNRYCcSHrO236FmC3/n8A==
Received: from DU2PR04CA0234.eurprd04.prod.outlook.com (2603:10a6:10:2b1::29)
 by DU0PR10MB5430.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:329::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Mon, 5 Sep
 2022 13:55:58 +0000
Received: from DB5EUR01FT049.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:2b1:cafe::44) by DU2PR04CA0234.outlook.office365.com
 (2603:10a6:10:2b1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18 via Frontend
 Transport; Mon, 5 Sep 2022 13:55:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 DB5EUR01FT049.mail.protection.outlook.com (10.152.5.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10 via Frontend Transport; Mon, 5 Sep 2022 13:55:58 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Mon, 5 Sep 2022 15:55:57 +0200
Received: from [139.23.79.104] (139.23.79.104) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Mon, 5 Sep 2022 15:55:57 +0200
Message-ID: <6ea2824b-fdaa-ebdd-6873-af0668763671@siemens.com>
Date: Mon, 5 Sep 2022 15:55:56 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/1] net/drivers: igc: introduce rt_igc driver
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Hongzhan Chen <hongzhan.chen@intel.com>, <xenomai@lists.linux.dev>
References: <20220822011821.21283-1-hongzhan.chen@intel.com>
 <20220822011821.21283-2-hongzhan.chen@intel.com>
 <2b643cbb-add7-fc03-7b22-fe691072d9df@siemens.com>
 <21a7d392-041e-05e7-3b9a-00134725f41b@siemens.com>
In-Reply-To: <21a7d392-041e-05e7-3b9a-00134725f41b@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.23.79.104]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--10.239700-8.000000
X-TMASE-MatchedRID: Fi1yTWlF5J85QaOxwNGfvo9bHfxDWoibEEHv4jm9YZTJkecgyZD4ON1e
	FEoaE12nh/Zinvfjw35e9tX9WdS/SkqhGu5PwZpUb8VqO5p5BOLRhEyb9f1sjpeZUDMyphfSpvD
	LLlsAH/3k6Qbi+9i6D0GzU7CKX1sdKprQFSyV+161T0CQveSi0MxAixoJws1YqJSK+HSPY+9lRz
	ZAkKRGDeMWwrGotJWUbj6AD6L0PYO+cKWVQmxRy9NnjPE3rgZHgtjbI7qady9uXgIqq6mQyvRU+
	9PTPHSYp+5vzsY5mKPw/uiEDEcVOeLzNWBegCW2RYvisGWbbS+3kKuphdkuP7HlqZYrZqdI+gtH
	j7OwNO0UBC9Bhrukg6zG+wPSMm5kSqR4cmG6CjMutYQ735R3Lj1y8bM7Mykt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.239700-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: F799FA09A85D9CB76F75807B09F8495C7BD02689431EE2F8E02F13A7163E67652000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13b692cc-cd66-42b4-8627-08da8f465c25
X-MS-TrafficTypeDiagnostic: DU0PR10MB5430:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YHTN9YT4++m/fuxrC45rVzhl6XqLCDgrFSTMZd3oRyMGoDBC0P9H0LHpkbAf8EucjFWIZVR7B1THvyzd4qA0xAcbw0Jd44QqLGevzB/hMmiqyfTM6ochXGCZHYQJit8An0N6NKVHSt9m+9RBNVvq/0yOtId+NiKDpIDQoWKNJC+x2IKmpLpqZvYEp1dy5nfZTR9JVqs+UEHU8XPMLAMZgItu6Uy6YIaUyUSli92jxzzl0KPmj86U+lrvEaN/3j9jz2LSQAftPRtWyOptoYJdBBXtevw7HKFOOz81tGcMnakQh8ZE8o8fG63JYl9Qfizbev82vZ+d7xbIpjy9mmmpN6xHFXU2dy7MYrxzLBHdB+zkgl5/Z/SFumbvUNdIb1M4CP244bbl8agDeDeFm7UmXZFMbvplKn4rdHYSqDrcrykvD9gJAg7xId7pl03JLowWyyQsl5kjv3eF/mzktdBit1lxxMwxE1Sz4gFAlpMUvOOib5BD2K0CKeafO/BNnPdT4Z/6EDmn805uTdoDTBaEHfdvPxtUZBL7fwqbdjcRMbYSAEPRhqhP+Vz50HYPmi/YeBQ0gFLyCs0pElxJOutbjFKryYxYNiZZ2MUR31vFXDCiL3iELr6DtATPOpe309IaT6t6uxPJv8sr49cWpq0BTDEgQar6eOglxgRLEeM06ax1Lz7q4VQzoPh6McNqOlXyncqdvIxSH9tBsfbdGj0oblI+XgevqHn0QMN3P0QGf7x1P0APH6+6U0uJg6fgz91WsmDkt8ckarsDLJmnKm75LFqTyv5WYQLE6l0ZWpFN/JIyHHt5LeWaDtJLs/ImvpBWfuw95eti/xbruIQWQoHBvWA1WrBy7Ct/4wUSPIPgRoj6G6rrjGBwfRGYcDs20+/7AAQECKDULt7bcq6fl0VPwQ==
X-Forefront-Antispam-Report:
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(396003)(40470700004)(36840700001)(46966006)(2616005)(956004)(41300700001)(47076005)(336012)(53546011)(26005)(36860700001)(16526019)(186003)(40460700003)(44832011)(8936002)(8676002)(5660300002)(82310400005)(40480700001)(6706004)(70586007)(2906002)(478600001)(966005)(110136005)(316002)(70206006)(16576012)(82740400003)(31696002)(86362001)(31686004)(81166007)(36756003)(356005)(82960400001)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 13:55:58.2011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b692cc-cd66-42b4-8627-08da8f465c25
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT049.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5430

On 05.09.22 14:03, Jan Kiszka wrote:
> On 05.09.22 14:00, Jan Kiszka wrote:
>> On 22.08.22 03:18, Hongzhan Chen wrote:
>>> ported basic network function not including TSN feature.
>>>
>>
>> Please enable this driver in CI so that it is built regularly.
>>
> 
> ... in the future. This time, I'll just add the following to your 
> commit, crossing finger that nothing will explode:
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 2d4c7635cb..03d3382117 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -129,6 +129,7 @@ variables:
>      - ./scripts/config -m XENO_DRIVERS_NET_DRV_NATSEMI
>      - ./scripts/config -m XENO_DRIVERS_NET_DRV_VIA_RHINE
>      - ./scripts/config -m XENO_DRIVERS_NET_DRV_IGB
> +    - ./scripts/config -m XENO_DRIVERS_NET_DRV_IGC
>      - ./scripts/config -m XENO_DRIVERS_NET_DRV_R8169
>      - ./scripts/config -e XENO_DRIVERS_NET_EXP_DRIVERS
>      - ./scripts/config -m XENO_DRIVERS_NET_DRV_3C59X
> 
> Jan
> 

Too much red, unfortunately:

https://gitlab.com/Xenomai/xenomai-hacker-space/-/pipelines/631386274

Please address and add the above hunk in the next revision.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
