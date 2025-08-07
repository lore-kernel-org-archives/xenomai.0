Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011018.outbound.protection.outlook.com [40.107.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EC14431
	for <xenomai@lists.linux.dev>; Thu,  7 Aug 2025 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754557455; cv=fail; b=DpkxyYWlVhSCphTydtswjSM5eD9e4+86OQsQZRCjZz5ZdnZ0OPOgJ9FqUMvKz7AB8VNe6V/WRo8VTGGdulwhCzXmT5N04l0vr37fpKbviA98AxVDyfjy1p1pSEsY6lD4cXmF6PoHjIY7S5mM8XN+G8GuPWmPYoYldWavt0begxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754557455; c=relaxed/simple;
	bh=+H/BkdwL9bHX+q+PB4lUmGrX9dc5sH8wa0ru1sNrqb4=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type:MIME-Version; b=m2uB6saVgVrcHL8K+MRNqtIJO2ce30Ff1Mn1KihVFRgo6TGZKQ+AXQVuiAA2wRM3LSxE1V4Y2UqCQYQbhzdNKWUzpCQ431d4WG50M5ufHCLS1P8Sp8JwQRucqIOJeNlCFiQVv2jD0JPZnr4vmq0KY2w7yWKVkw1fYDOR3YsphTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ipo72/TF; arc=fail smtp.client-ip=40.107.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ipo72/TF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+aD+kLGwxq0TTSr7mxpkQYIMMrmgNRYJZhbkduiJCLcQ50xIuHf254A7mCd8xePr4OvjgFrVcYN9LSgCwzjnDK6wIC+Bzz+O9BPwBvN24r4HRIe9g8kZHyEygAi3q9akPc7t75lLSv1HlK8NAHHSvmde5qcYuy8TKjUe8sQOHcC5lPuyr1h2lkGwWDxhL314ctyIIMiCuhC/pd6C9rc/UNTpQNOlMrwFy3RP9iWb0hxqZKPmRQpBEfRi3GtOZOS5hZAGhxms6rasdOot+lwIpQKvq8UwnWOLotL755jt815TUIJ1T52nYAYtDcqGLCcEJtENlMMhA8amU+yKVGCzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypPf70PTDK0AnaU+QJDMTOoGrYwKVy0/MzFzR2rL58I=;
 b=TuhoHODnKYdlijMGu0HjMOYiXc/hWmIBeR7runWrkeXXWXXmULmSgYx3o2URIn4A9NgVWEGFcsTw1l2f6VoP9+vPrr+TJk417IF6BN6tLQ6rdi2V758VytkCxR7G2tKOKILlqCT10+5S29bJvLAxX6bFaPggg5EGcqD8YD9ZhPTVaDGfsPPFtLxuDiYrnH2e064C2x4b4sqFZ01JCm5WSxgD6qwiGcGKcvovIRoqyBE7uBQ9a5q4ILp9MKspRI17bYx4cRxqZnxppI1vxsalpMht+b4bnNIOmoJ2qgV6qkxiWEn/9Wnrb1bH8wX2NbFzzWU8CRlntKTdUkdPIqnyGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypPf70PTDK0AnaU+QJDMTOoGrYwKVy0/MzFzR2rL58I=;
 b=ipo72/TFJQXb2f+b7BHzkC9fUWNygtc2RWWNIZeKb9GolSRTUFnAxdq0IgkxJeVoQFBnu/eK5/3BA87rFpliQJcRgwd6s7MNudt04IK4BxgLDmEh1GbcGJVEURU2JLAznLcIpTOL3KWc6yQKodrmMIOwdOGQNgz/gXZtnyYGtn75RfknIwhVBg+Kpw5B35D3Qn4N9oQbvv2RqGJ2nAfWY3oYeGU1Wfe9pkRSUabGWF1R1BRcn2Fl47iMDaDUZ3Bdf5/cMx+2tSyVvyM7vI4NTeK+31nudgci3DSHH2EdDm+382ywjATiwxrrMND7mCGJhBqCXDztHUHhiyeL4ruL0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5694.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 09:04:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 09:04:10 +0000
Message-ID: <a1f7db9c-0422-4b1a-a762-d5ad2d9edf99@siemens.com>
Date: Thu, 7 Aug 2025 11:04:05 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Philippe Gerum <rpm@xenomai.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: We are moving to gitlab.com
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5694:EE_
X-MS-Office365-Filtering-Correlation-Id: c4d6d170-0e8b-460f-65ab-08ddd5915f2e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjdkcXAxZEw3RkhjMkdtRVFLaG9Bejg5bjVRTnVNYlZyUUk5bzBUWW9PRjNV?=
 =?utf-8?B?ZXd6OHBiR1gxRTArL3JSSEdiczRKMURlZEVGTG5DRHo5Yy90cElpa2FVdU45?=
 =?utf-8?B?bHFWeXhEUjhZbTloZUhmbjlmdmZIUDJaNHBPdXdnZDgyeUlFWGlKYlFzeXVM?=
 =?utf-8?B?YzFISnpjRm0vTTBYNFRod3Z6N05jZ05WaS84L3g3MTRiM3Q3WUR1SFhNK2pL?=
 =?utf-8?B?QWFOY0ZzOGhXbHE2V0VaN3c3Q1FYNi9ha3RzRVZlTnZTKzNTdkpIN0VPd0VZ?=
 =?utf-8?B?N1Njemd6cXBKME5neDM1WXBKcDJ2QkNNaTRGdU9QNWw3UnR1b1c5ZFRlWW1z?=
 =?utf-8?B?SmZTN1FyOW9uVisxM21tZjBxMzZIS0d4cEEwMzJyS0RIUmVvNXdJWE5aMTZL?=
 =?utf-8?B?RGh1dEhPZkYxSTIwNmxtMVlQNEhCNFNNTzJCaFlaeE9nbGNBUVR4a1N0ZDIw?=
 =?utf-8?B?VVZoRTJaVjZFS0FTenpRZ2lCUk9Pd0EwOXI2MnZBS29yZW9BVTBWWWg0U0oy?=
 =?utf-8?B?WFI1VDdUSkk1Z2FULzhsZ0FCNjBwTzEwVStBa0luYzdXM3NmUWRHRU5PMGJs?=
 =?utf-8?B?R09VYld5ejdFb2gvU1ZYVVFnK1BVMGw5R3lSc01jbk5NSUNFdkNjdTMrazlo?=
 =?utf-8?B?MGxnb2FzZk5keEVLaTJLU3ZQN1E4SzB3VmlWYXdLbU9ES1NIMkJ4ZE05T214?=
 =?utf-8?B?MUp6M1ArYkVRNE5sTWxHVDM2ZHM3SWZhekg5V3RTRDR6aEw0Wmh4U2VXZDB4?=
 =?utf-8?B?a1NheUQ2WnRFRlMyY3NKKzEybVlXTFVDUXA0TVYyUW4xS3gzdk83UkJtT0Jr?=
 =?utf-8?B?bTJScUk1WjQxVXhDR1VJUmFSRHAvbUVhU0t4RWY2Y1JEcm1nbjdvNmFXNGVa?=
 =?utf-8?B?dFJyR1NyaTgxMG1ybHpDcXlRb0taclBzK2ozV0ZWbTFTSTVKQnlrTG1YRTVL?=
 =?utf-8?B?Y2RaN01paXk3Q3dhQlBQdDNUeEJBUXFUK3hnUzI1bE13TlQyTmlnd0UzOVIz?=
 =?utf-8?B?d056aEF5aC93Myt3eDZXSmwrSVBzdVRLK0NROHVxZTUzSzl4bnhKZmZ3cjhX?=
 =?utf-8?B?ckhraEZQZTBVZHBGRUI4bE5aTWRTeDZ1K2NoZzlPZitjek1BV0ZES2xSNUdS?=
 =?utf-8?B?TmVZNEZ2d2pEWGxqaExhQ2VJTlZDZEo5Nm9FbHZzZDVpZ2tkdHVSUjlUWVBt?=
 =?utf-8?B?VEFBUmkzaGdMZHRPNVR4eVpwWWZyVTg5Um84RXJYR0kvNmJuVnRPelZYWUVp?=
 =?utf-8?B?ZHgzbUlGOHd5R25rSDE5UU1aR2Y5N3dCUFA3K3hTYURqM0d6amp1TXhjZFVJ?=
 =?utf-8?B?ODlZdmw0aEhEMDVWS0ZNRlVOWnlpenY3aDVJVGRiRUlWcTk2RDJ5SE9Fa0RG?=
 =?utf-8?B?Z1Z1Zm45MVNRMWQwQmd1QU4xZlpsS01pT1AxeWE2YmxCNFJxUXVncXVxVWRu?=
 =?utf-8?B?ZjQzd0hUN240OVFLNy83WnFsWjYrZEtlWi9NVGdnWDFLN21sdFFzRFVTSm1p?=
 =?utf-8?B?MEYrQ2RrSERqWTJ5aFZyYnRneVE3VWxid3hod29wYjdLcUM3c0ppM1ZOaUpz?=
 =?utf-8?B?TUdqbFZFVFJCOFQxQUJIV3VhaksyN0g5cmJhcU1nMEZmdjljMmZ2MUxUMFVX?=
 =?utf-8?B?eVIvSGJKSnZHY0VXNlJuaEIxeGREa1FTT2N4V3EyU1VaOEtBdjV6TVIyeDJi?=
 =?utf-8?B?R29hTi8yZUxhNzZCYVNKSGowLzhWY1JoYjlzWGM5SXM0cnpubkZLWmEwUmhK?=
 =?utf-8?B?ZlkwcXFFR0U5enExd1d0VEZsQ25FRjQxaGd5NGFQNCt3SXdVMElvQTV0Y1FY?=
 =?utf-8?Q?yZ7ifxzA9dJbUCoANkQzKcCyWtY3+KacZGYUQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGZ2Zm9makFhckQyaHhYMXcxLzFZVFlwZzQ0SGFpeHo2NjVHMXh6dWFQZks0?=
 =?utf-8?B?N2Z1Y0NkOUpJYVJ2Mms0OXZsOWUyOW9rSVF4L21XUHVJc1FMbVNyQlZqekU0?=
 =?utf-8?B?SXdBR2NwNUZCOTVmUnJSMVFGNXdNTHdkdjh5OWVyTzFsQTVtUm9sWmFzRVZ2?=
 =?utf-8?B?YWZDWWZmNytLeEFTd20rNnR5dHhONjVqSXVGeDdtMXdOOXdmcjkwa3lUbHRx?=
 =?utf-8?B?eHVSeHpFbHFVckgwZDl3a2VPZGhsaG04TEFpSXpMM1NGbE4yNnAxVXVPMWtO?=
 =?utf-8?B?cnJWU0hVWUxkVGlWeGFtVzN4NkxGMmUyTml3WVZ2Z2F6czhsalRSQjJpbmtt?=
 =?utf-8?B?Q3RyN1ZJN21RcXFXRll2V1hWcUY0QURtTHhFZC9SQ3F2S1BBR1A2SDR4M1Yx?=
 =?utf-8?B?WVlCbW9rNlNCM1JIMkFSQjJscEFLdWh6K2pKVVIzdittSUR3Um01OHhXaXRk?=
 =?utf-8?B?Z1grR3U0TFdWQmlnL041QnZFUkJNck8rQk5oWXlucTZFVFI0a25TRW14YjE0?=
 =?utf-8?B?b0lJUkFreExhb1Z2bGVoQnVONTRpcTdYRWVwK1hvOXhHWGJqR29yV01ySmlr?=
 =?utf-8?B?U3Rmc2tUNlY4Vmh2STArTzl0bXFXYXJRbnN0T1JrVjlNdk5uM09GT1pBM0hr?=
 =?utf-8?B?OFlmR3dJbnNFbFBoTjFIajZ5Qk9zakdjTTc0SjAwakpIL1lCTzJTMlpYOURQ?=
 =?utf-8?B?aW9aN3MrWkl0V3puOFRoc21UTjVWMGMrQjRVV21TYjYxOFZlZ0dkMlBFSHRz?=
 =?utf-8?B?M1NKNno1Z0VWZElEUzAwemkzL0JBa292eFZIN1F0dkdtZWhVYW5ZR25iT1hx?=
 =?utf-8?B?TXpWelF1VFdzR0plUEFheGhYbndPRzJrYVFXK0FXdGFldnQ1WWJnT0w1MlZN?=
 =?utf-8?B?aGNCTG8wa3A4VUhZRm9DR3dJL1lic1lOWGlWUWVJYXVpa1ZkNTJla2QyVHdU?=
 =?utf-8?B?UUc2TVFqR0FCd1RENWptYTRlazJLYlp5R2RUeVltOFlGY3dGdnMyMHY5VWpO?=
 =?utf-8?B?dGxSWFMyblFRLzdwZWhvZ2ZnYXduNGNuYzdUWk9JTWwrK0VwbzdxTTRMejhK?=
 =?utf-8?B?ajlraXR6bFZhYi9MNVFXam1rRUo0QklhZ016YTdXaHVxcHRnWE9IVGVyd1J1?=
 =?utf-8?B?dW1hWEpnbXZtbFc2TmFjMURWZFA5aDBDbzNSclk0QkJnMWtqdldQNDExc2Fv?=
 =?utf-8?B?a21LK3ZOd3lvL3VuQWdMRldVM28xMDlxR1oyR21TbjQzN0JXRER2ajdFYnlB?=
 =?utf-8?B?RVViZDFhWk9XY2JkcWo1amtJSXlKRDRTMEkxNEp6S2Y2NWRBTURoWllXeCs0?=
 =?utf-8?B?aGhIVGtkbWNucTZEM0hhSC9sUlppdFBXT1dXaUIvRmhsSUZKN0F6TjFTUTNI?=
 =?utf-8?B?TnpuVE1oelFpSTk2bEpNVXBjejBqMmdBMU81T1UySDk1TE9IRTdFNmFKQUVs?=
 =?utf-8?B?bWtuRFVoS2pGM2U0RThRWkk3NUVodk56V0xFRkRTcHp1NnRHMUNLUkxkcXYx?=
 =?utf-8?B?c1dlMFE3TE5FdTkzWGlSTHlWR25LWTBqTkRYVldmN01tRWdvQUZxeEhwRElI?=
 =?utf-8?B?NHFJcWdvUGw5dm5objRYT0NtWVdmNHQ2VnVjaFNVZVpQcHBuNURhQmFKR0RN?=
 =?utf-8?B?azR6dHloK0YvMlVXbHVpalpibjF1Y05wSG9TMVhIblNDTnhtNFVtRVp5UDl1?=
 =?utf-8?B?L2JKN1FYaVlhcC9ydCt6Ymhib2VvZytyK0EvbjhHSmJNeHhMNjhBdTY0VzY2?=
 =?utf-8?B?OXgxWU50L2VwK2Y0aDd4cEJUWVF5UmM1c3RpSlZOK0tweVdlUWpXTzIwTnQz?=
 =?utf-8?B?UUQyeG80LzlzdUltSkRLZnI5OGg4S2R4amtWS0FsRVIyaTJRQlJRMkw1V3hY?=
 =?utf-8?B?ZGw5U2xXVitGdHBLYTVEci9hb0Fqd0sram8yNXMzWU0zd2FBUFo3S2dzaE9j?=
 =?utf-8?B?UktCTW1KanBIeGJDV0FodlI4SkdjdmpheWQxc1VVS1JGSHMzak1lOThoWnVE?=
 =?utf-8?B?VjlzWlVvcTRZMmhyc01GenpYWFVuK24ybDV1TGI2VURGYmFSc0o5OHNMaEli?=
 =?utf-8?B?MnlLK2NJVUFPWEpDVjFBQWxqTEpEMzFYRC9wMjQ1eTYrZlpJVm1lWSt5Z3Zr?=
 =?utf-8?B?Rjk0cExMZXlLQTVhRjJ0cXRHYkNIMittRHZ4cjJmRFFmWFVmN2RUVFFTS09I?=
 =?utf-8?B?cUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d6d170-0e8b-460f-65ab-08ddd5915f2e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 09:04:10.3125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /gKaBsvJYaWYiQRdcl9c0rCflNhJlSZ4YSTMvH32bv37TgK/TbF8589/m237llITpAskXIqC7qr12YOS33VK+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5694

Hi all,

we have been informed that source.denx.de will eventually be shut down.
There is no exact timeline yet but we better act earlier than later. In
fact, there were already signs that this resource is at risk. Therefore,
Philippe and I were considering options before and came to the
conclusion that gitlab.com is the most straightforward path.

So I started to build up mirrors for all relevant repos under our
pre-existing group at https://gitlab.com/Xenomai. At this stage,
source.denx.de is pushing all changes also to the corresponding repos on
gitlab.com. CI and websites are still on source.denx.de but we will
likely change that next week. Once those services are running fine,
repos on source.denx.de will become read-only, will stop mirroring, and
all development will start to take place on gitlab.com. We will let you
know.

Still, we would already recommend to update your git URLs, which is
basically s/source.denx.de/gitlab.com/. If you find any glitches, please
let us know ASAP! We specifically interested if Xenomai user in China
face additional access issues now. We already have some mirrors in
gitee, but their quotas do not allow to push complete kernels there.


Another change along this: We currently have so-called hacker spaces on
gitlab.com [1][2] which were created to allow any gitlab.com user to
create issues there or actively pick up todos from them. Some frequent
contributors also used those repos for pushing ongoing work. We also
planned to grant access to the projects CI and test labs, though this
wasn't realized so far.

However, with the main project moving to gitlab.com as well, there is at
least no longer the need for separate issue tracking. I therefore moved
all issues from [1] to new main repo at [3] and disabled issue tracking
in both hacker spaces. Please continue the creation of and contributions
to Xenomai issues on the main repo [3] from now on!

And if you are using the hacker space so far for pushing branches,
please speak up so that we can discuss how to handle those use cases
best from now on. It would be possible to grant developer access to the
relevant main repos, but it would obviously be possible as to push to
personal forks.

Note that this move does not change our patch workflow which remains
mailing list based. No one raised the topic recently if we should
consider a merge-request workflow, and as long no one does, we stick
with our tradition. :)

Jan

[1] https://gitlab.com/Xenomai/xenomai-hacker-space
[2] https://gitlab.com/Xenomai/dovetail-hacker-space
[3] https://gitlab.com/Xenomai/xenomai/-/issues

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

