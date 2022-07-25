Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70082.outbound.protection.outlook.com [40.107.7.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3914F2106
	for <xenomai@lists.linux.dev>; Mon, 25 Jul 2022 17:22:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/sCf9HeosQ9wHLgBbFPfFbv6ENTOiKL6k3lJ+dwMJ6lVRTvd51s9SKbdWLSieycjrUbbL0KxAz0IdfokPB9BEZwnGbopUyCl461RVD9e0Gh6cRAq/rXncIEfyNtlehiAi/5z5d5meSMpyLg3jBW/O4hMSmj1G83+/KnXeYvP8pPfNo8SIsSA6BKytAOHdxmyMZ1emNhPqDN45/q0Gqe7NDZmfgxa6MlByTfMJ1I1GsVqnVdbFe4If2xRNdbTQSO2zHqSV24yp9unCZb5Qs876N6YxQqsaqBwb/gKQVfd0Lu3IHlvYjvCHTjRivMs+858cDYZYcptpBtObJN/XzqCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhaAEGiKoLmE0867t00tAzgyTWHDI26gB41Poogw3Vc=;
 b=clToVRTbDB764Y804V1Ysq7wo1D40UWnl25ebFUJGPtEiRt0tj+AFz88FRTiqeSO3WR3TDIozl6ORgb5Wgw9Ah9Aj7AhoyNc2jslFZpzOjPf+zm71dvKdKTP465wyyfKdRQA+hrWq4MbHVsV35uIggPyX/NdfxgboZlkZfB87tlWpNHjGixxjn38CNTYSfxfwvR8y6dCL6l9pqEZbP4+4VElaOlDlRL8HLBAhZDnkCtX6qpiMGL/ZjoMyxbQ2K9lhThe9fO5C4eMesMGplWvowc6p7HRPyzQCTCO+BiOIL24sPNUTRpSguSuCDzO8/xx+8QydKUDagf34/wyGzkDqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=gmail.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhaAEGiKoLmE0867t00tAzgyTWHDI26gB41Poogw3Vc=;
 b=RTFvOFTZEO2BWevi5+8geY4WU00n+SuPuQZi43XfvCDVUlpMLjD/Rpqkpd2yP9vt/ve7bYBjOSdKN5UtRCMradIf4GZh+rU0xKZ4aS0r0K+v+S/XdsYcexsAcWM+YzptLrEi9jtT+65UH5o6Je5/9Sa0X7E1X5729Eh7bq0RYJqBZzikCq8vSrwGixBR6IigBRPWtJyrtgSW2X146AnCvPmgqQrtUxH/eN7rZaSy4ZVj+znRws6T4vGX7MLKbc0k/sMeEiS7pRF1G8yBvVMo0316EtfAeXk5ErFcMaX5O/r1D0p9lD+ejIPeL4p3MIAx/vzbuNUP6FwNclkr6YFrdA==
Received: from AS4P250CA0020.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::9)
 by AM9PR10MB5066.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:435::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 17:22:09 +0000
Received: from VE1EUR01FT049.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:5e3:cafe::56) by AS4P250CA0020.outlook.office365.com
 (2603:10a6:20b:5e3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24 via Frontend
 Transport; Mon, 25 Jul 2022 17:22:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 VE1EUR01FT049.mail.protection.outlook.com (10.152.3.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.17 via Frontend Transport; Mon, 25 Jul 2022 17:22:08 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 25 Jul 2022 19:22:07 +0200
Received: from [167.87.41.187] (167.87.41.187) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 25 Jul 2022 19:22:07 +0200
Message-ID: <17cb9146-1ee7-ff17-c7d9-ba59cad6e292@siemens.com>
Date: Mon, 25 Jul 2022 19:22:06 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] fix build with clang
Content-Language: en-US
To: Norbert Lange <nolange79@gmail.com>, <xenomai@lists.linux.dev>
CC: Norbert Lange <norbert.lange@andritz.com>
References: <20220725084231.8584-1-norbert.lange@andritz.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220725084231.8584-1-norbert.lange@andritz.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.41.187]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.132300-8.000000
X-TMASE-MatchedRID: Am/bhnZHfiMepAyha3ctZsU8jBVxKY1xPg9yfk4YC0bece0aRiX9Wlds
	bGTm3zYnzP9LEqj2YnhAHOg8qEtqyI+pAn19BHXO1NYOJTtXRe3EXBl0pJu/Jkcp08JfWWIeVC0
	UatNKNpmPY0JsXGr/MWWA+UQsexZZheDJAd6wrjIvHEcEx0NzujLvC8LxRzod9u1rQ4BgXPJ9LQ
	inZ4QefL6qvLNjDYTwIq95DjCZh0wmBvd3Ao2uOgtuKBGekqUpI/NGWt0UYPBm0ZZteavTE4tEh
	IHHsFbLFX0V1meLQ3lNtBNhgiGsqFqwxgxViRpo
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.132300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 171751890FFACBD40498F60FD31B16000837D0432646D785B94E4861B9109A9C2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f439265-30e9-4eba-6737-08da6e623430
X-MS-TrafficTypeDiagnostic: AM9PR10MB5066:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0UWIAZucvxozJzXuf38n9ty91j+Hgavs3pVfrBh4xvMe7bSf+U8/y57q+Keu5hM30BAJa9ynCPmEEvJmflB5mCF0eT7/9zrKW7/kXp6lkclkVNFFqGuapTZRYVmS8IBKcrF330V5mn231MoVQNvQj8kEsLHHRRqKxCBVuNU3L/6EDOn6VppUb7hKJgpXLlSYZem6S8ab7u3IpF2SecN7AQu+hw6dZAOnekVZYQpZf9YxnHrxidrsQZgGtNi0i8lWSFs4vj8P7IDqr4BjBcCv5NuQMd39gWpeo6NlbIHactM0jvS2OVlwGbjLfZS6Jj/e371MXgezstPSZJgR6+taxoN6U7glH3Y1HAOb1jHbn/RQfC/NgJ4tsOZILIZEIaGPKNOXGmieDTAb1FUsMknR4M7i598d3E7GAeC9qqwtTSfJxgZi+S6P6fI7mkKXDqrP1JQMRZySQTLBurIFSBLXDtAZlSmVg4a8XDmySoMVik9auuTh1ZDgAIkBzSzIzs2Zg4Uo5+tRjKmNNQTZ/khSTSJm95RixiDcZqWPGbZm3Ls0p78bI07n8hKOqm3NbVsB/0NVYmqGOay0tOFWFkpAP6kDFUqGp78PsqpJcVurKhz1G7RSAS4KJXpO+jRllEOh8drn1Ca41sF2uIkPPkvaj5adHDKfW9YLjYkiykDW+dY571zDx0FSbtHaGS7TWBpbOFR/cdeEM4Nn7dZr066QtxmyzZh0MYUpppuUYMKqESHpZT6cKsQUsBAMTzWqWxQbWLIf/4E8ou6duHAxwajC1kbLXqP/Jq0tDqJqxhNSTGmTMJPQj3ONKjqXCc1AQJ4txAbLyuHtZYWUrcpR5NzyRks/m1I24Z8gdPlvZX2fp8wva1CFcl7Cs34auPnd95pHMK1Ea+rr923L6YHxMzj7Dw==
X-Forefront-Antispam-Report:
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(346002)(396003)(46966006)(36840700001)(40470700004)(81166007)(82310400005)(36860700001)(40460700003)(86362001)(31696002)(356005)(82740400003)(478600001)(82960400001)(44832011)(5660300002)(16576012)(41300700001)(316002)(6706004)(53546011)(36756003)(336012)(47076005)(70206006)(70586007)(8936002)(8676002)(186003)(83380400001)(40480700001)(110136005)(2906002)(2616005)(956004)(26005)(16526019)(4326008)(31686004)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 17:22:08.7159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f439265-30e9-4eba-6737-08da6e623430
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT049.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB5066

On 25.07.22 10:42, Norbert Lange wrote:
> clang will never support 'variable length array in structure',
> and there does not seem to be a reason for this weird construct.
> 
> Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
> ---
> v1->v2:
> *   fix algorithm
> ---
>  testsuite/smokey/memcheck/memcheck.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/testsuite/smokey/memcheck/memcheck.c b/testsuite/smokey/memcheck/memcheck.c
> index a33700f49..b11d2babd 100644
> --- a/testsuite/smokey/memcheck/memcheck.c
> +++ b/testsuite/smokey/memcheck/memcheck.c
> @@ -80,9 +80,7 @@ static inline void swap(void *left, void *right, const size_t size)
>  
>  static void random_shuffle(void *vbase, size_t nmemb, const size_t size)
>  {
> -	struct {
> -		char x[size];
> -	} __attribute__((packed)) *base = vbase;
> +	char *base = (char *)vbase;
>  	unsigned int j, k;
>  	double u;
>  
> @@ -92,7 +90,7 @@ static void random_shuffle(void *vbase, size_t nmemb, const size_t size)
>  		k = (unsigned int)(j * u) + 1;
>  		if (j == k)
>  			continue;
> -		swap(&base[j - 1], &base[k - 1], size);
> +		swap(base + (j - 1) * size, base + (k - 1) * size, size);
>  	}
>  }
>  

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
