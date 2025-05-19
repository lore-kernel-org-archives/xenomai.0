Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCB7257458
	for <xenomai@lists.linux.dev>; Mon, 19 May 2025 06:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747637205; cv=fail; b=dgbPsn+egBHWkUZuACFpUGIbza/YkOsGb5MB1F5HEve983fuPY2wvHoXUy0Qd7FovmloWdr5eVt7bFtkvNsrGUgfdhJ4tG0oOxVlLtqs7hsCL7cbVOdH8BFhN6lUqbCkRMerVjuHIrIJIsFmm+BS2VAtFkpAi8JadFwpefKyjO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747637205; c=relaxed/simple;
	bh=A4SzuiSRKz77+rpSTIY3uYqa54KhwgeDNXUvPybCSVA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tu5NhqjsrMm0Nrns+HXFWGmFD3oBqbSH+z1W2373HNC8gZXWF6/uiDD2aNDq4WN3w0vSHYDSuVB4KKZm/JELTNDRGR232Szde+liJojKV4aXV+9kYKQlRX0tdYfHCQfq31thlfFsDKv/W7fdN08MFTLvCEJq0VbqDdgtY8mVSIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QPRW7dDC; arc=fail smtp.client-ip=217.70.178.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QPRW7dDC"
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id 032B743709
	for <xenomai@lists.linux.dev>; Mon, 19 May 2025 06:46:35 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20607.outbound.protection.outlook.com [IPv6:2a01:111:f403:2612::607])
	by spool.mail.gandi.net (Postfix) with ESMTPS id EA6EF7803D7
	for <xenomai@xenomai.org>; Mon, 19 May 2025 06:46:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hn654zjUiFIy80tmqMKYomnYuRxyS0TVGB/5a16FdXwVHFHE6AqSZsEU8grtjtI49TY3ZbZGNRdxf1o/oJ3bRw4YxipJElNdQn3Ma94D9WOsqA2QH+Y9OQcsJe4UxhBRDqWgkIVrO8ib+6wlpHGg7ZLAFKTpTDtMtP4CI84NoOhbAzj9zFX+atE+jSQTzRgHPq9DKhz9SBtpwSRbYJmPki1hGXUL7qAePQwNr/pNm9x8Weg20uZukcqmPoy8ocFjBjDS55DQiDlOSkky5UQ1vMHYNO1I8/yNPWgGa3RdDeOXkH4nD2F5E3BR+BY0XEbW5O8RLJ2g6wS7DepGOFJF7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muZkmCu9CLfZPOPZvIAQB/7BOTTMnpyHKzX7fuAr2MU=;
 b=Aa5y33dCHLHnv9iZNt9cQUSdc20Oeq3kaSTrrnGhDIwuQBxkfaEz3ukW1fw0f+F05tUcWwpVvYbfjbUAHBDdX07xYb48+euPi250AryqmBUW+mM6vN0hIddwqBfhCTTXvHQQtwvvj3aJ1dNjRHae0VUEEWgsj27G05MI2299wbiipWzT8TwCzwn40Fr6xnSkzH5Zlo6IZGZE9iZSWP3IoqmmbfRywlU06GE5VaEwUvk+noRA6xFd4bO/K0r8cvuN2EQgepYIZK1seZpmCnuNOJCnhbfFmqiq2QhBshjOWGBZ6ADJTZxokwvVNBvvphzpvdTs5Y0kEDpCkhUZi6yhMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muZkmCu9CLfZPOPZvIAQB/7BOTTMnpyHKzX7fuAr2MU=;
 b=QPRW7dDCV7FM0hm8mTvJdpon5hQmU0whS2W+Sr6wuTKcsFe7S0Gl55/ikhT0I8cTHkQ2Hkl8eMcQIam2rqa4hqJo1rkPrQFWYLpTDtwjYWKvDJD6phDZl80eYRpVorJzpPAVSS1kc/Y9rYHPjPFHX2poQTbUbD9Ynqs/kzTuhpOtwuj4zMI+B85kVrX/I0N7rqICqRF6bAHhE3Sb/pVhuSP3A1QnJjMi4YEPvMK8A/9nfo20/0wZphEVOC3qKquRaHLzjCgtduns+FAmeyatd5YKz5iF6Oy7Cb+7JLAXKCoaUeGVDdqie+o+cycOIqluOR76mXmY36zuxQbkHMukLw==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8570.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:214::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Mon, 19 May
 2025 06:46:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 06:46:31 +0000
Message-ID: <5bfe8c45-7e48-4c02-9e32-4689898b38d9@siemens.com>
Date: Mon, 19 May 2025 08:46:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: How to use wrap-link.sh to build static app.
To: Haiyang He <aspirestro@163.com>, xenomai@xenomai.org
References: <53a2c0bb.15f4.196e2a4043a.Coremail.aspirestro@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <53a2c0bb.15f4.196e2a4043a.Coremail.aspirestro@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0282.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 913a29b2-5ce4-4718-62c3-08dd96a0e3b6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUFUT1ZmeDdqOHF1WktkSHdtSGVuN3lTZ2FrVThtb1pHRkJZcmJYOEM5Um1L?=
 =?utf-8?B?TUQ1Rk1rWTh4Z2lDWEM2c3RCOUlJLzM4bnRKQWRpUkhnM1BwNGo5V3kxUkFu?=
 =?utf-8?B?NzlyYVlvMm8yalZkRmtjTGZWQmoxbUQrSTFMM1BaNDZlM2FJQjdMcVFNZk5U?=
 =?utf-8?B?eG9DY0tQR3FmSDRwc29IWFNGa3pGQVJuWFpvWEdvT3ZvNkhEQkYrK01EZVls?=
 =?utf-8?B?SjBMWXYxSGc2cGNadUQyRm5QLzlSZU94bVlvQmN6UmxqSXJNdmthVHlYZW1J?=
 =?utf-8?B?ank3L1hzTUlTZ1ZjRzI0ZExnS0ttNmxRbmtHeHVoWm5SQ1ZKRERSeFNSWFRl?=
 =?utf-8?B?NExRS2hUc05kM0M1am0wcUhvSnFYblNWNmxSOXp2UHU1TnN5Q0lVeVpHcjVh?=
 =?utf-8?B?eGdnZXE3aTR3WFhyOUc4bHNVUEhwMUhnM0djMkZWQmVteHc4MUh3RjlTYnBI?=
 =?utf-8?B?SEFFUmZEOVc0RDJCakZLVDE2blZEN09wWU9xODdyU3diM2xyemdFK0Fsampj?=
 =?utf-8?B?bEFPUXZ3MUtmbU52djRtejVLQnNkQzJtaWQ2TlRDVkQwdzF5V3d0a0krR0ZD?=
 =?utf-8?B?OXB4YXc3T0lkSzc3WHQ3cEZUd2pWYUhrMU1mZUFRZDFPdXdERStvS3RNR3g3?=
 =?utf-8?B?U2MwVHMyQTd0MzR2RjB4VFhVUytnbmJ5NHFtSU4wMjZVcXY3aTFVK2NUSWVJ?=
 =?utf-8?B?M3EvUENxbGh2QkpqSFI0ZWw2Z0J6TzhMK0NxcWVOellqaTM4QnRIdUdqMXkw?=
 =?utf-8?B?ZVQxbGpBeDBRaGk0VlVpMTFzVkZlYnBIUjRUNXo4N3JTQ051THVseDJQV05v?=
 =?utf-8?B?UzRnVkh2aGVxL2kxM05wQmJjdm0vZ2NPL0ZETE1jeUFZSzBSaTZ6eU0yclpx?=
 =?utf-8?B?clNUV3BzN1dGYmE5dzdHbTVlVTBFazhsM2g2aUg1dHBpSmVqcFFPand0RlA5?=
 =?utf-8?B?ck9nUGlpWDd5enJpalhCWEw3WURLTXYrbjJLd2xHd0JLK1FWanFuVXdqTGpN?=
 =?utf-8?B?ajNqS0VnMWdsN08yMDFXNkV3QVVvMDhxRTdoSDNHT3RtZGFjS2dJY2FHU0tJ?=
 =?utf-8?B?OEdxT0I1YXhpMmovKzhXL0huTlVrSkg1OUpYUHZ1ZWdlMDNoaHU5Y3JQVE1F?=
 =?utf-8?B?Z0I1bzQvR0d4bE1CL3hBSXhJVXJ2TTl3bXYzbXJDTDQ0aHcvTWl5Z3N4dCs5?=
 =?utf-8?B?OTExMFdsdkJHS0V2c21pbUZZUDdsVGIxOXJTYkpHQ3cwa0hXK3AvU2xXckxK?=
 =?utf-8?B?MnlVZ0Fid1o0YXVTOGRYRjJCOC9uNUpnVXFVZXdzQjY1WFlhWmxudlRkL3g1?=
 =?utf-8?B?cWZWQytmTXQ3NmJselJGdHNlRlY4MFg1dzZJd3VYbmh3Tml6ckFuSTlJR0hS?=
 =?utf-8?B?YytvUGpscDQwODQveWFZb0dwb0pRcjJPT3BnOXVoWTl2bTMxbHpLcWwzODVj?=
 =?utf-8?B?aHB5aFhYaWRoWFVJZlpOMlVxMkxwa3NlWWpKMUY2SkFSeHVRZzQwbEJrRHY1?=
 =?utf-8?B?MzloTW9MSms3WXFET1ZqTGp6MldaS2lCWGdHc05HRjdIbCtMTGlBa01FUFNt?=
 =?utf-8?B?STZiQ1RUTkc4SHNoaU91WFlLTGRjbEZvbnM4aE5YRXlYVEpqR2FUcUU5YlhC?=
 =?utf-8?B?MFRmSVEwQ3VHN2lpbnBrN2gzUlVhRFBJb3RMQmdEMnE5dnZESStUQzlZV1Yy?=
 =?utf-8?B?M1MzWG5jb3F5VmRmZkI3Y3VWeXBZY1VES2JCay9OM2FrT0JWTFM1Wk01MGt0?=
 =?utf-8?B?TTFlZXVmc09hMG9pVGlFelg2RlZJbzBDOU9FYk5NRUVZMlJWSlBvUXBqVUpV?=
 =?utf-8?B?QzFRRnhvTjVBT0pXU1JuMHlkeWdNZHlRVzBlKzVJd291ayt0dXdxUkRBNW5K?=
 =?utf-8?B?NDZlUmU4REhjUUNXRXIrSEs1K1RwejdENk0wZzRObFBiM0VpWnJWcjBBSkhI?=
 =?utf-8?Q?NhnQ8oGWLtE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGlwV01IcGY4cXFRSm5qMDdjZXBBeW1VbDdsUVZUMkJwQklkSDNzRzVKbWtK?=
 =?utf-8?B?QlV2aGlzSnJBQ2ZoQ3lxVjJIci91QzFrNWdFR05POURQUUVwdUl5QjllL1Vw?=
 =?utf-8?B?Y1lGS1Mxb0lRMzBkdldoOUtDVS9JQzJLeGJGRDhMM04vMkpWUUtpRXhES1do?=
 =?utf-8?B?a3Z2OXF6bWNleWdUTVgzei9tcXNDWk9xWVlQazhkV01QdC9QQ0FuRWVzNXN4?=
 =?utf-8?B?UGpBNDY0cDlvZ3dQS2J6UHo1L3hsRHoyUDhIaUtmaXJDNEN1UDY2L0prejgr?=
 =?utf-8?B?UDZ2SUZ3UVlKVUphTFJSOW05eXVZQ1VYMkdWRWRhTml4VXFjdHhTZkhQdVl6?=
 =?utf-8?B?ajBoVDlVNWluVk8rbkVEVm91SXpQZkUyTDBHVEdyaVZyL1RyS3lIUkxWY3BP?=
 =?utf-8?B?dDk5TTFpSEpFL0xwUDNyUDExenFVVTEya1NYSnBHSkxuSEpYR1R1N3hPR1Fu?=
 =?utf-8?B?dElqSTZTWldVTHI3ZCthS0xRMUFYNTNHUDkwelJRaTRWOGhDN2pId1htdmNs?=
 =?utf-8?B?SjBINjBoTUx4ckU5ZFdDdU1HbUIvTm1IRGo5K0NINHpZRjhjNk9CYVdyL2J5?=
 =?utf-8?B?aFRYVXZrRGlPSVIvZWg5SVcrc1doSCtUZDVKM2NvTDdZblZROXo0bnZRd0Qy?=
 =?utf-8?B?WGRhRExSZ05UY3o5ZFJ6c0k0UE1iQTFVeFVMSXZtWDdGUnFmZnZoWGh4QTc3?=
 =?utf-8?B?U2I0UGdXUVAyZXJPem5vdGdwa1RIOTV5MnRnYW5TMVNNWkxrOWxtQW5uR1VF?=
 =?utf-8?B?M1dxeTZxN1NvWVdJU1NRQjFneTUxOW9ha1JHeVBsWUpNMG1rZUl2VzRSZGd3?=
 =?utf-8?B?dXZVODd0MHUxRUtMc05vN0xmaUQvY3pBcEducjNqb2ZxdENrVG5FdGI5MlBJ?=
 =?utf-8?B?K0t0MUE1YlNyV3diMEk3Z3ZZd3h1V3lGdHJuQllScEp5YTMvQzVZUWdKbFpI?=
 =?utf-8?B?cHhDa3hjYThqWFlLQVV5alkycnFIUnJMcGVUNHk5dUNHdnJXM00wOW9odDdK?=
 =?utf-8?B?RXdKd1NETUJSNkFLZXAyNkpiYmhlYmNWckFuK3E4ZkRzRWJOMEJESFNwWjlF?=
 =?utf-8?B?S2lTdy84TmdrbDdPTGZHOWhJQUh0TmIzd3ZuWTZlRTR5eEtNMTY0L0RlVTFV?=
 =?utf-8?B?R0l1Um9lNDdkZGVlcTRsUVpqYzBTTmlZOEg1SkRXVXB4T3V2a29TbXk4R2RH?=
 =?utf-8?B?Mzd0SmRmSlJ1a3hyVVJkKytwQWxrU1JvTTlhdm9ueFdZWGpEcTc0S1lwQkww?=
 =?utf-8?B?Q2NVYkpYalNsK0RJSUk2akZpVW1raWowMkg1WXk3TGdmK0p3UFlnWDVVNUFX?=
 =?utf-8?B?S0RUTmM5OGxTMnc2NGEzc3g0T25iTGowRDk1V0xza0YralMxQmVLUkhhQ1pC?=
 =?utf-8?B?Y3NpeFJ3UXhBMGNYSXkzVk9ZOUo5bkVOWkp3T2xlQjJsYWdMYW5MTzkra0I4?=
 =?utf-8?B?TGJsaElvbkkvRVhEMklrV3ZBc1QyVkQ4QzNaSlVrc0NpTFZvVVU0Qkt3YjQy?=
 =?utf-8?B?Y3ErT2JlbFllQjRPcStMZjA0aFRBblhxK2svQzVPdTIxV3phd1o5NzFPbFRO?=
 =?utf-8?B?VzY4eHNHY0d0SitsZUtXQm5BK0doMTE3Ukc2M2szZVQvWnBIenduLzdIVFJk?=
 =?utf-8?B?YzQ4SWZoZ09tNEQ4VjZONWJQamhRejhvd2t2Rlp3djFKZlZhV21nbUh5MUg1?=
 =?utf-8?B?RlBXcUVLWmVRY05DeXBkZnY4ZzVpak9pNmNKYUNQL1lYb2NVM1I4ejN3b0N3?=
 =?utf-8?B?djhCY3NQUVBTT25EQnNiVjJsbGM1MStYVEl4cm40RmRFcFZSNjZLSXpFdFhI?=
 =?utf-8?B?elF4cnVMblBBRzVBSHJZTmZSbEhLeGdleDZMMm1DLzFUNDJ6aDFlK3ZaWlI3?=
 =?utf-8?B?OG9lODBlUzFUWFV4ZmNEbFRxQVhqRWpQUDFBVEJCVkN5U1JUVXVmYTJpbkt2?=
 =?utf-8?B?MGF3eU5nSENJemFXRjBvdE9QRktqZ3JkTVVZZWdzamVNczBVUDhqQ25kbFgx?=
 =?utf-8?B?K2FiNHV3TFpKek12bUxZQ242ZVZDMVJ2SzdxVEJNWTV4UkIzUEliejczZDl5?=
 =?utf-8?B?STNNdmwybCtOV1NPNVRHUCtrbmNuS2ExdjYrNTkzSGF3T25zL0FTM01ZQ2Fz?=
 =?utf-8?Q?xe4GZgK+dkMd/HR7xgehwPUep?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913a29b2-5ce4-4718-62c3-08dd96a0e3b6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 06:46:31.6980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OA5g6mtGVpBnPLEHoMXi7ejlDdH2owOpoJXJSC+7YSwoz2RwNgmNwRh4ZyqfUXnB1fZ8L1rUvMmGd3/cB1Em8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8570
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=QPRW7dDC;
	arc=pass ("microsoft.com:s=arcselector10001:i=1");
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:2612::607) smtp.mailfrom=jan.kiszka@siemens.com
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddtjedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkffffgfuvfhfhfgjtgfgggesthejredttddvjeenucfhrhhomheplfgrnhcumfhishiikhgruceojhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmqeenucggtffrrghtthgvrhhnpedvteegveefgfefudfhjedtvddufefhkefhleelgedvkeeugfegfeehveevuedvkeenucfkphepvddujedrjedtrddujeekrddvudefpddviedtfeemuddtrgeimedvtdgsmeehkeekmeemudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrjedtrddujeekrddvudefpdhhvghlohepshhpohholhdrmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomhepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh

On 18.05.25 11:05, Haiyang He wrote:
> Dear Xenomai Project Team,
> 
> I try to understand how wrap-link.sh works.
> 
> I use wrap-link.sh to build static app(a simaple hello.c), with following makefile. 
> 
> But ./hello always got aborted.  
> 

Thanks for reporting - I suppose no one was using static linking in a
long while...

Please try the patch I just posted.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
