Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80045.outbound.protection.outlook.com [40.107.8.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13789441A
	for <xenomai@lists.linux.dev>; Mon, 26 Sep 2022 16:33:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=In+abSB5SKccX5cJlefbDpeX8FuJf8dmgL7KfNN2tLAwlMEF1PolfOApStaMkoCl8mHAAcFeXN6alGYSjbIbrhwLJQazQpQIOgbZ26s/7b3y2/aW/9QwjAPSRJYu5GwNOzjP/ZigljP00poXf9OoLYFm8Lh3syJxGeeBcU3IuucCqUIH8WDqJTfmYRwGEFQ4njCEDrJX79mB8/nLxbpe+tLIRKmaEwfD+4xAV8Cy93vhQ28qYjDcknBnJQX1PWt4kViz9+Po6v+oWCXTAeKKJAnkwUa1Cods5POVkINHyD+P3KqQrdNK3aKWR75mG4bUHoqaT0GoXVn91MKKt3h1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSg/tDR3nJ/x3hP8OneiD0U+Xa+BqSsupRqAZ27oYlE=;
 b=bGlJ2hQawR/vbiqIuksVxpIgP9HSBzpFpxQKWhtUT4faKIDDTanghBmP0oS7/1zWY2/O57SAnYBa0sK8q03jLSe20XZ9pqqWgoHUmxAH2gBZexLP7dxjZGhyEtoi5tRDEyAvXfing7S4Nu6l2iT5gaX9o9fixJY/S1mi6xU/+SV2XrDE/EsxnAdDXNPDRqJEX75ue2hKB78EHdoCwZW2JEi+QUS75MBFLTEuBkbHztcadRmPjZLroA3FF2R+fUVldn0npyD0YFs1oetHLF+BG5Wxr9/6wyd8jMwPp1xqs5kxRCM7wcsxKnAZhVHFVB3MZaqrB0KKcNY2Hq7h62D99w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSg/tDR3nJ/x3hP8OneiD0U+Xa+BqSsupRqAZ27oYlE=;
 b=QBOhSesEfw6u3WGGQ0IB0UECV9/f17JSfUg5qey2H8pc8Z138oW8caASSpiwP/jBsun9YC2x4PbdS0vVYPJTZ8tfqVbkUN2KAirFF1JcctsVZ5KXAAam2Mwt8JRqsr25HbdI/ZWWGi2vgbqWhBt9tRBYx3ZMjyzmNPjqn2EAa2ycsE7p6Yn90ytH61BNUg1nL1k0ZGiD1lCuDSkB4yPmu3XpuoXLYYz+ALs0vB6uHw6SMw5T+yMdWDMu3kKJtZlgRFWduFf/OX6Z7dvOGg1V3KmoEvVJlCuxsN2FG46PepRICCscm/RctGPRKT13xIvD/qcH7CTUR7Xv9ZzeLD9IJQ==
Received: from GV3P280CA0082.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::10) by
 AS2PR10MB6520.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 16:33:17 +0000
Received: from HE1EUR01FT043.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:a:cafe::ac) by GV3P280CA0082.outlook.office365.com
 (2603:10a6:150:a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Mon, 26 Sep 2022 16:33:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT043.mail.protection.outlook.com (10.152.0.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 16:33:16 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Mon, 26 Sep 2022 18:33:12 +0200
Received: from [167.87.17.23] (167.87.17.23) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Mon, 26 Sep
 2022 18:33:12 +0200
Message-ID: <ed729c55-9757-563e-40d0-14c7de981284@siemens.com>
Date: Mon, 26 Sep 2022 18:33:11 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [xenomai-images] [PATCH v2 0/4] Enable compat tests
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, <xenomai@lists.linux.dev>
References: <20220920131454.121225-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220920131454.121225-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.17.23]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.601000-8.000000
X-TMASE-MatchedRID: AQ9SOYvqpDY5QaOxwNGfvo9bHfxDWoib8pKIoUEViCF+J3gtIe0gA9wC
	a7XGp56285b+xRMFjsvnPbk1mVbRPW35iU4Tw/SY1k6om1Yy2lpiveZGJ9C3ylAjenU+dzjTopG
	QY5bbP3JKDKmM2YMQ61i3OChnNKH6q9Roa73xn460q5UeVCg1wA+iIgfVcB/dxVQFfLw4zf+teS
	443ymeUWOMyb1Ixq8VeCNV1mMi/45naShipTcsDoMdEtNFjZ45oBwsfvIM1pfylEfNwb6iLauVO
	rDvB8LTBph69XjMbdmYZNCJVuN3JYXgyQHesK4yLxxHBMdDc7oy7wvC8Uc6HZ4CIKY/Hg3AtOt1
	ofVlaoJlgn288nW9IM4WIFQPE2cOjaPj0W1qn0Q7AFczfjr/7PxqvEWHeyk3rlTXubnVUFSyYkI
	wcH8Np6AtXH5BNlAbS2YcnYvHyYY=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.601000-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 4D9EC8E04E56291B2C8729EDEC282366801FD632C1A329A518241569FCDA41D72000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT043:EE_|AS2PR10MB6520:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f29168-8ae7-45dc-ef6b-08da9fdcd09f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0OkJ3hKu2FW1aw18ulfSLa+Ft4Zl6TrU3IoPm7pbCAx02GqqIHUIB+GcoRoSmWJB0JunvqCNVJ6D1If/vpgd5zAllE8SjhM9qnt7lip8r+rByIbRot3ESQ6Kp0tsZergTSkwiMvOlcYROC37ZZbsmz/SgFnlcvlfpI4oFuR7/i0JF5j94VdaBLNbP+Fa89tjr7h2fwKPPOki13Yt9oIVxBYOKShbG83lcD+55k+a9oM1tlAoD/zvB2Y1VQNfqWr8CNVK4VD0yhkyUepyHfhJEPtoRG/L2/kMvqZVKm1Iztn+rjVYWnDbkiScZrPMSsCMT1WhFXgraOa0WuEEWd1rsvcUU/5or1AMEgKI17R7/AvZJZPTgiX49irsqgpGP49za9T/GCdx3A19qnDQL36ycKL39cbf/WlQLmxR92a2f8kFjHBs7ODg+7MXg6IKy5a8i+wGn6XyDlVjgYYL+8AUCFPckZ3Y/Uvy49X0KqiIEPqifKlMT3zRtcY16VNN320RyumuORpA3Z0WA0jJ1qvLQBqVj1W2MoXg8y1FdAq10NYdFVTqUykGJ3x/u3qCIDB9edcwLxWqVJiRMu/stRjlleWLf8UOJ+LIB4fpKumBrm3eo0N1Srmx1ZaSMkI4gvlAyfQ32uL4UecmrzHfTNBQfEKckY+hagzcDGJjYhTrzzM6loXIjHE6ulpbltDmJWfosQ0OBbRUtIs7MVxjU6ogThk2ywSLcdID6eX4bs/+dA5VhhLJbR4MogatfofOhCLyGJXqeXuxFdv4VbMfzR9UvQb4tTUn/cc7crwA2j2H3mdnJngo+jySlUuPnk8JrH9HNfbNbpIxPdlF8mZquzKAI78wlpg/SkpFKlw6lqv/Ro6KEll4u0TdftlcKcaawy+5pZVBe8PHzSWu+56x2q9yiQ==
X-Forefront-Antispam-Report:
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(36840700001)(40470700004)(46966006)(82310400005)(31686004)(966005)(478600001)(956004)(2616005)(36756003)(316002)(110136005)(5660300002)(356005)(2906002)(47076005)(16526019)(336012)(70586007)(8676002)(186003)(70206006)(6706004)(26005)(16576012)(53546011)(86362001)(8936002)(36860700001)(40480700001)(40460700003)(44832011)(83380400001)(82740400003)(82960400001)(81166007)(31696002)(41300700001)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 16:33:16.7172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f29168-8ae7-45dc-ef6b-08da9fdcd09f
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT043.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6520

On 20.09.22 15:14, Florian Bezdeka wrote:
> Changes in v2:
>   - Updated patch 3: Folded next-compat runs into the next "stage"
>                      (review comment)
>   - Added patch 4: kconfig (addressing review comment)
>   
> Hi all,
> 
> this series adds the build and test jobs for compat testing on x86. 
> 
> To get the tests green the previously submitted series targeting the 
> Xenomai project itself has to be applied.
> 
> With both series applied 
> https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/21 should be
> resolved now.
> 
> Best regards,
> Florian
> 
> Florian Bezdeka (4):
>   linux-xenomai: Update kernel from 5.15.9 to 5.15.57
>   kas: Add option file for enabling compat builds
>   ci: Add compat enabled build and testing for x86
>   kconfig: Add compat build option
> 
>  Kconfig                                    |  8 ++++
>  ci/xenomai_next.yml                        |  1 +
>  ci/xenomai_next_compat.yml                 | 47 ++++++++++++++++++++++
>  opt-compat.yml                             | 17 ++++++++
>  recipes-kernel/linux/linux-xenomai_5.15.bb |  4 +-
>  recipes-xenomai/xenomai/xenomai.inc        |  2 +
>  6 files changed, 77 insertions(+), 2 deletions(-)
>  create mode 100644 ci/xenomai_next_compat.yml
>  create mode 100644 opt-compat.yml
> 

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

