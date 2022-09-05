Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50068.outbound.protection.outlook.com [40.107.5.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3E87E
	for <xenomai@lists.linux.dev>; Mon,  5 Sep 2022 12:55:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dH8Privmf4uXIqpDaJ2usjWTlkW683NVPJCnnFg66jYec+q+8VFgRizWaNkTztxATWdLdsyPCYikKArvPIZbZ4XB87AHOgzYYKjIlqZZILSpQYuhpDWw25XNDQDrgrZUM+U0vweLWIbix9gcfIsC6uLzX7auqSFuKCNQBEBMnsE3scYTHyz3K1c0MnqiefR/OKthyuiYdT8TJ+X3H5fvAFR1lDLsZirMVnkBGGtkBiIqP6RbVdECvT/k80dQPo9lQiqJ2pKtNPNdOEXo6RB5px4v9s3QvRzfXeKdxt1WPEoPz2HhmmBFNU35gGeAKxxvuGbSwrwUey4N1L0911kogw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oL73w28cvpi2n7vWTxPBgnLrcN+W+jwHEO2HtO00THI=;
 b=JgAZ9glM0EtXxdwuHQV9z9wEXUmYLEDUI3BnmPjrCErQZOXtvQ9Gd8AD0o5SaNSJ+EZ6P0go4DsUAd27ia4eD6/zHEgl8nI7//VcG6s+H/9VaXQxK/dfdIZ+r6nUgsdozEuD7SOP8BRD16KNPOl3QAhrayaKk8tQ4K+akQRTDZTIGlEj7zXiKjv3V4aICc8t6AmysNuuG//txj4SfipJWj/hjLlm8my64nhHkKTHaqx0fgMd49YrzTbNGlGJ4Tm1n8opk1qAVLkbNs/pgP1CVJnF9DoWlcyN13Xj5I0riyYzYsSONhjP7u7alPV2Xt0Ytw709qAmvSuATKNn0YRvUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oL73w28cvpi2n7vWTxPBgnLrcN+W+jwHEO2HtO00THI=;
 b=eLmLwRYYvzs2Eim8JvgNBRhHXtGw7pkvB2jTRTZcXGVDWWCTtt69Sf6saBeAxh81zddWRfUxo9ykUyR1H4gPDXcae0JuThz5HmSOCEyL36u+0jG4GvnTM+2fh8oRNl4bj2aSuxupdotUsv73kGVOhvr/DSmeW/EPp24FwY3cTj48BpYq1VQARlpMFXTLjuD+C2K5bAPGnoqhSaJWgVTK4EfzuZOINI3QSbJLzHgaAthbUvSbvQhrxCnbCbkB16f6T4GOAp50wYrvDxu8Y8R60tXhIoj5CCGeoYnxB3fyOvGYqX2vbeZIRTi2OxhGignlGdUcwc4jgCFNOh7fw5oNGw==
Received: from DB6P18901CA0022.EURP189.PROD.OUTLOOK.COM (2603:10a6:4:16::32)
 by DU0PR10MB7408.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:443::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 12:55:24 +0000
Received: from DB5EUR01FT084.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:16:cafe::6) by DB6P18901CA0022.outlook.office365.com
 (2603:10a6:4:16::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Mon, 5 Sep 2022 12:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT084.mail.protection.outlook.com (10.152.5.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10 via Frontend Transport; Mon, 5 Sep 2022 12:55:24 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Mon, 5 Sep 2022 14:55:23 +0200
Received: from [139.23.79.104] (139.23.79.104) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Mon, 5 Sep 2022 14:55:23 +0200
Message-ID: <091365ae-aa8d-f732-8716-92f53e044f60@siemens.com>
Date: Mon, 5 Sep 2022 14:55:23 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [xenomai-images] [PATCH 3/3] ci: Add compat enabled build and
 testing for x86
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, <xenomai@lists.linux.dev>
References: <20220818073113.19382-1-florian.bezdeka@siemens.com>
 <20220818073113.19382-4-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220818073113.19382-4-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.23.79.104]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.339500-8.000000
X-TMASE-MatchedRID: EhMq+2gclHs5QaOxwNGfvo9bHfxDWoibjLcBGoH1uxvylEfNwb6iLaKR
	kGOW2z9yb/1uHmr1EmpMEnlUJ0kvxf0q3GPWZeE6j0IvV7jlqDjIdJYmCmU+qYC3+Rng2NqjMDm
	YaN/e0lZ9y6OaSLZZAgN06QRaBqZ4+cb2npDIK0VPklatje1aJncYbeAdGHHXXmFVlObh0PxBfk
	JWKY0KaQrVgpI9tRVko8WMkQWv6iUD0yuKrQIMCAGLeSok4rrZ0C1sQRfQzEHEQdG7H66TyH4gK
	q42LRYk0x1MBy5MpbjbxlJciK+tt/1eGZB9DWmQY8Cdd0kIAR1+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.339500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 698E5F72847E9613ED6D218C48389D591E41456D1F16CB24850ED647F0D2C2F22000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40ba94f4-c944-4040-f09d-08da8f3de638
X-MS-TrafficTypeDiagnostic: DU0PR10MB7408:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7Dg4mzMCxRqFRnSKzyyxNEdDaT7TuqLW6CcKOEEEhf70d1P8zGyiUa3XHFoElS2i7Y//VRsOdi7pkcV1XNYHCD17c9f2VNF4mNucexgRAaCFR9mAqnQxS4NId+/dCBzTGZQVlL57mKBEN/vB6scnP0HsQjA/sTDPPiAi+4+bus2lF+3NxvLOEuD2YsVjGe16XMFxs6L5VjhAnsbVqPY3p9IpqAgL4m9N1+a3KfACR7cJLxKiU9K/lAaU/iIvUPTSPSbBEsEPkvzLzmGEWS4xQjvTymxqs3ObS16U+26mWl4GPP9HHbWTQOWXZm6AdX5KyeAtdftw3BBEh1GTIGSrSwzV5CQV8dlIqIvBGj16MOfTdUb/wt6E26DePBFhVGTYDfTpV1JctpuRZdEpBcqyJkRbn/KBmSUVa4sxu82Cu8FbAWBwRnR1lr6L0x1kae3AHsBpCI1/XisJiy8fqu1AFKZmkNWh3lnEyOCozk+F/jdSTQLoRJJ+Kvq9dK+f5WdCc7CEgB8Bug6oXdQEUth+54/9MfPM1D5os0q84MIZ6yWQvBUI16Be9p9AkW2YrEePCwrguH85KoML+ZaNQxinI3PrjqRzEcMG8Iy/+/cf8ed5mNHqmJ8Fuy9ksCMChiy3qWj05LvZFILKx/FKYkZgN68ZYRvz1A6j8g6LKtby42ip3EavVJnsPdWs4gc3YQpGEZ96PWpHU6RAfWK/LRV0v+neMcSoZfqXQcQx0kC0h6ShBKQ4MpOMVviwh6Ut/SM7P5RhppDfO5fqLWKb4WWkJveLibArlloKwoMKteHyelqbXzkF2IpIg7JAYELmWMIyVhBCd5FmYBNSPmyeDFO32g==
X-Forefront-Antispam-Report:
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(376002)(346002)(36840700001)(46966006)(40470700004)(8936002)(41300700001)(40460700003)(26005)(53546011)(6706004)(31696002)(316002)(86362001)(82310400005)(16576012)(110136005)(36860700001)(82740400003)(356005)(82960400001)(2616005)(186003)(16526019)(336012)(956004)(8676002)(4744005)(7596003)(47076005)(70206006)(36756003)(31686004)(40480700001)(2906002)(44832011)(70586007)(5660300002)(478600001)(7636003)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 12:55:24.3881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ba94f4-c944-4040-f09d-08da8f3de638
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT084.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7408

On 18.08.22 09:31, Florian Bezdeka wrote:
> Adding compat enabled build and tests for the x86 architecture to the
> CI infrastructure.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  .gitlab-ci.yml             |  6 ++++++
>  ci/xenomai_next_compat.yml | 41 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>  create mode 100644 ci/xenomai_next_compat.yml
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 58398fc..b972063 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -43,3 +43,9 @@ next:
>    trigger:
>      include:
>        - local: '/ci/xenomai_next.yml'
> +
> +next-compat:
> +  extends: .parent
> +  trigger:
> +    include:
> +      - local: '/ci/xenomai_next_compat.yml'

Reverting this again (not only because of pending fixes for Xenomai
next): Can we fold the new tests into the existing 'next' stage please?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
