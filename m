Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB0BA52
	for <xenomai@lists.linux.dev>; Tue,  4 Jul 2023 09:25:42 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 9B7C1100002
	for <xenomai@lists.linux.dev>; Tue,  4 Jul 2023 09:25:34 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on0612.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::612])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 56775941591
	for <xenomai@xenomai.org>; Tue,  4 Jul 2023 09:25:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bX6Q0z+5AVX0bv/da9pzoNORYxCCa8xxPQBo1c600Ps/4pG3gFNGC7ZB+fRZKNqsG5BCqUwS3PZ+jXObSUcUWey0cxBu+LCWdweYyiWeEqrP59BQ+c73JSiSUAJA/fEum+nsnhDaWtShNcyxUQhL4UoAl4UtBeRj+NZUfW6i6ogYBTKpffi1CHk4X5doaoeZ3X3OTawkMxqt82OXF2VVJnQhCaNmIvmrpL7ioaLSlbG1yj4omQpdMacT77umJKv2v/l5GvaHe/b4GBil6LyWbc8Os2qqRToE9SjN0YORm5Mh+gCA12DG6OBuEM4Mcfz8rw5p8jCxw5jnLIEH/g4sYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qe4/psRXPQnkbfwCygunk9B6qTjAsk7Qx/lQO+IKzUE=;
 b=WbJAnNIrA3yhB5xWR8K8TEauCA/RFB7yAF0qLGnna8R3xu8OhFKuSj3fkk8dZGEzt1eiGpmKpG3b/jfs0VU5E6AXz/eE6u38n2L/oAsprRg8aWdT6INVvhSWFJA2VS85LRLpQbRVUXyuB2jYvvgE1gUZxjgsrMfejliva/TLDunqzc+0QBdoy7KwFyUtePYwTfvfnwXt8VvhKPtMkszX8hLCeTxzr5lslc7TpxDyS0/ilfvg1SjCjKIqBE5+SJI33VHw7oD/YyQXdNacGiGOxSq5+nQyA9yMIXmPhn8yOSHLhKpibJ6J1mG7oU/maJQpPqqX1sheUSlFCq9FK8J0KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qe4/psRXPQnkbfwCygunk9B6qTjAsk7Qx/lQO+IKzUE=;
 b=P7c49LxSnIs5AJqAi9xSx7B6LHIrtFBS6sYf+nTWPMDscmw0PPuFzpK0bslazVt7nHFbrURE1zHQxxWCSgm2xd8rQa3R2RAblq68ugZ47mEKKIrotBcM10uZbXf0KyZcCaxAxgljxq28FbnW1Q6vs4mpAmtlqOuRg7G2qh+yCE3XEWPo8rnPHrsRblugtDY1n9SfMo9nue19YtvmMTT7XNpWXLsqE6bryknMCImA8Y7AaABmMKVmhwW3YeToPDyRs2j10ZfCdElhqKE3mF8LeCBVIyrQX6s9R8laTf93UForxGs+fU7YW0tBq2tiK96fZaRt5/Tf2kJrNEOocjAYoA==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7451.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ab::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 09:25:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 09:25:32 +0000
Message-ID: <f496ef54-ba1d-595a-d8e9-7a006f8aee53@siemens.com>
Date: Tue, 4 Jul 2023 11:25:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] Make macb/gem RT driver to be built against linux >=
 5.0 kernels
Content-Language: en-US
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <francois.legal@thom.fr.eu.org>,
 xenomai@xenomai.org
References: <3b7514-649de400-33-28cbfc80@10273628>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <3b7514-649de400-33-28cbfc80@10273628>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 58a7afb1-aea9-4f47-b94e-08db7c709d53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s4XNeDRFngBc0sUYodON4rvTkYV085cAbMKkGS+bUY5ClMC8pK01UrtIUw3RMbS3Y4N47QEEnGb2T28ByFoqPoG7kFNV18U4SXGXdrWL2HLNWqqJcAYM9ngMGByB7+0kyU9WfGJJfC0ktzQsrZK/LSMgbWaHiIX8JJkmoaxNVbjgFPd2E+MEqhajPCmKPr/kmpQES87H3HVlVb2c0U+Idaz6gZ8oy3p7+UY019MGXCGUPSjiRr92V2Lvqwq14jZO/c7ykwK19GD9gwiHe83TgWdUGA9eLO2gACXnrYQH73Q1sF4snurjMvGHkQjPIC0Wn4x9gp9YAZ9pl3md3UG08clE3vF5qk/y0rIXHCRHg/cIAM+4nOL2WDRC9KZl7IJ5GfepFXV3oG8SJn/AfvThkkMr4RVc/0DPZT4+jGC4DJ4sLd9LvgOBx3zkPHvajexpEygk8mUreq0vQS7xyhZBZmEm1Nq/LPWugEoPNqhazzZlT5rWl1zNNEJgZMFJHuIgy5WeqGgcd/D4y6DhQPS3HBESzs9FOlrnKtJJr6jeHja3z9ShO84hHXMBTerHZCHczBkdki0eI9AyukJYdkh835PYkCB00oPwnn5fmEq871mlgOtYeS7L51zWaubO2ier5edAsLAoMLUK3Ym31ERLhA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199021)(2906002)(41300700001)(5660300002)(8676002)(8936002)(44832011)(36756003)(86362001)(31696002)(186003)(2616005)(478600001)(82960400001)(26005)(6506007)(6512007)(6666004)(31686004)(53546011)(6486002)(316002)(66556008)(66946007)(38100700002)(66476007)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXdDM0xuOXg5dnE2c3dMMC9ENC9FaG1CeGtFdnVmK1Bnb3g4ZCthdW9ZT04z?=
 =?utf-8?B?SG9CSTV2TGdaL2tqYUVTNHF6WlhxVkR0eHZmYU1UMVBNakxIZ0Y5T1BNdUpE?=
 =?utf-8?B?dk1hM3k1cGpRQUJ5N2JkYmNSS2xXbkE4NTJFaHhxL1QwZ0hMRTRlbG9zdjB5?=
 =?utf-8?B?RFdMTEdwQkhBcmtOZGNWK0pDUzI2ZDIydHRPN1RiVlQ3ajBNak4wUU5IdUZP?=
 =?utf-8?B?elB2VUliNDNZVzhyWEJnZlhuWEZXcVVrYlpIZzlCT0M3bGNFR0N0Zi9pS1Ry?=
 =?utf-8?B?T1dPV1Z5dkljbkwyUGZLWnErTlp4RHJ2dGMyN0ppZDJwOGoxWEpyWFdHV0d3?=
 =?utf-8?B?ZFRIS1ZNU3hjWk5LRlVtK2l6bmt6ekRnYkxrZTlNcCt6VWJ3LzBJbldYNWwz?=
 =?utf-8?B?b1Y0cGgveEV1d3VBWCtqYitYK3NlQnUrMDNrNTM1SzZDb0ptKzJEUmJXRytY?=
 =?utf-8?B?WklOUmppclA1WFREdXJJQXcrMUFFMUlNdjlvWWx3dVVZbUl1S1d0bmxTTFBt?=
 =?utf-8?B?V3QxR3hKWk5BenJ0am1lZDVua0dYS2NzdDE0V0RWYTlXNkxTWkU2dFBtTkhH?=
 =?utf-8?B?VWZPV001MVcxRVRtRnl5ak5VZHJIalFwdGpNd21IemVzMWRJTXgxRnpIYmpk?=
 =?utf-8?B?ZEhjVHRjUjFFaURSdEhlYTZQY3ZkWFFjZzgrbFJ4Vmx6bDBuMk0vQ3ByUFFq?=
 =?utf-8?B?cjhRUHVXQ09NdHhYZjhacUE3UzkyT3JMV0NrUXI5VnZSd1Z0bVdScnNNZzBl?=
 =?utf-8?B?Vk1PZS9iRTFHMDZCL2U2eW1rQlExWWQ1RUdIc3g0ZHpJRElrVWQycjA2WWRr?=
 =?utf-8?B?MzdQNzloOG9tL0ltZklDdUZqSk80VWdLV1V6S2JNOW1GNWlyMUhtbVhIK3Ft?=
 =?utf-8?B?ZTRibVluVk1ralBwTXd0RE9PSTFIS01ldk1MUzR2TzFJYWdkdG9vWVRGRVV4?=
 =?utf-8?B?NGdjbjZNNGJ5MGhHdnJtUkkyOWRpVmZSMVpwQmFGRlNobVZXc1ozUytLeWZ5?=
 =?utf-8?B?YUZxOTVSbXAvN0djb2pVZEZtSU1ka25RTUV4VVE0UDdrZHg4ZXNYVCtabUt4?=
 =?utf-8?B?eGVMQm5RcExWZjFHQ1dHTEpNeTNXd1drZW5YbzJwRFgwemRiTENpOUNFTFpI?=
 =?utf-8?B?cFZMb3pZc0RGV2Q4K3lXOWU2UWhEeEliQXloK1FSWUpHa05EVW1TSnpNT3N2?=
 =?utf-8?B?c3FuY3pJZ2tscW90ckk4OTJaWW9ucVpJakRWZC9QcWx1QjFyOFh5U21mOElu?=
 =?utf-8?B?eHQ1RmZObms4R0d5L25QallBaFhnSVdHVVE2bTdKT0R6c2lmVis1alExNWxS?=
 =?utf-8?B?R3VmVlMzSHpPek9GcU8yd0JkdGRldHVaR3FJMDRvNWxzYjYvVE1za1ZuU3VO?=
 =?utf-8?B?KzIveC9nc1pSZ09CQmg5UHdmeHV3eFpJQXpxL2hjR2RzbUMyZUw1TnR3czAx?=
 =?utf-8?B?WSsvOUFrM0NYZW9yWnMvUlRpc0pwRkhpa3BnUjEySU5PZUpkUGI3WU5pTTZr?=
 =?utf-8?B?b0VaTEx2VW15STA3QjI0V21XOERDNG50WFZLYjNPc090UzAyU3NZbXUvM01p?=
 =?utf-8?B?ZEs2U2oxTXRhRnNnR2wrRnkzQ0hDaW5IZUZ0NEd5bWFoM3pHWHUyMDBXMkU3?=
 =?utf-8?B?aFVHMWNrT2p0VnpacG1NVUp5NXIxeGpDVDhxcXVURmVtNGxqdG5UYnNzWWVI?=
 =?utf-8?B?dEpTQWVlWXYzQXhhaXhlU0FqdTArcjVVS0ZXYSttRjExNk9hSlZycmpKUFFH?=
 =?utf-8?B?VVVHNWtzNVJod0dQbjhpYXNNc2JqZ1F2ckJsMnFPaGFVdjZmZ1licldSOHlp?=
 =?utf-8?B?S0psZ00rQVVYN2lmY2diQXZRWFVFN0RSTlV0aDdNU1ZHeDArdnd3SG5Eb3Rs?=
 =?utf-8?B?VkdSREtlT0RQQllkb2crZ0JjQ05PRHNlUDZqbGc1TUFrcVYvWXdZK3NmTmdn?=
 =?utf-8?B?MmlZTDVnekRDTCtWVTVDM1VhWUdCOTZBYlFoaXYxNDBrM0FQM3A0dW1aOFNO?=
 =?utf-8?B?MXNvWnFBNFNaSmhFMHphUHlKR0FuMzNPekZlVkhzZHNvcUFSTVhDVVA5ejJy?=
 =?utf-8?B?WnJ3K0lzQ2tJVlhucW10RlBYZHdQWk0vTzFWaitTdWt2azZmSUtpWUZoMlhC?=
 =?utf-8?B?bzVERERwL0xubEx3NEZ2MEk5dmt0UmNWL2RXeTFXaVZXSlB2Vy95MWNRNEc1?=
 =?utf-8?B?VUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a7afb1-aea9-4f47-b94e-08db7c709d53
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 09:25:32.1904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lX/cEIqXsNj5b+qJYPLqY6MfHYPPfDtC37RUBsqQKDRW3gdJoT/kgM2YKbl1iwUBa1VqASW2jXrUR6RlY1r7rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7451
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=P7c49LxS;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f400:fe0e::612 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com

On 29.06.23 22:04, François Legal wrote:
> PHY layer in upstream has changed a little after 5.0 in the way autonegociation
> capabilities are encoded.
> MACB platform data tend to disappear after 5.2 upstream.
> Plus, ioctl prototype has changed in xenomai. RTMACB driver does not build
> anymore.
> 
> Signed-off-by: François LEGAL <devel@thom.fr.eu.org>
> ---
>  kernel/drivers/net/drivers/macb.c    | 60 ++++++++++++++++++----------
>  kernel/drivers/net/drivers/rt_macb.h |  2 +-
>  2 files changed, 40 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/drivers/net/drivers/macb.c b/kernel/drivers/net/drivers/macb.c
> index 77957d906..0648afa3b 100644
> --- a/kernel/drivers/net/drivers/macb.c
> +++ b/kernel/drivers/net/drivers/macb.c
> @@ -132,6 +132,7 @@ void rtmacb_get_hwaddr(struct macb *bp)
>  		bottom = macb_or_gem_readl(bp, SA1B + i * 8);
>  		top = macb_or_gem_readl(bp, SA1T + i * 8);
>  
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(5, 2, 0)

Thanks for the patch, but master does not support kernels older than
5.10 (dovetail) anymore.

Is this patch needed for stable/v3.2.x or can it wait for v3.3? In any
case, we need a master patch first, then we can discuss whether to
backport it as well.

What we also need is enabling of the driver for CI to catch such issues
earlier. See .gitlab-ci.yml and all those driver configs there.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

