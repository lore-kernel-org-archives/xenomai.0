Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795529280;
	b=0ojPCwnXECSSWy07LRXMV5JVgWNyLVdEeN2Z+pF9ThoXrx29TSN1lhsRUyjgn52OLzfR
	 q5vp70dudcqWPqr7b4DSp+8OKa5wrrI41y+BZLxUxekaA1dgHiJE/htchwxjSloISyQGp
	 g17O+PzfVc7XwkrLBloLCtVPaViQ2hBTFxD4FGqD4s01PGPAUKfm3Y7yVMAZ4wYhrK57a
	 KaB+2sJSBh7K2shkhtp2xgKpKuVzrciLN5KGDxjgBEdcdnhxw3xZg5akUWiMNJtHkZUIp
	 Kru04+QJvyiH1r1x88hONdOg7VCEwBwwnFiECJzzplchNhnULQntd7yJNPwZwZ3iqaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529280;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=nDCHwo2F1gENB76ULz5rVxFcnar9HSLnbyG3oMMAVrc=;
	b=fwqQmZUmwmRj0heC88UEcM+fP07yqmiKPSvLEOa/WXJFlNoFL8qPDkVCxi57XMEtMuzi
	 iVxVgdwiMStiNnpcxgzW1g5DXINB/EdLns1j75cnarDB0tZR9atc8s3p0QwjVOBjBcsOU
	 lUivNbJ++JxPaHJeVd8H6II4fI3V8yXGvTxI1UmgdJVGRBtlnOwkbxMmw8Kr2mmX47jIA
	 iIfEV0mSGh85oL2z6ImARXZKryZRR6oRcrgVcLZrd9Se6ym3jivnKjh8Qa7S2OqxMrFzk
	 1qpSdLof28mtbjlthgL8IRRCciWJd1OB+khkveIneb7LChZj7htVPZ/F6QR3T7nzqWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=df6xw1oT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.69
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013069.outbound.protection.outlook.com [40.107.159.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8843B606A33A
	for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 14:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8843B606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=df6xw1oT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KE3RD+auEa2FXsMRkDK4067v9+tckDs/G9FQ33FseRM1lUetulEoxX99v5d60x3RPPjcbgJVyuglpt83YWqwxygxGzPy5jjbSYLPH8buLlWM1tvKI/f7/W17mSgmooS78vqP5SvHZZQuoB21fuu9GSRpmR401eo3azJ+UN206usVW9HrlQO+5B6+G9eKjRFQO7jgS1mTqlZxvwdXXjuNUglXkAFBKZWJQQqzWlvk42ADnn7EJnEZyoBTPS9KQTWFYhomp4Soz31/SQw+nJdMhN3HeCy3+LBJDgSNltAUGVEK+b9Yngkmay2eeOq1KDboxQ+PieGpobzzejGX1XXfPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDCHwo2F1gENB76ULz5rVxFcnar9HSLnbyG3oMMAVrc=;
 b=BHd4Xi2V2llcva0z1fC2lCaKwljJd4cZXkWvzth9V0JQ705hELWin18nik4+94qYzUd/93hzGumbtADLps3jMLVO0N0zmV/siXUV1X0yewqzxPVERq1p4uH/gsSJk9YxbXShKomjIyvaTp94FMtIbD8Y59p0/el1U2ANvXmMWitd3qM6s8BBPGZ2Zhs+gYTjQI7LkJjTsIVZh7LNedXc64qRnexnhKhfZ5Me+h2M0ptyURbwoJTm0c022StvM0h0O2pogmhpIanSoaw4J9WdGB1ww5YNbCA72qQjJk+KwAGCGjOCSt9gdvGz2jU5DnX66bUE6szXSNZst44gUGAVsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDCHwo2F1gENB76ULz5rVxFcnar9HSLnbyG3oMMAVrc=;
 b=df6xw1oTEu77wslGrEAdcw7XzY1V0Eg1aY3JEToIAi1ASE2ARTAuedKYwIEtE3Rmq5f+mcJpWX6m5SvSN7stKBhWYKP+05M4a+Q5rBe72TrBZVUKe/8COl7A5JDBc4Tm+vfq9EgwSNjsf5cy/4ZYjqFtDt9rwl5jyMVADn5tasrMjn7Ep0DiqgRP+19LJEOPTmsl86jHofRGCVu965sT8E8C3P4Ujm8t2TSKmoltYoDYdOgVdF7KwEtoe82pPj8wbuQpqPJcJlwMnyjwXVFR1wSdomNaTidZfkpj4mBhczeTL9w8GKne8sWlQ/oWXpHMWlHmDm5eqy6jjYNVMZteRg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PA2PR10MB9080.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:41e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Tue, 24 Nov
 2026 14:07:55 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 14:07:55 +0000
Message-ID: <bbf9d784-e2dd-4747-9f66-8d88a205f16a@siemens.com>
Date: Tue, 24 Nov 2026 15:07:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ci: move downloads cache to S3
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>, xenomai@lists.linux.dev
References: <20261118144737.635199-1-quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261118144737.635199-1-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: IA4P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:559::11) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PA2PR10MB9080:EE_
X-MS-Office365-Filtering-Correlation-Id: e6294e74-5b4e-43a9-776c-08df4a34561a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|260925022911599003|260925021311599003|56012099006|10067099003|11063799006|260925021911599003|261021121427099003|261026140227099003|261028144727099003|261022115727099003|261026121527099003|261102123227099003|261021123027099003|261022075727099003|261022105027099003|261009223027099003|22082099003|18002099003|6133799003|55112099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Ghl6NrnUgATOYiaakuuhi8RJxRB82EIHWPHHQMERBGPSC2ZclKVQaax1GHTLUx4ZOpYxR4lx3anmq5JkyMGxoztphQ3stFIAMvH91dKWbLBp7uTct+27ncaIDxGeKEBcxoRLagDLL9Mqp78ZzzbNM1b7usEb4YVmT6hhfPWrOVKZ8K6xXuoSiZwA41WIH7TNCyRVt5EIxAKfLl1/wyc+UHi3Gin+H0F4hmTdkvqv5nN824H4exsv8STxWp+WU57JLYRX1nSkgu22M/DCOzTbvUWWGzFKmwvYq5q1nfzQjiDbksuG3rFxSfIGoA9Rj1MmgsoaKoFjH2DgYPlRb3v/nk1usbU4d6Z4OmlHsCrH+eZT0s0Ilf/dqSHMFfWtQVHgnrWOiLLaAtal0H7P3haJSitWF/VWmumBkUPobbiw1skPGMRc/Mrf+GSw4o/OAA2dlCwsfcp1vBp93qSu0O8WMrfxP5voETRPsyv4MARdbkKBKserJXBMBybrzH+IUzB3lvGnsbF9EoYTEupd5Gm12MaGB+rnYGB8p1QAdiw860xsvoF27v3xZ4hrczQpKgTsaSMukLumjVt+YL/ixiHZNEByXttJLxv17I7LzE1tJL/gd2rGWcb+gIixbIPd8pnHPFo2HW09TQP/GBnySV4jG4/udeNob6PneCx5NgJeWjc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(260925022911599003)(260925021311599003)(56012099006)(10067099003)(11063799006)(260925021911599003)(261021121427099003)(261026140227099003)(261028144727099003)(261022115727099003)(261026121527099003)(261102123227099003)(261021123027099003)(261022075727099003)(261022105027099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(55112099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3JnM1ExSEwvZlpjcC9nUFRwN1lYMVJXeTZUUUlrTm1adVoxKy9Sa1diSzJP?=
 =?utf-8?B?dmdyM1NJeVMzYVRMWjhEcUdoTjEwK1dvMzhWMXFGNzM4NEhubDVFOWRnQ1V4?=
 =?utf-8?B?TWtHNTR1TUZnanJFMVZIa0NsOFIvRTJyOXRPTkhtWnJ6L3VGaFVRRVZ6MkVn?=
 =?utf-8?B?ZnZ1dVROY2xGRDlmczBoMmJvajY4QUNEOWp6T0NWamk1UzRvUWM0bEEzNDVX?=
 =?utf-8?B?bVZTOStqQitBcjhwN24zODkrN092WXJidzlHaHF3NUN5aW9vWjgxNjJHa3dn?=
 =?utf-8?B?NU1YVFVjN3FnSGZzVXc2Vm42b3B1UkhodU5lYytXenJReWQ1OVFhMGZ0U24z?=
 =?utf-8?B?NnJPaXVjcElGM0lEQ3p2NytpeDBFYWcrbzhUSUtaSWVETm5sbmw4UUwyeUMw?=
 =?utf-8?B?b21DLytCRjRJZExsMDk2UHlYSmpLZmwzbVc0alBSSjlDRnA5S3JycFFRalRR?=
 =?utf-8?B?eVRpaWJNcEJld09GNmRCRmRNd0E3NEhHbXg5VTBSa0E5RmZVdmw5cUNCZktv?=
 =?utf-8?B?MDlEZ2N0ZEM2SHpvZHYrSjBYNFdoTDBNUjlTczJCYkRjc0ExanlOY3R3Q3Bk?=
 =?utf-8?B?RFRTYndqNlZLVSs0QUVRdkg0c051OHZ3c1hIUU5JRURTL1lFK1A1amt3NFpl?=
 =?utf-8?B?WG1Ga2lpUDJ1MzBZZU1IcVFaOThwUGFxRitlMXpLOVRVSkpieTkvMmRld2Fv?=
 =?utf-8?B?cEwxV1A5QWlETVZHbXFBYXhNY3JwMkdac2N2MGVLODA2aXA5NE1oZVNtc1lv?=
 =?utf-8?B?L1dPSlpGbFo1UXZ0R0RTbXdZeXJUc2xlTzlqdDRqQWtlaFI1YUY0VlIzanVK?=
 =?utf-8?B?TGhVbXJ2TWpuaisrNzRPTGNHR1lQUExxYks5SGxNa1dUSmpCNC9VT1FwVWhF?=
 =?utf-8?B?MzRBdXRqbVlHbFJiZzdRcHBVQzNNMDR1TVBPTm5DSzN3M1FRdE80MGR0SmN5?=
 =?utf-8?B?d1hWOStJSy9vTlhzUy9oUURNWUYwd3QwYTFNRWlzOWJ3MWUwYU9QejJnbGNn?=
 =?utf-8?B?ODNaNUh0aXlzTk9ZSG5iMW0wRFNCNk85UHp1bGkrT1NKTDB0TWhCdVpMQWVP?=
 =?utf-8?B?Q2FKYjVXd2JZVmp1Ni9lWmtVOXRqbmZnZFNVdFBhYmoySCszeXBnNG83OVRh?=
 =?utf-8?B?TDl1RDhVL2pXcGMzWk80cXhOR0x4czlsVE9CbmhCdC9Sb0tNNmRSbUJNWXV5?=
 =?utf-8?B?dENTbHRuVDJpelZaSGZPVDFhS05IcXFFQ1JJQWZOWnFMSkIwZ3krU2hQbU94?=
 =?utf-8?B?Q3BQQWN4UTdrVy90SzQ5SUkzUkhjSW1yQVVoaDJabGxPSUppT3NGc2V2alBv?=
 =?utf-8?B?bmZXWGZGcjJ2cjJyZnVKd0tVb2JqM0V1bUtWSjVNUEZ4Qk5zd3NjUkduenNp?=
 =?utf-8?B?Nk5tM0wzUkJxL2p0SGlYc2tHbUpmNUs5VGdrVnpYZFVMOTF6YW9GMHhtbmRp?=
 =?utf-8?B?STlaYUtWME5EMWZxd1EwckhUWWpPY0FhWnpQYnRub2l2ZDZTYTZYTDVGd1J3?=
 =?utf-8?B?MGx4YW5HM3VMbGVmY3l4TmVBV3FYTVg2d1dzanhpN00wYVE4VWhUN1IrOWMr?=
 =?utf-8?B?RmU2T0F0L0NCK3dsVFloUi80MFFhZ2hLQXQxMXA1a25IL2VWV0ErRXFiQUll?=
 =?utf-8?B?dkE0MTB4d0xXZitoQ0VtR0hQTFExZ1JZbU1WNnduV3kyTG9KbTlvUVFoWVlP?=
 =?utf-8?B?YWdLUllhM3Z4L1EzdGlzeTZFZ1l5NHlOcnhHcVNmb1RCVnRGRDhqTzYrREdJ?=
 =?utf-8?B?RkxrMVlSajJWTytTWHpPS3YyalRBZmVFRmFvejRzcnRuT2M4eE52Q3JtNks1?=
 =?utf-8?B?alVadGNrQkdiazNwU21YOUNVUGhoWUZZL1lMZXQ1THFMRW8rSzNlVTh1anRQ?=
 =?utf-8?B?UmVZakJEV0tIb2pKUDhPREhDbXdYNUR4QlZiTjIvcjdyN3BhWHM3dFk1S1g2?=
 =?utf-8?B?c0M5VjBoRExHYm9ONExNbWxsa2NPRVpMdmxuTTdhTUdsclBvN1Z3b3BuT3hI?=
 =?utf-8?B?dzNGZmtxSEoxaWp5cytzTEJONjREUWQ5aVN1d0hEYjFKbmZPdGhCUjVzQUlB?=
 =?utf-8?B?Unk5VlJOUDVCZzJTVVFlelVJb08xNk1QN1BvYzdqMDVPdCt4V3FlSHp0aVc4?=
 =?utf-8?B?QVBpVTh2YkJ0R0Q0QXBETkdkRkZ2TURDalBvNStDZ051Mk1iUnBQSVZqKzUw?=
 =?utf-8?B?L25kVUV3dzY2T2h4b1A2NUlvVDlxYmlRejRNMnZQN2dhU084WHR2b0hMdUpQ?=
 =?utf-8?B?UnlkZGRWb2VrcUpSdzNibWRlOW8yNTAxL1NoMjFnUFFKVC9NRW5GdVMyQzRS?=
 =?utf-8?B?WEFXeHp5NGh1T1Nsek5MaWV6NDJpTWQvaDlMU0puQk1JN1RvdnF4Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6294e74-5b4e-43a9-776c-08df4a34561a
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:07:55.4399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xbuzhc1HeJkz522RImcmk7KFylU/2jbuJlPGnPPbcRP6RJwkZx0W83GTtTJOfpg8nsECN13pEedY4ejCr5altA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9080

On 18.11.26 15:47, Quirin Gylstorff wrote:
> The runner's native S3 cache fails for uploads larger than 5G as
> multipart upload is not support by default. As sts access requires
> a change for each fork/runner we stay for now with self implemented upload
> script.
> 
> Replace the GitLab cache: for build/downloads with a single tar.zst
> per arch/kernel stored in S3, restored before and saved after the
> build.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> 
> Changes v2:
>  - clean update remove unnecessary code
>  - add comment to multipart upload in commit message
> 
> Tested with https://gitlab.com/Xenomai/xenomai-images/-/jobs/18136100219
> and https://gitlab.com/Xenomai/xenomai-images/-/jobs/18136323078
> 
> 
>  .gitignore                |  1 +
>  ci/lib/gitlab-ci-base.yml | 14 +++++---
>  scripts/s3-cache.sh       | 75 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 86 insertions(+), 4 deletions(-)
>  create mode 100755 scripts/s3-cache.sh
> 
> diff --git a/.gitignore b/.gitignore
> index a796dba..c85555f 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -1,3 +1,4 @@
>  build
>  isar
>  .config.yaml*
> +.s3-cache/
> diff --git a/ci/lib/gitlab-ci-base.yml b/ci/lib/gitlab-ci-base.yml
> index 7e15321..3516ab3 100644
> --- a/ci/lib/gitlab-ci-base.yml
> +++ b/ci/lib/gitlab-ci-base.yml
> @@ -54,6 +54,14 @@ default:
>      - ./isar/scripts/isar-sstate upload "build/sstate-cache" "${SSTATE_LOCATION}"
>      - ./isar/scripts/isar-sstate info -v "${SSTATE_LOCATION}"
>  
> +.s3-cache-restore:
> +  script:
> +    - scripts/s3-cache.sh restore
> +
> +.s3-cache-save:
> +  script:
> +    - scripts/s3-cache.sh save
> +
>  .common-config:
>    script:
>      - if [ -n "$ALT_DNS_SERVER" ]; then
> @@ -71,6 +79,7 @@ default:
>      - build
>    before_script:
>      - !reference [.common-config, script]
> +    - !reference [.s3-cache-restore, script]
>      - !reference [.sstate-prepare, script]
>    script:
>      - echo "Building kas.yaml:kas/board/${TARGET}.yaml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:kas/opt/ci.yaml"
> @@ -80,10 +89,7 @@ default:
>    after_script:
>      - !reference [.sstate-lint, script]
>      - !reference [.sstate-upload, script]
> -  cache:
> -    - key: downloads-${CACHE_ARCH}-${CACHE_KERNEL}
> -      paths:
> -        - build/downloads
> +    - !reference [.s3-cache-save, script]
>  
>  .build-qemu-rules: &build-qemu-rules
>    - if: '$KERNEL_VERSION == $KERNEL_VERSION_WITH_QEMU'
> diff --git a/scripts/s3-cache.sh b/scripts/s3-cache.sh
> new file mode 100755
> index 0000000..ff66142
> --- /dev/null
> +++ b/scripts/s3-cache.sh
> @@ -0,0 +1,75 @@
> +#!/bin/bash
> +
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +# Best-effort build/downloads cache in S3, authenticated with the static
> +# AWS_ACCESS_KEY_ID/AWS_SECRET_ACCESS_KEY CI/CD variables.
> +# Usage: s3-cache.sh restore|save
> +#
> +# Defaults are built in; each can be overridden by a CI/CD variable:
> +#   AWS_CACHE_BUCKET, AWS_REGION
> +# Provided by the job: CACHE_ARCH, CACHE_KERNEL
> +# Any failure only warns: the cache must never fail a build.
> +set -o pipefail
> +
> +action="$1"
> +downloads_dir="${CACHE_DOWNLOADS_DIR:-build/downloads}"
> +state_dir="${CI_PROJECT_DIR:-.}/.s3-cache"
> +
> +warn() { echo "s3-cache: $*" >&2; }
> +
> +AWS_CACHE_BUCKET="${AWS_CACHE_BUCKET:-siemens-xenomai-gitlab-cache}"
> +AWS_REGION="${AWS_REGION:-eu-central-1}"
> +
> +for t in aws zstd tar; do
> +    command -v "${t}" >/dev/null || { warn "${t} not found - cache disabled"; exit 0; }
> +done
> +
> +key="xenomai-cache/project/${CI_PROJECT_ID}/downloads-${CACHE_ARCH}-${CACHE_KERNEL}.tar.zst"
> +object="s3://${AWS_CACHE_BUCKET}/${key}"
> +
> +fingerprint() {
> +    (cd "${downloads_dir}" 2>/dev/null &&
> +        find . -type f ! -name '*.lock' -printf '%P %s\n' | LC_ALL=C sort | sha256sum | cut -d' ' -f1)
> +}
> +
> +case "${action}" in
> +restore)
> +    if ! aws s3api head-object --bucket "${AWS_CACHE_BUCKET}" --key "${key}" >/dev/null 2>&1; then
> +        warn "no cache object ${object} - cold start"
> +        exit 0
> +    fi
> +    mkdir -p "${downloads_dir}" "${state_dir}"
> +    echo "s3-cache: restoring ${object}"
> +    if aws s3 cp "${object}" - --only-show-errors |
> +            zstd -d -T0 | tar -x -C "$(dirname "${downloads_dir}")"; then
> +        fingerprint > "${state_dir}/fingerprint" 2>/dev/null
> +    else
> +        warn "restore failed - continuing with a possibly partial downloads dir"
> +        rm -f "${state_dir}/fingerprint"
> +    fi
> +    ;;
> +save)
> +    [ -d "${downloads_dir}" ] || { warn "no ${downloads_dir} - not saving"; exit 0; }
> +    new=$(fingerprint)
> +    if [ -f "${state_dir}/fingerprint" ] && [ "${new}" = "$(cat "${state_dir}/fingerprint")" ]; then
> +        warn "downloads unchanged - not saving"
> +        exit 0
> +    fi
> +    echo "s3-cache: saving ${object}"
> +    tar -c -C "$(dirname "${downloads_dir}")" --exclude='*.lock' "$(basename "${downloads_dir}")" |
> +        zstd -T0 -3 |
> +        aws s3 cp - "${object}" --only-show-errors ||
> +        warn "upload failed"
> +    ;;
> +*)
> +    echo "usage: $0 restore|save" >&2
> +    exit 1
> +    ;;
> +esac
> +exit 0

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
