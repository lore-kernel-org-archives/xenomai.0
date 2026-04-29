Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011007.outbound.protection.outlook.com [52.101.70.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F066B35F180
	for <xenomai@lists.linux.dev>; Wed, 29 Apr 2026 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777465707; cv=fail; b=OWWl7BUUgtEr9mEG9l/DRX19+7CfqJGUkOjaZBKiS/Ycmgm/rnOVia40r6TdozA1aOErRLsBNdOSHlGWAyYf0xQM5EMFLzWTCsC9fH3YS9gD88SUD0ytfeNfkV+TwBSlNufRVfusO4nveNNPzr+JUSw5O8quZOhG9EN1V+Xjz2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777465707; c=relaxed/simple;
	bh=nGhDoWUTfVVZqCpbFrF7hyUpq3wCo3lsIvoCwRU+snM=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=tlwaT228Lp9rwNRIPNWtTNH1p1OeHilljjDrhN8zzBKb0E6lJd6S3DlmZ0p2OhZhYACEVTZCoXEv4o+ZlgypkxZolBQwk9hw7uJAAbe6iy8KQcFVeo2QxFN+QgFi/SexQSnIddN/l1BXvjHlwC0n3k3iwmJLW9ELbJL3/ckR8Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=aa1HO6Rl; arc=fail smtp.client-ip=52.101.70.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="aa1HO6Rl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iA3ojrwxZ/2rcD3PQpiebqNk/QRwYEoMCxF/gWezmJlVufDlNDXQxDkWsb9C6Edl9IC1iinl8Aglp322LfcMmsK9kpUwSrayZ41I93YrsuZncQIUPJEFGM+x2hHe+G9uvsCJodsC7JiUXN22083exYqkauCDblAwqpwtAo64dISOda3HjNrD3pRqhHJsywiOFdZmXmb0CQGf4Y2DJCMjhXdFVAN2BGqDr4wxeLtLtAcgmCScjko5uYGBAS6hgi4NoBphXHbMoGR3Q5gAn+UaK50hvJ1Qt1NsajhW/0zEObne6TEmFwMRlWp6gHvZHffwiTf3JPb0SOLNR2nmTyQXtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZolRHLY1rykqWcf9T8dew+x9jhyMvDhnLv3anYXUC0U=;
 b=lglV4wM61X0akZ5kIwKwS1OI6tpu7ZkuUqteRQVze29ohIHxRaNC+G+8d6OhxLXl0mxDbBDt/2xP6xqFtrEU2g12W6wBbglmIuyYXgTOOlsJk9jSoDBz13v7/HKOPXTWlRjw+6RD1ad87d6DbEQoZm2Q+fOeVMoWwnXEClIdlZo5dDDNeWnBYfmkyvmceY++V5morq/cHc6bifOoirtIVENR7QoIqfR7oJc5TQUA6Ee00ht59em65B84wqwm1gzMhNBdWcjPk5Jyk0nPyIzGHmkiqghhSyTpYa3hsqFcbvreQJhiEQSNtQQQeD0FT+N9e5P8X6skmQr78oyDRIOFtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZolRHLY1rykqWcf9T8dew+x9jhyMvDhnLv3anYXUC0U=;
 b=aa1HO6RlzT1jzrcKK29IV2qk5dPdiQc+Fq7KtBw7zl2Cs5V/W0SDU5pBKEeTbd6g9Y332anq1o6E9NvIM2caH4I7Dzcxq0wscUBDI/2u4/IadNnIEoN4CW7LSD1m3aWRXX6aEydjUeCd7bqVWuDzaCTC5l1zR4bx0T55e2A4tB2vXBNVDK743sETqxXZuH23s4x3vu/Jm0AxZWsL7ajITkAr1y/G/SE2WxCqbmhyLApehh55AW0kO7+a0L0utz1bztsjNIp7yfhGiV4z1mXb9foEvAD1DVIfOW09Xc36jhXllzHff/Rf5PkZXdCR5nMezFce3wZQZcmIkl+j9NCb0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7521.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 12:28:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 12:28:21 +0000
Message-ID: <4cd3b430-b5d7-4ec1-a86c-8c8b21e344bb@siemens.com>
Date: Wed, 29 Apr 2026 14:28:20 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] configure: Ensure we always have a numerical revision level
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0245.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c219cd6-9c51-4853-7c0a-08dea5eaccf1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|55112099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	vv1lD3WEetBu8s8rwFEYvTlB2HCxDhMpGrsNlmEVwGNAtZxRCS5SQwRc08xxy59Qm8mGON8JPhntRFdqbAatdsIkJPlv5GEjHz7zp5cD3EWhkpSkqL3kOPNGIV69aGV4VZaQW6TffaULpS84UK6e+HcFA2TYTWeFX4xVCuJi62C2KHTF58UCkkqt51CR+Sy1B8MtehpG9Nkx8LALEFqqVaQpsfujHPr6oQTcYlA9CSBosz1YxndBv8wBSC2ZDkRC0Nx+brPGygW3evbSGBcJEZDoPaHABj74TlMh0I7qAtnflqECuMLl56fT2XLIRqbechyr033G8/xxIPhBj381gWjls25+y1GxjXgwJ1ZAWQu4Q5uox422M3xVSbDFuiF/SUoB1zniMY2LpEnYMDmqF/sdMBOVbboS2DGSUisMrVPMd8axP+SGNwJ5bXahjS45XKzW3GQscTmUGP9nN9fMR4WGtS+1q3MkxAcpD7bDO7KSWKis9D6RgRWZBg4gRRF+mYqefok0GCJP6Qq1hVgHFmSw4wavMzrXChyOFn+dxXhlVKfGKpnwRJyRugTGrTwTShnnAJPQD7A9Z5o5dUg4nkGzzYWw98Vb1PRXopmP+O/4Ig8MSJic8cd4c+dKg7t+8J4nWHWytXk4QVY6hFICigSanSPwuvubUUY1oFYFW2F1iqwhsVEloJZF8KuXbW0CIWgC03WN88kIugNwWVPz6trd2/J64VwJxCEn69HFgOI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0g2cTZGOEg0WHJsdWIyWHRRK044ZTNGSnd0aXBsR1NsWjJGQnhDUkFYUHhU?=
 =?utf-8?B?UUxyWkxsajdwdk5McVhtNE1tNUFQTzBERGx6T3owc0d3V1lpK0FLcExrK05T?=
 =?utf-8?B?TzNyaGFoWFhSS2NZdnYzdXhVRjJVUE5pZkIramI1c1hKcEw3NVRvZlE3eVYw?=
 =?utf-8?B?N3FydXRRTmJHMnFsM2ZTNUIxd2tlSmYva3FlNFg2c1ArTm9GTVVwbDBjbWFY?=
 =?utf-8?B?dkdYa1BHOTgrMG5aRmtQeVQ3MEJCZkE0M1lzelAwZ2hnNUE4T1IxaFM1OFJ6?=
 =?utf-8?B?T2xEZ0E4d0FwVVhKZDJPZitrUzlpam0wOEt5NlpUbGhKOWkxS3I0cFl1SzNp?=
 =?utf-8?B?RGJJVm5ZWW9wQUhjU0tkSFJkK1FpdGp4dGdwM0djME14VGJGV0Z2MlZEKzJY?=
 =?utf-8?B?ejEyMHJDNEd1RElPQ0ZEdDRiYlZHSExHOUhFOU9CdDUxNVZjSTBEU0gyZjVQ?=
 =?utf-8?B?ZEx3UzVybjRLSnNRQ3dBN2pzTEFWWjNMQ29aaE91eVROU2ozTWIwREFFcjZB?=
 =?utf-8?B?VzdSUU1UQzlsdS9SdnFpTVRXeC9jWTdPUWtBYTI0OHpmTGd5MmFYUHFZSlhF?=
 =?utf-8?B?dStXdjlPZ2QwUWhmTTFSWlgxQTFiRFlTOWZuZmZKVGlCSUhobUlLaFdkZXhl?=
 =?utf-8?B?T3k2TDNJZS9BWFZEbkRzSm5nN3ZLZGUxUHVEd09YRXFiWTJRZUdBdmxTK1RW?=
 =?utf-8?B?akM0VklSTDdYb2JaOXpDQkJ2MlFBd0pvVXEwWGU4YTRrSExRbG0vOXpSV0FH?=
 =?utf-8?B?dWpESDAraTlWeXNDVXZiZGNoeGFzSER0bzlKTWtYN0xhVllXTHlZTlhUalhx?=
 =?utf-8?B?cFJSMlFvb2t4M1Yza0ZnQ0FySnMxekNzR0tNZHFqZngzN0VwZTVDWHRyWHI1?=
 =?utf-8?B?V3kxeXpHU2Y0UGZENVZzNHN0SS9vVkFTdElHcHo1MzRPdURrMUhHRzU5MUMr?=
 =?utf-8?B?MUJSRjdLRUtxSHViVDVLMHVjMGo3NytJQVkxT25zVU1sbmdoRTc4RlNDSkU0?=
 =?utf-8?B?NmhKb1cvdzlmZ1c0WTVNQS9mK25aVVcvS2RxVTFZRDJwOERoeER4Y3JoZnla?=
 =?utf-8?B?aVlIUVN4cThqRFo5aTRQY0VibGZWamRha0ZMbDhFNVRIMjlKa3MxVjhFWXp2?=
 =?utf-8?B?ZGNMczl6bXVMM0tzQ1ZHTlFVU1ZKdVIrTkpjOHY2NERyd0hNemR0aUdJNU40?=
 =?utf-8?B?Q1orN3cyWTYrUHVHRS8vRGljUWRaR0NEeFRCS0tObE9nVGpYQVlsM3lMUDdN?=
 =?utf-8?B?aTR3aGw4RUNhcVNmcVBxSzlaZFV0eVJFVlhXa2J4N2V6NXNqZkgyZ3VsOXJ2?=
 =?utf-8?B?SnJ0eGIvcXppaVhneFUweit1N3lNczBVRHpIL0hOYTl3blVNVVR0Z2EwTWda?=
 =?utf-8?B?R0J6TU9BN1VpbDEwSVdIa3BYb3ZRd1NQMXl2NWZWYmdEODJtazNKbVk0WDBn?=
 =?utf-8?B?U0tKNmF3dmRuVWlBWlh4NlBQT3dUMFpUZ1VsZklUaWNkQjZmT05GMGFkdE9u?=
 =?utf-8?B?NE1YcHFiNGlFUk0rQ0lGTHc1UWVFWXhxbzhCZkNraFUvNkRWejlseDB3Qk9G?=
 =?utf-8?B?SUdDajFoT2ZhSHlvSU4yWGhxWWNqeVhPcHd1VlkyM3VaOFRzOFRoUWxEVWM3?=
 =?utf-8?B?czJWZlFFeC9yOStrRUdWREFRYkE2K294bDB3dWVjSVU4M3ExSjlnMXR0NGNH?=
 =?utf-8?B?RWtiNDg1dFNoL0dvN2dPT2gwTkxiVWxsbE9KUWx1ZGxBeTc1dHdITm15ZXpL?=
 =?utf-8?B?YmsrZm16UUlNd3VuK24vY1lxQmtvNzF2a0IzQ3V1cStMT0R4QVFPWllRWU1v?=
 =?utf-8?B?a0JIWS9hN1E1bzd0WURPRVVUc1lpTXhlNVgrYmNXcHkzeGlKdkdWVUh4YW5n?=
 =?utf-8?B?RVYyY3pkNTZ6U2RCR003RGhjaE1GRmcrTE04RDREemFsYlJoMXAyeVZjR1Nr?=
 =?utf-8?B?a29ucHBlUGNVc1NhQ2V0WjRaWnBqTlV6Wk5Ta09jQ05CUEVhRUJpOXN4WU1z?=
 =?utf-8?B?aVVyT3VFdHgrZEo3bDRXNjdXa1NieGVMRGNpOGErMlRpVDhZT085UnE1K2NU?=
 =?utf-8?B?NkUvRHB4dzBvZ3hsWjFaWG01ZkFYdzBwSldmN200ZUdleXFiQVJoczZvRzg3?=
 =?utf-8?B?alQ1OXJFeFdIbnJVSVlZWCtYQkRzTjEyc0c2dXdPK3FWalhDUkJhWWVQSG9W?=
 =?utf-8?B?SlhpaE9ta1ZtWmZZQzRyNjJYWWJIQUNLTmpFYjQ5QzU5VWdXQ3VMT3F4b2Nv?=
 =?utf-8?B?WDZrSTNWeEFMbFI2Mzd2ZDlaTFBtMGxYYlFqL0k3R0xQRTd3QUx1Y1F6ZlRC?=
 =?utf-8?B?MXZQMkF4bTY2VkdvU2llVHVpTlhHSm9tN20rSFVZWi96K0ZpaEx4Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c219cd6-9c51-4853-7c0a-08dea5eaccf1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 12:28:21.4477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Of115CKSnKNWpffr6BAmwOo3Yx1nIR31cFuwGmjluEzlgp4FBF/bNLONW5s0K7+IMsiHdl7yhBQfMN0HAfNR7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7521

From: Jan Kiszka <jan.kiszka@siemens.com>

For major releases or on the development branches, we do not have a
revision level in version-core. That leads to an empty
CONFIG_XENO_REVISION_LEVEL which will be break XENO_VERSION_CODE.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 configure.ac | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure.ac b/configure.ac
index 22823756df..0d6dd87b61 100644
--- a/configure.ac
+++ b/configure.ac
@@ -23,6 +23,9 @@ version_code=`cat $srcdir/config/version-code`
 CONFIG_XENO_VERSION_MAJOR=`expr $version_code : '\([[0-9]]*\)'`
 CONFIG_XENO_VERSION_MINOR=`expr $version_code : '[[0-9]]*\.\([[0-9]]*\)'`
 CONFIG_XENO_REVISION_LEVEL=`expr $version_code : '[[0-9]]*\.[[0-9]]*\.\([[0-9]]*\)'`
+if test "x$CONFIG_XENO_REVISION_LEVEL" = "x"; then
+	CONFIG_XENO_REVISION_LEVEL=0
+fi
 CONFIG_XENO_UAPI_LEVEL=`cat $srcdir/config/apirev`
 CONFIG_XENO_VERSION_STRING="$PACKAGE_VERSION"
 topdir=`cd $srcdir && pwd`
-- 
2.47.3
