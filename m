Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795673366;
	b=GVzcCeZ4aLfkwE+OLvKlkmbjcl4crSc1Z00f4s8oc/3rZ1h81cpBWsWdaDJSmmMoucgU
	 dXH7EvmB5VDiymLKLXpODBPwc9cDgFtSXhcx8aU6xUUR4YIVJa3Nm++Yg7Oyw8oQqBZI0
	 tYP5CBT3MbYl47PP7F937NjjH4JBN8F0vC79Wq+A2z0W8FlKOCHgDrCMeJNACEHUaL7vt
	 RX4QJL1TD+YcbYwvlzyvN1HEyNCY9DlHTRmxI87T4IW4wWF4ZnWVIz2y2c9e0JdZk+J9y
	 eVWDrVSvjqPur43MObg0xzJH/YkNyYCDzS9caHJsynN+wEiR+u6s4YC6UV9rmt6El2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795673366;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
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
	bh=l4BF6pDDs58DSMaCyX7V2Te3lEQaXmib3YLXQbvh1j8=;
	b=NOYqce4pDgr/hE0Ha+hbOsS2eJPjSBc8jJouAdnCW4eZD9urxmzg7VFoulkbA5p5q2It
	 ycro+UrBYobzX3Ff8DalMh7xvkcmqjpXz3gNPh4/+J94y72A/Ne0EnesBqqgcdy6EAuuH
	 pbhkjOQB0KczKYuMWAjl6QRlAgHmYjm4TrN9u2XfEhmH/yhAjfiOMSzLwkRksJrZhLUZK
	 lxGSKHYM6lC50+O0rCtkoFJJo79WfCqUMqc9yXMpfyZoLZxbmtIzML2M+QAfAKJui9AAp
	 3ixBHtZnZ28rAdOwFeW+FT0G/hOjYBVyykPpnq+Iu7vBBAt2M74jk9OUhDVGPtTUDig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=kOHqshDl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.1
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8273606A31C
	for <xenomai@lists.linux.dev>; Thu, 26 Nov 2026 06:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8273606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=kOHqshDl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9Jj3p08KBuavxNvif2sxbipw2wZBngfNqswTKzmhnBBKhSVD+H+72WyRRn9mFjMFSMHY89hWkywDfLA/Y9Vw3KqqTp7MO7K2+hyAWMuz1H+qtNb8ZVuEYr2QKlmtx6AHLSlSg7zDZQPUyNr6hQ5loi3yCCZ3wC1NL3g9hZWro/bzQerYiRMthKDaZJi2FWzbTqXejlmGFNsUZqyb9EyyIPdpsu1j9WsO1PpesnkUeYsRC3aB1lzT0Cn+N7Pci6QjpqaZULXVv0LwGPV3W6fwiignS3Bi57YL+BJGTvnrINsZ8qJmsf3ghs3A2RZBWoLphx3LvCSpAMGMt5POFyJqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4BF6pDDs58DSMaCyX7V2Te3lEQaXmib3YLXQbvh1j8=;
 b=VBCDqVQl9G/INELyjgmfSQdZ9C3DOXV1nwGC93KYr2XsJlLuhJXCWBIL02Q2Ee+JwPZrHXXCLrJlFk/gdblvatgM8zFOOIrtPrCNWnHEz+mjSbGk7ht4A+M+FErJ5NgzNMmWdZcQeliqUKiy/7puxofgDKq9+gnFvdE9kwHpF+N9eZkrsCivb2u91qAA+OagSq7hJvZ0Sk+kSPGg0BOUUnwHU/TJ4Oq56Q7fY4FOKjjUCGaHToBnWoPDuxz9/2xFdsoMhvTdW9fZfJew66MRNMb5RRTEDBi+eC6aXKEd/B6xvI9VdsGIkBZDzmt+ZxAE/lutN+n+4R/2wt82PYXreQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4BF6pDDs58DSMaCyX7V2Te3lEQaXmib3YLXQbvh1j8=;
 b=kOHqshDlreVSH6A4QjzUdYHsnKGV5HaJLQfemQAEBbnDchkR3f37HSj3ETtQ82Kq0dVjUUMjkJhHz6Et2ucdMxHx4RN8pU+TIoHYxashpr93ioqvmZ5+lQS31qTdDJf5cVYIFTxji6j9YNtFURudcxd9SZnNmlGBM1qKgKtJIxaaLNAUiVX7L40HQwBigquHrnDGmxrHAWNwcMu5l7sGh+inrFvPFkmjDg/T5Fd1Qdvd6YPAVBepv1tsKvSe9WygTMiBhQil1BKtNRLqED7RZRd7FlgpShViwq4g0ufCnzvUpT0AkC6z0h9lPwKR0lPFO/8CPbwdPXFOtb671e+10Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS2PR10MB8034.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:559::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Thu, 26 Nov
 2026 06:09:20 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.001; Thu, 26 Nov 2026
 06:09:19 +0000
Message-ID: <49e03888-e770-48eb-b096-32dedd9a4aa2@siemens.com>
Date: Thu, 26 Nov 2026 07:09:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] lib/alchemy: Require a Xenomai task only when
 actually waiting
To: "Richard Weinberger (sigma star gmbh)" <rw@kernel.org>,
 xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at, Richard Weinberger <richard@nod.at>
References: <20261125213419.2363742-1-rw@kernel.org>
 <20261125213419.2363742-7-rw@kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261125213419.2363742-7-rw@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::18) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS2PR10MB8034:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b98dc93-54aa-4493-16e3-08df4b83cf31
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|4143699003|6133799003|261009223027099003|18002099003|22082099003|55112099003|10067099003|56012099006|11063799006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	uiM1MFsFV2nAV+iJQEqg81tmUYTowOU6yGMV2qTTBd9ZYM2ogfWZzAsZgHz9G4CBdGskXPu1+T3u5zXWVhMj+UO1+RvVgIZWWJp31P/2kHXN3ct80So0Hj0pHuVQ2cVnC07UHzuGW5SNkEUh5RtzLMLnjOgtDL0dy2/VitB0Z5Sxq/eywgzaY2659Dw8Im1Yj4wl4OhGkEpOiBw793yaJhWflFUCqxiV1WpiCitRBJ0Itw7tApb8HGzzU7bviDrJJOoHciYiVTO5aF4t799ioukHhLr9H3PMSAWMyqSKGnd6NdzT0QRdttway5I1Od6EHoCJ6Hcy/BgPF/gP7EWzM0+6MPgF69WY2Zn3VVXK+CMExyIGeS6ZMSlFcr2gycFbHuUBg1Nqd6k8BY1qtQONv+V5SQXFPwbsvPz8BUJgSNFAhow8nXZrwqH7ELrKVDqwNng25Y41nGIbgOBJFKVHsQAFPahrpfhGzh6+s7uK0Yqi8NjRoaWH6y71fsbhxes+T9cvcN27Fg5p/J2832A41cIaLS159iPkOwIyuh/nb4dh5t8YoaP0oGvkbQiuE9cOJJBY6f2Yfhn3hp64ppGN0g6xwvl0y2Awo1QiCs/GG9/hBS3Qd2au3HJTXbOsM1u8UQcE1xSs8cTJHlr8j/W3Vvr8Xe6eRxurKmZbmtTkdNk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4143699003)(6133799003)(261009223027099003)(18002099003)(22082099003)(55112099003)(10067099003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2tQKzduanhwMll2TXhXOTN0aXIzMkdjS0ppRUpsMkxmN01zM3BRdGszaFJE?=
 =?utf-8?B?TnNONEVleEw0YS85M1BKOHozQm9tc0pKN3NEelNMemFSVlNNZFBRY21zS015?=
 =?utf-8?B?T3BHdi81U1Z5dmNwUTZURkFvRkgyYnlJKzZTT2xxd0FYd1NWVWh4bDNheGF4?=
 =?utf-8?B?YitqQ0x1dGNRVGl1cHgvTjFjd1hDM2NHNWRwayt5WWNaWmFNT01nVWozU1BU?=
 =?utf-8?B?UDM5UFcxSGpqbnVRNEQydGhQb2xhSTEzVzVWcWdCK2Z2QTkxTUYzQmJNN2tw?=
 =?utf-8?B?aFZ6alFXd1M5T21MbkFqYzVEdDMrWXNtQVBSeXc0SDdibjJvejZmWEszOHZr?=
 =?utf-8?B?OGNMbElJSGV2VnUrbG9OMTV5TlhycWZDWWxLYjN2M01FUjVhQ0ltamRpSHE4?=
 =?utf-8?B?NGlRYlhjRGpnTWpHQ0p2UzFVSXVlRmExdVliRlN3TEdneVR5R1llV1BpcExT?=
 =?utf-8?B?aG1tOEZvZzdsS3ZjWC8wVXlwUkJxZmVhSjdLa2J5cU5OM2JSYXdpRFJsRnFE?=
 =?utf-8?B?S1U5R0pCTXpHQzlsUU5WUk5QSjQvdXYwbC8wNXI0VGRJaVFyZERmdU9GcXlp?=
 =?utf-8?B?alpEd015bmxleStKWllqYUcySm4wckJxR2poK1Q3aDhKK0V4TjdKMDZLM0dJ?=
 =?utf-8?B?RU1tUFora20yRWdHYlRUSmp3QUNBclN5UzhwemV6Vnh3YlQ0RTBZQlJNV3d0?=
 =?utf-8?B?bGJNY1VUbktJaDd2Rk16c2ZFQTBxSGVvamhZVDljUEk4UE43NmhqVHhIZURR?=
 =?utf-8?B?aEhGNWorR1NPdHJ1SEVmM1oyWXVIUmJFNVBGblJMZDJWQWh2MkxTaEt6Wnpk?=
 =?utf-8?B?cVp4akdxRzZCZzM2L01oZFRwR2RPTWFhQXhQUGtyUHoxUWNNOGdQYkxIL1lL?=
 =?utf-8?B?MnoyNGZFSHArdlNpTW04VWo4OVAzT1BUSmcvMFF6MXh4aUJIcnpER0Zscjhi?=
 =?utf-8?B?N01ULzVqWTY1b1ZWSEdqcVp3aDRIM2cwcmV4a0xUaGU4byt0b3crNnNDZ21N?=
 =?utf-8?B?M3FadlJmdjVTbU5HMFRnZDROY01TRWNHSlpEQ3NBVmNmRlZXc25STWdLZU9n?=
 =?utf-8?B?NXdvNlh5R0dXRmxCRXlmZGc2ZVhEQzRJRXo1RzB2czBZc0NCRGtTTlluSHZn?=
 =?utf-8?B?ajRSZ2NSYXFRck1QR3RpQy9rN09STFpwQSs2VFA3d0kzVGphTGRGbElnNGF1?=
 =?utf-8?B?WS9mSjUvU0xjN1NSaWFWV0VVZWM1K3Z0ZGhFNkhaMzRTUVViNDF2ZTJudWU4?=
 =?utf-8?B?QkhwOURyWG5oMWFkaXFLUXlyb01wU1ovMWhCanY3d094d0R6elhvRHFDQU5X?=
 =?utf-8?B?ZDMvV3Yxc1ZWUllBMCtKSG5NeGU3Qk1IbStVdFNlSElwV1BkMVVTWUQ2T0ti?=
 =?utf-8?B?bTRsNjY2QWNUeWFHVFBOeWo4cWdtMmVNdm1IUUEvdzlKUjU4SWs3dUxVaCtV?=
 =?utf-8?B?aXhXdHBhRWpOQW5pQVRXTUpmUTlaWlYrbVdhQk9NaG5PK1ZwTXFRYU0rRW5o?=
 =?utf-8?B?bUJkMWJWN0JGN3FsQWFFbThEOGpkdk8xc1FHN2FLRE10NUxkSW95WWlsbVdY?=
 =?utf-8?B?ajZWRHJzQ01yeXA1Nlh0ZkVQWmlaZ3p1eUNGLzN6V2NMMUpUQjcwMEsrMmo3?=
 =?utf-8?B?MlRXM3pGRkp4MkdLTVRJWGhZY0E2QkJPc2IzM1R0QWZ3NWZpUjhOektCeDNC?=
 =?utf-8?B?aXJQTnlMWTJUSUp5ak95VUNhVWpURnVOUUcyV1kwOFA0RitBa0dkSnJqTzZD?=
 =?utf-8?B?QUFCYmh0Z1EwNjN3SzFFVm1SdFhuc1ZGcUthNm91cy9iS29TaEdQMjFDcWdz?=
 =?utf-8?B?WHEvMjZMTnZ0cUJ1QmpYaDdJOGZ3SnFJbXhIb1NPdUN6alBSTTBjV3hONnpP?=
 =?utf-8?B?c21ZUnJoYnpQVlZQR3BlbEkzSFdHRlBQY1pCczVKSCsrb290RE9sTlEyOXYx?=
 =?utf-8?B?MHlOK3Nzbk1pdDZjaFdrd3MyaEhPc2hCOFBMNUhpcHdqYW1Jek85SW5VTDd0?=
 =?utf-8?B?M0lSd0tVcHh1Tlo4VFlqTmwxeWkxcGhKWEEzakNldCsxT2s1VVhOUTdDRXh6?=
 =?utf-8?B?MCt0akhEMU9zcnlQc2wyWmtiLzlnSUhHL0pGMFJPYWd1MW5qdlE1VVl5L2Fr?=
 =?utf-8?B?eDYwOGtTVXR5eEpubkpPYWUrSnMyUnpqUTN0UmZwbllBNUR5eHNuTG4zMzFz?=
 =?utf-8?B?MXh5WlI1SUsxZ3hkVi9ONzdDWmpYU0NDT09zekQ4ZDJ4OFNTOGVDUjUydmMy?=
 =?utf-8?B?bjRqb2ZlVW1SU2tMZHE0bjVBbGVOK20yd2I1YzlUaHZaUVRnVSs2Z1RwbDNp?=
 =?utf-8?B?K0Izd29QRmNZYU1DbDBOeDRNazdMWGVvcWJhbHhpYUk3MDgwRVdrZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b98dc93-54aa-4493-16e3-08df4b83cf31
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 06:09:19.9510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fm/FpHl1/nEzsRn03mD2NoXmrzDux316SwRYsBKzVKYocfFMdngRdfH6/ZP6MQh9YNbjjVe8tCP4tOz1MvPbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB8034

On 25.11.26 22:34, Richard Weinberger (sigma star gmbh) wrote:
> From: Richard Weinberger <richard@nod.at>
> 
> The queue, buffer and heap services refuse non-polling calls from
> threads without a Copperplate TCB upfront, even if the request can be
> satisfied immediately. The TCB is only needed to wait, so check for it
> there.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  lib/alchemy/buffer.c | 24 ++++++++++++++----------
>  lib/alchemy/heap.c   | 12 +++++++-----
>  lib/alchemy/queue.c  | 24 ++++++++++++++----------
>  3 files changed, 35 insertions(+), 25 deletions(-)
> 
> diff --git a/lib/alchemy/buffer.c b/lib/alchemy/buffer.c
> index 4f826fb27..66e37413c 100644
> --- a/lib/alchemy/buffer.c
> +++ b/lib/alchemy/buffer.c
> @@ -424,8 +424,8 @@ out:
>   * waiting for data. In such event, @a bf is no more valid upon return
>   * of this service.
>   *
> - * - -EPERM is returned if this service was not called from a Xenomai
> - * task, unless @a abs_timeout is { .tv_sec = 0, .tv_nsec = 0 }.
> + * - -EPERM is returned if this service should block, but was not
> + * called from a Xenomai task.
>   *
>   * @note A short read (i.e. fewer bytes returned than requested by @a
>   * len) may happen whenever a pathological use of the buffer is
> @@ -468,9 +468,6 @@ ssize_t rt_buffer_read_timed(RT_BUFFER *bf,
>  	if (len == 0)
>  		return 0;
>  
> -	if (!threadobj_current_p() && !alchemy_poll_mode(abs_timeout))
> -		return -EPERM;
> -
>  	CANCEL_DEFER(svc);
>  
>  	bcb = get_alchemy_buffer(bf, &syns, &ret);

This one takes syncobj_lock. Similar for all the get_alchemy_* below.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
