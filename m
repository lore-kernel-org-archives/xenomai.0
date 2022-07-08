Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00065.outbound.protection.outlook.com [40.107.0.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBF97EB
	for <xenomai@lists.linux.dev>; Fri,  8 Jul 2022 07:12:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkvpvDKjCnb3ZGz2v+XnKu6PwUql7XRPm4hQ2d8bKoijyLVLD+ZrlrTN+yuCjoXtPaZyOFynbHcG5I7mHbTPEHrMPx8W+xDwSNgELNAfAieJhNAxF8ld+bjmrJYQu4SpSYihHccRjUE4gtQ1GwnSfB4g7swG0eejIu1Zjj7rL8jGCRuLxlBKr4UH7qy8EkO5yo2/YTILZfpHgLoB6nbnzmcFf1h5cYHGeser8TkPnUop61vXsg71xPZa00yFkpx6kcha1a38YhHI1LqEmnsWZfZP89mMUtD0qvo3AxmRBkMa1EOXZv6hMlwxrCI+yI5E+ddrtJIDyoJjcPnn74PORg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZ8KMVgFCRRuCl1+fBIpbwAe0tS1Gz07CicK5X8Ddxg=;
 b=OZKGAOSKE/mRau7gPq2qks7SlVs+MZ/gs6AUSafQxD9P1JEQBkEbDnbaCAuLoIQ4FGzh/Q5/xz9t/Pr/noYJFpBKREm7/3OIg6HuMzLhZMnE/oPuLsQDeM7za/FA4V9D/wJpGr8QJ9+WZVJOF1RYCv4op0Q0nP/KKDu9dUdQX1aaVPTjmv5gfo51Zd0bifF9O4CNyWdNde/GxJcs5WkLA/Txl8cDEYh0h5rRm8RxYbVet7ZyL+GpHA4Iq5Rf/rwO8nrhS4r+6N/sEpDCNQtr1G7167qpAXs3lAMQlT3+r+QKm/pkJzZqcHRVONcRHqJkONmweodCjArIFZy5fJrINQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZ8KMVgFCRRuCl1+fBIpbwAe0tS1Gz07CicK5X8Ddxg=;
 b=Zf9KKw/STulIbCe9NniRT96RFx+sQqPf5LoXVcSw5n5rUmuqR4W2/BvMU8pau69y2QrE5Ekv4iOEJePRhC/Hw2cYK2oPYPyoZLFquXB+0ED0VvzTsytfUQSA+YKgs5k8G6DYlRxX9aW+oSLH3ROGYE9pIa5XcpziPwrj47kILqnia005QJ9psAl6AKadxfHu/tRbfzTXECaLBZVanhLdVazv5Wo7hQA3HRsqUUhEA8OHiUvjfHyKXpSIyeDsdxPwgW0Iq93B726PmQmtWwCeptqsdzo7nfz1ZYQyYIDxAwDRfz7r8GKwYksZtVTfbAB49Y7xMSTThpXqGkXRfoJuVw==
Received: from DU2PR04CA0029.eurprd04.prod.outlook.com (2603:10a6:10:3b::34)
 by AM6PR10MB2645.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:a1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Fri, 8 Jul
 2022 07:12:49 +0000
Received: from DB5EUR01FT025.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:3b:cafe::6a) by DU2PR04CA0029.outlook.office365.com
 (2603:10a6:10:3b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Fri, 8 Jul 2022 07:12:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT025.mail.protection.outlook.com (10.152.4.240) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 07:12:48 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 8 Jul 2022 09:12:48 +0200
Received: from [139.21.19.112] (139.21.19.112) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 8 Jul 2022 09:12:48 +0200
Message-ID: <8929fce3-cbe6-79cf-d0a9-5e8399e3dec4@siemens.com>
Date: Fri, 8 Jul 2022 09:12:47 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC][PATCH] x86: dovetail: Permit to declare a trap handled
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>,
	Johannes Kirchmair <johannes.kirchmair@sigmatek.at>, Richard Weinberger
	<richard@nod.at>
References: <006148b8-dfa1-1abb-b243-029db08ceb0a@siemens.com>
In-Reply-To: <006148b8-dfa1-1abb-b243-029db08ceb0a@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.19.112]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.724100-8.000000
X-TMASE-MatchedRID: vIFHZ/uiyj85QaOxwNGfvo9bHfxDWoibWhGKUaUS+pj27WtDgGBc8thQ
	O8CvZj/XIZ5kqZm//eW0QygafZjV1Ykhnn7Y9QAO1tP4AhoH7X4hT56GTxfKB/gAhuaFie7S+If
	riO3cV8TozDhGeQC9EsQ5vcyCjz1IZ2koYqU3LA7xdGAezyy08aWUV1+bBXx03nHtGkYl/VrjxR
	eo2tk96p+4ziUPq4LxS4s1XGkEG1o8cZKhqz8yES8cRwTHQ3O6Mu8LwvFHOh2eAiCmPx4NwLTrd
	aH1ZWqC1B0Hk1Q1KyLUZxEAlFPo846HM5rqDwqtL/9IYOKm25T/DtoYIwynqxOjn2QEB6RQsQkW
	CuWSmqsjJN1PYS/gyg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.724100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 87B495F01E1ECBA3ED82B5A1CB908689D226E4901B29A2BDE96FF0CD680EDFEC2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c97ca7c0-f0f3-49a1-35a3-08da60b143d0
X-MS-TrafficTypeDiagnostic: AM6PR10MB2645:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nv/ptRdtlz+zvxVuqTUQxH9Jpwxm7WSGpvxqT7sYJtKiE46WV9SBoIaCHSKBh9JkiXAPc95ztWye81mpyXldU3nix6rz058A22udAb4auygvcymvjpW12p+ODh69kPi4AgBYQUQQkubE6VO47lqrOkSb9A7ZhhVLrToHd6J+PixrQ1qdOJnWUPa3NjjhtrCPHFYmDZx+hecZ1XBSGRP3MObI9A+KF3R3tOEppaD/NAKtRpVCz1PENlS4qhFEF50cWfbS39Cz1ywVvOMOKCD8wcCxYSahypU7WivU7rG0Tub4h1XdUMqmPczrsBIB5QTRdAIDTD3Ksuz+5YtMQ4JQOm8u7rb8xedZGBM4tTACtGaccQanBTwLkNCc57HtEATmtqDHdc1qamXewpYd9ixZsbSjLRnf9uwdDVTtMdMd51VeZfat3viz7zcHYT+7cuMPPAr2TyCZfsFe8wopfUrFUTy3ctOvoS+GpebMG3+CkYhlii66SfEuIaFWESywHnPWfONA2BogRSZOxrhBDR82iONBm24wdfyZ8qbCX2B06TCX5Ipw1tUqT2ENwaljx6ytnBAg4vRooxHz1D0VORH4FOEG+d0CbymY3foQ563W84ReI7H6JC2xa4LVDXdBWJSoDsTg68M4wH/V+9BZypVK19lz9mGNUE2TrB7GCCfMfFuWpuwAiFzX0JSFR8DPZncLlSSRtnQjPnLVi7jba5guKPF4r8Kvffa99erfEYDW+GD1YpCNXp+QjPr2Kgtw75KSaCgFhZBBOZ8wkypr/PcUPIMXWT0Rk0x/3Hp5HadYZgz9DElSutCG5GpOqht5LIbHt6qWNKG80OHSJ/JbM1gIooVI+H4nYPEBiilUGCp2Zfb/pPXxaIskyqf9wFSbFxiWaF8x3e5cUTHio0cKHLUbsR70vJZJ5WtmpObkNPN1/rQ=
X-Forefront-Antispam-Report:
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(36840700001)(46966006)(40470700004)(31686004)(40460700003)(31696002)(110136005)(47076005)(82310400005)(26005)(186003)(16526019)(336012)(36756003)(316002)(6706004)(956004)(2616005)(86362001)(44832011)(16576012)(70586007)(36860700001)(53546011)(8936002)(81166007)(82960400001)(478600001)(40480700001)(82740400003)(70206006)(41300700001)(356005)(5660300002)(8676002)(2906002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 07:12:48.8804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c97ca7c0-f0f3-49a1-35a3-08da60b143d0
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT025.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2645

On 08.07.22 09:11, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This allows to skip reporting a trap to Linux when the OOB handler
> resolved it directly. The handler can signal this condition by returning
> "true". This feature was present in I-pipe as well.
> 
> By intention, not all spots of oob_trap_notify are enabled for this.
> Debug traps are left out as well as asyncpf in kvm - no use cases from
> OOB-perspective.
> 
> NOTE: breaks unprepared users, breaks non-x86.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> I'm happy to add non-x86 support as well if the direction is fine.
> 
> And if we introduce that to dovetail, we will have to add some kernel 
> version checks to Xenomai so that it does the right thing with the right 
> dovetail versions. Feature flags are out of fashion there as far as I 
> understood.
> 

And I forgot to write that this if for v5.19-dovetail-rebase. I have a
5.10 version locally as well, the one we use in a downstream deployment
for some months now.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
