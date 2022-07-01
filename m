Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70059.outbound.protection.outlook.com [40.107.7.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCC93D6A
	for <xenomai@lists.linux.dev>; Fri,  1 Jul 2022 19:13:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fq4ayK8TZYjiMyxztbZg6LyRN2rHX7RTWig2rQkx6JdzHAbLMqTJtPAnuVv4bmm4uV0uh8syBnaILSWSxaAgDcSZSqS1YeFLEj+ROjPjCvYe4IU/f7euaHJeGd7uNWYB5wgyabKMjzWnbZEJMq6VW47hhxbuGtm8HWMeKP6fL1FnCzYHPLNMsPekL1Zw9wURBo60AwoJYOQB4uf6n+pX3A01/WvVcSSQC5NxpIHHpU2N1r9doAwgxBFJvdQyAspb6RC8dj+9H3HnJ+AljNcRpCimIjNYLnBXNC6z05jONn4DrdYLM/aiGYXULhyVRIX/O/bAERBuFVUQrSVgLAgqaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQHivLrbHm6KRM0or8FKzxZCuVN9ksSghbixsZZTi9I=;
 b=Xw/y0LY1Oh/nSrpaoJTCLiY2RDXC82DKtPLGP09e9UjHqMmOXJ+hmBrT4UntRxxlSWv/DV3GgZL9pYUKko8JpF9hyKHJIsGlMFDZV2k8r/rVrGXW5OK2w0iqbLsQbQ6R4D+90X5UkEjc6/Djiqqp8be14AVUVz0AWoV7j1YwQ08iJphLUkBFs75aOthLYmd6ScG28tlq/YGof+MbV78nEpJPlQ1G88vwXuNlFk8MJzgVGfnC36M2M3DQnPk6znxL0H5oPppkx/Q3p9IHf88x3izCJKLHGcnTawFQ1f/Q2bdAmmrXxcnhpYzTCqqWDI9ygxhCd3DRNAwczY2tgxQ3gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=philips.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQHivLrbHm6KRM0or8FKzxZCuVN9ksSghbixsZZTi9I=;
 b=CL76UT/TVtOusAlxKUfC/J+riu4LwNaTqsKdQD4CBd1MFm6hBUTbyPeuJX7Fb+VYv38aMBRGdBRB7/1CXPT0J3bkpN+Z2bMcSaLHRg7vxLKtAqRtwrLlR5BUDUu60p8qojJ5C6wj3Wi1nd3KA2bBxctYADpHx3oo50msYmU3o48S0B+i/1XeXsvaFdede2tGiZ0qhyn7VOgUUJnFCXgAtQeI6bMqxWcNGymG8TKsksfXmOICNDGiSkQBgIgsVi1exZ1vA55XyAYDlBsYCV6pre2Ay8+6eYFT67iYvWDEEhzjaC2XmECvT00bjsw9i2RPNqk50a2RZSETjMZYYvEdgw==
Received: from AM6P194CA0041.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:84::18)
 by VE1PR10MB3007.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:109::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 19:13:22 +0000
Received: from VE1EUR01FT063.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:84:cafe::1a) by AM6P194CA0041.outlook.office365.com
 (2603:10a6:209:84::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Fri, 1 Jul 2022 19:13:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 VE1EUR01FT063.mail.protection.outlook.com (10.152.2.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14 via Frontend Transport; Fri, 1 Jul 2022 19:13:22 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 1 Jul 2022 21:13:21 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Fri, 1 Jul 2022
 21:13:21 +0200
Message-ID: <e9cf335f-3885-e6db-a731-a08358616fb2@siemens.com>
Date: Fri, 1 Jul 2022 21:13:21 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [Xenomai PATCH] atomic: Use __typeof__ to be compatible with c++
Content-Language: en-US
To: Gunter Grau <gunter.grau@philips.com>, <xenomai@lists.linux.dev>
References: <11b10ed7-043b-6f37-a186-53b7d57a1ccc@siemens.com>
 <20220628110253.2577276-1-gunter.grau@bbl.ms.philips.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220628110253.2577276-1-gunter.grau@bbl.ms.philips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.504200-8.000000
X-TMASE-MatchedRID: UgbjIbm2QqbPhQMrvkSA3r6YI58LYP7EXKlUkWaHqwvx5KZMlKYS/SeH
	MCGC+irnJLfQYoCQHFYjWgEz6moKERVKopMi6WfjV43p01DwjZX9od0tzzCKmEUzvZoSFxuNyWx
	Pa/RwSU9eziy/2vLIY+Bq0yNOt+07k9/YVsv2kPVZyLN0Ehx8q1mxlmzmINeW3nHtGkYl/VqWOD
	D/yzpvdwdkFovAReUoaUXs6FguVy2Wkqk2IvguWn8IK1pvqzfu/crq95lCYLCOtWfhyZ77Di6My
	Pq4TWG5tsxVqq1TeAWSLvAQjXykCkGPbm3tak5+kZOl7WKIImrvXOvQVlExsHAruZnjhopuylNX
	FsiN4FpJKW4mDlJsMSAHAopEd76vZvS6p3XiWGSnLkmjFXvAHiGeDDnuL87NQe1yn+CKAvyx7bJ
	Z6d11ug==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.504200-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 93A4D7ED9CD7DD4071BE24DE76BFC579D25AA1D786A19E2363801A67FB2452D32000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fad212b-ab81-433b-f68d-08da5b95c404
X-MS-TrafficTypeDiagnostic: VE1PR10MB3007:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	56mk+KnL00NhMn+0PhgJKRtcVXLEmjiICEpmVU/5Ve2G5rCY7ydYpYNM1jBZpDL2tdX56I0Ypr1MgZGrablIrSz5py53sw9EV+k4RfduIWc4b6eIKaoJy6eIGQ9iqMdj05DWxUTqaz7snhIq6C/xh46h66g6VTwLCvhXL+zHk8Gmusgb4E/FeQ3WCF78Yi6SQ+xlVbWaC0Ih1Yg/D5XtjWybuZJsm0xJfqVeSftHZXtBwEtKEvDkf9lg8vSI3tKszhYx+DzJLqio5MkR37x0zo3dSwWDYJx8u9b/4h0++QoLIfxR2xRVtGQXpV8JeZT6Ah5OowYFZNfRBp5ah8CyopCQnamgSE6BjDMGbEqjDkidkHNDr0yl6/D0vnoenvgJmUCFXr6LnmfG7MWddFZUSjhLmIixvFF1p9c5ocbtu9XcWIaRhzT/MqE/lmjoMXtpz+Cib27ei4k1K+IF51MtOskH7Q3G+FIo2WYLaRHyLeL3qZGgN++M4S9xuQ9O4rzT8fqhEuwCt5CTKdWfNZuGDpW8xIve0b7XD7Ozw4xfyA0O5OGqF+3xZvdcgeLrKM4SIKdGzIfM9At1HPpwknuV8i/OQB0sgfIeiadxnWd/ZaKfs4XNuijaKqx8uMoRYHf4cskLRzuLepNA0yND2jL/ysjO7JzigPKyA0LZ5ZXmasZjD6nnQj/cqLvkrFy3j920gaea83jLfm0u8l7h6bgHs9ZAo0D3pir1xzvzqWickEWPG+0+8LyxfJLhTQMlvbOeLErba5/KBEmWsaXrbSgPHO45i75cG/yzuurDnsLJWEnV9wfGlWAGBOBWSFuWghA1I/QJEb66PQtHQdFLXD9uBPFHdFnlKXnoI8GnOUET0KLGcUrmIuwY/mc0UKDwSdigDaiBldstURh0GmL/nWcg3CnF2eej0CnBeoKR0gIi0yQ=
X-Forefront-Antispam-Report:
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(376002)(46966006)(36840700001)(40470700004)(41300700001)(2906002)(44832011)(47076005)(82960400001)(356005)(110136005)(82740400003)(53546011)(86362001)(6706004)(336012)(40480700001)(82310400005)(296002)(31686004)(316002)(16576012)(81166007)(36756003)(31696002)(16526019)(186003)(478600001)(40460700003)(83380400001)(956004)(8676002)(36860700001)(2616005)(8936002)(70206006)(26005)(70586007)(5660300002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 19:13:22.2792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fad212b-ab81-433b-f68d-08da5b95c404
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT063.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3007

On 28.06.22 13:02, Gunter Grau wrote:
> From: Gunter Grau <gunter.grau@philips.com>
> 
> When compiling C++ programs with e.g. std=c++11 compile switch the
> compiler refuses to understand typeof since it is not part of the
> c++ standard. Since Xenomai 3.2 the atomic.h header is pulled via
> dependencies also when compiling userspace applications.
> To keep the possibility to use higher c++ standards use
> __typeof__ here instead which is also accepted there.
> 
> Signed-off-by: Gunter Grau <gunter.grau@philips.com>
> ---
>  include/boilerplate/atomic.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/boilerplate/atomic.h b/include/boilerplate/atomic.h
> index 731961e3b..4ee5f3930 100644
> --- a/include/boilerplate/atomic.h
> +++ b/include/boilerplate/atomic.h
> @@ -78,7 +78,7 @@ static inline void atomic_set(atomic_t *ptr, long v)
>  #define smp_wmb()	do { } while (0)
>  #endif /* !CONFIG_SMP */
>  
> -#define ACCESS_ONCE(x) (*(volatile typeof(x) *)&(x))
> +#define ACCESS_ONCE(x) (*(volatile __typeof__(x) *)&(x))
>  
>  #define compiler_barrier()	__asm__ __volatile__("": : :"memory")
>  

Thanks, applied. Will also push this to stable/v3.2.x.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
