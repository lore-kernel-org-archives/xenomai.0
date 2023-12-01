Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2081.outbound.protection.outlook.com [40.107.13.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA161F934
	for <xenomai@lists.linux.dev>; Fri,  1 Dec 2023 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="NXsc2qjl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4M81pTBeOzy32AInBjm+O0S2KNSYhuHFLqlBWQcWEM0vn/rVvFebDObqngrqhipoaaFLzE9Lyp0o+RlNe2xli31KV8ffa8++MJmve/wNwReQxJ5tj9ym1Xjqu4so1do6hws/9DxGmLRmZdtiS++cHcwtJ+4dKX9siM6ICRS3terbyGTe1kajTgKf4aa4YgIFZG/TuArxyIhdKyovUNtbj5GRsMvh7KHFNj5eOa2xYqBFqm5iONR7OPJ2VYzb7O5Xv20bRX16zXgkMzGBtzQhlfIsKuvCET9J3iEP+7TZ/SgR71PaksauRIYoQtzfxppDhLyzvLW2LlbMoydGmcoCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3jrkeSI3YiLcR7kkulRnMdfmHulfhxAKv91FcmmRws=;
 b=dOG4vkxPdaGXIl8kD3WmULdKjbkimT8WRj/L4S/sw0AQYfZY791+XT2yX19BsM61of7WOdTt0ExFlI3Nxv5FcnPR4hfdmXx+WLBfAlBetbGSADfvRPPoY3zM2m+h1zURP7HCx+mIhav4xoQgx+sFMaYS/PUXjPwzTGaAEViHET50JaX0Kij05J753c19QyIKmiooyMfh927cwju1qwUyv5bG1H5YQuECfDrG0/LjxbtcOUHZIszqlHLjsY/qI/huHUmcSh0jBIMkYdhbPZzrwr0YP98h/vWya0jOuMUiY9MIWSj+DMO3h+jqGW+y4FOUCZn8O5bh2KhHi7Z8X73V9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3jrkeSI3YiLcR7kkulRnMdfmHulfhxAKv91FcmmRws=;
 b=NXsc2qjllctdYzVxBymLpjqwZrF6HGKYsIGdLWcy8WRvgxk/kRF9vd1JRVfYYmBLCAAboZeEPiH4ELYw5rFGvqKUQJxidL7OlC2acuSbYZnpgkcfvNTlJDU1tGZfumH+mjfsvywEyb6kvtzIsuORBanOeEplmyN/nv3YvM2UuB2VLPt3DjzkSsNLT6Ss4aXxYgqryGZmjGKHHVVIFZN2hkq4nHd6t3jx5/inXuyA/nohmim5GT0wH8Qnlr0w08rNCKG+WPB68a83gCm0FVQWXQ8guEtvtTxVViSGg8QBsK1zY+gLl7L9JpanAX/EYC5pDfjmVC7d1nJyIym6upmJ2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7460.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:425::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 10:58:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 10:58:47 +0000
Message-ID: <4f50d56e-c574-44c3-810c-1b5236ee724e@siemens.com>
Date: Fri, 1 Dec 2023 18:58:40 +0800
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] linux-xenomai: Fix recipe parsing
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:404:14::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be77ec9-3cc3-44f5-7683-08dbf25c7e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KuTCbpTvneEykzBjcit4E09XpCoyp3T8Pwd1hcWW6QrOhSaux21tpONQmyNg6s2mn+sWD0uudmlPj4AB3D5rxdZLPi1KFvPI0DpCjb2D4FhXIxpC1k782AzK8x7ErHaTSDt13MLHmFHYMy3T2BTJW9VCfZsCc9h/F2rUCUjNkSm2hWS7gQqYVq7tW6M0jldlzM5SfMFKyP9StRxzqRXfDWwzQAXjJwoyiL4s63WYlQWiAG+GnLF877GX0ASsCoAYfHZpq5nit5+k5HzWDkliYySDwDdPYPtRQi15hagNZ+OYnsjZrw4jteqrta06/d5fn/H9BfPSXb6QWq9YgmQ55GsLXWEsNpCIptlfIyI/yOe3pObbkIlR6JVthc642MFGYnDNWjUbW58XHPMANlH9I5Rr/2AfARN2y7fYYajJ2wUM/HxtNCwqfVXOilEtxDWOeNzp/N6vLqTomvzHSy1ZbBQEjZApYAz9TC8Yw9xyUzWL7ykB/N4bgfxHA315UmpzsX0W80awH6Ag94LXeGcDSPflFJcRIOjHr7PfgdkI4H42eytYQd8BVGJAQc9xahYP0psiopbxEdr1UE6VtRm3gyg/SpPIf4i/kz8HenBeFQBg3Kwhwe3v0dSl6IvnM1GbolAe2JKHIQb8UsSJog0uNQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(86362001)(6506007)(26005)(6666004)(6512007)(2616005)(5660300002)(8936002)(41300700001)(4744005)(6486002)(478600001)(44832011)(8676002)(2906002)(316002)(66556008)(66476007)(6916009)(31696002)(36756003)(66946007)(38100700002)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eENCL21FSXI5L0pWNnZub0laQ1gvdGd6R3k0eU5SMEFLV3cxSzJLMWRCZnZn?=
 =?utf-8?B?emxYNDRkWlpBcmUzaG81LzFtTHRkMnh6Qlo2MHNEWEhkN3I5QUR6NDBQZGtM?=
 =?utf-8?B?QjZ5ZjMwY2xXc0pwZEdZV1dtUm9wYy9vVVZ4OFZPaXJLLzhiNDlKUVZaQ1N5?=
 =?utf-8?B?WnBrVm9rMUpaSE91WElEOXJ6RVB2ck9zNmViMlEzaTNkelB5enVhOFZiaVBT?=
 =?utf-8?B?N2dueDIwLy9pUWVpSHUrVENLbGdVR3FIYU5rQWFaWXM3NTFkUE05SjYyNEpa?=
 =?utf-8?B?WmlqTTVXeGlOd0dabU96SWlhWmtYejhrdTNzdVAyMHhxWDR3ZnE4WnlwTy9v?=
 =?utf-8?B?d2tXRlQ4QmFRaURFcTVWeDFiMlBYUlY1V1EydTVGMHZQdnJzcFl5UmYvcm1z?=
 =?utf-8?B?bFFNS0JOVSttWHN5WDJsQ0NDZFM0ckFrbG5jMVVOQzE1VkROWEkzQk5PdnpT?=
 =?utf-8?B?R3pnR3QzT01IVDNpdVhQWm9TZTlzSmhXMU1yalNKTFFBVVdVNnFGRFdPb3ZF?=
 =?utf-8?B?TlNSNWVTUXlOZTcyQWpSVkVuenI2NUhlUStxNnprY2c0RjQyamVrNUt1d0du?=
 =?utf-8?B?cUlCcHFKeFR6a0NRYVZjYTlPSmx2ODhNTnJQVjIwczF3OW95dHZkR2tJQVY2?=
 =?utf-8?B?NlY5RW11MDhlS2tjMHBQY3Vnbi84bGRwbWpXaW9BSmxmakMxOEtrOFlHenMz?=
 =?utf-8?B?N0VtWVFmQlRPTXNpUURUMTB6LzlMRWN1OHcwVlFGNElDbWRUYzdpTW9LQ2E4?=
 =?utf-8?B?Z0RWaDNsTkRCRUU4cytzMTlHYzVmV2ZFeC9nY005NmJZWW1pdjBhYURVd280?=
 =?utf-8?B?QnA5T1kweVhNTTBUZmZDZlUzdWdEbnNiRWdqYmlPSnRvWERaVXJwekVjOU9j?=
 =?utf-8?B?M2w3WWxWWnliTWRDcjZscDQ5RkxUenlKc29jdmlITG5WOGUrdkJKTUhvc3Fj?=
 =?utf-8?B?UUxuQlY2Y3N1WkRpQXBhS2dzR09QakwzQmFydjRXUDl6WlVWbU1FU2owKzU3?=
 =?utf-8?B?OE1XRXYxVk1MWm5ZdUsyVmpDNHA2WVk1cjNaU1N3Qnk1amdwTWlzeGo5TFl5?=
 =?utf-8?B?eEd2VWxQVFY1WnV4QjVqNWpuYmhvQmhmT1prYkFnUDd2UHpXWW1qYUtHK1lE?=
 =?utf-8?B?YWhvbWsraEpIbElMUGhsZ093S0RHRnptUWoyY285a3hxSmxKeHBnL3NJaFgr?=
 =?utf-8?B?U1lkcTF5NjBLdDVhZXJGU1pnN2hSTHlJTjk5em8yQlpuZzkrb0ZWbHJPSDB0?=
 =?utf-8?B?VDVqb3NRa1FRb1NGWi9iSS8wbDVhUkVLNy9OKzE1cldNNTUvaWN5S0pGbytZ?=
 =?utf-8?B?TE90QUtMKzMwcXNMV0ZvdlBXNEpZa08xdGFHNlhzS0cyS1NpVmVPNjREYnhF?=
 =?utf-8?B?QldjMXlidG42Rkx0c2szT05rRm1PanNNUjhHaGloSHBCWTY0K2ZncHFEUGlP?=
 =?utf-8?B?TWE4dTViMkhjblRYOVVjMW9nU2VGcFBodVhIQjFBcG9scUpsNVIwN0NsV29Y?=
 =?utf-8?B?cktJemJ4WlQyYkgyVTRjUTlPODB0RmwvK3Q5V2N1b0dYMGk0Wk0wU21tSWxQ?=
 =?utf-8?B?c1RxdzhyUjFWSTl4UStpcTZGWUJNSExFQyt6K3ZIZFI2alpLemQrRDV0ZFJZ?=
 =?utf-8?B?bGd6eUdVc1hwV3pIaUw5OE5HQjVCNHlmOVEyaGh3TURwMmE5WVRWV3VTdXpV?=
 =?utf-8?B?ZWV4SmF6N21ZRWhRNnhrY1VZVXpZS2FqN1BMcE5zWTdBc3U5VDN0RFg2WkZZ?=
 =?utf-8?B?SXNRK3RkVThtY2puWFNrMUN2UE1EWHpRVW4vbEdBV3RKaytDZGo1eFh4aFFQ?=
 =?utf-8?B?MUdBazZncTRESUNuZmcxYlJZZjF6bk9meTBMZVhESllxV3RuUmlpd2xocEhx?=
 =?utf-8?B?YVhoUnB0SnJsS0YrMW1sc2E5djNpeDBmRmRyUjY5RVVabHJ0Mm14YnMzNm1i?=
 =?utf-8?B?TytKOThSSktNMmhNTFJSRWc5YkVJUm5ha1NRdjFSb0svSkdsOGZWazM4a2lr?=
 =?utf-8?B?dlBob281eWEybXliTTAvYjBCa2Zpak5tV2ZsMGc1cWZaZ3M3Smx6bDBybnJx?=
 =?utf-8?B?bEQ2ZXlieUoxWnJ4L1pVamtxY0xUTHJNVlY2TDQza092L1lrd3NTRkZ0dFVs?=
 =?utf-8?Q?5haFV9F/d9G/SOKpBV8eR+ufI?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be77ec9-3cc3-44f5-7683-08dbf25c7e0c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 10:58:47.2469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PlpxVvnEZbmr4qXMxY3YsMLXLJyB2Kd6BOVfQk1ZTid5+QAjzzPySyBYWh8rVamZNX2s1a06k5ajP5uUtWV+Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7460

From: Jan Kiszka <jan.kiszka@siemens.com>

When selecting a fixed version, we fail parsing the latest version
recipe in weird ways because LATEST_KERNEL_BRANCH is left undefined
behind. As the default repo is linux-dovetail, initialize the variable
to an always existing branch of that repo.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai_latest.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-kernel/linux/linux-xenomai_latest.bb b/recipes-kernel/linux/linux-xenomai_latest.bb
index e5348c6..dccae5d 100644
--- a/recipes-kernel/linux/linux-xenomai_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai_latest.bb
@@ -31,6 +31,8 @@ python () {
               'sort -r -n -k 1.4 | head -1'
         (ret, out) = subprocess.getstatusoutput(cmd)
         d.setVar('LATEST_KERNEL_BRANCH', out)
+    else:
+        d.setVar('LATEST_KERNEL_BRANCH', 'v5.10.y-dovetail')
 }
 
 # default: amd64 or i386
-- 
2.35.3
