Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D3638F9C
	for <xenomai@lists.linux.dev>; Thu, 10 Oct 2024 17:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728580494; cv=fail; b=RfpXmhdES3rTy5+VPrKlfLg+/szGFwxZg0AQSrHIHSmCj+Rl0c8QlMoTSs2rViQIrUTzJWwfGIjLLPnl5BmtBmaVS2fSq8727/TFm/Z5sR5ZZ96vGopXeOv4for9MzkzBBFWd5TKRldi8GDU8dbyDeO9d3A/PhZnGH5CMdmLCTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728580494; c=relaxed/simple;
	bh=nvhCX8vytyAdg9MMpW814ebu+sm922u3DWt6LgPm6xQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XK7obA7KoGqn6nKBQY/JD8nRvvtTrGk1m/jdANnFT1kbDz0QbScAhqceYFR/HPY/ek+vde5verZCnUTLBx56POHK43gtCHXVX6yPpKVM9LlqO12JcO+IKwZ4y4vfyFwvGMQ0JRRg4DPG2LvP13OPddcwcf5Zl1rwQi0HADDi7rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=PVdkjLC2; arc=fail smtp.client-ip=40.107.22.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="PVdkjLC2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfgArdam3i2IKx5vUg5kFzDpLhxB9F9IDghnUDgU5aR09OceNqYGUwzjBfwxEzg/Eg61+PbwrSNxiAI5SGkg4nAcmF9L3BbzH0yDZw/MsdyY1QWmUDyIdJDnbahTea+hCT+lJwvihifyD45gXQgKGSmG+rWxNAOegogYfUbimysnDj1cMMoasR/CF1EUksxvOvxA2x22HxpaAtfA6UDGzxxTNPDIrZ6tFF3JkiWdSK+3HVYZk8TiKeBgfyg4LQ6X02vKk/WND7v0iu1tZOU8xJqMAW2Wo3lKIiYpzoH1ilqBqbIoS1wxSm7T997h9rG/p8ohdg89fHTBEarQBQds2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FThE00/5yx0aKD+5Vy4rUiRNRawHBrx781+1N1oxIcY=;
 b=ehUbAzdt3icLRjYaQDI+ffUCKLodLgIkOb3cPZDX2X99f0eoSLyZbCMOiXhYLrgvVdiJiuT1GSTTGbBfxCpNaQPd5reX7O3gvb/A0bVyH9XuQPXtHvpmy2Tos0s22TeJWnPkvc5cxo6koefZnhPevhzJhwUlFYVG76d4qo2KqjJlPEy5cnH+T6Lk2xNiRRfpkmKap5lIIxcsmDQjtUu5Tq//nzg8S4dc5dhUV3ycrxX5dpIE8wrJwc7O98Uk43pyJuyoSZDdCvUs6W9deua4e8NE1MOkIVX9cq/v+hWaePOLVuDdn+5x1+EKppUBtj2xKXr/Ttqlf+f9qTSSz6dQMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FThE00/5yx0aKD+5Vy4rUiRNRawHBrx781+1N1oxIcY=;
 b=PVdkjLC28/Hg2w+tdPp6vqQbEu0JsQQq4DTLzm0tLS4XjOMYpWEVxd97gQ2269j8O3sXRrybNmqirLAmgZ2fdKl65Q5RQAiAZtFAnFFMdgT2FCeLbS3e3e7P7YpjaiDijsUrTr3nlSJzxIShCvXR6S+UiId13UC+3K2dTufOQZ9W+yyNPcMN89RAfWIIGfBpMRgpTUx7e7iPx+zDA0tYGQCPLJvmJ02p4jqx9hSpROL7JaDRGbVHmQuUTDcx5G3lgFRt5KvkymaRcEmPDZtNnxeaUIbG2VBClAOOgRxuUqLhxwm/qFNI+MtVXzfeYCq/z2DTViK2whEP01TsrlpnUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6025.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:8f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17; Thu, 10 Oct
 2024 17:14:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 17:14:45 +0000
Message-ID: <2da42ac8-e531-49a0-87b3-639c8158fcc4@siemens.com>
Date: Thu, 10 Oct 2024 19:14:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail 6.x] x86: dovetail: Fix inband IRQ state
 corruption on out-of-band compat syscall
To: Florian Bezdeka <florian.bezdeka@siemens.com>, rpm@xenomai.org
Cc: xenomai@lists.linux.dev
References: <20241010154421.23303-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241010154421.23303-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: fa26a1c3-4761-49e0-4b2f-08dce94f0983
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnY4UDZhekpaV0FPUG5zdXF2NHpnTEUvUmxJYzhicldGZUExanlQZWpQTGsv?=
 =?utf-8?B?ZEt2dGJ6aGdLZlFXcmdLTmVqczNPdzFMMnd4ZFhvOGR1S0dOL255bjRJWWFw?=
 =?utf-8?B?UWhzdUJBZUl1MHoxRUNFQ2NyelVzUmpSMkprS0QvTTg5R3BOZ3h6Z2Izcncy?=
 =?utf-8?B?VTVDeC8yY3JCc2l0ek9pVUkvYllLeEw4WGd6NllJYlRMWEpGUndNZW1hYWNN?=
 =?utf-8?B?dlRrRURORkxTQlpDMHBPSnNZTmEyUEFFZTJua0dWMkVJYkVCc01nWWFpSjdW?=
 =?utf-8?B?b0h2MGh3RjhoSFRLVWJKMzJDOFg4VGJQNWpRMzc4cUVLbTBuc2Jzc2dacVBY?=
 =?utf-8?B?eDhmaEhPRG42ZEwyWjZybVpOQzdlV3RmQVJPakpDSWM5bTBkL2RSTFVyL3pn?=
 =?utf-8?B?RlAvWHBkQk5MMTdxeGZpd0FJSWNYQU12bGg2LytvYm9wQndzTjR5NnE5TURY?=
 =?utf-8?B?UmI1L21sQ3ZqMlJmT1crM1paaUQrUmN2bW5ScUVMUW8xSHgrNWlaRmNucjFY?=
 =?utf-8?B?SXlUMGNBNnY3UzNUbGkxcm55Z1FNVVhLakxpT3Q5dlRzM3l1bnp3UndKVElJ?=
 =?utf-8?B?bmxSeFdlZE1DMHZ4YlN6b3Z5bTIwK1V2dDcyZ1VISnpnSkxPSmZRRmVmaTRo?=
 =?utf-8?B?bGtBRXNraHp6R29JdHppcVo4aEFhRlQxUC81SCtpTVhYVk1nYzNmSzFFN1VG?=
 =?utf-8?B?dTlQVWZxMk4wcHR5UnhLMzlpTGFOcmRSVHhMZHZxODc1d0NGNlRoVnVYOHVy?=
 =?utf-8?B?SjgvaG5QdDJpcTBHTXdWbGF6Q2pQNEdtakptdS9JeTB1N2NkZWFMc0xiU29s?=
 =?utf-8?B?eEFWWHd2ZTZhV1VKSkVMMVA4RGFKbXlkQko4VG9WVWVPa1dJaFIwS3JwV0ZO?=
 =?utf-8?B?T1EyL3dXSVpQZS9GWCt1TkVsM2kvV2lVcEEzZWcwRjBjTXdRNXkrQkRLU0pT?=
 =?utf-8?B?N2tBR1RPMS9rOWNkTzUxME0yMlBhZTk3MEI4dTE1L2xnYmQvRHNUVnppeGMz?=
 =?utf-8?B?dnF6d09GTm5hTldDVFJyLzI2MVBrUG9zSFBDRXpDQmExUjJ0S2tmWnA5TXNw?=
 =?utf-8?B?bzFkVnM5WExtWWhJNzNwb3NMUThQUWRHRENBREFlN1R6Z3E3SHVvTWJiS053?=
 =?utf-8?B?WmJ3QUs4a0dLdCtZMUt4emR5eWNpZTM2YTdwOEtHWkMxd3ZxUnFoUXc5MW42?=
 =?utf-8?B?aVNMRTk2ektFMFUyaFB4cU15WER3cXZnbW1hSzlLdWlFRUs0TVdNSEc1TE50?=
 =?utf-8?B?MDVzK0tUVW5PdlozWXNzMU1IOXMzcUZUNTBpUVFTM2FYL3pxd2RvbE0wZzRE?=
 =?utf-8?B?dDluU2hvVnphQmVPTzVGSll1U1VQb1REWEtRbFFmWjRNY2tZTkZDaExlcmpo?=
 =?utf-8?B?OVY2L3lOVm90cUs5SW5PUVg2UG1heFhCV1BVRW1JNXhoWjVtd0RtYU8vN1Br?=
 =?utf-8?B?NnNyV3htN3ExRjkxZXp5RzR5QXhVZE5CUnEyZDl4c3Z3a1VSSmVuNjJqTWh5?=
 =?utf-8?B?Sk1EY1JYU1RORHhROCtVNDZZZVpzby80RFBTekdKa1lOZHdXRlFLZ3JTaU1t?=
 =?utf-8?B?M0JFM1A0ZUF4UjZuMVdVQmFrd3VvMjU0K29Ta0ZKQnNsZWJ3d0tIVFNBSlk3?=
 =?utf-8?B?ZnhNdDRVbWtORDM1M2hPdzBEaVlVNExFcklwRnBjNjFvSnVUUkpqdDVMcnZU?=
 =?utf-8?B?K0QyZDhRczFtU0RDZ1JneEF0TXFKbnVleU1pbTlQMmI3WlFWMS9HVDJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SE9KaEtOSnJnVkJ1NU1RL3NGbUVHZWlESThlakM2Y3d4N21YWDR5d2lhQ2ZE?=
 =?utf-8?B?RlVybzBNeWNqTmp2cGszbWxrSHFhSWZUcHhFNSswWEVyNnJBKy9XMkh3Njhm?=
 =?utf-8?B?NHFKWHI5NEplQUNzSEhHZUJQZlh3cFhocWdEY2J1Y1ZyblpVN0ZFUGNDN3V0?=
 =?utf-8?B?MTJYNlpGTFYyemVvSEkwY2VmVi9JSjIxSzlUdFlWOEpOcGNPa0dtTG1naGVF?=
 =?utf-8?B?VDFzRjRLaFhtZXZIVmgreklrTEI2SFpLR3Uyb1Q2U2F3QWl2NTZmL0xLSGNQ?=
 =?utf-8?B?dlZ4VXZndzErck82bFBSUnZtK3JaRXl4NnZpY1V5cE5yaDVvUU9Ia3hUQ2Mx?=
 =?utf-8?B?Q3NTcENncmdvaXYrMGRxakxRMHRDVzhxd1NQSEVJMVJEdkQvOE5hRlpBSTB1?=
 =?utf-8?B?ZDB6TWx5emxzbXB5ejU5bDlGRHdRWmo4UFFzckVqMWRoN2g0YUpybHl4Vy9J?=
 =?utf-8?B?dWVVd2p3anozV1NubXJ6Z2dqSlBXZ2FwM3pwUTEzcmZteVVQNHRJTHNoVzFM?=
 =?utf-8?B?ZHlxNlZFeGQ1cWR2K0dEVnFtV1JJWVd3NUplVE9WbVIrWkFWeUFMbjM4YU9X?=
 =?utf-8?B?WEg5NkhKQnV5Wm5RSnhVQmxpT1JBbUs0QVhyRDlHMnBUWXF3cnlwM1F0c1l5?=
 =?utf-8?B?d2FJaW41eGI1WCs4czliTFpVUVRBNHIwaFR2cUJtTWQ3Z0w5MWkwdU1YZGp1?=
 =?utf-8?B?UVNxTXgwU05lY3poWThBT2JjeTQvRkNtaWJjbmpqVkw0T2JkdERuL0tVZ0lT?=
 =?utf-8?B?MVQxclFFeTRjbVkyaTFPTDQ4ZEpzTkFxSDVqSk9oOUVJRU9HM2tiUW4vTkNa?=
 =?utf-8?B?NFRtaWhRNXMyUmhtZE5QMzl5RTZGbkNHUS9rRFcydVNlblMra09sZlBFRzlQ?=
 =?utf-8?B?NWlHTjJidVhMTjFXbVRkNkZxUjNWcXowSTFITFNlQXQ3M2JKazJybUhzNVZF?=
 =?utf-8?B?UWI0NVNFTDA2NmJXMTRKK2dsbVQwVW1EOTJmdS9NaGVZMzZCVFM5UkJIenlr?=
 =?utf-8?B?TS84dklGaC90blErZldRZVhYaVIvMUlmQVkxNGhXZ1FacVIwc0orcEFrdWlC?=
 =?utf-8?B?TERUTDhuMUVnckNjc2dvbWdOUG5XT2JHWVpVenRpdGtYS2xkSVNiVnlQYUtG?=
 =?utf-8?B?TWtSNlBHUUdaN3ZRZlgrM1lxTzZabWpJUFg2a2NlVjNqNkhjT3JRZllVWHZZ?=
 =?utf-8?B?aFJOWi84L1NwTmRDaUxuMjU1ZXYyWm5KdkxWREkxT1A0QlN4eHRISlp2cXNa?=
 =?utf-8?B?UHlHNE1kT29OanhzMHB3UWtXYWY1dXR4RTVEWkQ0OVlrVVFXMkloc29QRkJM?=
 =?utf-8?B?ZDlpUTVaV3JzRHNBVWxYY1JjK21RQkdnSVczd1VxT1NZL2FOVDRDdW9EZXor?=
 =?utf-8?B?ZCtkYmFJNGlKQjhOM04rREluaTJkMTIxMDV1V1cxY05MYzcwRkhVVG5EekNl?=
 =?utf-8?B?dWJtV1dEWGYwZHlzaXNBK0JxU3RMK1BBSVF2RFduU3hrb3BESEVBeDNLenoy?=
 =?utf-8?B?dU0vaklvZHpUSDBDa2tMVXphR01jM0RJMjh6aTVOUFNGV0d3UjVpYW9lTnVE?=
 =?utf-8?B?L2lCd3J1YUttRTVRZjVHcjJwdGpCdTVZUVlPM2VNK2JzM1g0N0tJZU91cDhL?=
 =?utf-8?B?bDlqVG54NnQxTjhFOUxpSmRKSkNkZmx4NzNBWE1sMy8yTy9UUkpzTUhjL3Fh?=
 =?utf-8?B?NkFJVVMvZGN3SGtLL3psUWJBd3czL2lWeVJ6aGZBdGFmY1lGZW9MYnhrUU9S?=
 =?utf-8?B?bmJLZTdjSnZYdDFlN1ZmZk9EMnliVCtvREpqWnJTUGFFd0EwcmRSM3cvNmhv?=
 =?utf-8?B?UU03R1hBTytqQUFmcnJWcE5pK0Y5R2ZlOGpHU1lEQS95NVFqSFFlVitwZWxk?=
 =?utf-8?B?RE9kZnQvZ05tVFRZbjFzRE4vYlNQM3c2NHEvMlhRTzBLSXBMeUxGZkViTzQy?=
 =?utf-8?B?MlBSL0dEWVRFU1N1bVFUTEprWFNWajVtTDRRR3Z4NTI4MTJZRnpKaktseVRI?=
 =?utf-8?B?SWdMRjBmdmhxcnJ4a0pCckw4dU1wNnRoZEFKMU5CeDM2R29Way9BUTRkbXJm?=
 =?utf-8?B?LzFCRjdXQjg2Rk53ZTA0N3phUUZCUVhwQlVXNG42bHJCMzFOSkowY25BTUVk?=
 =?utf-8?B?em0zUXFjZ3FrU2RIK3RZZlM1LzcrL216VUNLcDZKaCtOSjNzVzJ5UjhsNExa?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa26a1c3-4761-49e0-4b2f-08dce94f0983
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 17:14:45.2143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRe+44ZFrPDv0nLSaZbMQ3Xkh/wufYtzODPtV0i0jSNo0BVGpamz35MpReEZSVo17///XJQk4sek4J8fd5Ow4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6025

On 10.10.24 17:44, Florian Bezdeka wrote:
> The following kernel splat was found when running the Xenomai 3
> testsuite in compat on dovetail enabled kernels:
> 
> [  513.620975] IRQ pipeline: some code running in oob context 'Xenomai'
>                              called an in-band only routine
> [  513.620998] CPU: 0 PID: 510 Comm: smokey Not tainted 6.10.0+ #76
> [  513.621003] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [  513.621005] IRQ stage: Xenomai
> [  513.621007] Call Trace:
> [  513.621011]  <TASK>
> [  513.621015]  dump_stack_lvl+0x6f/0xd0
> [  513.621202]  __inband_irq_enable+0xb/0x60
> [  513.621249]  do_int80_emulation+0x68/0x160
> [  513.621265]  asm_int80_emulation+0x1a/0x20
> [  513.621285] RIP: 0023:0xf7f692ba
> [  513.621288] Code: Unable to access opcode bytes at 0xf7f69290.
> [  513.621303] RSP: 002b:00000000ffeedf40 EFLAGS: 00000282 ORIG_RAX: 0000000000000127
> [  513.621307] RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 00000000ffeedfa0
> [  513.621309] RDX: 0000000000088000 RSI: 0000000000000000 RDI: 00000000f7f7aff4
> [  513.621311] RBP: 00000000ffeedf88 R08: 0000000000000000 R09: 0000000000000000
> [  513.621313] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> [  513.621315] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  513.621319]  </TASK>
> 
> When entering the low level entry code from the out-of-band stage
> the in-band IRQ state was changed. That is now avoided by calling
> syscall_enter_from_user_enable_irqs() as all other entry points do.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  arch/x86/entry/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 467e2511df2e..13589f1ca89b 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -259,7 +259,7 @@ __visible noinstr void do_int80_emulation(struct pt_regs *regs)
>  
>  	nr = syscall_32_enter(regs);
>  
> -	local_irq_enable_full();
> +	syscall_enter_from_user_enable_irqs();
>  	nr = syscall_enter_from_user_mode_work(regs, nr);
>  
>  	if (dovetailing()) {

So, the subject strongly suggests the issue was not present in 5.10 and
5.15, but just to be sure: Is that correct?

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center
