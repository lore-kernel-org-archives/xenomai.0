Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2076.outbound.protection.outlook.com [40.107.104.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B1F33CF
	for <xenomai@lists.linux.dev>; Mon, 26 Sep 2022 14:12:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAkWGbXjkeUPSY+Mm/aMNhMTOA0XUiUbknE0hT9m7vHcopHvofnjfCDZ4WBEQIH2WFj+zEDavku958QnjzVQpbITgqpANpIWZTHTwA2S3HWOr6Ncy7PXbHzKMBJcgpNWbkSGFbYcLPKdbHAFZEa/BzbSQ7YEngKUCkrw3x/5gju4pzKN8xI/b4kM9y7c1W2WQ+bDsCiBWiuS8foJDAQquqW2E/GhOvXnRO9kVDo5JmUl5ImgDyg4DfNXyAovwJJw0cWjTYn8n+7S8xiH/RazyqQI8l1WTXVJwQ++1udpIjOSzZK57/qaUXFCObol68mmbjJJmHGtF565qAiErixsew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgSJ5ft9bQtq7mt6UHik5qGoDEt7L43l34vDnSW9xHk=;
 b=ZlOHWZYTmuxU1v/hbH14FNWKIBukdB2iA4minUPqa0lmXUGcUcs0SmvLA7BcVQpXEhPmRrjOJAD5ItvJfOvcERKhJAzlp8yUJMhBNTElURNjLkruZWZzxN8lwpfS1XwY8ZTdS1GvnTnh/AU6KqUJq2lRBDgc3psRKBXp4SnZPaCE+9enNcVgjbPMNGj7m2z93uS+mW9dwSIrPV6X0vXhAsNiWeyh3TyP937AfjzSksHkvGLdSnaiINFyDawTERPceSBdjKjiLjL3PI/Qx7TySNiuW4yyP6LobBVMr0LVXkb29ftpbjD7TmSeC2RbuQFEiSUTdwxJ24j2IWNynVypKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgSJ5ft9bQtq7mt6UHik5qGoDEt7L43l34vDnSW9xHk=;
 b=tQq53Eq+xRBUTLdLrCT4dXf2kptxhOZZHYHJ7uhJA528YUjjRN4+jMDdHjsaBUfIjMNsu/+LJg/rwGQ5lKfokD6WPQSJI7Y7rnvsFTmWaYew81AdJtnGy+XlzdcvUh4SuzHNfnHMWbYeTkCZDYS2Ir0HpRYQPbc6DJeV1mY0uWlAsUQ1p1MfJ87//xaPAbVsI5Xp4vGpIkviFBUrquKUE64NdIzsR7jZ63cUCBewvZuyWvGssjULwYzp5rD0do8v/XPKXKRyvQdhr9ejLwdbc1Rdq5HNFuAGx8WRQ2RRp9MmcGBnSRsfCw77lmNQnBKYS3UlsGesVFJfIL7KLRDd+Q==
Received: from AS9PR04CA0098.eurprd04.prod.outlook.com (2603:10a6:20b:50e::29)
 by AS8PR10MB7065.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 14:12:36 +0000
Received: from VE1EUR01FT017.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:50e:cafe::87) by AS9PR04CA0098.outlook.office365.com
 (2603:10a6:20b:50e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 14:12:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 VE1EUR01FT017.mail.protection.outlook.com (10.152.2.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 14:12:36 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Mon, 26 Sep 2022 16:12:35 +0200
Received: from [167.87.17.23] (167.87.17.23) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Mon, 26 Sep
 2022 16:12:33 +0200
Message-ID: <0b37be56-c31f-5603-414c-07e678c6b560@siemens.com>
Date: Mon, 26 Sep 2022 16:12:32 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 0/4] Enablement of compat tests in CI
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, <xenomai@lists.linux.dev>
References: <20220920122503.115682-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220920122503.115682-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.17.23]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--15.938100-8.000000
X-TMASE-MatchedRID: Alur8Cs15mw5QaOxwNGfvo9bHfxDWoibNtywwIf5ksV+J3gtIe0gA4vO
	GTCbVKU4fsHhg+2FIAuj1fS2cCKT341rT/sKjwatpX1c04mAgVG61uxEWGyNMi289eFksaeReou
	vej40T4hLxCuBTCXaKqJFmbmfOdw3zSEy3HVaiC5Joro5CEMAFAshYDXXcgntf8dNT84FpMYQAi
	YeAVgD3qRymZqZOCCtY2iR7K8Wcsy+cKWVQmxRy5uxrOzNyr8Uqbt/wkKSxwz9xyC38S1f/f3l3
	BKhUmN/Odl/GMFVBFuncita11QPxUWKnB9D0c9mvtPMyLC089dT+JmnZwrj3F5hVZTm4dD8QX5C
	VimNCmkK1YKSPbUVZKPFjJEFr+olA9Mriq0CDAgBi3kqJOK62QtuKBGekqUpI/NGWt0UYPAI7oC
	UriDS4fiNnF3M9WGNakQRvi6zrx4muxImCuacLZgsUDEHK8L/
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.938100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 555B5E4F399CB7CAF55AFC9B2AE4BAB7A2AF05A73B180864D87C7460567BC20C2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT017:EE_|AS8PR10MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c28b123-01eb-47df-8946-08da9fc92992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B0dnz7wzIjEwvrzCx/n07MJSBeBv5rv6LSvtkrUbBSz49gKD/7YKcALN4phAkByTYt09kXnF/4KabSR7aG1p1Lkw9WJl9pY3tqNJKbGgVkO7fkC+Diu3usQZ24Tp/60QmLMd2nWl6Cl5hGozVbzntCxjvfRSn38cj3efhjbVvaPnvjXxq6iAWrrSR8W4eNfx5U+hZI2vsS8Xjclu1iwt6NwwGHhUS2cqMfubPplsyFGSb6+w4vF1ok8gnLEHdrsN6ccNLkh1ULtbjrvy8BQ4z2H1yKqT1B7Uxs92rGOq4Ohk33AxZW5IVlLksdXnayUfUEDMs83w3adOiZWy8TgygaFRSnVk1O+nXB9w6SREjty+ojzAcmyaF16MXzh/S+zcVvSEU2Z6KZclcc5BpuLQtjRnSob5CGOG2l552FAGUb8Wymx7OtusS1cllJwjwFcPfsVDxn/Vb40bDTsTcpkNRmrMutzOq6Bm4nHkQgoooFoDUa3603HRZFzWp2/hSsFF6j+D+oFq/7hNzgbLTQz4aB+8DxRagXfOqywAYb8Q1bDosyeSO5/Jf3/OnfzJ9nOtyKOiAeGugDBpEWlav0KnJHwBEVg7recKyTHgAYzelPg0MCRLVvJc5vYFPO2QwPgUFvF6yoNlX9djf391KWUZIetjJPyizRbRof8+74jZ9mzrlLUHQuTBYjTsTKM/muAIMEYQdr7DLETrjYA1gnS0ZqBbXeGrZ4CRKUueU/qIH1wFMokRmfp2+xjGGuwrk2lWhePCf5sb1i+RZ1nd3VmRlONQXZv81fB7Uis3jZig0TectWgoYaBujK46NKt9m8aiDpJjVAdlnnlhnnEyZA5F7P+lIQpD2DuDXqg8ubl2ECQ=
X-Forefront-Antispam-Report:
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199015)(36840700001)(46966006)(40470700004)(44832011)(6706004)(40460700003)(356005)(41300700001)(7596003)(7636003)(2906002)(70586007)(70206006)(8676002)(110136005)(316002)(16576012)(31696002)(5660300002)(86362001)(53546011)(26005)(8936002)(47076005)(40480700001)(966005)(478600001)(36860700001)(82310400005)(186003)(16526019)(956004)(36756003)(2616005)(83380400001)(82960400001)(336012)(82740400003)(31686004)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 14:12:36.0589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c28b123-01eb-47df-8946-08da9fc92992
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT017.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7065

On 20.09.22 14:24, Florian Bezdeka wrote:
> Changes in v2:
>   - Removed patch 1 (already merged)
>   - Splitted patch 2 into 2 parts (addressing review comments)
>     - rtdm extension (now in patch 1)
>     - compat support for rt_can (patch 2)
>   - Added patch 4 (helps to separate CI logs)
> 

How about using patch 1 on other drivers than thouse you address in
patch 2 and 3? Not needed? Or not possible?

Jan

> Hi all,
> 
> this is a spin-off out of my y2038 queue. This helps to shorten the
> y2038 stuff. The following 3 patches are necessary for getting the smokey 
> testsuite sucessfully running in compat mode.
> 
> The necessary adjustments to the CI infrastructure (part of the
> xenomai-images project) will follow soon.
> 
> At the end the following issue will be resolved: 
> https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/21
> 
> Best regards,
> Florian
> 
> 
> Florian Bezdeka (4):
>   cobalt/rtdm/fd: Adding helpers for handling compat affected data
>     structures
>   drivers/rtcan: Implement compat support for the rtcan driver
>   drivers/net/stack/ipv4/udp: Implement compat support for the udp
>     driver
>   testsuite/smokey/y2038: Show sizeof(long) and sizeof(time_t) on
>     startup
> 
>  include/cobalt/kernel/rtdm/fd.h         |  16 ++++
>  kernel/cobalt/rtdm/drvlib.c             |  17 +---
>  kernel/cobalt/rtdm/fd.c                 | 122 ++++++++++++++++++++++++
>  kernel/drivers/can/rtcan_raw.c          |  42 ++++----
>  kernel/drivers/net/stack/ipv4/udp/udp.c |  29 +++---
>  testsuite/smokey/y2038/syscall-tests.c  |   3 +
>  6 files changed, 176 insertions(+), 53 deletions(-)
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux

