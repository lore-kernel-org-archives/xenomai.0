Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429081E493
	for <xenomai@lists.linux.dev>; Tue, 10 Sep 2024 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725975130; cv=fail; b=AnUCEzA9EUZTmg2itsgG3qo6kN8gzeImIbJhmDjLfREAFW/sl+bEgD/GL5WeDKRDhxVt8dCEK7nzdolY/LUHdtbD530bTt2LLE1bsbZChkejqW5UbJkA9JTnP93+3f/ESOE/8bdq81zypSBIgrvY6pWt/urbGKAXI2K/qKaZ0GM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725975130; c=relaxed/simple;
	bh=8kuDQPsEyPMlobvS6oHbpUFA1rZH3LPcanV2VUGuG8c=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=trfbBc+1A8siHs29Ohh1XUphP5j91raNFYbGuAo2pDI9rAmPHMPgWoLZG2P+YrDp3t7Q9gq5I+0f8CMX6dS3Ccf7kFnrc+jg42eOvlKt3H6AqRbvcWIwE+/tRXb9ys+jwY/lZmLVRvrY0jDQhFTQMAvyk4XAddgaVbTGOoowjbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=lnU30jbT; arc=fail smtp.client-ip=40.107.20.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="lnU30jbT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAZI0NN0Uvl1NA9ibpnoFgfSLZseeA+0HhLzt7mrMlMutgeFcSioSrobEmaxMJfdhBO9ewAC0i2k9CCAmME/3sZ/ZfvswWd6knQtp+ZSKav2Lry7WATNF5anE5pkoaCbnuTxY/mlkTbSi4nBcJC8gxaV5EPAl7QSnZeHpl+Ca0k2m9KWHqBwCI3N0QCBlqYswyknfh8rPeQLoVLKU1P94K+V44v0ZCyNOcQvgN6j+2P08hqQCk5nfNeYbH3lOpT7KlLebeIcIZxP8z+yNRP3y6A3RRdo1zHxdazdk16ggFc6R+feAz528Mn2MaHJdLHVq2QNakQX9kQHz0HyjPQNOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIhj9m6kLFULs7sgUxI03NIsXI4P5UMO9nwRDF8j4wI=;
 b=uVpoa7I8i//FPgcGZ7oVGQbD4zeGCqd9TvTv3Ns5SZa53SNu75a4Dr+EBTvRmJNCYks2cLBGxYGba4qUn5FN1/JlS/nHoOqdNxwS6XJ1Gj6h++P3Dy9+ClX5CFolhFzh6sRPC07U7qSQJtwSj2p18BKYZt0v0VihEvMNAesYWlPYXVox3I9cKZRSsIV3niavybIj9H7IK0MI3l0s4hhJuaFZj7+YppNj8sURXT1FDlcJ766HSH2lZJcRLWMhPrlEGgCzvVUf0vLTku3kOKhhUkGWJXk7E10uDY0dweq0B6vjSXrCpA+1K75bn4cv2OXQg4xzYRFcVwRAPHBYX9fJDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIhj9m6kLFULs7sgUxI03NIsXI4P5UMO9nwRDF8j4wI=;
 b=lnU30jbTJevx0Y9h1mPbosatw3sNsTySvHYVGED21WeIsNbETd0IJ+SztNY1p9vMiCAc9EbH0Ai4/n2A8mKDoYvj6CWvsSVHx3mSpFZ4UqKtfrZpotPyqiuCBnFlCJ2T+xokQQh6spFJqQh9/a42LsLBAk2w5kTlXAbOj5K63dwpdxyksBHp6fC4EQ5TEx3GFwhOEgup0OWGfqxU1QHzjV3iw3rdeS9CQS4LrvuJLqy/up9Y/nq0xc6Wt1vSNhxPo+LLSJ5+F/kFzlXXKkT7XAKIje9iE2l+TQaD2fS91haDrXJ0FEcpopugeuXgvdyss3eZitXyI8ezvTods7p7PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB8021.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:407::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 13:32:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 13:32:04 +0000
Message-ID: <e45dc61e-bcae-4d45-aeb8-d195528428f7@siemens.com>
Date: Tue, 10 Sep 2024 15:31:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Compilation error kernel Xenomai3 for x86 32 bits
To: LE-DOUARAIN Marc <m.ledouarain@fareco.fayat.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <AM6PR05MB6024420AB2F1754C19B5612EAD992@AM6PR05MB6024.eurprd05.prod.outlook.com>
 <fc38f3af6fa7b993fdbc81deecd7134ad6a39af4.camel@siemens.com>
 <AM6PR05MB60248E3F1360E8FDFFFADCD4AD992@AM6PR05MB6024.eurprd05.prod.outlook.com>
 <f8bdb69f-b500-4a5d-9739-90cb1a1a88d8@siemens.com>
 <AM6PR05MB60248187776E0975A0D64FBBAD9A2@AM6PR05MB6024.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <AM6PR05MB60248187776E0975A0D64FBBAD9A2@AM6PR05MB6024.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0037.namprd07.prod.outlook.com
 (2603:10b6:610:5b::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: 896b243f-9e70-4187-1551-08dcd19cf577
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzBtcDVMdVF5dk9SOFNQT0YzZkR6SW5kMFNwUzNDc1pDWmgvU1VaZGNWdFJv?=
 =?utf-8?B?bkM5Nm1scWdYdnhIKzhIT05HOWsxeGVKRi9uWjd4K0syZzFmV2dKbmpPTDdH?=
 =?utf-8?B?QVZPMkpMRnlhNkNteG1GMW9NeUlxYWZNY1JIT1Y3cncwVFVYZi9yRGRqVXlh?=
 =?utf-8?B?Mlo2Q1F3WWd1ZGRrWTNkZ3FNbjhhY1R2ZEhucXlaMnRCU3JzajE3R0NEK3Q1?=
 =?utf-8?B?bWM2ZXAyRnZpanlBTkNOcGltancvL1h3NTJRQlNhdFZPWFZjclFRbFpCOE9u?=
 =?utf-8?B?ekZ6RU05ditIc2Y1c05lNkRNTXVaNm4rc2hWR3I3UWRNVUxlMUVHNWc2UnBG?=
 =?utf-8?B?N21pTzdHMVJISUxaQktaRURlVGRrZDVyaVo2MEh6UmhIV0ZGdnBNYmM5UFFY?=
 =?utf-8?B?bjVzbi9JZXBVbEE2WXRPWVJnNDBpazBHVmpSRG5FTThEL2YzYTV1bkxYVTNI?=
 =?utf-8?B?alM5UnhETkpleHk1MHBCYmRtVERLN0loZXMvbXRyc1dma1hvU3hzN0FSWURE?=
 =?utf-8?B?aUFlK0FmaSsrK2hKNDRCYm90TDQwZUpmNHUwdy9VeUROK1dKeHpWb2c1QkpL?=
 =?utf-8?B?QmN4M3YveXlBZEhCeUdHbEU2SUNlK1BmRzB1eHA0R1ZMV2M0SjBPamNUYXZp?=
 =?utf-8?B?elN1eDlGNWZoRUl0S3Q5MU1iK0VvcnYyOS9Fc1A0TFMrQjJMQ2djVjdrMUdI?=
 =?utf-8?B?bXIyc1I3V3RtbElDSHVBaG1IYzR5eFFTMDBYajdIUFovN0FwdkhHRjYxUFRi?=
 =?utf-8?B?cURuZUtjZmRWc3g5Q1pWK0REeDkrUWR0dzlqc0ZCZHRxVGdQeFd6bktUR3VP?=
 =?utf-8?B?SEw5eVdHN3lkU0d0VVhVMUNwTlZPQ3JJcVJpSDE2MEROOWZyK0lwSWorMkpF?=
 =?utf-8?B?WXR6MGx4V2ZCL2pVVnE5Y3lzTFdJS1JqdlpJWThYMjZVcDg3MlkxRjVLWStp?=
 =?utf-8?B?TkJSK0E5RUNRcmtHRFhMMzNXOWEwZUlqejRKaU9Tajl2dVBGUWhHQzg3NjEr?=
 =?utf-8?B?TnNqeW8xZU9DamIrdlVTbEhYcytGNnB3S2poekZyaGE0WVNFVEIwNDd4bG5y?=
 =?utf-8?B?OUdPTjdXTlBKeFpqUUVJb3Bzams2bCsyYU03UVc5bzdneGdOTmJTTXFNamJD?=
 =?utf-8?B?UkVIdTdkWU0vN0d6YUpjcXdscDFYYzdsN2lpeFVlVVV3b2F0cFVIa0NZSUZx?=
 =?utf-8?B?UjB0RzZwTHBCbWNkbEtMN3VqcFA5NzVmbmI2c3cvWTlEU2JsQ3NvS0FMWEJB?=
 =?utf-8?B?OC91VVEyM014QlhUVlZBT0Q4NmovbXVoTGE3cFZidHZSSDNFYjZJUnhkQ2RE?=
 =?utf-8?B?MjFLR1hRSHhDWjVTc0Y1cm5ucnVkOUhpYnJmM0hReDNSK0NSeE1YbnJuTXNC?=
 =?utf-8?B?cDNTVXBtSHA2bTNoM0ZJNTI0UmRRaWZ0MUZWKzB3MjZJeWQ0TlM5eW1JeWMx?=
 =?utf-8?B?djRXYXRDekYvci9xUWpvdklvTHE3WGx1b1dhZ09wYzVjcU9wYmt5YWdMZm1S?=
 =?utf-8?B?RlpTZ2hmd3ZKRVlER05jZ3VrVjIwbmtrOXFUaVhBQ0x2bXlhcEJ0dXpDa2kz?=
 =?utf-8?B?RC80VGZiczRIeTQ4YWtlTEpRN0JiblhDQS9MRkhZQ2p5R0NhTGlHREFnc2xB?=
 =?utf-8?B?L3JNNTlsdlJpMnpsK3pLblhOOUQySXVqMXFrRktUT3pwYzBNSUdyOUpJSTZJ?=
 =?utf-8?B?YjlpN1hZNjdtWCtoNVB0eHJ4Qi9uQTdaQmNOUEcvMDRBdCtOaTBwbytjNVQ1?=
 =?utf-8?Q?fKay9Yp8DWTs7z3Bpk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDQ4WDlwdzlaU0FYY21hM1Q5YS94VHBjdTB3SlVJdEs5V2JXT3Q1L2RoKzZl?=
 =?utf-8?B?b0pweURKSTc4ZjVLbmYwSzgxQzkwSEZkWGZ0cGlJNmJ2NnRJY0ZnVGU4TUVx?=
 =?utf-8?B?c3BQL2Iyc2dYM0NsQXFtZGF6S3lnMXJCUDdKd1VYQy9HQkllRk9WWlhTVEY0?=
 =?utf-8?B?OENickNad1F2VnFUZjdjSjdVcmhXNVdKdmtoVWR3T3d2dUZFc1BRa2lTekhQ?=
 =?utf-8?B?NDEya1RKenZlTEhiNW5GeFp4V0o5SGgvK2k0RzErU016YWxHT1hwSHZvTnhk?=
 =?utf-8?B?TGNmVzkydHJ0a1BEQnF1ajZUNEN6MThRcnhKZ3lNWU1IQ05nVEtPMEU1cTU2?=
 =?utf-8?B?NkluQUlSWkJhN1NzT05tWTNHeklHdzE3M2FIdVVpN1hJNTZxWUYzVkxFZ3Ev?=
 =?utf-8?B?Ynl2YVBXOVBqUExQWDVvM3NaU0o5WkZrY251aGhha2FtRTYrbG1nQmFtd3VF?=
 =?utf-8?B?RktPR05Ba2wyOEdqMTdpeUVIVWg3Z0Q0ZDhZWkFXVEJYNmM1SnRPdTUxOVdz?=
 =?utf-8?B?aU5uVitqbEJWRzBLTXp5UHd3RzBHcjFBdzV0VTROenpXRlhpdlZ2RllDK2V5?=
 =?utf-8?B?aU1zK1o1dEJqQnZaa1RxU05ITU55U2wrQVpVT1FDL1UzRHpBdG5Tam03aFhK?=
 =?utf-8?B?TUVoRDNVbWhsUUxYY2ZFMDVZRkdiN0xZZDZRQWpjZHUxakdnTWdWY1FjSmVa?=
 =?utf-8?B?M0h3UzRPR2RlSjZraUk0VkpVYkNLQmI5V0hzU1FvK1hhRGx5VmpaRnJhZ3Np?=
 =?utf-8?B?RzJLa0UyZTk5Mko5NzhndmpNUVc2eHh2L09CVkhtRnpZRTNCOEFUV0dMNkp1?=
 =?utf-8?B?U0IyeUliaWRMTzFrc0p4M0Y0OXpkTE5PemJMOEd4bGluMlIycnI0RTgwUEFT?=
 =?utf-8?B?SXVQTG00SVM3ZEt6UXlob1R5a04yMEdSOXFwbUdhVmM2V2xBWjdvelIxN1Vk?=
 =?utf-8?B?K2NvdWk5RzlLVVNVTG85S3psYThzT3NITmt1MGpHZ1JVeUpkU3pRWFdTQVM5?=
 =?utf-8?B?dGhMajhFaUNjb0MvQjRER09ya29hL1VYN3EzMWVLdTEzYU5wSTRGUGtlOEZQ?=
 =?utf-8?B?akRpbGk0QTU5TlZ4ajVuNXNUTVFjYk5oSWN3S2psaGUwRWhtWndmeUNHQjhY?=
 =?utf-8?B?TFFKc1AwaDl2aWpNM0wxZXg2MVVZNXByNStnbWFZTUtJbWFGa3N6VkRrd2xk?=
 =?utf-8?B?dnA5NUt3TjkvYWVRUFFEOGNnOXVsRFc3QWd5NE9WTWdzakpHVGZ2T1BtWDY3?=
 =?utf-8?B?S1JwMnlNL1JuY0l5VFlFeWhHT1F1UE9IZndCaE5wMTNyVU9aNVZrVmRVWmhw?=
 =?utf-8?B?RjFRZmhhblhtbGJyNllIczhyaGhXeW5IZjBTaFIzYWdIU2E0YnFEU2I1eVJJ?=
 =?utf-8?B?dGtPeVhLZEtQdVQyT1FESjBtWGcvRFlPZnZGa3B4dUpMU1lqMWVQb1BRNkVh?=
 =?utf-8?B?M21EdTNEU3Q0YUU3RzM5MkpEaFBqNW9UZkdjWjQzalRnbGZZM0ZEa2VOSUt6?=
 =?utf-8?B?TXpQMmZ0YVhCWTVmUjl6Tm5naVF1cWJBUlY4MkdqQ3JmYjF0OEpHVVpyWkVw?=
 =?utf-8?B?dSs2VWNwNEExOUdMY0ppNFczY2NjSWJjdHhHbGlpYlNQR2k3Mlpub1E3emhP?=
 =?utf-8?B?STU3ZEZaVytrdWdCVmliL1pCeG91azZLMjJBRlJrY3A2M2RTRG5rdVh4L043?=
 =?utf-8?B?TGk5RTIrQkZTdmhWZ2puRjZpZWtHbEZza3VybE1SeFFpVDQ4ZVd1TEdsNXBL?=
 =?utf-8?B?VWVuNnJqYWJLTU50MWtaWHAybytSa2pCcTNBQ3duTE41ZmVvUFVPbkY2eUkv?=
 =?utf-8?B?QWt4QWVvU0ZjcTN6ZkpxbDFHdW9CYWVSb2I3QmE0elRPZXpiNmhDNE1QMTk2?=
 =?utf-8?B?WDJ6ZkVsWTZybVZEUkdib1hxZ1dRTzhIMjZNQXV2d0VFeEZOcmNLQTVZQ0lK?=
 =?utf-8?B?VGpQazVpN1hwWmpVZ1grWHFMNCtsSW96VEVVTmZWUTNoWm92YmgrME5YT2lX?=
 =?utf-8?B?V1REeE5Gc0lQblQ3a0JxUmwxZkI2VnlkdklQeFpzYnFDVVBXT0dhZGg4M3Fn?=
 =?utf-8?B?ZUVPY0REOEpQYi9Eczk0MFJ0NldPY2FDVG9TV1R6c2VpVVo1bGthenZaKzlw?=
 =?utf-8?B?TWpTNUptSktiQk4wS1FRZytZbWxSV3hkQmZGdjYwWFQ5SFNJUXhKZjRuN2NH?=
 =?utf-8?B?blE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 896b243f-9e70-4187-1551-08dcd19cf577
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 13:32:04.4367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PnUhe+UYnoUzUNsdqQMuF2nR7OcE/wl0Fdu0eyujiVfeAD0Rl5vA3+8vvPzqSC2qL+HMGCxAf5Z7QOZlrDeNCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB8021

On 10.09.24 14:46, LE-DOUARAIN Marc wrote:
> 
>>>
>>>>> I’ve tried to compile linux-dovetail-v5.10.214-dovetail1 github 
>>>>> repository for Xenomai 3.2.5 (from a Debian12.6 i386), and it failed on theses errors :
>>>>> (the same with Xenomai 3.2.4)
>>>
>>>> I think the main point here is that we do no longer support 32 bit kernels. We still support the compat case, so 32 bit applications running on a 64 bit kernel. Might that be an option for you?
>>>> Should work as long as your board supports is 64 bit.
>>>
>>> We are working step by step to update OS with an old base hardware (ISA bus) as transitional for now, and will use a 32 bits CPU "Vortex86DX3".
>>>  
>>>>>  
>>>>> I’ve used the command « /prepare-kernel.sh --linux=########/linux-dovetail-v5.10.214-dovetail1 --arch=i386 » before configuring kernel.
>>>>> Not better with linux-dovetail-v6.6.23-dovetail2.
>>>
>>>> Haven't touched the prepare-kernel script for a while. Seems we should bail out and complain loudly when trying to use --arch=i386.
>>>
>>> If I can understand that for the “new” Xenomai 4, 32 bits is excluded, 
>>> it's perhaps a pity that Xenomai 3 can't continue to be used, especially if there's not much to be done to fix it and make it work on 32 bits.
>>
>> 32-bit x86 kernels are practically history since almost a decade, independent of Xenomai. 32-bit applications on 64-bit kernels are still supported (even with Intel upcoming cuts), but only few people were testing 32-bit-only x86 kernels that long ago. Probably almost no one is doing it in this decade anymore. Distros have dropped 32-bit, and CPUs that lack 64-bit support can be counted with one hand - if not even a single finger.
> Although rare these days, some distros 32 bits are still available, like the classic Debian ! 😉
> 

Right, but nothing I would dare to deploy into anything mission critical.

>>> Is the error, on Xenomai side, or moreover kernel patched ?
>>> Which kernel / Xenomai latest versions were running on 32 bits for sure, or at what time ?
> 
>> I would not say that Xenomai 3 is definitely dead on i386 but no one looked at it in a very long while. It could theoretically still work with ipipe-4.4.y-cip, but anything newer dropped it. While we are still carrying i386 in that kernel, we didn't test it for many years now. Also note that this kernel is now getting closer to its EOL.
> 
> I could effectively go back to ipipe for this transition stage on our current hardware.
> The latest ipipe kernels seems to be available here : https://source.denx.de/Xenomai/
> but what is the difference between repositories ipipe and ipipe-x86 ?
> What was the last known Xenomai version 3.x really used and tested with ipipe?

Here is our full test pipeline:

https://source.denx.de/Xenomai/xenomai-images/-/pipelines/22174

3.2 and older are still (or only) supporting I-pipe.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

