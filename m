Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013033.outbound.protection.outlook.com [40.107.162.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258D4322DAA
	for <xenomai@lists.linux.dev>; Tue,  2 Sep 2025 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827521; cv=fail; b=hc+cq9B0pWKfT3QWxjv6+SMyfrNoR0MI3KQ4PBtVHF2y4l1a2v/9Xo/jXOOdBQaasxZK7l8GbGbL0B/Txhf7z84dC0K0BOJXbNVri3WjIVH/6fGyj8RWMeXpn8sNBEN2WPt664Guo41LKzueMpOWMSus3h1urnzFuBFnzPx51CM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827521; c=relaxed/simple;
	bh=xugeA8ry6aROexeMgrZcnBXBcuda2zsPu3wHNSwoCBA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SBK5g1hK+fuUYEXqlfooVPFlF/a5cBmauPJWITBdRPulEoB05ovXgEIGoMpjwau1q5SLbkz8goclKxZ78lDaDLl7cj31IQDvBv0UCcKF2yke1PxHk0xEXwDsSifq+E1zG/s1q6ZGoFj6dTZRf7HUTbQlH0n5iR0CA7zulJ0knOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=MOj9hbaC; arc=fail smtp.client-ip=40.107.162.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="MOj9hbaC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKvIU8SxPD6z2YxynozPcST3avpTHRfCSJ/mmyNNnn5kzhY11VjvD612xzxeStcn4TeLC2cT8JBmrltBTKckBVCzv948njMj4wPxpMP2YlrGJXHweMxQ8vZbZSQpz2oaj21nWp7NpZvDS+m7XYX2F9Qw7yhSPKPuAh+MtXyjzyjHX3/gehomGSDKNlqMcM/C3LD7Gauq0JlSKZckhE4flUJylT5KJCG7MfBbGTSgcvN3Mb4tpvTZBe6SZ5aouFBiDTHWawRXJQoCg6DTFqo96qVU+JSyKfTznKu+dsA9V0YFXb14Uo3o4YCV0u+uOjFlrOYxioZ7NGcRcnDeXHUCMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9aGCiIt9WMYY3f5agwP6GKxb+Gvd01LbhDvmkv37qcc=;
 b=TOX0FY2bjit70tShCWCZOotrcLtYwbRh45i4q6xOCWrSYLdbFydcIuYdGfVGcd3N0jdqzaQCeZq87lx40BfF7hONTsttJ5blmrc6wBgR7/1MXgKvfMtE/8/v0FI02RzQrLu5Q8NYveGD/l5KL6FKnuCCKOmOD1wU6hMzneip5BEcjl1xMizJm10WM73JXBC7Ei8AmBG4vkxjutnpzXgrJtHuoMcEUcqAiK1ST5n8qnA39UFNH8AkMBfczvn7SGB5Gh/GYXSU84i+Aw3niIzJvPuegV4ynV9JE0a+yLEmOyi9tkuaLKg7aoahKSeCiipQj6yP203sbcUpoVP126vHcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aGCiIt9WMYY3f5agwP6GKxb+Gvd01LbhDvmkv37qcc=;
 b=MOj9hbaC2W9cfatPkrATlPC5kEu8e/WsMb0gR6T89JvvON90NFN5K3+qlrfACSNL31JmGMkAn3G/SsQ+s8hJhz5I4JWU0P2Z6FtxF6NG2cYLPoCeVoiFWEyibdPa+3wqtfaTDrMlMrvNYE4Hed2fYwz1YUvvVdJl05rzNw8BfdLtfPf7KNoYr7Og/wbX3nF3gvnbex01Oub5Yw1fuCEPXBak2WeRUorBtQcnqDBfNkjlIW8X8qhWLYEYRoE8mhjDDewVYLtSeWvgzFYzqO1MuiRtt23Ud+0FsMoS6vkhbobvhhwNl4oes2BBaoO7GUTX13LiarhT73268XEgA3stdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DU0PR10MB5607.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:319::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 2 Sep
 2025 15:38:35 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 15:38:35 +0000
Message-ID: <4613fa7d-a1f8-43b8-b7c6-acc7a45bbfa3@siemens.com>
Date: Tue, 2 Sep 2025 17:38:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cobalt/pipe: Fix invalid wait context in
 xnpipe_wakeup_proc()
To: Philippe Gerum <philippe.gerum@gmail.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20250829-wip-flo-migrate-cobalt-pipe-to-irq-work-v1-1-43a7c06e676e@siemens.com>
 <bc5c15c2-3423-4d6e-b296-63797ef7ff31@siemens.com>
 <87zfbe19bn.fsf@xenomai.org>
 <df36ef6e-7909-43a1-94ba-a0159c0eaad3@siemens.com>
 <87qzwp1al1.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzSNKYW4gS2lzemth
 IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPsLBlAQTAQoAPhYhBABMZH11cs99cr20+2mdhQqf
 QXvYBQJmWPvXAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGmdhQqfQXvY
 zPAP/jGiVJ2VgPcRWt2P8FbByfrJJAPCsos+SZpncRi7tl9yTEpS+t57h7myEKPdB3L+kxzg
 K3dt1UhYp4FeIHA3jpJYaFvD7kNZJZ1cU55QXrJI3xu/xfB6VhCs+VAUlt7XhOsOmTQqCpH7
 pRcZ5juxZCOxXG2fTQTQo0gfF5+PQwQYUp0NdTbVox5PTx5RK3KfPqmAJsBKdwEaIkuY9FbM
 9lGg8XBNzD2R/13cCd4hRrZDtyegrtocpBAruVqOZhsMb/h7Wd0TGoJ/zJr3w3WnDM08c+RA
 5LHMbiA29MXq1KxlnsYDfWB8ts3HIJ3ROBvagA20mbOm26ddeFjLdGcBTrzbHbzCReEtN++s
 gZneKsYiueFDTxXjUOJgp8JDdVPM+++axSMo2js8TwVefTfCYt0oWMEqlQqSqgQwIuzpRO6I
 ik7HAFq8fssy2cY8Imofbj77uKz0BNZC/1nGG1OI9cU2jHrqsn1i95KaS6fPu4EN6XP/Gi/O
 0DxND+HEyzVqhUJkvXUhTsOzgzWAvW9BlkKRiVizKM6PLsVm/XmeapGs4ir/U8OzKI+SM3R8
 VMW8eovWgXNUQ9F2vS1dHO8eRn2UqDKBZSo+qCRWLRtsqNzmU4N0zuGqZSaDCvkMwF6kIRkD
 ZkDjjYQtoftPGchLBTUzeUa2gfOr1T4xSQUHhPL8zsFNBGZY+hkBEADb5quW4M0eaWPIjqY6
 aC/vHCmpELmS/HMa5zlA0dWlxCPEjkchN8W4PB+NMOXFEJuKLLFs6+s5/KlNok/kGKg4fITf
 Vcd+BQd/YRks3qFifckU+kxoXpTc2bksTtLuiPkcyFmjBph/BGms35mvOA0OaEO6fQbauiHa
 QnYrgUQM+YD4uFoQOLnWTPmBjccoPuiJDafzLxwj4r+JH4fA/4zzDa5OFbfVq3ieYGqiBrtj
 tBFv5epVvGK1zoQ+Rc+h5+dCWPwC2i3cXTUVf0woepF8mUXFcNhY+Eh8vvh1lxfD35z2CJeY
 txMcA44Lp06kArpWDjGJddd+OTmUkFWeYtAdaCpj/GItuJcQZkaaTeiHqPPrbvXM361rtvaw
 XFUzUlvoW1Sb7/SeE/BtWoxkeZOgsqouXPTjlFLapvLu5g9MPNimjkYqukASq/+e8MMKP+EE
 v3BAFVFGvNE3UlNRh+ppBqBUZiqkzg4q2hfeTjnivgChzXlvfTx9M6BJmuDnYAho4BA6vRh4
 Dr7LYTLIwGjguIuuQcP2ENN+l32nidy154zCEp5/Rv4K8SYdVegrQ7rWiULgDz9VQWo2zAjo
 TgFKg3AE3ujDy4V2VndtkMRYpwwuilCDQ+Bpb5ixfbFyZ4oVGs6F3jhtWN5Uu43FhHSCqUv8
 FCzl44AyGulVYU7hTQARAQABwsF8BBgBCgAmFiEEAExkfXVyz31yvbT7aZ2FCp9Be9gFAmZY
 +hkCGwwFCQWjmoAACgkQaZ2FCp9Be9hN3g/8CdNqlOfBZGCFNZ8Kf4tpRpeN3TGmekGRpohU
 bBMvHYiWW8SvmCgEuBokS+Lx3pyPJQCYZDXLCq47gsLdnhVcQ2ZKNCrr9yhrj6kHxe1Sqv1S
 MhxD8dBqW6CFe/mbiK9wEMDIqys7L0Xy/lgCFxZswlBW3eU2Zacdo0fDzLiJm9I0C9iPZzkJ
 gITjoqsiIi/5c3eCY2s2OENL9VPXiH1GPQfHZ23ouiMf+ojVZ7kycLjz+nFr5A14w/B7uHjz
 uL6tnA+AtGCredDne66LSK3HD0vC7569sZ/j8kGKjlUtC+zm0j03iPI6gi8YeCn9b4F8sLpB
 lBdlqo9BB+uqoM6F8zMfIfDsqjB0r/q7WeJaI8NKfFwNOGPuo93N+WUyBi2yYCXMOgBUifm0
 T6Hbf3SHQpbA56wcKPWJqAC2iFaxNDowcJij9LtEqOlToCMtDBekDwchRvqrWN1mDXLg+av8
 qH4kDzsqKX8zzTzfAWFxrkXA/kFpR3JsMzNmvextkN2kOLCCHkym0zz5Y3vxaYtbXG2wTrqJ
 8WpkWIE8STUhQa9AkezgucXN7r6uSrzW8IQXxBInZwFIyBgM0f/fzyNqzThFT15QMrYUqhhW
 ZffO4PeNJOUYfXdH13A6rbU0y6xE7Okuoa01EqNi9yqyLA8gPgg/DhOpGtK8KokCsdYsTbk=
In-Reply-To: <87qzwp1al1.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::18) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DU0PR10MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: b2069aad-20a1-4eae-2c19-08ddea36c79f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nno0dXM1RlNYUEdwYmtKRVZzY1E2MXRmNEFJWVU0LzNnMjNYc1hwaG5KcGRa?=
 =?utf-8?B?anpPYVpXOFk2TEN0Z2MzVXJJeTJHZjFjUVlBTURVbEVLYWtwL0JMVkVxbG1l?=
 =?utf-8?B?S2pQYnBhU0JNNlRSbkp1WlRWS1Q0YThTWWdxTi9EY25aQTJod0Q4bDdiRG1n?=
 =?utf-8?B?OENRdTBtbkJkY2l5Q0VwVHNXWER5V3VjZkRlWDNTQU5tVnM0TGdQSnY2ZTRN?=
 =?utf-8?B?dVBwVlZUZy9tcmlJM3RIWjdrY1hiZjVLcEh5Z3poR2xOMXNPRTQ4ZFNZVkYz?=
 =?utf-8?B?WGt6cEplUnd3Ti80UUNBM3FsTFdaVEJtaTgweUd2YkNXelI1c3ZVbnpRNTFo?=
 =?utf-8?B?K1dkNWl5N1kwUDdqRCs1ZWJFcmVidEc0Rm00cXlWQkorK3hkdmRuWmpPNkJv?=
 =?utf-8?B?ZVpoeUI4VE8vYVQ4UFM4WlZyang1WG52TEx5WXVTTzJsSzh2WDJkY2VwbEcr?=
 =?utf-8?B?RzlHZ1BrS0ptdUlNUDlZR0gxL2ZSbkZlTDNYSDRFYlRJa2cxMUljN0tnaldq?=
 =?utf-8?B?dnNwWExaSFpGRndRcCtOQUN3bjk5Zk9RY241ZVM3ZFNwWk5pTVBZYmExWFkw?=
 =?utf-8?B?R3lsYVJPRFljcGttbExaR1YyU3JrR3pwTHI4UXBTWGRqbWdrTUhQanFSZTdv?=
 =?utf-8?B?Y1NsM1czQjhhQ3R6cWNxZ2lUUEpjanJaay9iWVk2aDZ2QjdHdUJpck9BWWJM?=
 =?utf-8?B?QXJCbEZ1ZTBVLzJhMVgvVGhtQVVtLy9HUHZBaHo4d0QrRTQzWTE2YnU2SGhC?=
 =?utf-8?B?RzVlaE00bm1IWXoxWnZIN3dLWjBPSS9seTdsaVRNRi9mbmx6OFQ5OTFEZlY3?=
 =?utf-8?B?N2s3dkVSYVlPQUpnM1g3dDhobTUvei9mMFo2dCt2ZVlqczJ6RHRVYUVYd2VQ?=
 =?utf-8?B?NVJ6NERUUnBLSE91NS9NbkN5cG54eDUyNnplT3RMdkgxa2UxaHppbTBXTGNS?=
 =?utf-8?B?UFJhWEpPRlVyK0VTbGM1cmFPdzFIMTMyNUlsTTBBWTJObTZzM3lBVW9TVDRy?=
 =?utf-8?B?MTkwYmEvdG9yRk51QndnUFVDL0FNeGRGUzFNVVFqNWc1WkZmM2cxNm8vaHBt?=
 =?utf-8?B?QlBVWnhSTCtTOWlCRjVheWRuMGUzZ3ZvakNmQjFjcnVQQmdxRU9xR0JzS0Zj?=
 =?utf-8?B?TmdUcFUvc3ZrQlVvaHgxcmY1UHpqL2NxOEhpR1Y3eGxRT0hGRHFYZS85dEt2?=
 =?utf-8?B?Wk9ISnlIOS9LK3ZYUDdKdW16SlE4eEtyY0pMakNsTSsvZ3lMTm5uR2tlSDVX?=
 =?utf-8?B?eXRmODczOFBmZWxRYVR6eTFSdmJhRHZFVG5CVTZBbFJ3dWNHWEE4MVh3RGxr?=
 =?utf-8?B?aDVFcUJaZStORCtzYUx1QzI3N2YvUEwyZCtLMUZRZ1U2ekhtdVZLaDM4UHJa?=
 =?utf-8?B?ZnZocC8ydDlsS0RVU3lrSHFIZXRia3gra1NIaWx4L1I3dml0UXp2NnVTZ0ZI?=
 =?utf-8?B?T2xLNXh4MnBuUzhRdlgrSFZOenR5cStRaGp4WXM0T0NkOHB6YlExL2lyT0tC?=
 =?utf-8?B?OWNSL0g1b3YyeWZFZU11V2hhSkZQbVZIQ29ZOXhvaTVaTU5uODBkNW1mamxj?=
 =?utf-8?B?RU5aSHQxSjlWYW0zcC9wMTV0LzJBRytCL1pMSVRHbWgxbnJSZW1aMC9VZTdr?=
 =?utf-8?B?ZjAxakdFSnltTlJIRXFpazVRREZ2dE9zU3VCZkpCck0vOXR5SmpMZU9rTXlu?=
 =?utf-8?B?TFFjUEQ5OHFEdUVlM2JJcHY2VDE1YkR3ZDJ3Q25SMUJsaEl1aWsrdFhWQkwv?=
 =?utf-8?B?YkZoamdEcGMyU1BvcldUNEJBVVhGNEQwd0FQdFFvN3dJZW5tN2J6M0cwbW9i?=
 =?utf-8?B?VEVtOGZXUjNSVmFTaVNudXJoZDQ0blV6R0ZLZG5hTkV0Yko3bVdRZlRrb2tj?=
 =?utf-8?B?UkV6MWZEY3ZZcmNCbWNOc3hlVEI0Znl6aW5MUEJ6dzQ0Zi9kN3ZVWEg2eEY2?=
 =?utf-8?Q?U/ldid8QVqM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjdFMnVBeURWZWlXczExLzQwV0Eyc2p1dmhtclRMQ0xOMW1rMGljV1J1RTJF?=
 =?utf-8?B?N0RuSUdtSlN2aHczYUpBK2g0L2o5T0VpaWVyQ0RTK3RnQmJXelBaVDBkWTAz?=
 =?utf-8?B?a0RjQ040Q2gxdWJ1aTBaVlliWXhGdVJNVGJDTkFJbEpBaGVMSXQ5ZlZCMzVP?=
 =?utf-8?B?YjdQREhaTU80L0o4NEc0T3ZzSHpMMnVOamNFUUN6eFB1cmwrOXpOUGN5TVRS?=
 =?utf-8?B?WmRtRmd5WmxwdkgrUmZodEl2MjkyZloveXU5NHp5YWZ2NUlOWEp6Z2lTejBW?=
 =?utf-8?B?dlhnT1grWWJOTnNXRVZVT1Nmbmo5enFLYkNWbTl5cTlDdkpPRkpCb3p4RUFC?=
 =?utf-8?B?YzFUdk94VHlKMllTRHV3Y2wvWHdYNkFnVnVZZ1dOejF0R2JLTEhvZDBVUmxB?=
 =?utf-8?B?VnROUUhyTW9EYXJJWVI3WWJlWE1mRXRyaWtBOWp1L0Z4UEg2ZjBxUmw5bW92?=
 =?utf-8?B?VzNTZ3NFSXlsNDFrUVQxZWo3S2pCK3I2ZlpBdVVFTml4bTJFS0tYcHlCazJV?=
 =?utf-8?B?ZXF2MEtpYld6ZisxSURIdzFTYnoxbm1rQTNFMTFIeFBXbUVqSHZ2ZXdZbDlB?=
 =?utf-8?B?bUZzdVBUNENMZzZPWUFqQlJ6dHlISGhGL20rbUNtOUlUR3QrMGRrU3Fqbk9u?=
 =?utf-8?B?TCtLYisrL3NWaU9LaTV0WHMycm9XS3NYR2VvdE0zYk44UFBXSWlkbkhRUk40?=
 =?utf-8?B?N3VDQ0VhWk1vVGZrZHhLV1lXTDhpVDRrQzdMNGpuUDdGVWRrSFZqakFSMDRR?=
 =?utf-8?B?NFZ0UXBkYWg0OWs1MDFhYXFPNDU3L0VtL1hoamZneUZOV3RJaUM0SUNtWElv?=
 =?utf-8?B?VHhLRjFxZVpBV3p2V1Q1aHRReW1jVHVWZTFuUW80emJsUXNyV3l3N3pEV01w?=
 =?utf-8?B?dENtZElZbUF6QXhSdGprRnJtSmNObktxQVdJaWhVS1psaGtPNlFoVFJHMDUr?=
 =?utf-8?B?b0ovNUpRcXgyK3BGRWRtaWc2cEttVG9abmRYQWthZGVMMXFubXgzd3VqTnNO?=
 =?utf-8?B?VHNjWjRUYjRSSGEyWHVwbDFzNHA0MnBwZGpnNjI1SVBmU1RicnRNZWJpdjRI?=
 =?utf-8?B?L1oySlEvMGFxdmFWS1VnWmRMcFFMSWprWDhSZXVpSXE5bUI4bGx1aFA0KzUv?=
 =?utf-8?B?R3JpUFMyeEl6ZStyNDFtMVhUTXFLSzNvMkIxOHFpUVBYdHpoWUJvRi9mT2RC?=
 =?utf-8?B?ZTZzVnBYQWxqMW9YYkM1ckovOWgzalFCaWVNRnRvcWxob1dRM1hmYU9KTW5O?=
 =?utf-8?B?blBhMmEyMVcrYWRJQko2ajlsaFlMdkQzQ3VnZ3BXMmNOQWlrYzNYN0NWWVZm?=
 =?utf-8?B?RTBRY2Jwdk9GVGd2bVBJU3hmbDNpa1VZMzJQQ1lGNHFjb28yU1FyM2t3dTVa?=
 =?utf-8?B?dktMMmJlT0FWa1lJUnBVVUdHZ2VaT2FJQUxMS3h0QkVaMlhHQzZxckFiZFRU?=
 =?utf-8?B?YTNhNVZyNC9vSlhZYkVjc2pzc21HU1dGL05mWlhYc0psa0VKY2hWMzZCZzdn?=
 =?utf-8?B?Wkd3R1dlbHQxMVRiQTlPZVdEbDUxT3F5Ulg2MjhoUlVxYit1cWtJSHVQT1JR?=
 =?utf-8?B?SGI5U0dKWnk5WGlsWnNCQzM5U0tmcE50UVl3RXhmVm4vZW1aaEVhVFoza3JW?=
 =?utf-8?B?SnVyaTFZeGlPaFVaQ1BOMlhPbnhpaUZkWkhNODI4bFpSVC9LUVJkb3J1RlZx?=
 =?utf-8?B?d3ptWDNTbmw5MW9KWEpFK0I5Nm9IbUFYVHZybWNKa29sbDJBZmYrajg1QWh6?=
 =?utf-8?B?dHNjaEJMREpuM0NpWEpuTjNTYTk2ZzZWdExzZ2hHbEZxS3VhSVFBa0dOaXhx?=
 =?utf-8?B?MXdMdGUyc3pNR21UK0lyTWxmR3NlNjV4SWMrK1VzVHBnZENocStIam9Nc1hZ?=
 =?utf-8?B?Q3pWelZvSjBGeElickY0S0xvc0xUZndzRVFMb21LTEZSRndzdjB4Um1GRUFs?=
 =?utf-8?B?YTRGRHdWQmdsVHJXSzRRUmloaU1sU3BIMmkwdzV5em5XcFAvRmMrRVZweXRj?=
 =?utf-8?B?NEJpMmVEci91cWJIdGV0T3UwK0d0bW9QZHhoSzBIeTlFa1pxK0xTSzB0RmJm?=
 =?utf-8?B?OFVqaXdLUXdwb0xzM3BYeU5ONzdCaDBnWVJQeGpoa29OYnYxc0wyYy84bXdJ?=
 =?utf-8?Q?F9ytfI0a78mbb6s/lPpn4icDU?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2069aad-20a1-4eae-2c19-08ddea36c79f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 15:38:35.6247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: on0vZVSBuW2kJl19MPrU/u09+29uUHaMWKpC1FJxDybSJag5jzayyMS4Bgt6vJdwjqletuX6ZxtIa2i1lDOLKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5607

On 02.09.25 11:13, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 01.09.25 17:28, Philippe Gerum wrote:
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> On 29.08.25 17:59, Florian Bezdeka wrote:
>>>>> Recent Dovetail versions complained about an invalid wait context in
>>>>> xnpipe_wakeup_proc(). It turned out that this warning is correct as this
>>>>> function is called from the inband IRQ context (while syncing the IRQ
>>>>> log) with hard IRQs enabled and inband stage stalled.
>>>>>
>>>>> The call graph looks like that:
>>>>> xnpipe_wakeup_proc()
>>>>>     wake_up_interruptible()
>>>>>         __wake_up_common_lock()
>>>>> 	    spin_lock_irqsave() <-- might sleep on PREEMPT_RT
>>>>>
>>>>
>>>> So, the warning is issued independent of PREEMPT_RT being enabled but
>>>> the bug would be limited to that configuration, right?
>>>>
>>>> Since when is the kernel complaining? It is wrong since PREEMPT_RT is
>>>> available, officially 6.12 then. Then this should go into 3.3-stable as
>>>> well - noted.
>>>>
>>>>> As confirmed by Philippe in the discussion linked below, we have to
>>>>> migrate the wakeup code from using a synthetic IRQ to irq_work to address
>>>>> that issue.
>>>>>
>>>>
>>>> Hmm, can't we use something that is a thread when needed and an IRQ
>>>> otherwise?
>>>>
>>>
>>> Unless PREEMPT_RT is enabled, we can't guarantee threaded handling, but
>>> we can always guarantee irq-based handling by setting IRQ_WORK_HARD_IRQ
>>> for the irq_work struct.
>>>
>>
>> This was not what I was thinking of. To my understanding, we need
>> threading here ONLY if PREEMPT_RT is enabled because only then __wake_up
>> can be sleepy. With the conversion to irq_work, we would go via an extra
>> kernel thread even when not needed.
> 
> If PREEMPT_RT is disabled, irq_work does run on top of a synthetic irq,
> no thread involved.

Perfect, thanks for clarifying.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
