Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2125.outbound.protection.outlook.com [40.107.15.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200FA147C7F
	for <xenomai@lists.linux.dev>; Mon,  8 Apr 2024 20:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712609628; cv=fail; b=PjEe1DxSZLvOED7ybA4fvLIyZfAqn6A/5pK2QXcZZ7nRTEs0Z5kISG9nVGxRMg2SMmYWMdO4olFukL0Pk94FWalC/vK51FsDJWrZZVexuGEuqvCm7oFGneDjHhItCGZL528CfH3N1xNikhIe7owJm/M1VLhDAevI/Peeq9Ae1+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712609628; c=relaxed/simple;
	bh=iuDt+MaA1i7PBzsG3iBgPeaNqYTnS4E+RPQbnzAkeCo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PrKy21OYKE4ivFwFUNbf6z4EboSPNi30g3sSSr0XYQHzYZ9EVk0daL3FZuyr63y6nmB3KBda0boF0vhZ9GQ8/7zhMHzBsxIipf+Ed/RjFYXZGj3CxQIlejg/l6pa94jqBED19KEDTAo71eI3n/P2hhIaJbtldWe+k1UbaVhgylA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QQbeuqsk; arc=fail smtp.client-ip=40.107.15.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QQbeuqsk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIWMzxciPXzxTVrkowgqENjHl7Z8YzzL6NYd+LlhdY8g/qcUfJpnJS4XdfWncWVHw4jjzfonMsEMIW+PjGUoQ8ij8TXNqJDa6UBYGvHXaXivqjxTbWwILa37nat9FBA6mIAIx7dQcphA5q1tsSC1HXBqb+pLjP9bpuKmPjKI3DH9fjQtS0Cwr12uobbrxLULRqRSenyvpUmEYA+D7rjUhYeZVllLNIpSTcrRfnTpfyZWjJET9q+r+7GAUszvIUD5X+i/mn803bJFHsVymC8Qr/aQihVzRkQ8ubeTNdtNdVm+Up2KLcusdr8hjw/oAmh+4L2z7lNKdESyMbx8UluDsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAiV1rFhrJkF0zqvMUHWZjJ4PhZUNOvkwTPw2ifftxw=;
 b=FP+qVNUrnJzmDp3FqSimaDguvahEpmVIzH8UXAT3nuCj/4X/kRjm8bP26uJGmHUfz9QnkqIBWJ8u/OH1FpdKARYSxLKuT5Ukfq2BQMpzCLg4k/P/w8Ub3UeM7v7vDlXgtqer4cLQ45a2Aocl7cv9wEmICSNUEzMoHxefSH0PAHR9m96gg9p7lTkaA32fhJ2s3kyYLWtHs80ek5lHYrmNai7NPMds3GCeTNW9scY/3TAtvH7tkHzg9DKcYwqXkiZpsXC4FuDiTd+QJTPmx5u8iVoXVnv2xJRST3HokEy3226svWnOYZJ1vz/gK9sCveQNV/FELjtOhpNfX2T0+GYunw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAiV1rFhrJkF0zqvMUHWZjJ4PhZUNOvkwTPw2ifftxw=;
 b=QQbeuqskCfEMb3gC5EjUzGq9OqPGTpJYGmzmy8sFONDlbj1gu7k7B1VCkRtnn0iil7ZjMcsGu9xwvjPKeH5TMZxm2sJXWSDrkB90AIVr2EZrejP4f/OYk0uRZQvKpeXCiO17ZZYKsw8jOnQWfdbtLA0CEz+NrDGE9wwoPG1LfrRb2PBdiFUiFVOEEgMTDTZ25QElptq38T8EJ5NIHtBlV+FpbykRJS0BT1TDYmT+sfTlnuvW1wFdOt7SA1iqZhmyJzoyaVf9LbSmsju4oQr0rYhz5bp60KN739SGJx7J+Y1BpK+pNvwYMYoRudN30aazelxXZpSvT/OtHFw5QLQxTw==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4131.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 20:53:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 20:53:42 +0000
Message-ID: <d687e7f4-3002-4086-9cf5-8f37daa935d9@siemens.com>
Date: Mon, 8 Apr 2024 22:53:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] prepare-kernel.sh: Warn when result can be defective
Content-Language: en-US
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
References: <20240403214811.8979-1-richard@nod.at>
 <20240403214811.8979-2-richard@nod.at>
 <3f3e21a2-1f44-4737-b530-ae8b62619c05@siemens.com>
 <CAFLxGvxTuEF5sseZz4_tAwA=YLj95rZzFOM+TyYEvK_K1zxn_A@mail.gmail.com>
 <428fcf0a-6471-499c-b6b5-cdf102a0f69e@siemens.com>
 <CAFLxGvxTQ1JB7XmA=4pxeyQo7t+fV8ueFp5QiWxyKiZW57jr7w@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAFLxGvxTQ1JB7XmA=4pxeyQo7t+fV8ueFp5QiWxyKiZW57jr7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4131:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R5mGyae5+8YpTN2fONPLfLjladpZPDFhJMzeY2h3RDeq8rJpyK2noJsBD5rCqW7CE3j72S1eE07p6ihBGkOIrnrz0uhbAnE3Ism1MhXY1vOxlgdgaD+fPPiDk6PVz/kOcsQ/254CFYgFOzktqcYrmf5gnrZhGJVkpxecX8Sl60HmgRlap0DDRQ0WM3voiAvwLJJuzwBt/fBIhRlP1KqFn/p+Wi5ZxFHMYQSdFdNMoEreF4MNOOvaIfvbuyw5+bPlVU495RMJyfh/EAC+p4lNNh0eXyda4/BZb00IPcLLWveyM8jKV79J3KDng+KKiLEpBMbzdi74vorYuZt4YMr+ZhbLESuYtXi03o/qw/TTpAEybTySEERrh1XY+rMEKpjejx2SdrlG+0JWZuiUnBIK4YG/uH+7RVFypJt8jpY4kWnWibGzz998Aj+vZlnVVT2tGQ575JWKGwNzFd6P+swOgvkEtAKRfjs0uCXt5ahoKV5+GX/e/wMSRy0lTnEf7eaUrwkFk4d2i6Df6d/g+CG3P5pbhNkOLf+g2f/B9ukZBUZ1lQggiL0nr2F+hO1Xnu5OHcJlHWQCMQf7pbPEyolU/T0YqPAOSlz+GHlBaSsbAiLm6fs6SZjH3NKvC46nJkR7FvGVMiSwhwX5/2iBIEZk2+2HwGBc4URZpGMJIUxkses=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVJKZ21EYVpDRzNPVlBmWTlpaHlHVFQ4RVFGYU5hc1Zwd3BwZ0pnN0l3dVNO?=
 =?utf-8?B?ZjlaRDFhT3ErTmxWOCtsQzhUaEJHS1RzbUc2eXEzYXlWZUxueGpMVldYbFgx?=
 =?utf-8?B?K1I4RXNTRFlTWkRTc3RkMXZEeDRhVGYvNVVPQWsvUUJhTDc4dENOZU50dDFq?=
 =?utf-8?B?SitwaDVaWDlOQWJkVEQyam1pYmthSjVWaTZydzd0SjJxQ2FIY2NuSW1DOXhm?=
 =?utf-8?B?YmxlZVptTEtlVXRpbTA3QmxoTDJvSkJERGxIK3ZzLzhxcStEQjVRY3ZmS1Nl?=
 =?utf-8?B?TUpTa3dtTGZYMERqMG9DeTZRSkh6dmhqZ2xZNnU0eU9UMDJ0dlZTNUlRUC9R?=
 =?utf-8?B?UG1LbklzK1RNQzNTRS9GQnBqRm5yQmdSR2NqUmFjaHorTnNsdEM5SlEzZFJu?=
 =?utf-8?B?RVpYbERDbGtPdHZzRXNFQm1yNnpPYjRhQ1NGQStVSnVOa3l4T1lBTzlhYmRQ?=
 =?utf-8?B?dWtLRVk5QXdLTSt6MTRMQ25yQVJvNGdkQWhrQlFoQTlpdEJzRXF2UkJZb2dE?=
 =?utf-8?B?MUJpbWhKVnlPUWNPRHZQeUEwRCtsdmxZSndEa3hOS0NlSjFiNTgrZStiOHVL?=
 =?utf-8?B?NGZCaEVZN3MvMzBDT0JYc3VIclJsWjVxa2k0YmVsdk5MNXNoaG9tb1ZNbGhB?=
 =?utf-8?B?OG5Hdjk4UkJoWHZiR1p3bDBtT0JqcDVUM3FLOFBVV1c3YVFtTkV0N3R0bFJO?=
 =?utf-8?B?Rm5HMjRRcHc2VzNRZ2l5YkxtT0YvSEdsTHFqZHlGblpUSTZpSXZ2VHB5WkEx?=
 =?utf-8?B?WmpnVEg4RHNPdlJCQlo5Q0Q5VmlYTVpEQ1RUZ3FoUDhTT0t2UDdGbVUvRUN3?=
 =?utf-8?B?YTUydm1IZ0dzV3F1S21Nekl4NHhsL05jQ2ZVMEdLd2Zxc3psQnhRQlFjcUsw?=
 =?utf-8?B?cWZ2OXZOZ2tHSFAxUnErd2owUlJHdXAxZzNmdHpHNHhlc2wwemlkdXRqNUI4?=
 =?utf-8?B?VUR1RmdZdkRGcVp0cjJlcTQ5VWxZN3ZGMEhGeHlhQ1RyM1VnbFo4SWhDeFVz?=
 =?utf-8?B?bGJBQkp0R3ZvbzJNWDlQUFkxMjN4ZUJhd1hyaDJETFo4cU9QNCt2QmVaSVpw?=
 =?utf-8?B?c2d0NGFDQlJYVy92OWRSRlgrVU9kWmtWN3FSOHNqd3VPOXBLWlE0WlhSVDFQ?=
 =?utf-8?B?QWFCcFlvY0owbEIxWHI0OE90cTJteGRzTmU2UFB0VzlMTVRGYTRiVWl0YTVV?=
 =?utf-8?B?d0h0Z2JPenZCTUo4VzRvcUl4ZTBoQ05XYndISzhKZ09OQmFjZGszU3B3MlhV?=
 =?utf-8?B?RlNScmdwY1JYbWVnQWJjaW9sUGp0Y1VucE01Rk4yRTVOV2p0ZWpSby92SXBa?=
 =?utf-8?B?a1ZyV1VvVVI3azhuVUI1d1NhY3ZGeUNLU0M5L0hobnR4U3Qza1FLZ1pmZWx3?=
 =?utf-8?B?Z2VMNndjdDhyaDEyMXVPS2tsejFCTFpmaWxaSzFCY0Jpc1gzM1dmMmYwUTNM?=
 =?utf-8?B?UE1qcklmcUl4U0hFS3g3em0wWmNkTnVZWEdNUWtZMjNhWXpaYWJhUzhhYlgx?=
 =?utf-8?B?M00zYjJsaGxOa05nNlNCYVRlOUpHbEdKNmtvdTBMZlFCcE9vczZ4THp6V1BI?=
 =?utf-8?B?VzlYNml0TmlZcVl3TkRWRmY4cUdyYys5Z0tHdDdmYmk5M2Jzc2J1ajBPSEI5?=
 =?utf-8?B?LzEvVTVycmEzM3VqUUdZVW85WTkwbXVnWHo0dTQxVTkvc1QzcGJ3dmMrckt5?=
 =?utf-8?B?TGZhUFV4TmtZei9PRmFDc0NaY2hRS0kvcHB5ZjlXdkVIQXcwWHAwUmdIL0Iv?=
 =?utf-8?B?cHNYbDVNaDBncHFJSEpyV0l1N0JrRW84UnQydDZZTUFlUEdCVVhHeXB6dFo2?=
 =?utf-8?B?K3V2NldpbEhJSXlXM0E2aE5lUlR1ekNVejBzVkpSU1pyYXQ4OVRXWlJveFpr?=
 =?utf-8?B?b2t4SmlkVTBXbnpxM1E3SFpoaWxIVXE5WXZGdG5KZXBzSC9xYWhHZktTL0VH?=
 =?utf-8?B?WjZzelZNS1dKSzFCSjIxSGFBSG1VWC9CU3dZOHdOOVF0b1NmQk15UGxoZHhv?=
 =?utf-8?B?SElNd1VyaWF2dE1EWHVKMHAvOS8raEhmWndYVTh1Ny9JTWZlcFpyVVI5RW9s?=
 =?utf-8?B?R2g0YVArYklNdC9JNXRWQ2JDRXVadDR0RFdGYmZCTFFZUVhNMFZoTzdnSGMw?=
 =?utf-8?Q?EemvHbOMMoA8blo8pOsnN912+?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7392556b-c247-4786-a851-08dc580df95c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 20:53:42.2081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wndS5qCFqpqrXpN8jUVUrK2gJpEJkjITMhJ8ZXbe9L48JFYwDMXhx2wcCDj3nuPz15szjX4PXWotFIsDDJZA1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4131

On 08.04.24 21:46, Richard Weinberger wrote:
> On Mon, Apr 8, 2024 at 9:42 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>> It triggers, e.g.
>>> rw@foxxylove:~/xenomai (prepare_cleanup)> echo zonk >
>>> ~/linux/kernel/xenomai/lock.c
>>> rw@foxxylove:~/xenomai (prepare_cleanup)> ./scripts/prepare-kernel.sh
>>> --linux=/home/rw/linux --arch=arm64
>>> prepare-kernel.sh: warning: kernel/xenomai/lock.c already present in
>>> Linux kernel tree, resulting source tree might be inconsistent!
>>>
>>> Only when using the --forcelink flag existing files will be overwritten.
>>>
>>
>> Nope, the file is overwritten without your patch. Now it is left
>> untouched behind, and the preparation is indeed broken. That's not
>> really an improvement...
> 
> Dang, you're right. Just tried myself on the master branch.
> What is the purpose of --forcelink then?

That will likely remain a mystery. It was once introduced via
bc2959c7241f411b15396fa6811fb57213c998ef, but that was under-documented.
With 7098866e087e092701034e0b950ef5eb4ea19a0a, I suspect it lost its
relevance.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

