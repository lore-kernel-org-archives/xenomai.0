Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50040.outbound.protection.outlook.com [40.107.5.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232B83D82
	for <xenomai@lists.linux.dev>; Mon,  5 Sep 2022 11:41:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bI0PcSRIidmfuxQJLm3tJMx0psWR83nCCRmh9zYuJZ2Zh60AI+XmbgRK1kY9gMAi4HfyaB9ShcnIYmAaaUX7XuwL6kV5FXJIOnX9GTeEvfqs7Zn0DAabuxfGnm/I8ijy32e/TLfAxaStpDbUlAs8nl+0O4oYYgrbujpe/yyf872DaO2c/pfmDMwHyITOMd6J+frL+CAWmQ/pGriSAn/agBfYec1b9khMx6c7dtAX9NAdSZ5EORRqlHS8kofzxCt445fvXaZGN0dDXm7uoiYfaFvCJwUQBZnwtqVzUkUE4EdB+2oC3R4HtSX0zyH2rXPvQaOrsYD0O7/dcPHUNrKUew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Smg9VcKCQqhThOQe4JpD7ErIBSmrUBnnfWba1ZVNhcg=;
 b=m3s3WDWXT1OeJlIJOHuEwB4Rdim0t+t4LUWNla3BzeYrwddrg74MoC9yEqJlWGtFfbFqE8kVu54rtMmCcxakrkK5IyViKVvl/jTJxS2kxRnP4f4zBHiTXhiMj7FUzFdmBtPRc53oMAgT3SwuI1HkdG4OZzSpaWItcdc+14shsUrZ46NiRxkHA4A7DbdM1Uerag0Uu62Zsid82GvCUY4OwbZ04hFBEqW9EJkB5QPacYtFldaJMu34x+4Y0v8Ptps2WfwxjYnLfJM98NHWUp2DfXuUvuuqj3hc87i+y21HPZTZOiZMDtRUAyy/clEs0O7y6VAD2or8DfahlfT8r9Fsog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Smg9VcKCQqhThOQe4JpD7ErIBSmrUBnnfWba1ZVNhcg=;
 b=QspKcCqrcdUfs95u3u2YBMRWLAW0SmsgErJ0ym+/f5jGP9335OfTEMujFlzQ31OTpVl6vmVuDumFHYgEqpA8gJlNfv5S5OMqHv+2OkucI+bP2jK8ICxT/U6tkgQ69dMfZlFlPsDpuBa6cfRd7fE+cCYUNu/x6gy/QLUJChmkJEuGgQo8sjNbQK8GsDQ95ce7tb9e+U9y+woJ9EvwRioCEthSvLxl0fcYb2AiGnd+P+3D5V6KbVIA8krxNmAjXb8gG9cURM3j0vump7aeOvMrkfhtsMvauiaCXdDMirQJ5oxP5HO/TdtQJ66YounqUZb3Rvozg82+HbRdWAPQCFqB4g==
Received: from OS6P279CA0156.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:39::19)
 by AS8PR10MB6413.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:56d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Mon, 5 Sep
 2022 11:41:25 +0000
Received: from HE1EUR01FT009.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:39:cafe::93) by OS6P279CA0156.outlook.office365.com
 (2603:10a6:e10:39::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12 via Frontend
 Transport; Mon, 5 Sep 2022 11:41:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 HE1EUR01FT009.mail.protection.outlook.com (10.152.0.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10 via Frontend Transport; Mon, 5 Sep 2022 11:41:25 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Mon, 5 Sep 2022 13:41:23 +0200
Received: from [139.23.79.104] (139.23.79.104) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Mon, 5 Sep 2022 13:41:22 +0200
Message-ID: <d63fe442-b0d0-5167-6222-8ef647ac81df@siemens.com>
Date: Mon, 5 Sep 2022 13:41:21 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [xenomai-images] [PATCH 0/3] Enable compat tests
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, <xenomai@lists.linux.dev>
References: <20220818073113.19382-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220818073113.19382-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.23.79.104]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.646600-8.000000
X-TMASE-MatchedRID: MWBePzxHDOw5QaOxwNGfvo9bHfxDWoib2Uwl4gfKRdLrOLyP6vXu3Wva
	omg0i4KNV0rj5xi3XrjUobyHIcIzrgeqcuDEJjQg/b0rUsqym3wPgCQ1Nx/qoCqRJ4M9q7OvyeU
	l7aCTy8g4rjJc1YXhsJ2PyNq+B8xIEtuR7TIdaKW3p1gSIrjuNmQexWkOikPfjC80jICd0JMFee
	AjqMW+l4PLx3vY4vNiXnmuBT+Y9/JUa1d3Cmr8XoVWjMf7ysVUxQuyWuTn6yp9Na8belcvhA+jS
	+LRpl8190btya4ycShMEnlUJ0kvxY0DuTXUKKLrl0jwRnm2nbFvDpvGBaZIXG5eAiqrqZDK9FT7
	09M8dJiHPSXOyvGapqPFjJEFr+olA9Mriq0CDAg870o9QRfzO1Z0V5tYhzdWxEHRux+uk8h+ICq
	uNi0WJNbfCVmGptsGsep0TEat2o81ofe6HIErHcmud+1SlkLdftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.646600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 2B198FF037AF950D51B70F805DDFA410BAEEFD0FAFA086089680D564DB9181162000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b36caf2-68ba-46db-33bb-08da8f33902d
X-MS-TrafficTypeDiagnostic: AS8PR10MB6413:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OdQulu00uaL2lQFEnA4irQTLAiVDXaOzw/amDM+6xQ1cNLKTds5JqTEcYvTSCBOReWn7gwXc4nldW82i+roSl1nUE606NT/c9bSq/p28bGIX6D+ZHxC3taW/XxZfL5HvdAFuQv5un2Yz6hCwXQkXlGikXs6p758HYq5aOECxKVPJc0kzC3Cw+PoM7sJ8PQd7Pd3L1WRgxnR6GH8lTRlKelZCybDxwcHGae3n5mzVw6Ow2DrUHd80fKUoZzAxzMWxka7wcOS1ihTxbuQ8hUQB2Noiopjkbgp9sCysOwzQ1xC71gJz9ZjI/ec/lZ9LVT0i9ZzPCK0AvG88MkCuGzr4IeWpsD72Rdbr73wKv5Epd/V4kVBLRLRgFYmhWozUMMUNPV+1li5rjq4vV0yQiPbwSTLkay4kGv6FhDxNeo0jXvPcnVOxjpi35n22ypa4uEHE1plSivXwTZ2w59g+uBzfe5qQ3xuadRdIsjXHqLSSD0UyhIqvDVem5Ga8f7dtGDKEOOJkRXZuoRrVFjf/9Q5uHOgaNixYvoUt8on4UZ/NWgNtqWFhwhXdkGPfDKyMZV4pFMIGm8u7ivm7jQPPzFc9gTnPSf07sfm4tcZLcke3P2cOEn/T1DhlKzyuQGgUcu5y3RWkSf3aRziZdKshP1NutGAWCfhukr5AsF60JSyJggbKWE8Lo6EdSngVQAYNbrmeSjVyrrWJ6jP1rlUy5E9+gbiY5KOuOINg5af4kHr5GNtJMbK1ndOCvs1/huqSPqDT8d/OrQDMGHkxNM2FoAGuZ05yUFg1dcSfK7mpIRvON3mEi2Y/FZYG/ehKMC38bG/ZdvCeFY2CuWK6nIwTUQFV6+qFVnONcc/B3qPogSP/lNfSBu3C0hGiigW2fsLEBJrPNuPzW1IGKFzU/Iy6hc/vjQ==
X-Forefront-Antispam-Report:
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(39860400002)(376002)(40470700004)(36840700001)(46966006)(2616005)(83380400001)(956004)(82740400003)(16526019)(186003)(47076005)(336012)(8676002)(82310400005)(81166007)(40480700001)(356005)(36860700001)(70586007)(70206006)(316002)(966005)(6706004)(16576012)(110136005)(53546011)(26005)(41300700001)(31696002)(44832011)(82960400001)(478600001)(40460700003)(31686004)(2906002)(86362001)(5660300002)(36756003)(8936002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 11:41:25.0238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b36caf2-68ba-46db-33bb-08da8f33902d
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT009.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6413

On 18.08.22 09:31, Florian Bezdeka wrote:
> Hi all,
> 
> this series adds the build and test jobs for compat testing on x86. 
> 
> I was trying to enable compat builds for the arm64 architecutre as well 
> but failed. The early Xenomai init code fails to detect the cobalt core.
> Would be nice if someone could tell me if that should work and we have
> bug / problem here or if that was never supported.
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
> 
> Florian Bezdeka (3):
>   linux-xenomai: Update kernel from 5.15.9 to 5.15.57
>   kas: Add option file for enabling compat builds
>   ci: Add compat enabled build and testing for x86
> 
>  .gitlab-ci.yml                             |  6 ++++
>  ci/xenomai_next_compat.yml                 | 41 ++++++++++++++++++++++
>  opt-compat.yml                             | 17 +++++++++
>  recipes-kernel/linux/linux-xenomai_5.15.bb |  4 +--
>  recipes-xenomai/xenomai/xenomai.inc        |  2 ++
>  5 files changed, 68 insertions(+), 2 deletions(-)
>  create mode 100644 ci/xenomai_next_compat.yml
>  create mode 100644 opt-compat.yml
> 

Thanks, applied.

But could you also update Kconfig in a follow-up patch?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
