Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011009.outbound.protection.outlook.com [52.101.70.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DDD2288CB
	for <xenomai@lists.linux.dev>; Tue, 10 Feb 2026 23:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770764882; cv=fail; b=YXxMvdwVo8mwcJfSdOT33OhaUV67nx0hrwMJK0yWwVPKiguk/Sl9e0L0f/S/mygNMMhHVMt1PyPLeZfXaOx/CovhyE5LwvQ/M99apLCA4Xdksk3HM4odcR/ncro+puGoMyAFlQVPmGnHBWQc5WD8xQ1XTHEoyf1zrLIbwBYU2lA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770764882; c=relaxed/simple;
	bh=1EVoxDb4p2Rer1I77sh/PX0xO1bEz9HBOtFftByjXZ8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mf33L9Otui4RvT5NgvEybrTeMjWEiA9wJvmPnFHg9sgj8CoPBxuS5nFrkrdDCBadtFdwD1+2HHMahHFGgRwq1vbPMC9Azg1Vr1vBBuZehf0Ee0gR7bRilanidr3H0geIspKWVqOL+smQZwov6/gYlXYADi+xZ5PcFzZkfpVRDhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=rZ1aTCTV; arc=fail smtp.client-ip=52.101.70.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="rZ1aTCTV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/QP+34lelFIQw0w1EAhm6FZiptVQo24uf6sOWxgCcL+E924tuLOfU4X6EbKqMkZQb5DoES+6HMfKlVCGAlwMEwbl52PcqqOB+jnOCkEningJlgg85+rZWaecuwAxbRiGStfKzN8If1AALK/aD1mPV3lBTo5fU/89j+oIM/B2a0MhhhR3YBRm/hXPXji8Fo5/SQ487NWtccogxts27ThR5/AE9dLQzDdIC7UfRq2ZrvV8eGsL5nDjWlP7xytkSfzAB9823JuSD9g6W0TdgEjpiLbBjMhl0ff4PFajwD88jc2g4LF+8jRGwfK6oJaKHN5AD1Q4Y+K1YGwkvGtX0B3Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJsnYCRXSI2tIfyIhHuaK1CQuDrS6LsM1r2npJFxJNs=;
 b=NuNbXUeUw6KHxoC6+9cOs2ZRlJpCthoghGSkBJlZZkIOGeRZj6+egzk3SZgV+XNByhEhY6h0loIIvrcw/2/0r1wdg+auHylFhMJ84PUA01RwAc0bWuNFdeXK1S/DqQr9jVT6pK/4DRbLUNrZJqS5QyXluO6SRv1mQ1BydzGHuMjkibxqOUOOYUbRg3LV4l6UxUUvxDETtgxQzURsLX/qTsN2IPIK0MpdLcEbmxnLbOLWU06fusdZ0iPFOUgt7HHX0EXPKaz9wzMbvZwTiMFavV7VRQ4lL2fU0w19GvaezjiQE8RkPXgUqNC8rk3NGHPCQePJeGUVejQD/GRHDJPdgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJsnYCRXSI2tIfyIhHuaK1CQuDrS6LsM1r2npJFxJNs=;
 b=rZ1aTCTVw8nttkaCJjlDC3CJS2Gd09fBMagEd00QeB7J35Uaw+b6mHt291EtpFsoDywOk1kJR9Uq+cfPTeFn9My0eW76Ddt9fyriYVHeLLCoQ/HhY813kyLkl6Y9vEcwzucwcb+ODS8XU8GIp8yBGWS8Z+4qffIdU4nXI3N6aYMNhNYbI2KzPwUn2l/4xfMR0FiDWtZbM3gSVOAV1q15IrUXAzfH6UC23RvdPVSbo/mduVJfwjhBQiIXcsBfOWwJKb0kQ5bnOqisXMWZtE1krw+4ZbkOaK+G2ybgQCmcRC+ognRIQWS6qt3TL/mEjBIWS5VulelAnPeKn9elVPj6/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DU2PR10MB7833.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:46c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Tue, 10 Feb
 2026 23:06:45 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9564.014; Tue, 10 Feb 2026
 23:06:44 +0000
Message-ID: <9091ec50-b519-41b2-8105-5dd03e28822f@siemens.com>
Date: Wed, 11 Feb 2026 00:06:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH 0/4] Trigger xenomai-images CI for
 linux-evl and libevl
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260209144346.487179-1-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260209144346.487179-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0315.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::11) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DU2PR10MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d5462a-bdfc-4b07-90ed-08de68f90ee9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3FDVWYxeGtXNUwxK3FhcXErbkdkbUxSZVJBR2wvOFlldzVsWnBLQ0JiVGJQ?=
 =?utf-8?B?N2pXc2FadFVqaFEzYVBBSlZMYTg3Y0cveGNFYWE5UCtYOHlNZ3R0aXNlbkVR?=
 =?utf-8?B?Q2lkWWlSalVEZTY3Ri8xRytBNkpoRFhuTVkwcnhiOWt2V1YwcGNLckZaRVRL?=
 =?utf-8?B?amNOZ3ZrWkxMeXRqZCtVanR5QjhucmhWR3pZaDZybURMVFJUaXRzV1pGeFZh?=
 =?utf-8?B?YXRITmNaU1FmTzU1YzRWb0NxMEpiMEI3eUdOYWp2cml2bzJkQXIrZGROS2lF?=
 =?utf-8?B?dnJOMXRkcktMMXo5TEFpUXQxam4rUmovWTJWcjNGVENzVEpVakJaVVFMQmlN?=
 =?utf-8?B?MzNldTF4RlBBdGVJUjZLdy9Dbjljc0wvaEMzbVVMQXVGeUpkVnFjbE1FOS9B?=
 =?utf-8?B?TDhBQm96dWZFcmhETDZUVlJpOFJ6Ky82dlBaR3IzNFkyWVB0Yk1mdi81V2Iv?=
 =?utf-8?B?OFJISGh5Y2JqTHFKSHVlQVgzREtoRTU5SE5TVHFxNXFnRjRNbmZpTFlTUW9n?=
 =?utf-8?B?cWo4ZnRNdVhVT0h5UlZJWFFRQnRSS2lsd00zbmFqeEZycEhlZ3R4WjFkeWpt?=
 =?utf-8?B?V3FzTXRGTWUrWlBhaEJyNSsrYXhuK2FtYS9vRTh6dkQyNUd2VkU4Uit3UXpJ?=
 =?utf-8?B?eWVFeUNtM0lkK0M3c2FSMlhuTnhhclNpUzNhVGZaRDYwcWxsRUdyeERUSnBI?=
 =?utf-8?B?dHpJYzBKUG50b0svZmplTTZtUVVMUTV1ZXdBWTlBaTg0MkpjSWdOcU5PTUhQ?=
 =?utf-8?B?RzZIamRSQUJqUWQ2K0h0VjNnK0pwb2t6MDROSUs4ck9hWjRRWDZMOFVhUnVN?=
 =?utf-8?B?ejA0WUp5RDVYU3g3a2RGMlRqYWNtTWZEY3Zzc2lkaDZmbUJpN1ZjNFdZd2tE?=
 =?utf-8?B?dDNhS24vS3pZcXBLdG9WMVR4Wk50YkpxUlU2QUZ4MXJ1MEc1dlU5WjZHWnBx?=
 =?utf-8?B?NVMrK0M0YndOZXdoTzZlaEd4ekVjeG1nclNKSERpYU91YnZaSW1JVTFqTEZX?=
 =?utf-8?B?Q3h6eDF1aHVhR1NCOUcvVFFkdHA3TmdIVm5RQ2Fyd0U2azltbDlWOXQvak1R?=
 =?utf-8?B?YU1halU2MkUxcE5PbEtySllNRUJPTTBETXBialJvMkN1L2dTV2o5VjZHZnZR?=
 =?utf-8?B?UFM0TTdMbEdpczV1ZUNhN2lESkRBM1BzVFBvTVVQVW51SjNDOWg2M25WOWJm?=
 =?utf-8?B?d3d3ekdqRjlSQ3NFMGR1RWs2ekdIMzhtelB3dW9oQVl3Q1poUmxKVEpIc3Yv?=
 =?utf-8?B?NjhveGpFWnRlOVZwU0orYmxKYWRVNmlZNjVHbEROSmN4cEdCSTZYamRuTjZX?=
 =?utf-8?B?U0FIYnBVT0RhYTdVSm5Nc0xoWVV0b3J5cVBoajEyZmR3akF4c2xvejZGOWhE?=
 =?utf-8?B?MXJxNWJIMG1yWEdKb2loRHZJcVZNbTcxUDl3Qm5HaDFMNllBUnRhVDhlSmJZ?=
 =?utf-8?B?UStqNEdhbWltZytORjl6MEN3ZXlDRklGdlJEYisyWWZpQVhtUFRMZmFOTjNU?=
 =?utf-8?B?V3VpdVIrSk1DUUVaTGxoWCsxYVpPbExnbnhEeVhUcXhZMTVrTW0vYld6U0VK?=
 =?utf-8?B?UzA3bG5mR095a2pJbUtUaUZLazQ3NEhMTUZ2RW11dnFnSjYrbU5odVVJYktz?=
 =?utf-8?B?djY3UFV2NzZrKzBocEsxbnhTQm1uK3ZhVGxGUUp2OVdNN2FzMUVHMCtPV041?=
 =?utf-8?B?NUI2TVRyOXc5UzFpeGZhcU8yWXJvY3hYbHdFUHJFVWpFaHh2M1JGVVhIaU02?=
 =?utf-8?B?VmlyS1BDUGJ6bnIyT09TanNHeXE3ZndIeDVkM1IrNzVTcUN0NmFSYTE4RjBD?=
 =?utf-8?B?N05HOGpyOGgxcmRZSmlybVJXNmhwZmg5VXNxQm5mMmNCZjJDK1gxd3dvbnNI?=
 =?utf-8?B?RFdQZklieEwvaG5ZWDVSdFI2MGhPOHozOEJyQU1DOHg2RktCSHBTSi8xTXFi?=
 =?utf-8?B?ZDA0TTdwMXZ5dDRYNkxOclBPVEE5dDdHb1Z6cXNmendPNDY5cDNwWmxpdDlH?=
 =?utf-8?B?ekFhVVc1Q04vQW9VSi9pbVYvRFArenhDb3Y4WHM1b0IxajZvZGlIMDQwN2wy?=
 =?utf-8?B?dWZ1SDhvQk1Gbk43aDI3VFlwSXc1dzNycUpyUnFhYWQ2cG9vWnN4SjBxVHVB?=
 =?utf-8?Q?ZTMY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFlOT1ZLU3RhK3dKa01DYmtiRjl6R3BacHJUdlI1Mnpmd1ZBNFYvNkc2WVZX?=
 =?utf-8?B?bUNkbDdYK0VwQlVKZVB1b2ptREYxVVVWNkROL01LUUVhWUdDVWlrZGpMYkxT?=
 =?utf-8?B?dEgrWFN3UnFLYUE4aHQ2LzlpOVRaY2Y3MEtPMFVZdnBNZmFoUzMyTDFjZU5T?=
 =?utf-8?B?WXdTRmFQT0tUVSt3VDZhZm1DbkhhcUdWMmNpcDUxU3JrdHlwcG0rVXBpcjlK?=
 =?utf-8?B?MTFzNnhBd1dCS1FYZy9HSk50Q1dOWUJyak54SGxsV3RueU4wQkFNS241dlJZ?=
 =?utf-8?B?YVpSNTEzbDEvU0NQU3k2VTJLdysyL2lka2E0Kzl2cFF3V29DNkxiZFI2TzN5?=
 =?utf-8?B?THdaNEJrNGI0Q3Z5QW5Ob3pZSWRaWkNuNHU3N1VYSFdsNW4xR3VOQldteGk1?=
 =?utf-8?B?aEFTeXJiYmNaUzVpblpBMzIwaTg1dnRxaWt4SUpaUEZMWlY2czFOZWV2TWZE?=
 =?utf-8?B?a1FEY3VvN0gvcEN6RTdSOE0xR2xlYlBXQ0pDTFBZbkVOUDZoZFFpUEc3cXNT?=
 =?utf-8?B?VVpHWkEySVc2N2Q1ampPclVkUHhMNlhaNS9zVVdtSlluZGlCQmV5RmE1NVp0?=
 =?utf-8?B?alJmWTVHc0F1QnB4VXV3TC9zNGZucGl5cVpkNHJHWW11NmRpc2VZdHZha1RD?=
 =?utf-8?B?Q0FZemVGOHlOSG51RTdlMWxlb0htUk45NWNOWmFHYlcweWFzT1d0K1haSy9o?=
 =?utf-8?B?bmxjS2h4eC9ocC9IUHlaOWJKbklqNEFLTFJralk0blBBVm5OOGhqZW1VbVJy?=
 =?utf-8?B?N2ZjRVlvSTBrZmpNd0JtaU8yODV5dy9xOG11SXZmbVpxay9MTkplVUlVa1Vr?=
 =?utf-8?B?L2tIei8wKytMb2VoQmVMSXQrTU9Wa2k2VWtIT3ZXNmlqYVBTa01zQ2E2a2JO?=
 =?utf-8?B?MWJwQjZBZ3BmUjM5U1V6bjFlTnUrVzgvRC9yaFNmZDJsYmZXRzBrT1pKTGt4?=
 =?utf-8?B?RitYNklmeGtFQlNxMElVOE9CT2JqVllaK09Xd3dwYUlyUDQrT1BLbE9rYkNi?=
 =?utf-8?B?KzVUY0JZMGF4aCt0VVlabHZHSitkSlJYblo0VzBxQXBLMW51NUJjek1RZHNO?=
 =?utf-8?B?dUp3WElDWHB4TFp1ZGNML2NtekpaNDViM25hd3psb1AwV2xHSlNzUkt0WVVl?=
 =?utf-8?B?bGFwMmpIYlhEdThENTdsZkRBc3FqeXkxOTNjV0tjYU93aDlQUUZyeTVJSmxR?=
 =?utf-8?B?WXVDSkRmbno5NkdXTzJJRHRxMXR3VGYvZUxZbXNMTWlFUUpzak43dkMzWVNN?=
 =?utf-8?B?aElxc2wyd0VRZzJONTl6ZXVCR0tST0EzTnljcitTM0lmdlJTT0tibG1xVDhI?=
 =?utf-8?B?RWxFRXNvMjVFZExtOGJGSnorUmROajViSUdjc2xpbDJhMUM4WnpFWi93TDhY?=
 =?utf-8?B?RTlwengvdlh6QUtENFlDQW5FeHZuamdmek9vRktwVisxeUoySVpIeWdyeUJU?=
 =?utf-8?B?K1pXMGNHUTlETGNBNmRzcHdpMC9HVFpsNllPYXBnVVo4UkVkWGxHbW5QMTAx?=
 =?utf-8?B?TlVESXQ3SUZKYWpXU21pK1JMTjdxWEpPTHlITGpkWU5ha2dkTWk1Q1Zkd1lG?=
 =?utf-8?B?S0VvT0JkZVlDL3haM3BDZ3Z1d1JvU2h5bXh1N0pTY2lDdHAwOThmT1dYY2Vv?=
 =?utf-8?B?ZFcxaDh0OS9HcldlUUtYdTlNYW9xS3VjektkVldSdFBPeEljNldOTFBnYXFh?=
 =?utf-8?B?NUR0UFFLWkQ3RTQ3MXFlcmc1Qk9FS3MvWVg0QXovWnZZWGhXRndTdlF1a1dj?=
 =?utf-8?B?TktRYjgzU3EzWWxrNHA3UlJqVUU1ZEVVajVsKzV5d3l3elkzanYxci9aSHls?=
 =?utf-8?B?L0ZkUGMyN0cyUFZYc0VOVGR6YXRPQ3p4L0F0d0U4Y3RvTGhmU1RkL1AxbnpM?=
 =?utf-8?B?dDlRbE9UVENxNFgwMHhCTDAvNzNtZGR1b3FtOWFpeWhPVDBoUFpGWHZvbFFm?=
 =?utf-8?B?VVFoWHZSZnUwblk5aFF6ZHRrWjE4L0JBS3V2OUZ6bmtyMUlwOWFzSFVMdllC?=
 =?utf-8?B?c2pwNDB5TmVrV2U4eXp3TW9DNVhPaHlXK3pqemUwRFhCTXh5V1lYa2xpK2lP?=
 =?utf-8?B?Y3lqc0V1U3RRanBZa1JuUWpRekdtaW5hUDFWWnZpTnBpUW55S2FRRlpKbWhU?=
 =?utf-8?B?MXVSdGlQQ2NOREs4dC9iMElYeWduVmNxczJ4YzJCM1VJYTYyRlhlTmsveU5T?=
 =?utf-8?B?Q0hzcGpDa2JtVUhOeVJITjFFamVIYVA5WTYxRFd6WG5ndkoxY28vU29pSm1h?=
 =?utf-8?B?aVZNZkNFSFQrS2dlQzJIeVpWaUVlY0prbW9adm1FTnNYZVN5YVNrZk51dTZV?=
 =?utf-8?B?T0NiOFdpSWFtR0lhNURyUG41b3JvK2RDWHRJUCtKWU85K1htWjVmQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d5462a-bdfc-4b07-90ed-08de68f90ee9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 23:06:44.5611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCNNZVmHsBOfQvsmtw1/bEBAnJD4jon3xFwT3apHnT+D1yrz122g1u7vS2vcCsZgleLEv8AZZXKU3GSQYhBm+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7833

On 09.02.26 15:43, Clara Kowalsky wrote:
> This brings support for triggering the xenomai-images CI for pushes to:
> - linux-evl branches: head (6.18), 6.12, 6.1, in combination with libevl next
> - libevl branch: next, in combination with linux-evl head
> 
> I noticed that the case that a branch matches the rule
> "$CI_COMMIT_BRANCH =~ /^v6\.[0-9]+\.y(-cip)?-evl-rebase$/", but is not
> the head branch (6.18) or a xenomai-images supported branch (6.1/6.12)
> was not covered yet (this would be e.g., v6.6.y-evl-rebase /
> v6.6.y-dovetail-rebase).
> To cover this, as GitLab rules are evaluated once at job creation, I
> introduced a dynamic child pipeline that triggers xenomai-images in
> case of a valid branch. If the branch should not trigger xenomai-images,
> the child runs a dummy job to fulfill the GitLab requirement that the
> resulting pipeline of the trigger job cannot be empty.

What would happen today if someone pushes to an unsupported branch? CI
for the triggering repo would fail, right? Or something worse?

This would not be a big issue for dead branches. OTOH, a silently
passing build for a new branch that is awaiting xenomai-images support
would also not be optimal.

> 
> I tested the patches for:
> - linux-evl branches: 6.1.y, 6.6.y, 6.12.y, 6.17, 6.18.y
> - linux-dovetail: 6.6.y
> - libevl branch: next
> 
> Best regards,
> Clara Kowalsky
> 
> Clara Kowalsky (4):
>   ci(xenomai-images): Add build job for pipeline triggered by libevl or
>     linux-evl
>   ci: Add CI for libevl
>   ci: Add CI for linux-evl
>   ci(dovetail): Trigger CI only for head and supported branches
> 
>  .gitlab-ci.yml       |  8 +++++
>  ci/ci-child.yml      | 27 ++++++++++++++++
>  ci/ci-dovetail.yml   | 35 ++++++++++++++-------
>  ci/ci-evl.yml        | 74 ++++++++++++++++++++++++++++++++++++++++++++
>  ci/ci-libevl.yml     | 28 +++++++++++++++++
>  ci/evl_xenomai_4.yml | 29 +++++++++++++++++

There is a certain structure in all those new files under ci/, but I
think they are just getting too many. Also for the existing files, I'd
like some separation:

- ci/trigger/*.yml for files that are consumed by 3rd-party repos to
  trigger us
- ci/<trigger-repo>_<trigger-branch-or-version>.yml
- ci/lib/*.yml for anything reused by some other yml (e.g. the
  kernel_*.yml)

Maybe you have an even better idea for names and structures. The
principle should be that the ci file structure already gives a hint
where to look at when traversing the pipelines, from .gitlab-ci.yml to
individual settings per job.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
