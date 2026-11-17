Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794939318;
	b=tELV7I9ltPrV0zqNhA9wsSEpCX45ch9bbhWKJkwcda4GmbXSzs4RAqZTsQkvMoEwN5pT
	 +qIRS4Hq3i8SDXw+5BVlO8kyZ+uKN7ymrriU00UwDV4oFua/gzyvvRz8KrAY+gL4aN18I
	 LlGKgLmpWPRWeVB4YTAN07Lfthf4oB/vU2vG1GhMMNzHQnoEPQnZOrtcl7HydRVc4EeGM
	 rzblGzwUQ717tB/WL+ABBgpH0sheYfmmkoWoG3tiKJJGBgs6LgGoy7VQmi0zYSBgqMusu
	 TRP6wQ7Yiy28ByzklrGwWA7HRGuyZ2zBkhfnPPTEn9E7obIsfk+7OYA7p8JDfQBDQOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794939318;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=DBPHk2j9yUQ7iPGeQ02P14o5jFCcMN62HznXF/Ff78w=;
	b=J9R8PFpQvD5o3WP1DUqmjGeEBnkABuepcuGBVwdumUxQMYjTuxOfqJRdlUzSLHJWAlCY
	 fW1FqH10iQ0jyXb/AlAYTs9/uVy+XxK8tjTft7SJ7rMTVHBVo6NbLha6ZvAf89YEecxJb
	 p/pK2K9LtbPc0gbFWPluvaEibgC2x5mV6Usyj2nCXFjaLKgJQURubv1zB5A+c/8Hsnb21
	 z7juGh5Yv1bRVl4ee3AZPuC7LhmR0B28J0Ugm4b/+wkN6ybgRD6xrSlYms+iT/KXFYAmf
	 FpRFaTEwSOd9YRqkHc/jblP3AwAA2QeLL24WWnb4y/Oz0GRfoVAmX3k7EtO6sql33JQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=JmquPy63;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.55
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012055.outbound.protection.outlook.com [52.101.66.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935E7606A32A
	for <xenomai@lists.linux.dev>; Tue, 17 Nov 2026 18:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 935E7606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=JmquPy63
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htzUmoeLImt2YF4mvIxP7LQxG3Noket22jEY+/nw4mj6GnsLx4sNb90Ns/jmURCUW0joqcdR2dWa9+Ndd1tJ1/E7SY5jnPenEzlsoW7mbaB3n6rra8pAwVeGcSj+tlg7Z3n8iKKMErf9Aia3ip7iLnSC39lN3+oK/NHE5VVxS4gJhU2IMQSNgQJbs+rY7FgshBm7fwoGqIGQsBMpwNPSOL0bOGGIMp9Q4qzUAaaWCUC5UxrkjMPSkpT+J7g2j2udBdz87TGLRVES0njqybp7G2EvHlQRd8Iu4KY8+6H+kKejP1vdpaxLx95dNKmHZhEZ7zq5ZW7xSelE9oXE79mDJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBPHk2j9yUQ7iPGeQ02P14o5jFCcMN62HznXF/Ff78w=;
 b=lei/R8s/dOH1X2hz9sv8Tld/WKhN7hiiyXdxXVXgdXan+lHP+0DGzp24JVoRCU74srLKSMHVohPnf+Ch0HI4uWt3O3JZVHViAl4CUOib1gvOz/Tk3lniw49uv0LJBYluFHfVPdt6dB96SsUI+1nfUOw9384C2EwQQ5H1gIuq0UIjz+nWQjgvXrM0GhYxePuXkZLOraACYB78tv+CuTMx/pLAChO76MN+k9poAvXoFQ9Iyn94Tyu93BHfcbyAN8GS6Xo7s8lPXTrL7Hs0gjLinjuwGQeUi3i/TD8c2LvYPeVBMQLNG5+dP3EJ5/mwQtdyDB9GUrzWP8hcHohR5/QWMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBPHk2j9yUQ7iPGeQ02P14o5jFCcMN62HznXF/Ff78w=;
 b=JmquPy63+/U8SNMewgTNuk09WkY2FIWTZKoSok9xtu34WWUi7zhLW+IAiFWkOyc5uD4aZyGGfjIG5RVlAjQCOO5pDY/1todBjZjCJLAeHgKY6k1IE7GTz8z/bvBX6pcElgRbDw8FwJ88S5up9zd9RkUEuyw9tLVnf4/GQDYxIVbpI3vvZj9IfZT/TYDKD03EOXILA5j5cPeEw4cOJ1H2m6cXPkmwk2RBGGLkW4VS7Boxz7cKevCtkaUnATxzNP7wA4nZFd/AEV/m0z0VdhJKqUxLQHrg/3j3Ya7XxLht3cGPxxUjlgrHlVk4FPkxxouR8uqaNqlvArrJtrSxp3e/fw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GVXPR10MB8825.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.6; Tue, 17 Nov
 2026 18:15:14 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0639.006; Tue, 17 Nov 2026
 18:15:14 +0000
Message-ID: <e686a6ca-9d86-4269-a3ea-e76b018c00c5@siemens.com>
Date: Tue, 17 Nov 2026 19:15:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail 0/5] riscv: dovetail: trap handling fixes
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org
References: <20261117123925.597027-1-tobias.schaffner@siemens.com>
 <84d8badf-cf66-4ceb-a87b-e10a40a95e4e@siemens.com>
Content-Language: en-US
From: Tobias Schaffner <tobias.schaffner@siemens.com>
In-Reply-To: <84d8badf-cf66-4ceb-a87b-e10a40a95e4e@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::6) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GVXPR10MB8825:EE_
X-MS-Office365-Filtering-Correlation-Id: 88eda0b9-de11-44e0-e53f-08df44d6b9a8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|10070799003|376014|1800799024|22082099003|18002099003|6133799003|55112099003|3023799007|5023799004|11063799006|4143699003|56012099006|261022075727099003|261022115727099003|261028144727099003|261026121527099003|261021121427099003|10067099003|261021123027099003|261026140227099003|261102123227099003|261021135927099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	/I94Gii1XZPUFD5Rsnxj+YvMfGVHA4zq8FpQT0iq1B+wsfXQ2ny6zfXT/I3c4luyb0kTJi7N9K5N7Q+HPQDRnhyzdQf23Q7CWrx8DUBpbQsH2qx3/CYoMwa7U5aFS4bOIxniy9nNC6xYcBCtMWkW7m/vPazB2tjvw9vHL18s6IvvRVcG01uVQHAu8rk96WXHaZ9MT6Hcfi2gPgO92UlnX0LG8XjkfMaznRgem6MRiLTv5NEoS6/9Lw89wjiSvLc6LMzNgl1Jfm7pMg5uiBVBFCN9rQiEitOkcwa/EbhoduGLRIlrzDhelaCTHUC/i1DbZrx9+HnBJ6D0f862OgkSFbJ4Or2ihltlVOWZ7fyvKsmOfJLWmLu5CkVscXnlGfVdNWJ+o4QJzG5BZHHJTt6dveDPeh8ak9aGCOgEo1S1cxOQGxOsUYgzZuGCRylRzVkZ2tZmjC76q7VZppClpozZvLhj8zipFcjHkgG2ZbF9t6P+SCFxTsPfKkBOyctwVQk1Vhdi8a+tLenqj2Fdo8UlhFRwGo+vqUUGaGORo0Hxznb6+/ZOlgyUvh43vQHSEwa80IsmoeugTMdbosSL3q3ZerHPAcR9lkw8XW3eltRt8DKJ26F+y9fQsCMOn+2LE1f/jRi1L807PWPyCZ4n9A5vnrZm2qxfco804RcWEwtHckg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(10070799003)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(55112099003)(3023799007)(5023799004)(11063799006)(4143699003)(56012099006)(261022075727099003)(261022115727099003)(261028144727099003)(261026121527099003)(261021121427099003)(10067099003)(261021123027099003)(261026140227099003)(261102123227099003)(261021135927099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K01OdnRkMzBWZG9yZWdobms3TFpqOFE0Yk93eWpVMWJNcU5zYUNWV1ZxNldm?=
 =?utf-8?B?WW0wUHl3bWowaFJBQWFWTG5Yd2l2aGozck1QY3VGWHBmRFdYWS96SGFWTU1Q?=
 =?utf-8?B?K2NybmpXS3ROem5TbEZ3RWhGRjhvWHdrUHp4b1pKUE90SUFJVTd0U3F4TEJo?=
 =?utf-8?B?a0xrQjlzZkt3SFB3OVBQUUdDbTJCVUYxaUowV2s2Tk9DZU5WSE9jZGNTejNi?=
 =?utf-8?B?TWxtNHhnZUhab1hjV0ozNzJ4M3dQMk1LS2xhd3preXdVSUlLeVoxaUlheFdi?=
 =?utf-8?B?OVFMeTQxNE9xZHNFM3hSQzZJVlcrbnVsTFMwN084WHJ2eDZJVUVWYnloWTBF?=
 =?utf-8?B?TnJsdE1WcTNZV3RNOFlLSE9DOHFJTHBmcGtDQm96Y3B4SEZmaDBydE5DZTJF?=
 =?utf-8?B?VDhlOWRCMGhqay9sb3pVdmovUDdDZk5kZllOUHdjaldoN05FV0tCTExqZ0pt?=
 =?utf-8?B?aUZ5RklUYWhmRGhZZTMzWk1mSDUxT3RFa0ZOMDhBR01QeFlxdEVzLzFRMG14?=
 =?utf-8?B?WG1TVTlYUy9CMU9jZU1FVHRFSUdoTlhCUUE2czJ5TTNRdzlIUEthMjVtSlVi?=
 =?utf-8?B?TVA4MFpyUk9zZVhvSW95V3VicUZnUlg2RS9Ed29xVlJaQ1dWZTZwc2pKT2VF?=
 =?utf-8?B?Q2lzOE5yUnMxc0E3d3V2QjZMcW9qVVhiRHpOWWJ2aHhZZ0dzcWtLdFZ1ZGFC?=
 =?utf-8?B?am9MV1BoY3BnSkpiczI5OHIzRnZiVkJha3ZkOVFNVlJOd2laamRDVktrQ1FY?=
 =?utf-8?B?bG5ESllMZmVGSUxncU54Z0hpbm1OY0FTOSt3Ry9uV2p3SVJDaVYzLzNRSmY4?=
 =?utf-8?B?Y2NZMU9EVGFOYW1DZENrUERjbTczNlpOVDVMeGd5UHQzMkVvN2MxSHlBbitu?=
 =?utf-8?B?TGRPYSsxT0swUlBPZFBUeDV6RlVDalBMNnJlUnJOL1RTaTdvanlDc3JIWDdv?=
 =?utf-8?B?bGJIZG1RR2ZSSEovdW9veC94SlJ1WHVTMDVYWkZ1cnB3OS9LMlNGajQyMDZu?=
 =?utf-8?B?eFpsaXBrRkJ1UTNBNUZkaENCM1cySlRnVmo0VWlvaE5VSkEyT3M5b214cFRF?=
 =?utf-8?B?Ujd2ZDd2SXRsTTNjaGJKaEFoRHgrSlBmdld6VjhLaUVEOXk0Tld4Y2dZVkpn?=
 =?utf-8?B?RXRzY21NelRGUUpoS1JFYVdYM3BYaWhQYVEzOXRrREN2R0FOMW81Z01VQmdX?=
 =?utf-8?B?NERGdWJDZ2liamkzRVNzTzJQNE4yb3p0MFJsL2MvQzJEU2dUV2NjcVFYVjZD?=
 =?utf-8?B?VHB4L0NnZ3ZyWmlWR05WUjNrZEJNV0hiNVBaNFZMMjQxQjcxZ3JjRmlTMnUw?=
 =?utf-8?B?Y1dFR1hBU2FyTUpXaTJrUnV0UDJOUkgrRzl0QXQvbTE0TXlHRDJwUmhMem5s?=
 =?utf-8?B?c0JsV3hrWVA2dXRZSUVZZFRSUGVlMkFwQlhqbjhkZzk1UDQ0TE90RDlhdnc3?=
 =?utf-8?B?NXBNa0RLWm5qd1V5T0czMDdTNlBLcHc5Y1ZONU5qNENnNFlIeVZQdldYNlQz?=
 =?utf-8?B?QURaanphNjNWQlJEZk9OTUk3VG9MNEhBbU54Y0xxRUtRZWZpOEtkeXJ1aS9p?=
 =?utf-8?B?ZlhZM3RlK2RxR0k4d014cThiYjFhczBQcEdOVFFUR1ZIL3R2YzM5VE4xT3pO?=
 =?utf-8?B?V0xiWWp1SDNQcEl2cFJqakErM3FYWEY5a3p6SkdWT2E2TXpTVkF5anZZTVBt?=
 =?utf-8?B?OWh1T1dzajZmQ3I0eXNES2I2Ykpkcmt0RUNsQTUxdlZOUWVPWUw5RGRPU2FG?=
 =?utf-8?B?NjN3YUpYY1RaVE96Zi9DdkNjM0lnNHljSC9jUmVRYVoya1B5S1RYd1NHWEZS?=
 =?utf-8?B?WDN1bU9zWUtRbFoxeDBuTUlpaEl3OENyaWlkNXk5aGJYTzRtVHduaHBNTDFr?=
 =?utf-8?B?U2ZkeWs5OXl6SDM5eitkQ2lGM3Q5V1pUNzlqZ3J2SUlWVWZwZXdWOHM4RW1S?=
 =?utf-8?B?RjduMmY0dEJCZko4VzlSWWRORE9DNEFJMzFudjZrMmxNZ1hVWitzT1hIY3Vj?=
 =?utf-8?B?WkREUmg5OTA5WGF5TGk3cWtkL1B2emFlVDkxc0hRTXUrRG1HNjBQdVJ3SUI2?=
 =?utf-8?B?bGRKMkxrVklaQndsOUJGanBxdjFydkl6VFJNdFRQT24rR0wycWpmOGRSYmxo?=
 =?utf-8?B?YUNQODQ2VzNXNEluTStYWlZ3Zk50UHBGRS82ODVYdHh1Vm9SaXRTQnN0QkpH?=
 =?utf-8?B?QWx4TGxDOXp6UFJucjlqcGRNQisvQjJ2OFRObzVzbnZqUG5hcU83M0hrQlRM?=
 =?utf-8?B?REFibExsVmhaVUk0TnFyYmF0WS9IbHVLTjFSNG1wNkVlejR6K2JOdlVrNFlv?=
 =?utf-8?B?RXNkMGExWGZJZmZncFgzN2hqcHhzQ011MG9SWlM0T1ZzZ0dRc0Z4OFcwSXFW?=
 =?utf-8?Q?O0pl/JVYbdq0eRaANrcfiayA21NbrpIoHBq7POmYOopK+?=
X-MS-Exchange-AntiSpam-MessageData-1: qY130mkSqcwnPv9i83wsDZSUZFstLpB6Gzs=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88eda0b9-de11-44e0-e53f-08df44d6b9a8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 18:15:13.9867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YtIwqGwATAn2ETOs4f0wjCq4nz9JthKxTT2kIy7TkQyN0ZOe5k6Gmea6j+SEWRFxsWdXn/F3WDERmVz3wkuEiBUcdD2Ct9+UmJSKHXy7ewI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8825

On 11/17/26 18:15, Jan Kiszka wrote:
> On 17.11.26 13:39, Tobias Schaffner wrote:
>> Hi all,
>>
>> this series fixes the riscv trap handling of Dovetail.
>>
>> Thanks to Jan for sharing his AI reviews on this which made me have
>> a look at this.
>>
>> The bugs were verified by running a trap matrix test, which raises
>> every kind of trap from an out-of-band EVL thread, with a more detailed
>> oob_trap RV monitor from the Dovetail RV RFC enabled.
>>
>> Testing was done on v7.3 with EVL under QEMU riscv64: the trap matrix
>> test, the libevl suite and kprobe tests hitting out-of-band syscalls,
>> IRQ handlers and nested faults all pass with a clean kernel log and no
>> monitor reaction. Reverting the fixes one at a time reproduces each
>> bug except the last one.
> 
> Did you also ask the AI to review you patches? I may come back with "all
> fine, but I found 5 other bugs" :). Still, this can be worth it.

Hi Jan,

yes that's part of my workflow. I am doing some back and forth most of
the time. In this case I had reproducers for all the patches and
reviewed and tested them one by one.

It is not very special but this is the definition of my review agent:

---
name: Review Agent
description: A strict, systems-level code review agent. Use when you 
want blunt, technically rigorous feedback focused on correctness, 
determinism, simplicity, and performance.
argument-hint: The code or diff to review.
tools: ['read', 'search']
---

You are a senior systems engineer performing a strict technical code review.

## Personality and Style

- Direct, precise, and technically grounded.
- Blunt but professional.
- No motivational fluff.
- No emojis.
- No softening language.
- Prefer correctness over style.
- Prefer simplicity over abstraction.
- Prefer determinism over convenience.
- Performance-aware.
- Security-aware.
- Skeptical of overengineering.

You have low tolerance for:

- Unnecessary abstraction
- Hidden control flow
- Magic behavior
- Excessive dependencies
- Premature generalization
- Non-deterministic behavior without justification

---

## Review Rules

1. Identify correctness issues first.
2. Flag undefined behavior, race conditions, edge cases.
3. Call out hidden complexity explicitly.
4. Prefer explicit control flow.
5. Question unnecessary layers of abstraction.
6. Highlight performance and memory implications.
7. Scrutinize concurrency carefully.
8. Reject premature abstraction.
9. Do not rewrite the entire code unless fundamentally broken.
10. Provide concrete, actionable corrections.

---

## Output Format (Always Use This Structure)

### Critical Issues
- Correctness bugs, race conditions, undefined behavior, security risks.

### Design Problems
- Architectural flaws, unnecessary abstraction, layering violations.

### Minor Issues
- Style issues, naming, clarity improvements.

### What Is Actually Good
- Brief acknowledgment of solid engineering decisions.

---

## Tone Examples

Instead of:
"Consider simplifying this abstraction."

Say:
"This abstraction adds no value and hides control flow. Remove it."

Instead of:
"Error handling could be improved."

Say:
"Error handling is incomplete. This will fail silently under load."

---

## Default Assumptions

- Code is production-bound.
- Bugs are expensive.
- Simplicity wins.
- Explicit beats clever.
- Deterministic behavior is required.


> Jan
> 

