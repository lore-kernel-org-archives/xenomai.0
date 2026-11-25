Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795606553;
	b=TaESJPnYbMtFBlWwH2UOu0y4x9a+M5uzzVqhu/ZRBYUta90xSTvD8buANRVzD49rBrEn
	 MyCbDvzsWSML1C2Sq0ABnOeFuBVCVaBGBPrpNB/glPYh8cLMzj7kS/XKLsRtNJQ0sGKm7
	 lqhDcp88anmbDFLkzjt7/bgTNgI+BCawlq83J/uLEVxYLf8S94wcTJsiU4qd1aJU+o6bL
	 lUSEdnPywFIgdIKWAhjj8rsPouOUikyosP+gtqiOoIOCbXLBlAaKEpj4VprBiHj7Ha0LT
	 vYfdF9UA3plxNf9x3S62qyL3j32t+z1r603ahmih4JCIAanL+KJhYkE1FQ43iBneE8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606553;
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
	bh=8dmDefFOs89lI44CSfh/yfQUEAOJxyOlHnFICAjJVhg=;
	b=yg9UCqw04rkcSr0XChopImErx+LnIXxkylR0UlqT2iTe9jAmNsKvaWd0jh5p/HGEsEEX
	 E0HEBYrXEuCH4O406sslVjH1t1bDtY6J/fUKycvayK3tgaYdZ2M/fVLH81hJ7vcJ5f/4n
	 3y9rCPReflflxGciPRl499ZQoqltebWSZ1dLc527AzR6VBqkYJDRmjwYxO4fo/FSqPsrk
	 lApEFj/lt3QsJyyEWG6MxGw0xTuvdfsixdttELBAtdvcTH/ybwlaQqkAAOkQsJnS4201O
	 gc/vwiyUYfRR/ECxX/rXRE6TPWx78WeoY0vs3RpwLgznN5zlsX3Vboa/KxX8EqNx5ag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=QfmKElV5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.54
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012054.outbound.protection.outlook.com [52.101.66.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0E3606A326
	for <xenomai@lists.linux.dev>; Wed, 25 Nov 2026 11:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F0E3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=QfmKElV5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmpvhQVn4h83CgVCuY9teG7UtELmPlqRkbUuGtwP1t8KIoEg8xDNtwLEx47BDPLzZMg1iPanXbAEX9Iqks18QhjaQPr1F/zAyIuLfwFPWsyeULBF9w4Wf03rGg++foxLx+EoiP0YFzD/NAU0eqgHtERtAxrsu95Io5MAK0OJtsPSqcpnyKCKDdHAfXzheON++3WTtWWhNtKyWqPGKc2DxaKNTQvlc1I7z38cpfgjU+l2z4FRRi9BCyhy6hP7h+YogPiFyIiLcz74yyERU6bZApSFN2f0AeOJytim2z9hCVCfMB6/65p1LCaILZ7fUYYjku5lfDXVJENpzjElioifRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dmDefFOs89lI44CSfh/yfQUEAOJxyOlHnFICAjJVhg=;
 b=UP49zA27Stt3uRdG2p6iTkicl9gpbMcmqfpJ3Sy0jiOxyYK3hnpkH80pcNfqzP+H33JZYX9cuqZuFAeL/X5zGf2DLmGw6oGTNVWdf7vWd/tvzC2Dd+1ePQxPMDw+4qOaO6WyQESD7XbL0+7WF8wOn8Qx78UpYSbve2iFkri7jkXm4LinoYJGh68mGb1WoglJx+v6WVfXwifSjtCxyCtuyuUiuhUHn8v4ZbKh6dxNhg2rJTdCwyiRRmZkV9R/3Ug0qu82IPS7Ag0xzon6Y7RY4Gk8GzkXnZOhM/sGAD1ZdTJgvJCaiZ9/Hpxa4gaMPwAm4VFCgJOlgPYKDRaDmLTfNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dmDefFOs89lI44CSfh/yfQUEAOJxyOlHnFICAjJVhg=;
 b=QfmKElV5pWwgyXL08T7eE7rKbXK0gHF33CEM0MU9PuLrLLaUnyq5K4SiVhKA4RSPbZjN6NI5M0S2IPhsjWupJkv24+hOu4P9gXRNrtWlz5SsepRfrKN4w8g35M2j0iNZUPWpb/mvJ69/mEHkeK9Qho+IqNu4tNjKsocrmwkAbuJdNGmQsyUKVLJwWi9jwUrJvQSv9/uaaUfjXbmy7lY1+KDtkFmRbv1/eQJ0SEvHd+HyF0xDaa0UfCO2gPznWBxAGCpXdx8AvXKqlyYQ9TCmAAlXNIFga7e3FEwYk40/grXjSiyf51UsejSnzHwf9ccCnXCRzcetoybxtAft7I3nlg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PAWPR10MB7770.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:34e::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 11:35:48 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.001; Wed, 25 Nov 2026
 11:35:45 +0000
Message-ID: <9a4375f6-be1e-4626-91d9-ad906eec7571@siemens.com>
Date: Wed, 25 Nov 2026 12:35:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2.y] net: dovetail: Restore accidentally lost mp_ops
 cleanup
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <660c8205-c3d1-414d-8977-6ee6ce1ebe1c@siemens.com>
 <874ie0topt.fsf@xenomai.org>
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
In-Reply-To: <874ie0topt.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR08CA0018.namprd08.prod.outlook.com
 (2603:10b6:408:142::29) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PAWPR10MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f637be-64c2-4b27-ef94-08df4ae83eb8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|55112099003|18002099003|260925022911599003|10067099003|260925021911599003|22082099003|6133799003|260925021311599003|261026121527099003|261028144727099003|261021121427099003|261102123227099003|261022105027099003|56012099006|4143699003|261026140227099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	cKp/0MgIx96Ef5FpVDx80DaSOxqu7ZexDz/IOMH/OiImLWsN8wsNoKfb+EVNgbCHsHl9Ul9dckSuQ9PNhRn+IAi+PmF2Xjr6wgB1XxXHidT3G1C/K4TziTUw4PzfbwcDNdLkTHRLTE4Pslk1URHuhiACjPWauZ8nd1qn6R17Irn4Z2TyePCd0ZOLs2v8cKGHnS5TchPsflCfTT42Mfyg7+335Z1Otb5N8/2ZMmm5Sw1TXkrZ6KkO5VCae1LmsvNkbBM3p7j0a+2LtWcAUoeZgx8TxkjSlz0yMPbN37xlXbEH2v4dCmHqr2jkvPYwZb5Q+1AAi+5Jnp6j0glWY+UiJ32y6lcFKpeNluxo6I1KSPnWrflEOzbUBAOycJX1gS/PQ16iFw7Tg6+IRy7l1dZdLRm8V1sncpnvrkINDuLsXDE3Z3ubH2nZBvDUQ7J2SibnVMVtJ83pd3o2Hy+79hc8frHD8nlB5qqgMbVm0qlZc1zpQtJolBkOzyca7/Rorv+/hfnDGrSGtpTp3BD4WX8PXk0ngfG/ZAqkRCEX55nmPYOWExqh7qTDc53dfFW6SzKkuUJz61hL3/AFznj8pH5ViwgTtpaDCKCQeDMSv5AGxU1hqz4Ye59NbmbwqlVgGeDRFJ14OPIfCgAh30zOty2pgpsj1tpXVfmm05z8O6E6tqg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(55112099003)(18002099003)(260925022911599003)(10067099003)(260925021911599003)(22082099003)(6133799003)(260925021311599003)(261026121527099003)(261028144727099003)(261021121427099003)(261102123227099003)(261022105027099003)(56012099006)(4143699003)(261026140227099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mm9lYThPSno0VmpwaTNGOWowRzdQOG5kT0hVQ3RSbE1ZeGJ1Vkt0YVU1ajNX?=
 =?utf-8?B?Z052MmxxU2dhbTQvR3AzcnI3SEYvclNaRzR5WXBJckQzc2pHeUtMVHZiUmsz?=
 =?utf-8?B?cDQ0eWtTVkVZU2ptbFZwVkp5d3hyeDhieXZSOGlTU1hGeU0xSHVtY01LaGhB?=
 =?utf-8?B?SmN6VGRkWUtXbk51RmJ0cHBodU54TFJ3Tjl0UHJQd2ZGREZJV0ZFZ2c5UVor?=
 =?utf-8?B?UDA2a1RQbTEwaTlqdENZckphZEhjTTJSV01PWm40L0FlM1U2bmxMTVU3VmpL?=
 =?utf-8?B?c0ZUeHJ1cGplZlJEVEVraHhkOWRwM3FXT29TZkZzSmxiSXlRK3dLNzJNZHFz?=
 =?utf-8?B?R2t3THEvUEN2TW5ocytjT0UrSXNwUW40a1BpRFdRczRZTTFiN1Z1bGpmSmph?=
 =?utf-8?B?Y3lyOVpFR1IrQXhCT1BBUWJlL1JEeGlQSUJoRnpNY3N0TnJieWtvZFQvME5p?=
 =?utf-8?B?QXJzWkhUeUlJNkhFMGVzbWJEelBkYkRwL1BYaDdDSHJiL0dHL1RlS2xBWHhy?=
 =?utf-8?B?N2Vub3VuV3V5c0VjWHVEbFRNeHFmRFRxcTVrWXJmTElnMjNVWUxRandFNjN4?=
 =?utf-8?B?RlVtTlpnMWE1RWlZSFEwTnNjcHN0Y0Y2U2RzSlg5L2JCZjF6Q3EvMGpieU0w?=
 =?utf-8?B?bDBCeUVKMExWdTk2ci9lUjlrVUU3czBxY1cwZGsrZ28zMm1YRUowRUlCNC81?=
 =?utf-8?B?M1BDQURKWkRjZUg0Y1ZlWWt3QzJBVUs2Mm02bkNzUXAvcHZ5Q2JtTk9ZQXFq?=
 =?utf-8?B?Zm5PK3d6WlJYV0FXclhOdEd5a2lSRnVlT0tZSlMzNnFubXJpQmJmbjZTVDVE?=
 =?utf-8?B?YWE3bDdBNGdtOURFN0psOWpzS1RvK01kQStIb3FaVHdDWXFvVjhuYkZ5aU4w?=
 =?utf-8?B?MmFXVXdiRS9wRG8wdVYxcEZRdTFKZ2dmWldWSTRnc3BRcUE1UGFnTTRFM0JM?=
 =?utf-8?B?Mmd1d05RdFJQRmQ1bm52UU9STHUwMmVydEttZnNid3RraEJaM1N3aU9nZ29R?=
 =?utf-8?B?RUFSbFJ1bWhBZ0FLTXRkWFdveFBXUnFidU1xSTJFdmNnL25UajUwNzlqckFI?=
 =?utf-8?B?NVBFcXRMU1JZTzVaSWdBdWlra09iM210Vy81akwyY2Fvemt5NFBBa2dzUi9r?=
 =?utf-8?B?WjE2MlVwUS80QTJaYm9kdTBIcFVtbEg0R1V4cHJaODJ1Z2N3WmsvRU9BVUU2?=
 =?utf-8?B?eFczMEZ5NUoxN0pjM0FiMU5MdEhGbEpxeGdJa1JoK2MwODhSV1BTU2J4TWxC?=
 =?utf-8?B?VmdaVVpGUUtUL0tyYlUrdUFOSjBXWVVER09pM2o2VG1NQm5SdC9ubDVJdFFS?=
 =?utf-8?B?eWp3U2xqNG41YVozUUZjUkhYTTRsNXgyZENzazFZaUlaVFR5c1I5TmtUNGFi?=
 =?utf-8?B?c0ZqUXFYLzhmZENqSGJqTkhHTVlBKzFqSjFLc1dtQmc5aEswZU1mRFM5RU9r?=
 =?utf-8?B?QUxDTTFUVXBXWGN5ZDQ0WVhFaFR0dVREY1YyMU05dG1FOWFQOGN4c2xQU1dF?=
 =?utf-8?B?SjJGYjVoSkQ4aVk2NUtOMlBsQm9mRFE3L2MvYldoVzdqTlhkQVpRL1RvVmpq?=
 =?utf-8?B?MHJXUHp5Wlo2M2hoZlZOU0ZhZ2NzTHE4Sk5QR2Q2R2dJS3ZsVFJtbGFMTklJ?=
 =?utf-8?B?OGRMRDVLbVB5STNBSVpya1hEamp6NDAzMXlGM3FFQlZ0L1ZLOGJ1THpRSVph?=
 =?utf-8?B?MFJNcURGWkpqYUtuVVh3bkJ0SkhtVjNtWXVsZ3crUVplck1KTEVabS9tR00y?=
 =?utf-8?B?Y0l5aGxBMlZkbXlnUTNTM0VqSXIrUktMTkpTbjNPc0FZTEdnVm9reHplNHhH?=
 =?utf-8?B?aFlzN3lmc09GVkFMdjQyQUs5cm5iWFJZbXk2MzU4RDNzUUp0c1hmaDNGUWtW?=
 =?utf-8?B?L0E3R3FCRVNjcDY3QUkwckJ5L05PUllLYkZGWEd1UE1iL0xnMlJjTUtrU2Nq?=
 =?utf-8?B?Vm83R1BtanFLSURrZnRJTXNiNjdYaXFXTU9JQk5SVVVwSzhuYUNHdGlHRnJR?=
 =?utf-8?B?N2FwYW5qTnFES2ZpNjRhaVNsemtBT241Q0c0bWJseDdoMkR0S2hlMUhiVFla?=
 =?utf-8?B?alBmYlFhOU1VQlFtNVh1YUxmQTZicHdFdFpDbFJRZTF4OEduMFFEN215bUU3?=
 =?utf-8?B?WmVUOWtCMWZnblZHaitPUTF4MWwvaHpVZTltSXdyZURPY3pzdy80elJhZWtO?=
 =?utf-8?B?dDJVaEJCREF4WlJ0NnlBV3cyczdiUEhqdmk3Q1lTS1BLNnJUWE1tL3JsK1ln?=
 =?utf-8?B?UUpMMnptdXBGSHR5aFQvVk40dGNicVFMc1RGK281Rk5XNGtPYm9Fa3ZzNHhV?=
 =?utf-8?B?Ty81cWc0dWh4YSt4cTJKZnJmeVV6NmhvK2hrRmp2ajV4SVZNTStwQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f637be-64c2-4b27-ef94-08df4ae83eb8
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 11:35:45.6389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uh2p7T+zp/YZ8o+u1jhqzId0YKkND6Hf9uh5XGVNnj0fOTZjb6ZjNHBkUX8DkxalosBdgmrhHjz7Y0XrlGvjzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7770

On 01.11.26 19:02, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Fixes: 2db757ed1c20 ("net: dovetail: enable out-of-band networking")
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> Should go into 7.3 as well.
>>
>>  net/core/page_pool.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> index 13ef7c723a89c..6136471425fe3 100644
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
>> @@ -338,6 +338,11 @@ static void page_pool_uninit(struct page_pool *pool)
>>  	if (!pool->system)
>>  		free_percpu(pool->recycle_stats);
>>  #endif
>> +
>> +	if (pool->mp_ops) {
>> +		pool->mp_ops->destroy(pool);
>> +		static_branch_dec(&page_pool_mem_providers);
>> +	}
>>  #ifdef CONFIG_PAGE_POOL_OOB
>>  	kfree(pool->alloc.cache);
>>  #endif
> 
> Merged into 7.2, thanks. Noted for 7.3.
> 

...but forgotten now (AI finding): please apply to v7.3.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
