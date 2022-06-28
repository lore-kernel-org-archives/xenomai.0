Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10080.outbound.protection.outlook.com [40.107.1.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205E57A
	for <xenomai@lists.linux.dev>; Tue, 28 Jun 2022 08:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDR+yStesbIapLXigNEyK9lY/vo9Tsw3TmuT/MBNXrN0MXP2FQTywXZMj9ELtTpgHHNnA+m+MsqHHPzqxk8St8b07AdwRRS0V/UtATV3y7miFOYsmfgy5wp3w4oNvDnbrwLXABr0GwVvjEFoeerYqoh/pAn0KmkaYkg2bTOn+OqDCezK84PBtO4B1ImQf30XymbuAQNGh6gwQVeZBpE4HV0umBpMpyM0ghu10GYXZDCzR0sT0Vgmxp7R0M3rE+4XaO6lRcjjNjajd2rNxcV09O7WcpIoKhUczzAg3UUckVkMswmYoV/DCvzuWUUHzC6C8hWSsLwt70VbDnl4//vo2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cllCYcYWs6BA5na08yGveVn+jfQ7nZO76GbgyRtKw7c=;
 b=OYRwcTXDxd0VjoBTg55baDlHjPVA4R7y47U4j/9d5tuFZrg7BQ6wwjAx/zASP5hVQKGja7ddfjKXiUf6t7bN//Hl9qWIMB/bPIwUAdXuI5uumqcS/Z7FybcY+ZQy6vvTCf9b52CaP+f94gZr2c5M/36KYBcmjhmj8JAnculd+mycB5Q1BhmOKXJp3c4a7eJfgQn7fnogsapuguLKALjwsMw/qGL/0aO6sB843aKNb+ZVtEvSAAyikI8oL/Qplpehtd0UhAD4AQlL0hHiPeVqLEQ+js5Gb66u9+0cQJUUwpiSCiIEE69MKJdphRz4iPa3AyfEDyRH//dlwraE+I87Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=philips.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cllCYcYWs6BA5na08yGveVn+jfQ7nZO76GbgyRtKw7c=;
 b=gMUhmXG79fV+Kial9+rVv3cmkGInB+fBb5sBPbv3dIMnyj+b/G5BnX6dc4yAYmMN4MBXcupvQJx27ig6EKeti0cN5aBh9JVTVrLoD/XQz5NDZd53NcA65oV44XVYPvAfs82TP2wJWURfw0BwXiRVPxf7pLlp4n4ssymBfkLf1Wxoe9g4E5rldsWOHHdYpsNuEMq1ZFosIXjYIGjriS9XkiXGCbLbjxDPQz4uYa7mNi8yKBVE8Pga5r9KmA2BB8UK0qkhhN90FbtzmUVAUg2Zdziu9UaEpjIAmjbiHvvfvqC0N7yHWS/I93Q4jYQr2raKd7IcCbke1mn00TohWlahSw==
Received: from OL1P279CA0054.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::23)
 by HE1PR1001MB0969.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:70::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 08:40:54 +0000
Received: from HE1EUR01FT017.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:14:cafe::1c) by OL1P279CA0054.outlook.office365.com
 (2603:10a6:e10:14::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16 via Frontend
 Transport; Tue, 28 Jun 2022 08:40:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.70) by
 HE1EUR01FT017.mail.protection.outlook.com (10.152.0.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 08:40:53 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 28 Jun 2022 10:40:51 +0200
Received: from [167.87.37.192] (167.87.37.192) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 28 Jun 2022 10:40:51 +0200
Message-ID: <11b10ed7-043b-6f37-a186-53b7d57a1ccc@siemens.com>
Date: Tue, 28 Jun 2022 10:40:50 +0200
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
References: <56f788c9-f7c1-a88d-6018-c5de0aaa3a76@siemens.com>
 <20220628080113.2527683-1-gunter.grau@bbl.ms.philips.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220628080113.2527683-1-gunter.grau@bbl.ms.philips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.37.192]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.149800-8.000000
X-TMASE-MatchedRID: Cc2Ao8tLfKDPhQMrvkSA3r6YI58LYP7EXKlUkWaHqwvx5KZMlKYS/SeH
	MCGC+irnJLfQYoCQHFYjWgEz6moKERVKopMi6WfjV43p01DwjZX9od0tzzCKmEUzvZoSFxuNyWx
	Pa/RwSU9eziy/2vLIY+Bq0yNOt+07k9/YVsv2kPVZyLN0Ehx8q1mxlmzmINeW3nHtGkYl/VrzZK
	DA1/pIrjcQcUZK1ILgUx7kGWSmvLut2gtuWr1Lmtr+D80ZNbcycGCkjn3GWnaJkf5qQgIh3Vqhj
	w5mlQ7KlAFH5WviIWiyl1phL2htxJcskeOj7yLTtqjRmi7h575Nfs8n85Te8oMbH85DUZXy3x1Y
	Nh2+qangfCfWlnNb/1cppCzPq+1UOwBXM346/+xZVIZLzeVex2WOwB2MkYDlsjzumKnmF++g5+n
	5ukO2OyPoSwAkCKjn
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.149800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 9B2146B7DF8B2FB30497E9A2DA3D6D228573422013F9926B63E30D59FA343A682000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dab3604f-3ff8-4505-9821-08da58e1e9ba
X-MS-TrafficTypeDiagnostic: HE1PR1001MB0969:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5H2FPCgxenhWgkuXhXsRnfHi7HIluWtNgcyHoNf0gbtZVqvIhfoccY0kK7bk7MOEKsRdHKjrKQam5DczL3FQZ2CwlKX/XvvXWDkTxaYMwTqDzcYOopU3/qbKEWb+t/dXT/jPN8bwoGbLf+0zdsV8WChLwHfPthD2Rv9Gb4S2wuxwXYwX21jCBEeME1r4wkIlikpR3MpEiP1H1V/WqGR6hJw+yRmt4V4kOZFeePtMd2bDPXxRPsrQzJmvdK6bI5dw8cjrqG+qKA30yBD+FFaP0wTLaCzlfGW+yR/OKTSUNABM5I/JQQ0bTFCRqB1huYVHHEP3dSVvZi/+jtDrfAFs3u9SCBjlaYCJ5kQ0u9yKRpnF4YRhqLVfdf6z0bYIkwCspA4q9+ZA4BfETTGtJAzCTQ3vYIuIS2Gh22LH2ikhnNGl7VGCRcqragED9mPCuOyFv1WGZXCHbQ9yrzIMRehbaRD1Ob/chm2hQ+xxSw6HdABkalBbRREXsYu192iZyedBW8jRttu0eqcBeiLZcdKoMnaO7J72krA7JBYQxkha7i6lN8mb3jvLYpabZP+nWPVlbZLZIakfd8Ls8mU3HbsJiDQI602zdMJQm/BuACwsdS0A87LyP0azCC9PGyALSe/LWsUNfNW/raiGj0QbXW+BRnRml+FoJfyMpKdzahD0jdIaiqgXHgVHANcAEQe6W2hMvPwPQFmZah2nan+P4N4Fc77Oxh54cOeKu/49WP73blwM3IoJkTKdrsydbCofCWshT12Vx7FuhSqjbSnFeHiZudQVrBcD3cBPKx0ksftrL1PYALk/NXh+bJs8tfEz2H8k8BswNPlE0rfvZ3bRx8tsuqCsruM/eCZCNObU7V6fXJc=
X-Forefront-Antispam-Report:
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(396003)(136003)(40470700004)(46966006)(36840700001)(8676002)(83380400001)(86362001)(53546011)(26005)(31696002)(82960400001)(40480700001)(16526019)(70586007)(478600001)(7596003)(7636003)(8936002)(44832011)(70206006)(36860700001)(5660300002)(40460700003)(356005)(110136005)(956004)(2616005)(36756003)(41300700001)(6706004)(296002)(336012)(47076005)(16576012)(82310400005)(31686004)(82740400003)(2906002)(316002)(186003)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 08:40:53.7771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dab3604f-3ff8-4505-9821-08da58e1e9ba
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT017.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR1001MB0969

On 28.06.22 10:01, Gunter Grau wrote:
> From: Gunter Grau <gunter.grau@philips.com>
> 
> When compiling C++ programs with e.g. std=c++11 compile switch the
> compiler refuses to understand typeof since it is not part of the
> c++ standard. Since Xenomai 3.2 the atomic.h header is pulled via
> dependencies also when compiling userspace applications.
> To keep the possibility to use higher c++ standards use
> __typeof__ here instead which is also accepted there.

Looks good to me, but your signed-off (Developer Certificate of Origin)
is missing here.

Jan

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

-- 
Siemens AG, Technology
Competence Center Embedded Linux
