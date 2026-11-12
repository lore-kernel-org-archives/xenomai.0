Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794501113;
	b=VyAmq22yId7SepqXwkssjzEyf+3Vr3EdPU+lgaDFjbCWpRJ+8RidmUv7XY+ZDVXAdfMB
	 PA8nxSG3iBl3VAQ4xEqcbSbYIbQB6iDK4t+90Rg1SStcsmCjZOWhUuAyYG1TMUAMnlTBJ
	 ZUtljUDngVzTYRtA8AFZNP4nk6Zft4lY/EkufcaCxwv8j2USk20joqUBhCuXW3kkEJarD
	 DJdvUjM1dq9o4tcZdh3G+thMpa7olkeeTW7Z2IL0lPK7aKIFBO42TgAWdBH7+l6FYj4XV
	 ILfeSWgcTnMNoXj/AAXJrpI/AnwOtS7juoAAQ2zczJF5dhFDnqrPy/oNOBZ6D4o9NIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501113;
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
	bh=r9byfNeEoB9b/sg7uTnVSQZjbupoc9Nj3ZfrnEZkoUA=;
	b=prTMWqojLnCVKL1tjdc6pJv1350x9qT2mBYJV4Ye8EfC6BiybFnEU60C9SqaMwFkAfJx
	 p5M4RI2WYiseyhTEqfUNWfGcLZ9YwXPAflH1GUzfrWEqxG2N/I+ylYR9JcP+Ri2tjwkGw
	 YXJ2HPyc2WC4aGTjyKJ35Bh9yKc16CLOHS98dHKSI4VWTxtvDZZhAfTsXnavXp4aKJb3S
	 l8eKgrvUJC92XhbZvN+P2edd3rsaGc17+VvgWAqb2zq9pjldzW68n9DzlKDv2leRFP4mw
	 2OiKh9QjJGkcjz+NeRH1Df/J8XvhTWgRvNGwQ/bJxjiUHcSAJP+1Ysl8Wi2vgxRaqTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=bL6n7pxh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.43
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011043.outbound.protection.outlook.com [52.101.65.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7893E606A327
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 16:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7893E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=bL6n7pxh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FggvVaDh8yybg5lGAL9DQP+BLWLOPjB147aVUzcAeVgzt06HBlvSI/q9ywq8rfijY8Uf1do3TJTgzZgO4h8TAm6lkX+Irh9uIXB8MsOtN37YRGP3jQW6BDNGuwoevdn2fu42iGii78b3yc8OXRrfjUHBuy8RNiiEfkDZwPbO4hW34ZTsJDZ1OfS7UZou2LAFcjNb7Rjg+GET1RBPi7QCU2KrP67q1a/NhhGaYAaclE1F9EmykP2GFnmHDmfza/mRZKwFhRtG7gf+C8q36BDTPJ0zToQ4O7z1oN2Gvphtmj5sucm+g+0cVcyvr06/t1UTMFlQMPSXtw0fLDsshg5T5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9byfNeEoB9b/sg7uTnVSQZjbupoc9Nj3ZfrnEZkoUA=;
 b=Y5TIaM8Fhp7/Xx1riEm9VKCpzM8+4CMZzt0Ng2SkQeB7ljL6zFzMYz4MjqQ0AApzpMbkOMuTAeqXurY1PuRZ/WzzwKDzpCgc1nhZX+6606mHtiVEE5eW2dDWqrmZzCQinnB71Rvi248BonrA3ax2tjlkoKHSZke9LVu4oY5DbF2mK59hMyLC+bHbn/oArI/WpVfyHyABxi9XQACiWXQaqbpeS1i1/zF32mLsO+pI8c6BCXGz55eDW4UetrwsRhA1pAkklHWh0CcBNKKhyVE1QdNUttVRxmRqNyw+tHt5PiQzZ8AEcjVX0bW6zJHWIw9IRFCPXIL0TUoOleK+RcXMLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9byfNeEoB9b/sg7uTnVSQZjbupoc9Nj3ZfrnEZkoUA=;
 b=bL6n7pxhR64fPyv+YUYztdqQS5D6qc5Nb0Tl5NlVz0507U71LCmWNYbS622IrIEGBg2k9Nw/j9UsKKRUOLhJVGyT947hj20tT3sqtdOdDUvtPyvzoRh36Nw4//zbZULjLysuuwkWtPcvejkAfIbzCwrR/b7djAEJnPdlrsQAQXoSbKE7D7jL0RZd6Z5wK5KPWAOc4//l9CrvFrl+kH19rOLPV00shmpuq4IR557Hjexe0FZ63tR+9wZRpT3LdwW1UGGjNJHFUBfyWW3KDtFC3R0umJfP8hZHgZDTNPs945UTmzksouDuj1/jh/uwHyNe7RzVaZoMbGs9GXyFNyaxLg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AM7PR10MB3142.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:10f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.0; Thu, 12 Nov
 2026 16:31:48 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 16:31:48 +0000
Message-ID: <e321f2b8-7074-4e2e-8db3-3bf50232903c@siemens.com>
Date: Thu, 12 Nov 2026 17:31:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: New issue with 64 bits wrapper
To: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>
Cc: xenomai@lists.linux.dev
References: <1209-6af5e280-177-5a2d1100@131733382>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1209-6af5e280-177-5a2d1100@131733382>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0224.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::19) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AM7PR10MB3142:EE_
X-MS-Office365-Filtering-Correlation-Id: 88321081-cf62-4cff-b792-08df40da72ed
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|6133799003|261009223027099003|55112099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261022075727099003|261026121527099003|261022105027099003|261021121427099003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	6DJMgST1H1FmPABh5ktvF5RU7Bp+Ns1B3KKX8BNqhgsPhrTkNl919KLPfEiLQAPQhDjT4T86G1yf/nbzJELM7qRggnAQXznHGbiIkf2EkfAR+vtVnTNPrHmZqw4hthS4YTDO3NJWYNNQoxAlZq86kAWmOQz0VhbG63A4kWXxLxP5QKxOZ4O3HyjoeiVxtYMhJY/FllMLhyUuA+9ZYHF6xjuvgdnd8grCQaiNpN8OD/l7UDonJlOI7gC9onrUlmPVEJfYQy26ObhdB8G8/Ios7GazZt7qvgZ6TY/8T7jBPPITny6cIl8sIsE680LFVO2scdJQy3UVW2DfqPkS3FvmD6CdP0w0agbQIZgYS0xCrezXRMuPtJjdIRHK0kp0ece2xWCCz6Rn+wNK3Fv9AKtafZxdCQdYXhQyvm80wKUo1X5PrkzDRxw49AOmgXtxF5SoWec4L2HkdMxNbK4sAzHQbNAcm9Qy2IbLp+7D38a5vlcxubDvh068QkmN6zllG2uL0roNi6DHrmiDOH6RiAVJxUjAgjDlu0GizMDhIe0l6lYLbq8mc9pTcLoqtwXFvsTMgG4SmhqCRvJUvOn512bAUi6b4MWCh3S8OstAO7viEQ27xJgpmQ+hW5fFQwOWJfaAqBzORbiSyNv/CE/wHBrFJoYoCYetjIOF7/B9BNh4mM4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(6133799003)(261009223027099003)(55112099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261022075727099003)(261026121527099003)(261022105027099003)(261021121427099003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elpuamJrbFBuZXNueityUW1DL2FYbjJCRVNNLys1TS9Fb3FPVHMwczFDNFdZ?=
 =?utf-8?B?Ri9UeGliT0dyUnJOQmxxOHY1bVdEQ3lDNXhtbzdCY3JTNjdNNUpudUhOMGVo?=
 =?utf-8?B?Q0tIcXNjbzBtMVdFajlFNUp2SEc1bjlKNUlrZXU1Vk1hOUQ5L2oySXlhS2dU?=
 =?utf-8?B?bE9pbnVBT1FqbFBjYjBiMWNkc21nblJaQ01hRk1SREZnUGZEbnZvQkcxcjZM?=
 =?utf-8?B?ODN6MmtHVmZUK3h0M0tIdnN0Q0dwa2ZhZWFVdnNRMzFBRnhMV0Y2RFdzb0VO?=
 =?utf-8?B?ckJNS0FMS1pMQXNBcjdDZExsK21KWFhhRE9RRDl3eWJtVzF0OUJxMXltWnpX?=
 =?utf-8?B?MjR2blo3TkppZWhybmpjR1FzRXArTW10WkVYNGcxeTRQWFVRbFNpOUlycUtl?=
 =?utf-8?B?R3JPR0F1V1hCNk5wYzlqYTd6TWlhUUZyYVpOL0RvTXVRelB5ME56R2hKVFR0?=
 =?utf-8?B?RVUvSHNCRlhxUHNubTBVQy9oOVZiazNmUlhGWTZOa1AxaDlPK2tYbEhMVGtL?=
 =?utf-8?B?b2Frc0Y1aHlGVytpb3JKbFdHYVNsMitycTlrMzV2RkxWayttdVZFcFZRWFlR?=
 =?utf-8?B?WUlHeWRFdU1BVHBnZmRVK0gvcXlHVXJvVnQ5UkJmWjVyYmlDZmZEVDIwaGNP?=
 =?utf-8?B?U1Nhalo0cW05cDdMaUEzZnZITWdVTWZtU0k5NDZJSXRIMjVoeUhadzBMOFA1?=
 =?utf-8?B?QmN6N1NVTDJQN3ZwcjBwcHUzendrcWM5eDh6aTdCTy9lYldjSU5JaHBGR0M3?=
 =?utf-8?B?d1VlNEZIZWV5SXdOaE9GSDZoZXdEZmo1Wi9RZXFMdHNiUFRoTDh1NmVzOVNk?=
 =?utf-8?B?MHJFMzNxaUEzUlhQWlA3d0M3YS9HMVd2NFdtQzZrdGJqdDVWS0dqTExuZmRs?=
 =?utf-8?B?WWpOZ0tzQ1JBQWQ5dnZ5UFhrdnhLYkE0TkcxWjJMMldPamlwclJrNU0yS2l5?=
 =?utf-8?B?N3pVb2pKMDdsY1h3OGRHblZBcHppbTUraEhrbTI1Sm81bUFicXkvK0t3VEtz?=
 =?utf-8?B?RHFTcjNPVFd0b3NycDVvaVljSFlFU2xtM3JWYzIzNTlYa0N3bFFEdkNHNE1R?=
 =?utf-8?B?dmllTWVFOXp0Z2piRkpDV1c0SHJhWVZFcDRvNDJHN2tqQzVWalRMQWRlTFB5?=
 =?utf-8?B?MVVNNzh6Q2pUVmlpY0ozZ1kyd0ppeTJZU25ZdlVLcE9vYStaNXZSZlhicDNr?=
 =?utf-8?B?UDFQamhnUFNPenlQOU92ZU9zNitrQlZueHEyY3V3aGdUbC9ubHp5RU9XR2d6?=
 =?utf-8?B?cWhIc2Vjd1B2QjZaaTFIcCtwSmE2VDBKbmdGRzlSS29YeGJsbUdjM2xXRmph?=
 =?utf-8?B?Ump1L1FtZnp4TlV5dWF5c3FJdFYxdmZjcFRMTUk1Y3VKZTFuMTAwajRId2xv?=
 =?utf-8?B?cE43OS9hck1MWmM4RFprZ29hZ3BCMEEyTGwyc1o3YUF1OWxuWWhOaVpNREFF?=
 =?utf-8?B?eHB1SjQxNlVvakpnQUhvTmFGOXZWdjhuUEtTaDFNemRNVGRzK1d3dzZpQ3ZE?=
 =?utf-8?B?UEtRWjMyLytDbktWckNacGpzSG44M1VjRHhoUjJJRkFRWFRUYWZXb0QwdUxi?=
 =?utf-8?B?dUpVd0oxYnVTQnQ3czlJSjdhSStRWGlnRWpZT2dPM29OTTZSQmJXbVlQTDVh?=
 =?utf-8?B?SEROazVaMjlWMjg2eFVIZWxCN2lINkErSGFNSXo1S1NEY1RzQXQvZktub2Fw?=
 =?utf-8?B?UDJsNDJ2OVJqd04xK2t4UHhYUlVLbmlWaHYvMDNvTTZKaTBVZVdRZEQ1VmNP?=
 =?utf-8?B?RGZkY0hLTGFLTUhUWktqb2l4OTk5dEd3MkpJUTVteGJIMU5yR2tGVGIzSW5v?=
 =?utf-8?B?eWtCMTZieDF1cnpNb1dTNk4rVmh2NjNsM3ZidUtkMy9ua2ZEK2htekVBR3VL?=
 =?utf-8?B?QXBtQ21XeEtGb0VqOVB5S205U3NEeHhaVU9JTFZrUXVFODVVeGRFcEw2cEU0?=
 =?utf-8?B?K1ZHYnYxdS9UR3c5Z044ZVRhangzczIxR3Z2V3FFWlRrOVpGUjd3QzQ0QnE1?=
 =?utf-8?B?dGx0Q092WHBzbkEwK1JQcmlHOWhoODc1NWNCeW5GSTJrSkN3elpCcnljL3E5?=
 =?utf-8?B?UWszMWJ5Z1FMRWttVm5FMzZyV2Y5VkU5N3VseURVVk1XYm1IYzJxRmRWMTBn?=
 =?utf-8?B?ZGxWY1lzOXhCTzdEL0xaN2gybzRiTVo0TzNsN2pYSGtKeko3dEMwOG0yeFQz?=
 =?utf-8?B?aVVFMFlDcUNlRCt1YXU4SHJINlJ2bmxpZFB4bWk1YmFCa2Z0dEdVRHl6alBL?=
 =?utf-8?B?RXRydkVVbzMrWmxMVXExYjZMV2dkN09PRU80WHRZV245Y2gyS0RGZnpRZ2Vl?=
 =?utf-8?B?QnFJeFB4RFFoT1BBQUlOaThDNENKZnplR0JOTmRycjZaZDVsYjlyQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88321081-cf62-4cff-b792-08df40da72ed
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 16:31:48.5838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oG6HcXDtUvAsDbKCjlpExqdUfxfNu3mDgT4W0zHFe9pcYDOxLpnqIV/tFbUlpHxC4vofhBUNk9ldow4gVklKkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3142

On 12.11.26 16:59, François Legal wrote:
> Le Jeudi, Novembre 12, 2026 16:35 CET, Jan Kiszka <jan.kiszka@siemens.com> a écrit: 
>  
>> On 12.11.26 15:34, François Legal wrote:
>>> Still in the process of porting my app to linux 6.12/x3.3, I've got a build issue regarding mmap.
>>> Arch is arm.
>>>
>>> if I build a function that calls mmap without __STD decoration, it gets translated to 
>>> bl	0 <mmap64>
>>> by the compiler.
>>> However, when I use the __STD decoration, it gets translated to
>>> bl	0 <__real_mmap>
>>>
>>> which itself fails because the real mmap expects the offset be a 32 bits integer, which is it not.
>>>
>>> So I wondering whether the definitions in cobalt/sys/mman.h
>>> COBALT_DECL(void *, mmap,
>>> 	    (void *addr, size_t length, int prot, int flags, int fd,
>>> 	     off_t offset));
>>>
>>> #if defined(_LARGEFILE64_SOURCE) || defined(_GNU_SOURCE)
>>> COBALT_DECL(void *, mmap64,
>>> 	    (void *addr, size_t length, int prot, int flags, int fd,
>>> 	     off64_t offset));
>>> #endif
>>>
>>> should be replaced with
>>>
>>> COBALT_DECL_TIME64(void *, mmap, mmap64,
>>> 	    (void *addr, size_t length, int prot, int flags, int fd,
>>> 	     off_t offset));
>>>
>>
>> Xenomai version? Would [1] help?
>>
>> Jan
>>
>> [1] https://gitlab.com/Xenomai/xenomai3/xenomai/-/commit/0bb6608b6fa7129de1ff4213ddf31298616cbf23
>>
>> -- 
>> Siemens AG, Foundational Technologies
>> Linux Expert Center
>  
> Hi Jan.
> 
> it's xenomai 3.3.
> 
> I don't believe [1] would help. I'm on ARM with -D_FILE_OFFSET_BITS=64.
> In these conditions, mmap as its last parameter offset as a 64 bits integer, an thus mmap64 should be called. Always.
> 
> 
> Looking at [1], the decorated __real_mmap still calls mmap which is wrong in my case. I believe what is supposed to be fixed by [1] is only partial (the __cobalt_mmap should work).
> 

These mapping/wrapping topics always cause headache to me. That's why I
threw the fix I recalled at you, though also because I think it came
from a compat x86 scenario.

Regarding your change proposal: It's likely pointing in the right
direction, except that TIME64 would at least be a misnomer because the
actual control here is behind 64-bit for offset - although (not only) we
demand to couple both in Xenomai configurations.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
