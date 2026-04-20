Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010018.outbound.protection.outlook.com [52.101.69.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D7B35A381
	for <xenomai@lists.linux.dev>; Mon, 20 Apr 2026 05:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776664106; cv=fail; b=rtHSpoVs4ZgAJ4QRscVuIOV5m4eC9IeyhLb3EUQ5++b5o1t0E07xy+pQ+XGLC8bxHcD8W1xG3jLGpIJESbEtY9/pGes/KVtcCYkUn1oh+4/6XRyTAibfwU8uKcU1rCsbu+RUFM6zjY5NE3oxaI+WN4OzLdwPAoKKEK1ITB52weY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776664106; c=relaxed/simple;
	bh=6d6eaUelNE0QcW7pIbH04Yv5qk+97F72l7LHNwLLxdw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VASFQ45jxMUea00W4826uS6RJqYkulHhcqRlTpzj1F87maGRIQriGgODXr7xBwN4k0ruQbqckjk+wJ+Q+7fyQHzlZstx1033kCCO1AkLtjVyejCUQCYbg/JPYRenWZT6P0x5c8X/hNYEGEbNwmbmP+6yZHs+L2frnxfFlo4lcKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=f2ENe5bq; arc=fail smtp.client-ip=52.101.69.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="f2ENe5bq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjaUv3juS7ga6EEVjR2SDmY4cl7DJjP8Q6qIj8i2rbKPVI124MPyXEXP2KhebDlHIon7s3J9MObdXp6DKX02mH6PGi31tpukqUS9kDKa8/3coleecb/C1tPzLTJuBrCKlQVszIPrBLOCj7HWm4OjrXFYpdbbAP5UNNm4p/+g1vWVorjk4GxAJS7Acc/zg30PwqcrYfxjTr0MdNVs8eWpQ3uhwhtKcH+NMmabswh6NRJRmGIkKiwAFmJl7jDWp/mL8+ypoIy38PQW3GxCwQDWw9cBjnIV0n4lG6JVVT8TqFMqMz2MEOISLTIhHR0IudKi3CwXj2tdaucp2FbcPpD4Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVogv7zvBpSjL8XhV6Pc31i2LuutZlD+b8yTr23mSuw=;
 b=pcPgfQQXfji8RQqS12kr7z82sjRiXZ5LzmiLO8EwvdKBiof/kYtXL3cJGcF6SVYQeKaSEgThvvYnW+ZBrtPSYc8reVQz6/yxiCiLx6J8a4o9a9QeJ98GhLi8RoJiUg4hfaTYd8SQNkk04Ay/8W/7LAZilvaDffcxjPmqDFx89KL5k3aXuQjyYoCCE16hEnncGAjpCqmljBH4m7lchjsVVMXCqpZtQv2VeYEx1t1QS8mioJiUmXooEmjlhEUqqqBSINesdllMDNLj6I/raCGxkHfYgcTLkz3yYYGpDLu6KgIlQ/KMBWW/SDHDsqgV7tWTNQj0RDN9TRh93VNC6TJG6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVogv7zvBpSjL8XhV6Pc31i2LuutZlD+b8yTr23mSuw=;
 b=f2ENe5bqSMufbpr9f0j4weoZHOz6auQsLBIborWAhMN2v2V+BmXQsz4xOtGuMRRpLMun+IMnzyycvoIwA30/rbSa2hPRjFkfc8nb4PrC3ludqeiG6QzygBCtIiDF3JDcCasBqDEdCxO6MkC7h3ZPk4C8DgF03FVnxPsLqbg7/zZrPTrLpaxO3eQbNd+h/IOzOtZwT5eLL4t/e7YmAlWI3e+rrCG8tVIK+Hv47ok31xFGF0kd56NFM/gFZfHss0m8gyyJzeI57t7QAw8D1uwjva9cS5XgjyVjvWJoVax82X0HdGWEcrlmEJxbQAQmIwbIk/MNid//qMUfZCOJvSK2gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5516.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:271::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 05:48:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 05:48:20 +0000
Message-ID: <cf115295-113f-447b-a62f-0ecd8fa16ec4@siemens.com>
Date: Mon, 20 Apr 2026 07:48:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC xenomai-images 2/5] ci: Fix deploy script to handle
 multiple DTB files
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com, rpm@xenomai.org
References: <20260417205713.2290350-1-tobias.schaffner@siemens.com>
 <20260417205713.2290350-3-tobias.schaffner@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260417205713.2290350-3-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5516:EE_
X-MS-Office365-Filtering-Correlation-Id: 99977df9-7a05-441a-25cf-08de9ea06dc0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	M2B9t+OZB7VsdZpDE6cI3PMcrlr3rOHtG99H6R2RUNbqvDVYyK8W9NRO2eAX8DZtSbjXAV2Lo/JYYysACWe1m5639YxiCHhVB5wEowr1kI/FO1HwCuCzGLJeFcw97EENV3rqctcWWxiz2BFsXqFhIcwvbW3I6ieEhzAOOnl2Q9u9x80fytN4EeTStdijoVYlIUFL71vc0bR2oczn9WbyRGOZoXBphRgD0LOkfjl+ZZ9cRMSfDk3h6F7hQaXFCAk1QjcIdshBTkO/lGrbhijM49ndsXo2sl436q91VvHB0D/UWkmV1gh3JqbP4WymMml0VQfGa1aHbMixYY+nMuy1Z8xarqgsGqhsrjjFtXs3yRqTO9X8NUMZpoEzPM62W1ajWHJDECF9pjscvV5/MOP7or+ykLmLYVnlvuPuJcf9KKT185TSXnn98fHBqDO7S3E7jO30c7txHkrpYZbuMrdVPCSIfa5GI2vGprAnfNxc7UwMi4sIlW9w6TC2pIXLY5oj2k3HoypTzVBoS5NEXuhNrI53nPcTpjx+AnBp+klPMEcFRxjB1lpNFo5oRE12Dy0n1VX/wBNCQSqr21M1U3kGZWJ2z1bkLSPMEUwnuB2gdMfVb6YsPoXXtbsV+VryDndF5SKyYbnH7YE8THKSIQfDtYA846p+lumBjY8wjw11Lg5dQIx6dTDwz4Scq29sAqXj6m78Y/dJOd6/iysKnot5lCrk3ayow/nW+VM1nYO+yG0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0FJMkxVbStPdDNSRXJuMnNoZGd0Q2pNQXZuNVc5dkdBQXJ4QWNyV0hxUDUy?=
 =?utf-8?B?cVpFbmhFUEJhVWx3OUhJdnNzVjdEblJXNzY1MDBpUWtxN1BWakZ3MUlRdzdG?=
 =?utf-8?B?c2NKa1ZxbE1rUkQ2WTJLWW9WUnkzNExCQmtCTlJuWnJwNGJPRHJJOEdmbHFj?=
 =?utf-8?B?aG9hUGxGREFMS0FIS2VEQkhKeXlhbXdRU0tGUHZocUdJYlNNMTEvL2Uza3FD?=
 =?utf-8?B?ZldqWk5wVE8rc0hET2t1YnFWVmkzeWxZK0lmU2NUSklXODRTZmE4UklRQUtU?=
 =?utf-8?B?b0Q0ZWRhcmQzMVVKeVA2ZVZzVzJ5bU5ST2xTdU56cGxGbEFzaTZ1UjhzcFlP?=
 =?utf-8?B?eXVaQmNmSlViUVRtQWxMWGF5ZGRGdGY4bEhGQnAxMXE1bVEzMXNTajVQTkpC?=
 =?utf-8?B?ZlVNR2lnekZXSFpQVWlqT3dlWEY4RUFKN2ZUYkgySGZWb254bVdtU1BWejZC?=
 =?utf-8?B?QThWZVV1dUtvbFQ2NHVPbTdXMktjMnp3L1NxUDRJZDErTVA2d09qOEhVZkZI?=
 =?utf-8?B?Y1E5N2kzeEp4MEw2Q25DUXl6VHRmVFBXak0yREZjcUZYVlZPbFNENUFZTnhT?=
 =?utf-8?B?RE1LOXNRTjQ5VzRWeU8wd3hzVFo1RTdDemlqY0xuQTRkdzZyQ05IVTY0cEZm?=
 =?utf-8?B?ZjJVeDB1dzMyenZsQnVTaTVxay9QaktPR2laQ1VraWFLbEQzT1RkemZBZnFK?=
 =?utf-8?B?eWtpdmZXSndvVWhIUDZ6dUF5ZlA0cGlacFN3QzhsL0FEcS9DaGx2WUR2SlN0?=
 =?utf-8?B?Z2ZKL2c3ZTh2YmRoalhETmZBZG9adEJsN1NSM2hRZmRYVjdYVzd4S2NSY2Rq?=
 =?utf-8?B?QUFyQkdyMFo1b1hDUmVDaVpwWWlvaGU5bUZSbkVlQ2UydnVURTNNQWN4K1Z2?=
 =?utf-8?B?U1dpSE9SVWJHaXQwaGRVQVVvL1drS2RLbXpiR2IzRERvdm84T045amJCcE9v?=
 =?utf-8?B?aWo1R0RwSUR2MG9kMVl4elJTQ1ErQWZNTGlOa0oxajVvOVJqYWx1SnU1TzRN?=
 =?utf-8?B?MGR6bHdDbkxadU1rQkFZRExjUE0zSmlDVkRSYWI0bWJPMitsZFprVTduSmZn?=
 =?utf-8?B?SS9lTC9aa2NVOFJ2UDRLY2ptZU1oTTJvd3B6K1JMdnVMUFlYMU5mNWNSSVlp?=
 =?utf-8?B?WEtXbHBIU0ZJOUdWZFVuQzRpVGVUeWhEZ0VQSVdSUm1qRXJGY2xTRzZoNjVL?=
 =?utf-8?B?V0Mxei9Wa1JIRjNlSUtQbnVwWWMzRWxJU3hNSzlweURQREdTMk9BNmR1Ymgv?=
 =?utf-8?B?SmlpaXp5VUJmL0lCWWJGNWdBeEZlMVhPZEtWdEFORC9WczR4WVJkNDlVOWFL?=
 =?utf-8?B?QjVIdkh4WWJuRTJxNFhXNGxnQjFtNU5mWFloZkFHV0RQK2c2ZXM3bVA0MUVH?=
 =?utf-8?B?VWhZa0RqMENqaW9ZdlBSUjlwWmd4L3AzdGppMnJTR2ZNWmJBZXk0aUJGV2VR?=
 =?utf-8?B?NWw5eWcwZkhFVC9nWUM5TjE3QnQ1UFBaZjFNbXovK1BpMkV1bTBaczBrVXJB?=
 =?utf-8?B?VmVseWZ1VUdvSnJuZkhLcXFvRjZQNHVWT09FNDhWQ203aFJ2YnFhcHh3MXgy?=
 =?utf-8?B?RUhpMmFQUDRsSG5Rcjh1Mm9od3VRU0dOY042dzZ3SEhyc3BrbFdjeXd4L1NV?=
 =?utf-8?B?cFZvMFdSNG50eHRRYkJzZFJlLzRONmEzaVd1SXRnUjRZb2ZVNm43eDR2L0NU?=
 =?utf-8?B?VDdWK1lmM0o1SkRENGRDbnRMN3FOTVl6VExpYksrbjJTVXdJYm03c2xjYVcr?=
 =?utf-8?B?Z1RuZ1NZeHRIQlBqc3QwaU1CWWlPVlExRmxvNmdrWExuVk9SNjFQNENhekFj?=
 =?utf-8?B?MzF2L09wOWluclZYa0hpbnhDMEdDZ29RRjRNMk1SczZLMThVNHpOYVlOR1BE?=
 =?utf-8?B?d0lkRU8wM1NPUWFNU0VlZ3BtL2t5MExiK3B2cjVxUHoyc0hKeHlBNTAzNU5X?=
 =?utf-8?B?UmdPdDNPRnQ0OHE3alFQTkVGcUc2bUVEMDdqOEFSeitrSFQxTENSTWdkSEZa?=
 =?utf-8?B?WTMzcE1lNytxYWVVUXovdWJqVWlRWjU5R0xsaHpUbjhydTEwblo0L3Q5TDhJ?=
 =?utf-8?B?emFrMnFxQThIek5OK3FlNjdWT0I1Q2Q3eS95aEs1N1pZbWFWekJ2WWdMbmty?=
 =?utf-8?B?TkZ2akd0OERTNW1ML0VXa1JRZ0xXQnhWSUthZFVzZitLbml3LzZiTHlvanpD?=
 =?utf-8?B?ci9wTTZ6SUp0cW1WTko0VGlVdDJpTVRkd2VETXpTMlRVS3pDck4zOVRyb1Ux?=
 =?utf-8?B?WXRTZndieW8vSEdGeUhPdS93K25iMklSblZoYUdXNGZvUFlXQ3ZvOXg4cUFS?=
 =?utf-8?B?RksvS0tLa0V1N3lhMzcrV3ZNR3NaRVZLelVQWjJ5cWpZM2U2YXplQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99977df9-7a05-441a-25cf-08de9ea06dc0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 05:48:20.7933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECWUsATWMHmKC7icRJX7rwZZGX+eosJVrER2FDb510Ljh9UMcq6MIC6BFH+49oUo68+CE81WHHN0CJhnzj1kgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5516

On 17.04.26 22:57, Tobias Schaffner wrote:
> Loop over DTB files individually instead of treating them as one path.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  scripts/deploy_to_aws.sh | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/deploy_to_aws.sh b/scripts/deploy_to_aws.sh
> index 2e0ee41..6c9d8dd 100755
> --- a/scripts/deploy_to_aws.sh
> +++ b/scripts/deploy_to_aws.sh
> @@ -53,7 +53,8 @@ image=$(ls "${images_dir}/${target}/${isar_base_name}".*.gz)
>  aws s3 cp "${image}" "${deploy_dir}/$(basename "${image}")"
>  
>  # DTB
> -dtb=$(ls "${images_dir}/${target}/"*.dtb 2> /dev/null || true )
> -if [ -n "${dtb}" ] ; then
> -    aws s3 cp  "${dtb}" "${deploy_dir}/$(basename "${dtb}")"
> -fi
> +for dtb in "${images_dir}/${target}/"*.dtb ; do
> +    if [ -f "${dtb}" ]; then
> +        aws s3 cp "${dtb}" "${deploy_dir}/$(basename "${dtb}")"
> +    fi
> +done

Will soon need changes again when the Isar dust settled after v1.0.
Remains valid until then, though.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
