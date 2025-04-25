Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2041.outbound.protection.outlook.com [40.107.104.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF10019BBC
	for <xenomai@lists.linux.dev>; Fri, 25 Apr 2025 05:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745557579; cv=fail; b=TKpbCz+zVJohBPNx0y2F6Mz5CjReTZS1IghLeyclf5ufwvrttE20mtEMPTwpIYZdpLGqIjZnIKh7s1zr9bcEbVaQ8IF7dQQLgVEZRLGC5S3Zasc4UvsEE8Zd8p6h+BT4mDIIVYHS8pXzMULoZRPnAIyBqge0kBSecJCgfxR6UC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745557579; c=relaxed/simple;
	bh=beu9stBKhCo9yOC7qukkxIauQp60Dr3FRyCGTjB5TlM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nWEdvVIWxsJIjhvswKkeEqKaXmu2GaTgN4xSyoPLdGxNZ3NPD6DC9n+wi21uvbpmow6aU7dd69NEuGmR23lLNP0y9x1VttGGiWjk+PYNLYlBUBGY9Qv9Ktb+0RSnGWrEp2Ez6+jQ/Zxsw8946sdXclcUqzygPHzitkWQaaUZMOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=pHPj1f1c; arc=fail smtp.client-ip=40.107.104.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="pHPj1f1c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dVN9WF5FUw4xv2aEBVgqCPBgewIE4LwahcfMbgCXHfQiyuaPOhp5LwLiDEYc2+QBoIve2Uhk3v60s00eIzxWwbeJ0Xc+p3ECc3gLPHqbXVx3mXK4gzudwE34pSqptVgjjCHixjiLVXuSvuhzRo3WYqRfV/M/IZtGB9c6v7RZCohhKSFKSElCeAmPoV8AiFViLgo9GhHO2mGuldZtrAPYRvmYEwlFmdfsBddXk3zPA7XkvKNeF+EkAXxPuYZhXTo6VoKouFVvJMbh3M9uwozZ+2r/nWUUBPB3oWWJu5AGFyt6m34qZ9Z4oIcn7Ud/chC+ZyOY92FeCnz2MSD9IIOvug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imMUT0aHs2qfM4JYPr7oI/vztjWSXb+f/pl6i6xL6rY=;
 b=Kuo8WIJy/CAR7fL2EaPVxtbEFfA+L4Ut1CrmgolqWz/a6y6OSrmM52RZ9U+ztXo4XCAhEzONWPK/tEo1n0PUGMhEWAjNlgWRhotYCEfOCcp/3CInyLTquCm0koZwp0+Zs1tG6vnL9Rkwhm3Wgugw2xb5ltBPFsF5F5gE9PH01DSrXB4BkG1Z8clZ0SAkUSKvs1nDEWvUkW6hmtAauUp4drMX8BiN5ZXhEOHamgSa/ak1Q3L381RfEljDuemDI1ui/9QanpGJRI4Fijnz2lsKUOGLGsPaMtDczh6sps0tnl0X4o1ECfRdbMTI7XSrDpUqKMji8od6hchtZV/gKfVIjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imMUT0aHs2qfM4JYPr7oI/vztjWSXb+f/pl6i6xL6rY=;
 b=pHPj1f1cW4HXzlWWMp3govVe2Yqt3amTDW/4DhKUcMYMPZhfH+wB7dI9biyezXquqBT5neG86IMEUDyE+u6doTT8q3IqsTCjfrJEQSt0jJcCFeiTY9OxxacuBCvgJv4Ctq/XJJS6jggCU4xuY70N5AcuxhIiIYnf4s7Z+JARyWo5qdep3MiWYx8/g1c+cALTXGo7Z923n8E1RTpZxeKLp6zWDpEDVdX8lYvq+hj3oYKff0gW6WMq2ZKIysLVQS4UxgSm+OEFIdZGK4so2feDS3fdQba2174pXuEQzBeA1eB9AaqL0yKCQgAwJq1eQdYjnVJI1obhdziaFWKYMpqXKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7366.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Fri, 25 Apr
 2025 05:06:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 05:06:13 +0000
Message-ID: <c1a75af7-7d29-47bd-98b1-ad6a0895955e@siemens.com>
Date: Fri, 25 Apr 2025 07:06:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Doc: Add supported_cpus param for Cobalt kernel
To: Haiyang He <aspirestro@163.com>
Cc: xenomai@lists.linux.dev
References: <20250424111521.2344714-1-aspirestro@163.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250424111521.2344714-1-aspirestro@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: 62892364-7e69-4ff3-8bcf-08dd83b6e67b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzNENTM4YjFnRlV5cmpVLzBtZXZPdTZ3M2RxbXI1Y3d0bGdaVitxK0hmZC9L?=
 =?utf-8?B?am9KLzZYRS82anBXeWtvaDdmYkp3aXBiWXpaM1kxZ1cwRWMyUURGSjRReXFD?=
 =?utf-8?B?aDdCTkVJZFdtWUtsa3JUT3c4K29NaGpFM1ljMGFPZ25SNTlDa1hKQUx3TEhH?=
 =?utf-8?B?bktmSm1EZU5zVnNKMGVLRjhLME1zTC8rVXNxRGNvdDBLekxBVC90a1FOSDN6?=
 =?utf-8?B?SVc3UXJScW9hZlk4WHh1dDRac084TGNOWjVQTjhYQTREVzdydStFZEJyK2xQ?=
 =?utf-8?B?QVl4QnlYeURIYUlvUGN1VHhySG9LODd5TEpaNkVmYkdsajJPM3M2RFplZ05z?=
 =?utf-8?B?UURXaGVGRzhGODFXcmN3M1crN1I5eExNTk5mM1Q0Rkk2M056bGJUdFJEZkpy?=
 =?utf-8?B?RFRPcmhieHI1Y3pybzgyVHNRYlU0RWlvVFVnd1k2aXNub2JqRFpkSFo1M1Iv?=
 =?utf-8?B?Y2pUaVJYVG5uWWxEQWxsOTFKSm9Kcjd5czlGTGs1S1ppRWdRMzEzTHhKOUw3?=
 =?utf-8?B?WWxmL0o5cmU3U2l2MDV4V2xWOGVHV0J6NXF3aE9VaDlyU0I3SlVWOGRXclVr?=
 =?utf-8?B?VVVVK2k1cVJDUWI5TndlRGtsTjZMUnNVeUhIMTEvK2xsZllQQ3cxbkxJNVFz?=
 =?utf-8?B?YlB2TDZqWS90emdTUG85QlhCRy9iSkFNM0FUTE1LaU5pYlY1RmU3cEhPNld1?=
 =?utf-8?B?U0ovTURJak1QQy81VHhGaVd6YVpLbFpadXJkNk9HV09lVHFEL2Y0M3ZOaHN0?=
 =?utf-8?B?Tyt2NFVCRUVrQkVSa284QVc5V0VpQ1gyZzc3b0ZEUzZjNElnK1MzT2hzNXhI?=
 =?utf-8?B?ek56K3BMbVBSYy9QRndvSlFuNm1TZFN2Und3YlYwYjVVNHEzeVV1VXQ5d2V5?=
 =?utf-8?B?S3hoeXg3U1V2bWRCV3praEk4QlQ4eGR3bFhscDg2T25PUW9sSFZkajVXY2U0?=
 =?utf-8?B?NWhVNzg1MzdBOXhCRlJxYVdiTzZ0c0YyTFdxYmxycHBDNVBEa1BaZVJlU2R3?=
 =?utf-8?B?aUpydU9SaFdKWFRQTENDRVUxTTZXV3d4RHlDcCtaVWJ2V0tRTVp1TXN1RWcv?=
 =?utf-8?B?UEJtUjQ4enp4NzFlOElieTVLWjd4UlRlN2E0akJ1MXlPZStucnVYbVdraHBs?=
 =?utf-8?B?d2N1UkhKYkdPbk53UHFqTi9WV0xuMjRUeGNWM3V3SjJMbzg0blgyLzlvZkJj?=
 =?utf-8?B?NEUwT0lhOGIrRzBTWFhYNUVkSE1VVHJSWUZOMXB4VjBZMFdMVVcxNWYyVmZl?=
 =?utf-8?B?cUdwTEhlb3d5amR2em5hVkJwem00NDY2Y0RJcnhCTFJjaTdHZU55R0NtOGxD?=
 =?utf-8?B?M2QzdXNhdUk2K0VIT2ZDVm5yTmVJOGdOK0s3UDh1dzQ1dERDMk5aODN3anpy?=
 =?utf-8?B?RHI5NmppbmppUXZvU1R4dFhIbkFJOFFFbWMvMUlTR2RtTlh1eWFzWlBuNEJK?=
 =?utf-8?B?anMwbkxVQnYrcW1SNmhsb0RJdmR2K1pOanpUTlYvdlgyeDBvY2c3elM0QitB?=
 =?utf-8?B?RHBLVlk1dkgzRmVhdGJrMFhzeEQ2MTBuV1BCVTVoK3pTVVBvMDdLbVpjTUVS?=
 =?utf-8?B?Z0tleXNwMjFjbi9PWnVCRXllUUkxcGdwLzkydVgveVY0QTBwZ3EyZXNqeURG?=
 =?utf-8?B?eTZDSmM0Uml1Vy9hU05WSlpiQzlSUUJidFFDVGxoOXdSUmxkRXYySllXbXlU?=
 =?utf-8?B?YjhjeGV5bk1XbVVyUUZCMDllSlJibWxXaDc4Yjhab085SktzU01mQloyU2pt?=
 =?utf-8?B?L2RPOWlma2kzcS8rTXRXeUkwME1YZ2dLSWpiRVVpNFFRMXBYV01LVkJ1ZE0r?=
 =?utf-8?B?NWRXNzVuU3Yvam03TThOV1BTTjdzRHowSk9kMWhlaDZWd2YrZmlqRFIrNUlQ?=
 =?utf-8?B?eUU0enlkYmZIN21pcFgwQXJ2dHo0RjBtMVN3Y2JZdTMvWnNibEZWZjN6WFY0?=
 =?utf-8?Q?QGWnTQUX2zQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkNMQjlyV2Nucm0zb3VXeVBZRXVGZlNjN1pqUmRXNVhjYUQzazBaNTdMd1ZT?=
 =?utf-8?B?TnJxYSsvQkZWRTdkTStEajJtVHd1bVhodUppQXcwWTdlaEw2NmhBVUdNUEZW?=
 =?utf-8?B?RUVLUHY2SE9wUzBkd25CNGg4dUZzb3RTeXRTS2JtNWVwWlYyUlVkZkM3VHBO?=
 =?utf-8?B?cnJpdlpqQVFsYW5BUGRDY0N4Qyt0aVVGam9Lais2WCtQV1A2UzRZc0lEZE51?=
 =?utf-8?B?c25URHlwOVZ5RFBaOGhrQ0JUYTZOVWU5UW1ReDlWT0M2OFZEYkdwdXBEVjlB?=
 =?utf-8?B?MVZXTWVIdm9kUldBUG82SWFLSi84Q0h1cXZZNG50S2htVGNvYk5wSTZ5TWoz?=
 =?utf-8?B?ZjNaV0JuRW9jQVpqN2tuR1ZFd1VySm9Bck55NUJranlyVDNZbnpxYzNZVXF4?=
 =?utf-8?B?MlBiVFJCcWFsWVRZd25DMDVFOFdEb3VpQXFneE9TNWZQWmZZQWdTRXI0ODNj?=
 =?utf-8?B?bUZlSVBiM3EveEZoOWZFTmgxczAwU2pJOFpEeVBDWUxUd2hTNkIrWnF4UE9x?=
 =?utf-8?B?TDdCQnlFek9Cd05DeEFsU0xndWhKS2JTOWNpWHBsK1dYK1d1OGUrOVZIODRJ?=
 =?utf-8?B?eUZ1Ukk1YURTSmFWMnRlVUI1K3g2SENCNG1QQjBjdTBhU1d3WmMwM01QMlpK?=
 =?utf-8?B?QWVrMHVkSE42V1A0MGd5RzM1WmpHU2pqRzZlbWo1cDltSFBubUNyN0svZjBK?=
 =?utf-8?B?aEVLTVkrNnFWVDFFb2pRb2syMWVMajlWdWNZL01UVlVjTEVTbWhTekY4ZTlO?=
 =?utf-8?B?RWlXa3U2SUtmeCtYcytIRWd0VWVkQXhQSW9GNktkNFJ3Z244K0dIYUx3RTNv?=
 =?utf-8?B?L1NpWXlmRGg2a2pXZU54dDZJRDdlVzJrRVlNRUEzNXZES2c0cHpXaFJlNHkx?=
 =?utf-8?B?UWtNQWx2WkZQa0UwdW91UkNoMENOV1dqOG1sNEJRZ1VFb1E5c29ubnpKYW03?=
 =?utf-8?B?cGdvb0dLaGQ1SVNOZTIwb0xpaTRiYnZ6SmdhZnRPZXNvSmVjNlc1NUFLN3Uv?=
 =?utf-8?B?TlFaQ2xqSEZhRzFTbEJJU29YNUFnSVFZOCs4dHdLQ2ozWGZKcDBDL1NBKzBu?=
 =?utf-8?B?TTljNnVwc2NQNy81M0NvRVlWeHh3bHc3eUR5Z3d6OWp0ekdZS2pMSTNjNDdi?=
 =?utf-8?B?QmdWb2pUNis4bkVYdXVkVGNzYnJVcGRWeForZ25OMzB5Tnl4T3dRTFlESzds?=
 =?utf-8?B?amNWRTRlNFYzQ3lmc2k4K1JCVVdIcjA2MU4raGh6dkF6azlQbE9KRHEzWktZ?=
 =?utf-8?B?dUJjaEZiNjZkS0JZVUYxMFlHS29KMm5vSFcvTzZrTy9tMTBuNytWNW1Hc01K?=
 =?utf-8?B?bGM0cHJhU0orRGJxVm5WYnkrRG5uYUYzdVN5TTgyRGhTTkF1NjZwUGl2NFRw?=
 =?utf-8?B?b1M4M01xMXZLdFU0SFRBR0tseUlnYWlyV1VnSVB2ZW44VHN5YTVYNGw1VUgv?=
 =?utf-8?B?aEhQSEljbkZkMklKK0Jlak9HNWxjWXhMT3FCWnpQUUhkSU5JV3VFc0dJYXh5?=
 =?utf-8?B?ZDMzaC84TmRqYkVSTGwxN05RT3AvVk1TZHh4Z0NpZXRzRXgrNjd1V0JaQ1cy?=
 =?utf-8?B?emdmbDd2R2hnSzZDRW5la1ZKVWV5V1RqOEZYSFViTDFoOXJrQ3A2Y05vRUdh?=
 =?utf-8?B?UUltS24zTHIwdFZ0UTRJRm9MMk9wUjNsd1NLU3BFM0lUUk51SUgxV2FxdjZl?=
 =?utf-8?B?NW1kNkxvaE5PaFpDREZoMmk5ekIyaHdrVjFPRWVrZjQ5dUtUMDFsV0lpbUMx?=
 =?utf-8?B?MlRvL0tjdmZKTTNYbVZDYUtrbCtJWFkyVWVyZ21DaFJqTmdIUjFrWjRtNGN1?=
 =?utf-8?B?L2hQRGdIRmsrZWx5NjFCRVJEbmVXZzZ2OEZpbDc5VVFJM2p1NHpqSEdDUEdB?=
 =?utf-8?B?NFVZaUg2MU5NTUwrbzkvMWJadDFwb0toUmZ6UWZwQk9ock1Welg3NzBTN1hj?=
 =?utf-8?B?TzJhNVltMzFxTlk3QXQvcTU1SzBCR1p5TFJoU0s1NW1NVlpBUWFDMFVMN0JC?=
 =?utf-8?B?cjR5YURGWGR5OStGNThyZXA4d0Z2V2hFREJna3pXRVRjUENYcC92RTE4ZWRz?=
 =?utf-8?B?NDZ5N1lFWkVuRzBrenFmR0tVSk55YzdoUFU1dTdUVEhtRERnOFpRMG5wVEU2?=
 =?utf-8?Q?MWfBCXtZn0vqmduQAppb+EI0n?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62892364-7e69-4ff3-8bcf-08dd83b6e67b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 05:06:13.3109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wf6Wtq59P+fYHXASq0hpxNUMcBqkGP0bcBvTLvSc8hVYA8m8Wmf7CMznZaC8Zpbg02Bd18obYOAo2kK2k6DVsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7366

On 24.04.25 13:15, Haiyang He wrote:
> Add table entry for the xenomai.supported_cpus parameter, defined in
> kernel/cobalt/init.c.
> 
> Signed-off-by: Haiyang He <aspirestro@163.com>
> ---
>  doc/asciidoc/README.INSTALL.adoc | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/doc/asciidoc/README.INSTALL.adoc b/doc/asciidoc/README.INSTALL.adoc
> index 04c102822..508e9b43d 100644
> --- a/doc/asciidoc/README.INSTALL.adoc
> +++ b/doc/asciidoc/README.INSTALL.adoc
> @@ -126,6 +126,10 @@ should be passed on the kernel command line by the boot loader.
>  |============================================================================
>  ^|NAME              ^|DESCRIPTION                    ^|DEFAULT
>  
> +|xenomai.supported_cpus=<mask> | *SMP only*: Bitmask of CPUs allowed
> +to run real-time tasks. Each bit represents a CPU logical core
> +(bit 0=CPU0). | -1 (all CPUs)
> +
>  |xenomai.allowed_group=<gid> | Enable non-root access to Xenomai
>  services from user-space.  <gid> is the ID of the Linux user group
>  whose members should be allowed such access by the Cobalt core. | None

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
