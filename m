Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A768639
	for <xenomai@lists.linux.dev>; Tue, 29 Nov 2022 06:27:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htwh6q1GbLzsZjx29WEIFi+Kcf6V2Cg22eR71yI6W2tED4P6/ITCBCWmbmsCYQtfOjcU38ylth38YPwf7hpUY0M6gqf1Qc3qM0mryhr/0F8LCNV3Ug2VRc5qpKITEULmAJ12c3JjMIBnIG2fbG/JrHeaJn92hk+I6Oa74/AsuVC3pW4XiK9bCNvVumb/eWsfmDI6Z0irDur3+w8NAKaLtSsVDODXYBoG1tbK8h3ZUBqcGAeduy7lxbfopnc/Ji0xY51ChoDshWzaETci+qf32XikzuJFs+St4qAJKLaf68Z1r8xmF2nccArH9AtbgGCFAI8CsmBlIBN93qThKkLzsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XlnVc8KuTH7dBc/2Jlqe6xkHVVOegm2/NvRhseX6dQ=;
 b=YiGmUpmbQpy37kQjMuua75rkvP8Z4QkUloni3plqWHYQX7y4Ypwpv+7L6E+xkk/0t0sABmMAoPd/R49VQWetZBRGU+XXymlouGiPywhYm7qBA5HYMMBhCbYfCz92TSPHcTXvwUl+H5xQdTb7LFsWvoC6tq7/GtkSXJzxp/PRFIKwPCU44ynf5OHOgL7l7Nt1Ep0CM8UagN48Vwv0aBwaMXsfr2NkQb3EM+fQUXasKEKyPVxUPsVRYBPFL5f54yf3Dk3+7/nbnLWMT7zjNxgEjuM6zEEvSgEULW6ZeR1dfw3z7opVe0zobJSGnBgfAYYU5QxSqblx81c4jrTZFFsnIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XlnVc8KuTH7dBc/2Jlqe6xkHVVOegm2/NvRhseX6dQ=;
 b=Q9y8FbdE2poyVbO89R38QPi7k5OSYiCk1tKWo6rLo7ygJIfK2IPou1/EDnGfJ0s3L2mGXEcu2LzhEA+5Y7R+S7TlTYTAWP1/6BXDItTpotH/4LSKkCZP+2nkZyM6zvewCLPAapfjgICwgRJv69ZKZtjT4L2lifKT4MbO9Sib9GB7mA+ULNAGYy0q63sIqsx2uiAlmnRSo8BVORb8StDECYdWC0fnC+o1DKYaYUZzXME+lk+uYjXch5SZUPX4D9qO+GRM/Fq1ojLQVWc4c5pGqrTuUtVMAkljgpNGqLZABA747eoL1nHnP/pSauK7ZfKu3v6asj6LocV8VIAwSFFFeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6848.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 06:27:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%8]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 06:27:01 +0000
Message-ID: <8abc32eb-fc46-3f55-eb55-59f4d20d7f23@siemens.com>
Date: Tue, 29 Nov 2022 07:26:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [ipipe 4.4][PATCH] ipipe: Fix imbalance of level triggered IRQ
 states
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Greg Gallagher <greg@embeddedgreg.com>,
 Gunter Grau <gunter.grau@philips.com>
References: <20221128121002.1136269-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221128121002.1136269-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: 448ed392-e573-43a0-553e-08dad1d2b990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I4ali8csIjNbg1D22AfnveuVxz4qCQx5CCBZPduJkQf6khTH+sXMMwHDxZ4DzATTSKzfAXyr25U09ipe/9+DBmXWY0LdVl1Q8VanuxDT3XNlRJdHba5Og4RhIX2HKr+s4J0RaQXrdcwiNO/L2sWKsTGMD6A3e19AinP2Osr5Kaa/W78abLSj0eI7DMe97GNs9bRMMIxh/ie16Wf+HVE9hhDv06l3C4sCc4CeohRpokO92BLIH7FBBGQGyONKcQdb5q8eVw6Elb4YM4xDChsqL2vO39NJzYH8wFEMBKhtYz+51iPHJO/S8NhZejq3TEhrsOC64lGRnuuAPHMxeu+ziV9M8bmauiKDItof6hpTEK6ULhR8J67tvUe1JjQjvGxiQfoNYdiUQ/oiGK+r8epszRDsFOS346bljlVgLHnpUSnkJrstiqoO06x9wNpLGtRynXfAhAxTykZeuC+dD+mXThUUgb1pyJtI4N0+8O5OSGPHPmBc9ElC9seCjZrUMbVvvTj3yEQ4aHggIfYE0khflTh2Rs70CeLNle6A31Dgtli+5vbsJh2xRhk1Il4WDj6D7w1wNF8qQbZ9U7limqTMH9+an26Tw1iwt/upIP3qzssd9hMzHc/cJ3muusWBWCYdOxj5WL+ahMHP6H2dxczqfhtRnw5keB0uldfPNUogCF7iFDvntGSjzqLp82+cdbOD4XyKC4u5t49oEVVJG4gijT2xMscMl5R4BsKwdtzcWpihnQ5YpIqOuWffCon5fZzby1jRAo861mdSPDO8+R1RvA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199015)(8936002)(44832011)(2906002)(38100700002)(31686004)(31696002)(86362001)(36756003)(6486002)(966005)(478600001)(186003)(82960400001)(83380400001)(5660300002)(54906003)(66946007)(316002)(41300700001)(6512007)(6506007)(6666004)(66476007)(53546011)(4326008)(66556008)(8676002)(2616005)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2kzWW04c0ZVUlE2UFp2MDFYek5JdTVQdjlGZ1pGdUswR3ZDRnpjcWxQTXZB?=
 =?utf-8?B?VHRLU3ZQTDg5OVFPT09hRHVaOGp2N0lkV0VGeUpndjFzY3RjQVlNcFhNb3ly?=
 =?utf-8?B?azg0MHBvSUVPN043cEg0S0FZTVF0ZE1hT21jUHVXQlhZVVhCV1NvYnJUekl3?=
 =?utf-8?B?VEc0eWxYaERPZDNwaVllZTdDMVpSVEt4SUZoY1VIMDRveXJkRVNwZFluMk5V?=
 =?utf-8?B?V09Wa2kyNTEvaWxzS0pUR3U1akxraEwycnN4dWtONHlKR25kVWpKd2JmWnQ4?=
 =?utf-8?B?eDRjMnUzeTQwcCtXSk1JbTZhRy9zYi9oY2MxSDBqclJiWnV4QWFOSWVtZWtx?=
 =?utf-8?B?eENkMGhwU3FWYThqRUZUQUVSZHF1MGRaL3p3L2FlblNIdis0VzJlWlFUSUwv?=
 =?utf-8?B?NU1rejlpQkdzNS9yRG9wVUNUVVVYOVEwRnlaakg5ZVQ3R3QxNzFwZzBpTXVs?=
 =?utf-8?B?WHoySGVDNXM5OWRPQ2dyampreUVBRXd1SHd5TWwvU1hwMGJqRWpIWUdqdW5Q?=
 =?utf-8?B?dTZ0RlFHaEU1QTRwdFJ3bWZGbXBidEFFc1FzMDV0SkRFVTViYUliZ0FLbWdh?=
 =?utf-8?B?ZDdsWWJ4eVRJNXdldVJuWXJDeHA3ZUQwc1RKZk1jMC9jRFZNSURNci9zcjhy?=
 =?utf-8?B?enR3YU5BSzhOeEVHWHRnU1k4bUhDWjFjemgyRFhqUkNlN1pNQUVNeFNaTXV5?=
 =?utf-8?B?OTNNUlN0WFJhcUZKYy9FUVkrNWtMK3pacVAxN21meStoVS9FcGo0STBHMGxM?=
 =?utf-8?B?dk5kdmNiQ092eVgvbEpSZ3BlYWFtQWZOT1NYbjIxQ0dISGs5ZFoyM1MyOHpt?=
 =?utf-8?B?eVc3bFJqZDFYQVpJQmtIQ1pqT01QaHF5UFdUZWI2YW5qbFhMNUYwVnJHRGV2?=
 =?utf-8?B?cmtoQ2U0ZGZ3K0xpUnJ2R0xNQkhtZ0tTS0tua281a0xuMGxZQlBCQzVmell5?=
 =?utf-8?B?R3dsdkkvK3FPeEd5UDUwWXh6d1kvbStJdGp5TnRLQURkNm9lOW9ZZUp2TXhO?=
 =?utf-8?B?eFgzTmcxUVJ3bnRFKzNrQTl5TGlBQ3dUUEdLOVhYL0JEUi9uSEF2azhJS1lR?=
 =?utf-8?B?TVFYY1NYOURodHdvK0hEeE9oYUdaUjFrR3hQNXlpNzUxbGhtNEpSU3NoZEwz?=
 =?utf-8?B?M3QwZ0o5aUl3b3F1ay91RnhJdmhUL2UydGp1WVBqRm4rVGFwSmZDSm8vTHJG?=
 =?utf-8?B?eUF0OEZhajljSEdKK0pOdUhYOEdBdTBVc1g2TUp1RnJaSUFyWlZ0VU5Fbnhm?=
 =?utf-8?B?K3ZpRU0rVTBFQjdSMjUwaEhVdDhaSUxIcUZOb2x4dVB6WlB4Z3ZHREFudWZi?=
 =?utf-8?B?VXZNT2VGUlZzcDUxTkJKakhPMmtnenB5UWJsQjVHaHhFV3JzczAyVWQ2T3pz?=
 =?utf-8?B?ZnVVczdwT3I1YjBNVnRnR3BqcjkwWnpJQmF4N0psdGR3ZEI3TVlsc1VIVkpr?=
 =?utf-8?B?VEloUlVKenZWdkZPTXBhWFRFd1lmVzhScFBSSG84UXhZdkI4SkYvbnVraXpK?=
 =?utf-8?B?SlM3SE9QczVTcFhud2FBSEVpYVExbTBQMENuOE1VdXVuZ0J5V0R3WUZ5cUd3?=
 =?utf-8?B?VWp0QmhCd1RQVnZRTklySG9qUElEN2JSVkJ6ZklJaEhDR0ZiUG0wQXNpbVo1?=
 =?utf-8?B?QTU4R3F5WUx2MlpNVnFIUGNsVG8rdFRoRDV5Mzl0cnBmenkrWkloaUZjWVlK?=
 =?utf-8?B?Nys0bVFFaEpKcGRhOU5QVWdLaThOYkxPdmtEM2s2MEFsdzVqQVdmZVhyd1lP?=
 =?utf-8?B?aXFTTk9YcUNuOHBGZGwvNFVBMnJCWTVKZDl0aTAxeHNjY0xQNUpZdklzU1pB?=
 =?utf-8?B?UVhOaFluU0lHZm9UTkhabUZsVEQvUVExNmcwS3BWcGxPempnRnVKZzB0ZExh?=
 =?utf-8?B?QXQ2WE9kaUNuNDBhaTBBdEp1RHF5VzBsYlFtR2dvSWQxYzY2MmVNK2RZR2g0?=
 =?utf-8?B?a1ZjZHNRVUtOeDlwcXFEd2ZkOEF4SnhBRHduQ1JWU1FtNVZQeWdQTzlwSlI1?=
 =?utf-8?B?d09tQUZyd3A0VUliWWt3YndFdzZ4QTZSN2t6R2NkdmNsbW9EODJteldLY2dz?=
 =?utf-8?B?ODRkbHM5YzFqOWdxMnUwL2tNTU5VbWRZZnorL2xVZlVpL3FwSGRjcFFBdzM1?=
 =?utf-8?B?UkRwUVJKejBXdXpyT2JvRC9waUg5V0p2YnpURmp6Z1MwTS96Wms5bUN1alNG?=
 =?utf-8?B?b3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 448ed392-e573-43a0-553e-08dad1d2b990
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 06:27:01.4333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xA01n0BcDTEwH3td40cS3ZeW652oXKapHpaE7ivzdfdj/qmF/wfhv3ZDp+e1O0FXZKkmNgCEyCjD5WXmd8/sVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6848

On 28.11.22 13:10, Florian Bezdeka wrote:
> There are two states maintained for each IRQ by the kernel:
>   - a software flag flipped by irq_state_{clr,set}_masked()
>   - the hardware state flipped by the IRQ chip's irq_mask() and
>     irq_unmask() members
> 
> When ipipe masks a level triggered IRQ both states were updated while
> during unmask only the hardware state was updated.
> 
> For the 4.4 series this is not a critical thing as the hardware state is
> always updated. Newer kernels avoid calling the low level hardware irq
> (un)masking infrastructure by reading the software state first. A
> imbalanced IRQ state might skip IRQ masking on next IRQ entry resulting
> in IRQ storms.
> 
> Backporting the fix from 4.19 and 5.4 to keep the IRQ software state
> balanced.
> 
> Link: https://lore.kernel.org/xenomai/20220210153313.2229625-1-gunter.grau@philips.com/
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  kernel/irq/chip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 83dee72e6f0e..c33953e39055 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -797,7 +797,7 @@ void __ipipe_ack_level_irq(struct irq_desc *desc)
>  
>  void __ipipe_end_level_irq(struct irq_desc *desc)
>  {
> -	desc->irq_data.chip->irq_unmask(&desc->irq_data);
> +	unmask_irq(desc);

On 4.19 and 5.4, we only added irq_state_clr_masked(desc). Why taking
the full path here which includes hard-irq disable/enable?

Jan

>  }
>  
>  void __ipipe_ack_fasteoi_irq(struct irq_desc *desc)

-- 
Siemens AG, Technology
Competence Center Embedded Linux

