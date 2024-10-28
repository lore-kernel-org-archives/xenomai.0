Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DD41D5AC2
	for <xenomai@lists.linux.dev>; Mon, 28 Oct 2024 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730121427; cv=fail; b=rP5lnts0Botu6SKvA1AjgEs9iciQXWtnCqg1Ana9Kkzhrnzlw/gi+28Y53Xsb5CQXgpk0Hvsf0jHrrpLsGkyNbQbNEgbI5atAOmRBbyvwgecGJkX5WZPJVoWJSnoK0t/i+nyysy28NHbSA/z/M3sLcQ3hpm/nVt1Ekdctm30A9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730121427; c=relaxed/simple;
	bh=havcuTMYVH4wu4PO9tq1xaUko9tbwd/EUnKVu0dxTY4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NZ/yw0Tc4h8WQyDfuCs1FzbBYeJVNCw2BfhpW4iRdz5p7f+S+/VkydJ45zpwCYW/RkZl1yFoGwuNamrD5XJZGkI/uqQUz9zfcMG4qVHtNbMeaHVOreYUoACSpr21mO5EuXiY0WciWB/6kXp5pcB+e8QsQJcnszDWRLwoqKDIGY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fmkhanX2; arc=fail smtp.client-ip=40.107.22.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fmkhanX2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FgJ51dpvIyrUC5EX2hOcbfrW5joPHznSbSdBgZjaqseORSy6i+0KG0afe0DVS5xQNxj75D+G/im4elI+PMsaw6QJeJOZd2lCHdSNj0fP957rDf7fgawi+SSHeimZm/ugeqkAHi5IfuV1S5kpA5ebxBRD25p2PyIg2i9/gQVns5kY9hmsCgFV5p2WdTAf1IGiZHzQkiT1a+9qBKvnK0NjqTVW8720K7OoyjtEYvEPrGUb+XN71UGrUU4eoObjfrZPYWZuCymTzpqOgFKG8pwhjgZVTKUKPHEdmE9MLQ0JFJHW6na0NAiPbsfVnsU+/Lmq7WAvsbxP6jPsnA/lYr5mxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+nAcGzASg8bGDHdyTCNJ7mqK02Uqptcjm7vFwxLCiw=;
 b=qrK3j4k5wfa3ZS/YBkCvB9kEnhGojImSnWEktd2jbNZowzipuVJH/J5WFC6EoYCHUxgDwfxeUZXNqpctNet55651gyBFeSV84Pu2OLs+KBII2D6E7f1wbr7hBUvNy9UHT8FzLSiZMSEI+IlfnCIFDayGouxZxUjHXHoNhvjo67il7Np/+O1D45Zd0fLhbw1RjawfLN3R9R+eYe22kITbh29V2DE0063zIe6DzKXwYluQUnARoDNytXE3SY/hBJ8hM5nvegoX6LTUVmIDLE2160jZC8ePVx/q9nARRaYrPijifkAsVRypBLjo6ARRt9y/7jliyLgHVbm8pJIvDG/OCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+nAcGzASg8bGDHdyTCNJ7mqK02Uqptcjm7vFwxLCiw=;
 b=fmkhanX2b3wdssALnGJa3VAlmSKw+m+Bb4V+ANtY33fU4WXP9NwiYzfD1eUsN+WnPQ6LQOdrBekbpj99y+toMzycZhssE4RYxG8sdsu2eyOm2Sk65R3oAOGCL7fD97X1CF6SxQOZC8GBry/mo6+Y5z5pB2lxQ6oDCkXFT5JncFGCrFNtuXh3TWGyHDV+1iF6oRKKg8wM71/zkaxewD1tutVdUjwGbm1LdHMEacPriorYSrOkEofgdTTc34Ph2N819AFobGYNr1u1qEwzHP8Fs87XdeuO4g+1kJNZ6j2WSy0T25HHRhjXBR0UnPd56OcZ5/1rocn+0mxohDti05iPLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB5901.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:526::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Mon, 28 Oct
 2024 13:17:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8114.007; Mon, 28 Oct 2024
 13:17:01 +0000
Message-ID: <be618cf4-7a8c-4e00-beda-f65bc6a278d5@siemens.com>
Date: Mon, 28 Oct 2024 14:17:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel/cobalt: replace unsafe strcpy with memcpy in
 hash_symbol()
To: liyinjie <liyinjie@sinsegye.com.cn>, xenomai@lists.linux.dev
Cc: songjianwei@sinsegye.com.cn
References: <20241028115903.1727776-1-liyinjie@sinsegye.com.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241028115903.1727776-1-liyinjie@sinsegye.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e7f873-da34-481f-3e57-08dcf752cf40
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djYzMkQ5R2VIVlVsNk5PdVlxN1IrUFRyL3VHRDZGdEpkWFozOXNrMDNIOEQw?=
 =?utf-8?B?SXhuRll3cVZ3YjlxaytGWTdQNmZXR2VZaHlDN0FrWUdiRFF5cjRBWHI5Skxm?=
 =?utf-8?B?SDhtRFNvdEVKUjc5anpzZFFkT0ZBeDlHUklkWEdCaFdRdjAwVUJwVHZoWFlo?=
 =?utf-8?B?ZnUrUGthUjJTeUplUExRazlhRTJ4ZzdrTWJwUVdoQ2tTWVdjdG8vR0xLVG5h?=
 =?utf-8?B?V1RjTTR5SWVORllFd09OQ2JXY1hOK1RKc0plVjhaYmIvMEprVGlHMU1XZmVy?=
 =?utf-8?B?YTR4cENmd0Z0amszZmtZc0h0WGhoU0hobFZMRTVsRXpwb01Ealo4QkoxOG0y?=
 =?utf-8?B?WDJlVXB3Vkg5cU9VVFpMcmJJOGlvMllkbjFKdVdQblJ5R1VqTTdjTmpHME80?=
 =?utf-8?B?a3gybENMazc5a1QrbVV2Z2xMMzdTSkpFTS9SVWJiZmpvY1psS0xjdnQwOUdK?=
 =?utf-8?B?cWxCNEVSci9CWEw1cVFiYjVTMjZjYUZ0QmxjTmhSZGJtV201TU9wNWNMMS9a?=
 =?utf-8?B?ODRpSUQvYnNyVFFlcGI3bFU1cWZnZGxVVDNiQUZvc0o2WkpqVmg4cDdDSjY2?=
 =?utf-8?B?UVE0MHlSVFFyUjdBSmtnQjRnWGloY2FCT1Nqajd3TFQ2NUx4WG5wODdiSXo0?=
 =?utf-8?B?UTRGejBkeStrNGFBcTdlcnJ6VnU0TmZTTjZxRG9FbzlwMlVwM1E5YURvTnZR?=
 =?utf-8?B?QUJ1cHJ2M2MwaFBlNUYybU5JTFZWbjAzNnFnL3RkN2dEYnZQLy94enE3bXRC?=
 =?utf-8?B?ZU1lUmV1TE1WcTF4T01uZWZsazdDSkF3LzRQTVNPUlc3SHlRcTU0dm83Wk5U?=
 =?utf-8?B?eUlPc29kVW9aOUtvVjRMSE9Bd1FLYzhXRkp0Z1RpY0RXKzVyUGtEeURQdWpL?=
 =?utf-8?B?UU5ESXFhZU91SnVxWFllR2dnQkpLM0J6blB3WFhnbGQ4bmF1WEtJMExJNE5M?=
 =?utf-8?B?UGszeGlyWUVEdFZKU1ZEK0lwT21ISWF2eVoxNjBBanN2RFp5d3BvdHdMMStE?=
 =?utf-8?B?NE1pRHU0V2N0bWVhS1pGNDByVUdXWHZKa1g2emtMRUtmVkF5Ryt3eHVlWUN4?=
 =?utf-8?B?elhQbnFRbUtkRUxtblExaVE2M3BoRU9kcFRXcUliT3F4QW1EeituSC8xanlk?=
 =?utf-8?B?MU5vSWZkcExXWFhTcGhma0VTZ1lwVlRGTmpXcVV2OUg3SCthNWRHWE1iTjBS?=
 =?utf-8?B?bzR6eStWLzVCOVNvZVoyYUJmd2hVZ1FsSkdqblFmWlI5eGZUN2JBZTNrUE1u?=
 =?utf-8?B?ZlR0L3lxRzBpV1dpc2dTZHZ3WGlRemFpaUZGcjRUWW8ySjc5dFRRaXl4MTN5?=
 =?utf-8?B?WFlkRDNRakFzbm52bWtUTEFmUDU1T0JVOFVZM0d6OXBTcTVqamVDTUhkellh?=
 =?utf-8?B?ZmRhc1B3VU1FVDV4LzJ5TXhUeEc5TFRoalByeTNZclprWU54dE5Ybis2N2Fl?=
 =?utf-8?B?UmwxcU5BUjhTL1YxWGQvTzFSYjVmOTE4cy8zRkNkN2xwSllKKzJUU3hEOWJ0?=
 =?utf-8?B?QjM3NmFoZzBhbEs1Tmt0VEhYcHlQOGpCcDRxYXkyNm1nS3FkQTVaUW9kRXZD?=
 =?utf-8?B?UDNEd0FZZnltZnNEbmdDZG5uUzNialU2TDFKUVI4UEpKTk1kT1pYYnFNZ2hI?=
 =?utf-8?B?ZFBXSDB1OWJpZmRsV0dVbWliR0FWaDlsUkx5V2xxM0hUdlFETDVRSndQc1dM?=
 =?utf-8?Q?GWmrg0ftoIPc84OiXwxS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUxQaERJdGh6TUl2YW03TTI3bVFOZlU0SzlnS0xQYmo2OHVodkFhYXo1U3Nj?=
 =?utf-8?B?aHN5ZU9HN0VzWklYaThyK1V3WHRnM002dTZtMC9OUm1OK3hJcmxpQkpQZldx?=
 =?utf-8?B?b1d4NDQ3TTZlU3MyK3NQZytGbytPWUc0Zk5lYUYwUmVvOVlTRElaeXZVWmxY?=
 =?utf-8?B?cW5oZEhJRkZXcGVkU2txNnJ5dlpPeFpiUXZGVEtNMzBzSDlIOUpsRys1V1M5?=
 =?utf-8?B?OUZaRmk0REJUTGVPWG8xS3VJeGU4ZkdCbVR0cXBFSVhLMEVSMEsxOUN4V0dN?=
 =?utf-8?B?ZW1HeXoxWjJFM1o0aG9jeVAzcys0REVlZ0Y2L2p4SVhjckJldWt0ZWN6eFJT?=
 =?utf-8?B?L0pJU3A0VXcybTA0TnpEUXQ0dzFQWlZjeHhISXFkZEJEd1hEdzBjeS9uSUdv?=
 =?utf-8?B?by9XbnB6M1Z2bjhZRXRmWkpNdVgwYmFzMDVzMmRtUUMwUllvMGsxMHJjVnhG?=
 =?utf-8?B?dXdRVVlObzIxWmFLbm5xVXdtZWRUMHdCK1dRelprWm9SbVNOY0NRSlgxdVg4?=
 =?utf-8?B?ODlxK2NOWU5qbER5WkZZSWMvRGZzTm13eDF0ZXJ3TmdFVHFLM1V4TzZIcVRi?=
 =?utf-8?B?TElsU3YxQ2MvMUFGUFROMXRMZDF4dkp6aytqT2RUVTBWRk5hVTcxKzMxTXZq?=
 =?utf-8?B?dDlZSU5adzRuSVBqOU1JdWg1VjBDVVl4OGZOK28vR3grNkZ2dHFmSHAwRmkw?=
 =?utf-8?B?M1VWN2k3ekNEckwwVkV5VFBsVld2K2JUNHdmcFlrbDJjV3dJRlUrRWdSeUpV?=
 =?utf-8?B?WTVDQm9JNVprQXZjNGpSUGJlQ3I3OW53V2xCN3pBclk1ZEJKRzBFREZtN3Yw?=
 =?utf-8?B?UkJsQUZwcVd0QzFXWEV3bUh5bFlJOVU5aU1vdXZJazRNU3A5Ty9oNVgxWDhq?=
 =?utf-8?B?M2EzZkFpRjJaRExUOUtrd2tsbDlwb0Jkbi9JdTdvQkphekFkMGhTZHphMWtY?=
 =?utf-8?B?eVdvOVRhbDkyRUdYL3NxbE5wdHY0VzFmdEZheHVwaWNUOGE5Q2ZJNU1ESzIv?=
 =?utf-8?B?WStpc2dMRXdzQ01CVUl2UUE4L3laai9oSkd0N2x6Yk9KUUJRYTBnNUN1TFp1?=
 =?utf-8?B?bEo2Q1VDMTV1SnBLRnJudjFaSEU4YkJyWXl0Z0daTGdvaW5QWnArYlhmRlRF?=
 =?utf-8?B?MWZtcSt4SHpnWUZlT3dUemZ3QXZVNTc0WWxOeFgzOGNpSGluRTVuamlaVW5v?=
 =?utf-8?B?akJBNWVUc0VTVnNGQXUvZWQvcC9yeXBDSjFUUGpJYzgybklPcTYxUlV5SHhL?=
 =?utf-8?B?TzBFUllBSVFpajMyQmZjN3VNVFFkM21FazVHQW9xdUdkdGRkcjBFQWlpNGpI?=
 =?utf-8?B?T0pPQWhOdGxUeWM2RTJkYmVsT0hxM3NPVDBMcUtCbXJHT215UzZkUDF4dDRH?=
 =?utf-8?B?QUw4RTRXc0trV253aFJLekV6bXRXR0g3UjRtSisvRFB4a0hCOWRzOWRlQVky?=
 =?utf-8?B?WC9FM3kzUE5hTUFzdGVWMWdnT2d6SlBqWWd2ZEppSWR6bVdiSmlaQ3BqQzNx?=
 =?utf-8?B?Qm5ROEFpU1hIMzJGV1pHcTg1cTVqdVFUS1ZndXl5M3ZiN0hFWi83djZ2aGNC?=
 =?utf-8?B?Y1RNZjB6dDhCcHVsMk01NnM3eFp1VWRVVU1Lb24rMktTZkVST1FaTzlpOXp1?=
 =?utf-8?B?QUVXaDB3YjE0bzZ0eC9qTU5laUpobWdPMHVuUG80V24yYVE2c2ZFWENqblcy?=
 =?utf-8?B?SnRxUWtNUjBzMHZ4QU92NkRxaVcrWUN1MHRoWFBUc2dGZ1RlNXVUMVdlb1hT?=
 =?utf-8?B?aHV0TmdsTUFsS21TK3Y2NTBUenlJMG9UU3V0TzhRemFoRTdLOVRpVUx0cHBm?=
 =?utf-8?B?dVp5QjJFbnA1bWx6VUVUc3dGaGIrZmhUaGN5Z2Z5ckVJRG54eXVPTC9mNHN3?=
 =?utf-8?B?NkhKM3greVFUeFlhRjFjZ1g2TkY3bHFGVzh1WTBtdmJDYTlFY29lWUtMQ0U3?=
 =?utf-8?B?ZTV2MWpSZUs4UlZBd09KNUR4MHpuMjQyZHpIRVJLZmVpSU1WSWZXamFxMXFn?=
 =?utf-8?B?U1RnOS9SYUx1UGpBcEM4L0l3Z0MxYnM3Y0FFVUhRYmZtRmJPWjREREQydCtK?=
 =?utf-8?B?RSs0WWtCVnFGMjYyT0FPYktrR2VjVHlkaUhRdGxIUWUyelRWU2t1dEY5cFBa?=
 =?utf-8?Q?mqmmt0TVYOz+yt1OQaJcZD4Ku?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e7f873-da34-481f-3e57-08dcf752cf40
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 13:17:01.7323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0ZrQ9VsBUYYL5RVATwDy/WnsSviNwWIM8P6DaqszTfHRkJshrvanJvlIY/vawo0thB+0JLNrzvvJsh2yVSfAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5901

On 28.10.24 12:59, liyinjie wrote:
> Hello,
> 
> While building the Linux kernel with Xenomai support, I encountered a
> compilation error related to a potential buffer overflow in the
> hash_symbol() function within kernel/xenomai/debug.c. The error is
> triggered by the compiler’s buffer overflow protection mechanisms
> (FORTIFY_SOURCE), which detect an unsafe use of strcpy().
> 
> Observed Behavior:
> 
> The build fails with the following error message:
> 
> In function 'strcpy',
>     inlined from 'hash_symbol' at kernel/xenomai/debug.c:94:2:
> include/linux/fortify-string.h:812:17: error: call to '__write_overflow' declared with attribute error: detected write beyond size of object (1st parameter)
>   812 |                 __write_overflow();
>       |                 ^~~~~~~~~~~~~~~~~~
> 
> Context:
> 
> 	- Kernel Version: 6.6.41
> 	- Xenomai Version: 3.3-rc.2
> 	- Build System: Yocto Project with custom layers at branch scarthgap
> 	- Compiler: GCC version [GCC 14.2.0]
> 	- Host System: [Ubuntu 22.04 LTS]
> 

Thanks for bringing this to our attention!

> The issue arises during the compilation of the Xenomai integration with the Linux kernel. The FORTIFY_SOURCE feature in recent GCC versions enhances buffer overflow detection, and it flags the use of strcpy() in the kernel code as potentially unsafe.
> 
> Analysis:
> 
> In the hash_symbol() function, strcpy() is used to copy a string into a buffer without bounds checking, which can lead to buffer overflows if the source string is larger than the destination buffer.
> 
> The specific code causing the issue is:
> 
> p = xnheap_alloc(&memory_pool, sizeof(*p) + len + 1);
> if (p == NULL) {
>     str = NULL;
>     goto out;
> }
> 
> strcpy(p->symbol, symbol);
> 
> Here, p->symbol may not have a clearly defined size known to the compiler, leading to the buffer overflow warning.
> 
> I also tested replacing strcpy() with strscpy(p->symbol, symbol, len + 1), but the error persisted.

Yeah, the problem is likely related to the 0-sized symbol field in
hashed_symbol. Can you first of all try to switch to "flexible array
members" ("char symbol[];")? This is also described in [1].

> 
> I am submitting this patch for inclusion in the mainline code. Please let me know if any further information is required or if there are any suggestions for improvement.
> 
> Thank you for your time and consideration.
> 

For a ready-to-merge patch, we also need your DCO [2].

> 
> ---
>  kernel/cobalt/debug.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/cobalt/debug.c b/kernel/cobalt/debug.c
> index cde0c17ab..e901572cd 100644
> --- a/kernel/cobalt/debug.c
> +++ b/kernel/cobalt/debug.c
> @@ -91,7 +91,8 @@ static const char *hash_symbol(const char *symbol)
>  		goto out;
>  	}
>  
> -	strcpy(p->symbol, symbol);
> +	memcpy(p->symbol, symbol, len);
> +	p->symbol[len] = '\0';
>  	p->next = *h;
>  	*h = p;
>  done:

Jan

[1]
https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
[2]
https://source.denx.de/Xenomai/xenomai/-/blob/master/CONTRIBUTING.md?ref_type=heads#developers-certificate-of-origin-11

-- 
Siemens AG, Technology
Linux Expert Center
