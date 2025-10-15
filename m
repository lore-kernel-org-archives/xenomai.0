Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011008.outbound.protection.outlook.com [40.107.130.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFDB2512F5
	for <xenomai@lists.linux.dev>; Wed, 15 Oct 2025 08:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515655; cv=fail; b=jUtgGQgpz4oUqpqIut0hMjibndIieLZB/vFGQoYMgI94JJnNJHtS7Q9zdAI7h48hgbFLd6L+veo5Q+a4KIgCWZCXzgT2/w3t0ODhoT6AStzXvjIDwgcPnok0THyYL9REDy3M5PObayhrWNMDMX1JU6HZjJQDAZKsN9ndZIQUvXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515655; c=relaxed/simple;
	bh=p4LPcfqYtROu285om3LY1KQ39WEPuHtV1Nk3FGisyNw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XqhG7kg4Bkswxo3u/sNfWmyQq0/7aMPxueSDsyOhl6oNky7h2pXx1yyDRrKtrK+Cc9y24d7JokAdYn9rmhpS1hSa5x+EdVGxREHZjyrD15aUHR9x4bJQtJmmoPmcb3BtwtOga4fI/EDjIX4R/TiUdcyuiVfSHNoZMpd8+k+/G2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=F66oFXZc; arc=fail smtp.client-ip=40.107.130.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="F66oFXZc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stQgs4WXvXOb0IMqtO+eMZ3HHDcZI1ktygREDqRmCgLUdKR/C1GOlhFSSAQorhJmZS8FMysCMbDwhTr1LrZlBbxVTKNCOfEqgP2pVT9V79pSA5pc4bmH2iSAFFo09cXJsT48qI5fkEHjfSSQvZIxHL1xrur+otx+R8IZ6iAfmqFuIZRAuPW7eLc7+IuUPddM2vnkox0bRSfWBOzEHGWRndwLQTbQ2g59Y3sg5Zi0qxpNuiguUkxnZWyAYNL+aTqik6FpOtpL+6+MfV6+9561QkW26hKNfHWvtJn8ortyjtgcafFXjInTOvjXfu09vq/1qp8OkF8MhuD266Hz/pdjwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBkyCUvSPSzpYcrKJfIYf+KCtp1lyVDzlACF07trCvg=;
 b=oB+z/L3qc3YFeVVgSbh6qa/5x1gnH3u4nYXJ2wO+vqAnx9rW3a59elD8MIzVNOk6RDGSjEmsBVsut65D/1a7xqd+O939XVOylpIgi08qAUa5qwxd0Ug5+2BWdqgZmTCy0ID5Yue6Xwp/BIcmhFhemBVKFNTpVtvclOmq990DEKB1vBb22ObrrOuQO6wv2Hr89rBYYwtS98xqmRRzDQ5dIjZiTKUSVJ8RMC+PXDGTsPMyt4yvwUB5KkKwFpdq41rQo6Is/rEGXKwW0e0cz/Syc1soQxbPop1mBhsgiuVo9iTIVxqgy9r0IaIV+LWN2NYwFa35Qa4+cX7cNotyacAYog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBkyCUvSPSzpYcrKJfIYf+KCtp1lyVDzlACF07trCvg=;
 b=F66oFXZc0RBnLrvGfGTeX5VTmG3lHLs+4DFSPv6QFOAS+gO9M1ftvmDx5H3Vx6fSy2ocVDMg623aR9PUhUAoeAkXHSLkvrbr4n5QyWQqEfqeMV8tSrkskIoiZf0PpgUSNfwcyavvJQRx2oI3kYWZhF1mdHeWRtONknUOHn4/YpaWdDluIlDAGK13tY5OUzYj4+FqiR+XJnrcqajv2mRyKm/Y1Ereq6ZuQlTzA3APpAsoEMLlOYIsF+t7nz3lGB30HUozAV1Z14fxgkG5D3nq1GCqVDRECfm6hAhGMqCd/Zh694TsA901h5CfsSXenmvrZC87s4WBHZKEZ5GluDhMQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8062.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 08:07:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.005; Wed, 15 Oct 2025
 08:07:28 +0000
Message-ID: <c4a50a53-af60-4342-8664-ea208073d1d6@siemens.com>
Date: Wed, 15 Oct 2025 10:07:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] lib/cobalt: arm: Skip SIGSHADOW_ACTION_BACKTRACE over
 asynchronous signals
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <cover.1760374860.git.jan.kiszka@siemens.com>
 <111db6f38a33a6d7e8a2a0b983dc244049a37d44.1760374860.git.jan.kiszka@siemens.com>
 <041484c388d623bbfb4832b55858083feb856ec1.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <041484c388d623bbfb4832b55858083feb856ec1.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: f71b49fa-72c2-4c51-07f3-08de0bc1e217
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzVLWWZiRmp4QUl4QjR2Nm8zR2VyV0RIcEVvVUhWRHloWGRpQTVRSzdWdFJi?=
 =?utf-8?B?bGlIY0MwT0pZa0d6R0d1KzlWd1VwTVRnQkF6MWdLb0lEREtqNndNL0l4VVc1?=
 =?utf-8?B?cjZCbUxQS2J1eFRTUE8yYksrTHZ0UGpTdndKS3ltSjNIZDBVbjllUVljMGJM?=
 =?utf-8?B?MVhHZjVaVitla3FTakcwaGU0eGR3MWJIT3hvZHpkZldXaTFtekM4YVZDZzRW?=
 =?utf-8?B?VjFxUjAvdXV6a3VDZnU5ZThURHBaZWY2ODR3emJHUklCVDZFSnlWSzdVVkt2?=
 =?utf-8?B?VmJzMUJDMVlZM3p5enYvZjZvNHkzeTYrTVJGWWRkWG8wRno0czFURG1BTEQy?=
 =?utf-8?B?eVhGem85MzVFSkp6WlRsV2p6MlpjdnlWRnlpS2ZwY2lKSzl2a2hFUGo5dDVi?=
 =?utf-8?B?TzBNSmtIMHZSRW5QOTdSc2pZeE84dkxLbTl6RWIwRVBreFlCMUZhLzI4eUdM?=
 =?utf-8?B?ZERLQXZNS3pwYUtXWGR6cHFIL0Q3L1pYNExJdk1PVU12L3hGVlB0TUZuaXhX?=
 =?utf-8?B?WndJU3kyUFdWc2ViYzBheU9wSmhkYXVWSUlKa0Voa0U2TkJpR3ZXdTJnY2lB?=
 =?utf-8?B?QlFNZEQ1TGg3MG81NHNHLzhNeDhKcXRHMkl5dy9FbXRQZFIxY1ROQVZ2WmVK?=
 =?utf-8?B?azFJWWZESU9FSExZQjRZejJ2bnZRWGJ1T0lnTmtsdDl2cjl3OTFYK25WK085?=
 =?utf-8?B?OG41MTlGODFhS1RiUC9YTTVDOW9iWTJGS0toZlBiTGNtbWJWMndHRk0rTFZI?=
 =?utf-8?B?a3VKaWt2a3htR0wxbUE2L2J0UWRpVVFIZERONXUzNU1WV2liS3FUSWFxM2N6?=
 =?utf-8?B?cTVLaFh0aUw5MjJMa0NzRWpkODFyRWFTUlp2L1BlZVo5V3BSaXJTc291UHpw?=
 =?utf-8?B?cVZjOUFKZFhLLzFONVkybUM1bGZ4K3A3dHBTT2t2d2twcWZkL0hPaWg5b0o1?=
 =?utf-8?B?RXBQenB5TnFUUURRdnptSHIyQjBMZVhUUU5OcndiK2pXdW1EcGtZT1BuVE1i?=
 =?utf-8?B?TDlybHdYVmtYT3RibHNuTUNLd3VZM2ZndFNiU0dJd2ltQ1dKMndvREFUTGF4?=
 =?utf-8?B?RHhqUTlSTkZ0VmhLdHcrNzVaeHJFVy8vNVd0ajlKbE9idkJPazNCWkpjNjRQ?=
 =?utf-8?B?alZMZkJPeklmdjYxV3BGSzdacnZ5dVVweUx2cnlGc0pWNERnejZTY3VJSzFt?=
 =?utf-8?B?dlJ5R0daMnYwMVNBTGlqbVowR05FQ0FlT3VTSkh6U21qMnZaSUQvRGxMVEdl?=
 =?utf-8?B?am14dndNWXQ0OXVqOVkyOC9GcklBOW5oamRjclh2VWJ3L1lQWGcvN2IvZ1Vw?=
 =?utf-8?B?UVQ1YmNhbVVlaXgrWVBZeVl1cyt1NVVJWlRmaUlNamVTT3VuNVJjYjF3UGVY?=
 =?utf-8?B?M3d0aStkSHpWN1RQZE13cDlBOTlNK0pDeE1BVy9xeHdiQUNvdHJ5TVdFcDIv?=
 =?utf-8?B?cnN5a2VyRTcxeTJVMy80K3NueHdMSUxZQURmQnRDODVXOUpHcUx0RWE3ODhO?=
 =?utf-8?B?THpka2NyY3BDbnhQa1ZhcXRDSmZsRUJIa3ZKTjJYdFVVU2RLQ2xaRWdIdEg4?=
 =?utf-8?B?cnBlZnlITUdaQXNVenNheGtGOGFyNElmUUtXdGVOelcvV3NNZ05jZHpPRUYr?=
 =?utf-8?B?SmNHK3UwS1V2TFJ6V1NyVHY2bHdycitMMFJaWmxkaDhXdVRLYkx6L0M5eFAw?=
 =?utf-8?B?WUNpQ2dZVDgyTnJhOGRQb3Y5akloTjB4RTZoanFhVmFsRlVDak9XOW9wVFYy?=
 =?utf-8?B?V1JOaDFyR2FiRURnVEQwNzJ3bWhiTlpCblFEenRBNm0wRGpOZ1JXUjkvTXhh?=
 =?utf-8?B?aXF3dGc2bTBMcmw5YjRyMzVKdGZuWUE5ZVh1N3RZV0NEUTVubUNIMmV5dVpt?=
 =?utf-8?B?dzZBWEI5M2JwejdUUkliUmkxN29QSXBZUnlFd0hudEhFcnZBV1Zod1ErNTQx?=
 =?utf-8?Q?2e6ayfM0A8+FEbnLMHuq4csWNoyI8VrV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXc1b3VqVDNFSWRYOVo4VTBMWHZQK0xrQTdMN3hocForMTNaSFZ6NkVTRnNo?=
 =?utf-8?B?d1BJbkR6N1BQNlcyOW50TlJMYmRpL2EvQ0NhSk1hUU5TZVFnQ1RZL1JyNHZY?=
 =?utf-8?B?RFltalRqaEM5ZFdRRlRHMGRocjQ0Q0Y2NStKczYzVWhLUFgyU25QYnN6WklI?=
 =?utf-8?B?WjlDd2hoNTFzN3c2YTc3U3dyTEQ2UzNRZGgvQnRTclJNUm9uNXlpaWk5THpr?=
 =?utf-8?B?MmhHM09sT2k1TVBaMTRFRUFCYUpKMlpLVmQ4TTgvZjRHZTRsU2MvMENjNkV0?=
 =?utf-8?B?QkZBWGwrWGQvdzVpUGIvbjZDR3JpKy95aXBSVE9EbU1NWkpRaW83WjVjT3FS?=
 =?utf-8?B?ekdCRXVpQjJIc08zNnJFQTNWWEQ5b2Q0MCtYMzdvVEhEeEpBaUZpMUdJUGxh?=
 =?utf-8?B?VENJckk0MVBxN2hqdUptWWRYWXpPakpQSG9jMDE0RVJ3OUZ6MUxUb0xsZkV4?=
 =?utf-8?B?UnV6TWVCaHh1SmNVclJMb0JnQ2drallaeVFXTjkzbTFxVE5RMzJDdHI3SXFY?=
 =?utf-8?B?ZnlYNTJzaWNpbnNjVGtNa3RsSXdYL05Bd0tpczdEc1puREVheTJPNktId2l0?=
 =?utf-8?B?a0NPZHNGL1Qydmpxb1ZmREd6dEVSSDVyai9hZ1Q2QndaTmdraTVDYXNiU2JF?=
 =?utf-8?B?QklGQUFXSkViUVhhd24zakNhTy9KVFJKT1dEbTFBWE5zQ0l4d0d5alJnWkZX?=
 =?utf-8?B?Q1dwTnJQZm5vbmNWSHVzVHV2L1Vmdjg1VXAzQkdXbHM3SCtLejB3bFJTbmNW?=
 =?utf-8?B?TFA2SzV0R1l0QTVXb1pKeTJrTDVOenlEbTJuQkdkUHppT2Vvc1BkR3N3WlJ1?=
 =?utf-8?B?em8xMTQ5ekFjazhZVHZ4VWVsMVg0MVhjQnZPbzdKWi9laVF1TnBYWVJBQ3dm?=
 =?utf-8?B?aSsxb2J3UUlaVnBTRysxZzhrdnAxY05sMDNpbXNVZUMvOTBrTkJjSXE5enAz?=
 =?utf-8?B?MVVzMEJRZDZtZjQ1ZEx3bmowZmpaYzZmUlhLYVhWSGhNaERWNFRGZXpiZGZV?=
 =?utf-8?B?cFlTelYrZmM5M3d6WGdCRktqcEVjczlodzBrM3BXSEFpK3lBd0Z0NTNtQTcy?=
 =?utf-8?B?N00vdVJkY0t6QWE4bk9kTWxOVWxiQVdBam9FemNhK0h4Zlg0aGk2UzZPV2Fl?=
 =?utf-8?B?ZnQ4aWExaEh0Y2dKZnNRNmdiWlNGcWk0RnZ1S2ZJemdhbmRpRWllb0FNRWc3?=
 =?utf-8?B?OHpYWEdDQksvb21RZ2NKQlB2QUZxc1FiaGRRMGZvdTU4VmpiM3IwTXRNV2k3?=
 =?utf-8?B?S3BPY1E5MS83WDlOaVNzcEpPVTVzK1M2Y2xNNldrc0tlcWpFMm41U2d2YTd4?=
 =?utf-8?B?OCs1QU9uZlpOWC92M0NzNlJCNHZxUlVGNzFqMEpQKzdmeHNBRjV6dzlualJs?=
 =?utf-8?B?cXBMRzRVZEdZZkNDZmFxaWtHRHo5UklmN2llUzRLUGpsTTN6UERxRCtOS2JH?=
 =?utf-8?B?VkRSYnllZUFoU1hzUVQxUmpMZk1acXdXbmxUV2phbWtHNURneXp4OXBsVW00?=
 =?utf-8?B?NWlXZzlRVHFhelR0bVcrcVZuYkhlOFkwMEoxbDc5QlFMd3lrMU9NTk1tYisz?=
 =?utf-8?B?Y0ZGSVNrTHhqRzQ1VUM0RUxqUjNsM2d3Mm1OR0tTcmZuSWR3dC9paVhhMWkr?=
 =?utf-8?B?UzZMdjRnZGlMMHRFemdQaVlOdFBRRXBDVytqUHhJSkNSNFQzRGRXdXo0bFd3?=
 =?utf-8?B?ODIvRDhzVDhWT1h2dmVBTHZiR2xWVC81TWVvak1MbkErb3orWFJjRVJTSlBT?=
 =?utf-8?B?Y1N0WmZkWHlUcFFSd1BNZXUwUGFZTnArM1RGMGcvNGdGNWUvYXAxY2x0ODhu?=
 =?utf-8?B?WWJwSHpta0kyUGZIa1dDU25wb3l1U052TFZSVzYzNlhmMWdaSjRkQWdRWGw4?=
 =?utf-8?B?cDZOTlp6czQ4K2hNRWZPc21NcmpadGxjUUhlaThaTGx0Tmc4TlFHTFZuY1F1?=
 =?utf-8?B?aXhlMEc5bEdZcVRScDljY0pPakQ4NVdOWllIb295ZVJjQ0ZhaCs3cDRDZ0Ny?=
 =?utf-8?B?ODZtSEY2TW5qVXdwaXhmaVA4ekhWdnF5cDJOdGFKcEJkWGp2NHVSLzRwbmpQ?=
 =?utf-8?B?Ukp1Q1RidnlpTUpGM1gxYkxCYnZJc0ZOQXpEUVNMcEVvYnkyZWcxYW9xbmw1?=
 =?utf-8?B?akFzd3ZTTEV6VzJKVHl2ckFPSW0waXg5RC9FZ1pzQVJPbXFGeEVpYnBvQ3A4?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f71b49fa-72c2-4c51-07f3-08de0bc1e217
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 08:07:28.5932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KU14jOis1MKRuV8K13PQoRRuyKJ7frWI24PhKz8zjaoTWFgE2DLkWEzcBNLl5JkLj+xh0WzP+DPNGzkcUT+RzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8062

On 15.10.25 09:21, Florian Bezdeka wrote:
> On Mon, 2025-10-13 at 19:00 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> The unwinders of libgcc and libunwind prefer the ARM exception handling
>> table over debug information. Unwinding this way is not designed to
>> handle asynchronous signals, causing wrong backtraces in the best case
>> but also too often even crashes.
> 
> Has that changed with trixie or why did this problem not manifest
> earlier?
> 

The problem is older again, but only with the trixie setup, I saw real
crashes so far. We already got wrong backtraces before.

>>
>> Avoid running into that trap by skipping the request to create a
>> backtrace via SIGSHADOW on ARM in case either the migration reason was a
>> signal, or PTHREAD_WARNSW is enabled for the current thread. In both
>> cases, the SIGSHADOW could be raised over the first instruction of
>> another signal handler, causing the unwinder to fail.
> 
> Hm. Adding more arch specific code... Not nice, but well...
> 

Will get dropped again when we once phase out arm32.

> Does that have any effect on how debugging works or feels on arm now?
> Especially any difference to arm64? I'm concerned about gdb showing
> different information for the same issue. (In terms of different
> instruction shown as root cause of a migration, or things alike)

gdb is not affected by this issue and happily back-traces through the
complete stack. This only affects the results in /proc/xenomai/debug/relax.

> 
>>
>> Improving the unwinding libraries themselves is likely no longer with
>                                                                   ^^^^
> Typo with -> worth?
> 

Right.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
