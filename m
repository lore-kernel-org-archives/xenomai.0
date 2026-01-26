Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010050.outbound.protection.outlook.com [52.101.69.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8EE335BD5
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769439712; cv=fail; b=spLM6CZbUFmtv7Srllbw84ohBxDbVc8xf3q69FFyx1upKEnKqMv2P/2r2SID7EgxWmP2zpa/3CDynJtdawvpl1v+pHy9qiznulcHX4ZNFE9BZdXyAnTlCU5/rcdY9wEWu9UkPH1zhb7bnfh3M0oc4WCTMgaD63+dHy4imdELpLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769439712; c=relaxed/simple;
	bh=lKJVEGXvOGnMviUSf32BzkmEyxCJp9Z+3fhJYy0DIdk=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=u/aSr4opp8UvwqskSoJOYhArepc8UXuL6nt+88XxbQyYgWSaHdJ41VUe2waOFx6Ph7d8i5GfPnC16lw7CB6QwyTPIGFuO7tpPKpRBGzOwN7qdzTDluxdnO8QtOptIZcqomduQ/aJIvGdgb2LYWKSIHbg88ItfRyoNCYiOm0Kml4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=y16B4WrV; arc=fail smtp.client-ip=52.101.69.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="y16B4WrV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ioz3Rde2dB7TwTeTgZ6E9K6orEOv9QuHG1oC+IX4FF75/T1N1m+CykOJqddae2Lr35NXSRK1cwAMtSZ0DGK9OJL003fHFBVBPpSSwkl2CB3tPhvsA87XbPc5M1I3uu/rEwwBouO5WdccSLVp7ICPxI4fBea1lHaqB5Uw8UVJtjbZ3hMFCaFQ/9jCgyvGMuuL5Kh5PMS1vbyvDEkwxR7OzSQ6EECxU4umPT9j9tkc9KwVh43HBJdxNk3org978vAOPcdH2CkBvxVG7RdOVpe0/gblY/ASjTOJAlYH3YU9OCTp9htswy0aZ4+Of2TTlH1+ApmezCN8bKB1AqAYlLrviA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOi5fbR1yd7y6bQnpqyE9ShQn2uNdI/ffyD2C4WBk/g=;
 b=Zd1ZvOcJwDtPNauTd6R7pCsTmWEK+C5vGbZwme1fe532bBK/R66qA2DokocxArqSmIycFUCmwuvkyGOeKgB5U3n/nJwXY94m7+NtVz2dA+TwqykTwOb7RuM8NIn2DZ33NwFfImLYUlrg4EkQBV28EnSTk6H6MCWU4mOz23cZR2daJ9JEcyYTjBdcAML6Wmvh1QR52sFv5VQIwgT6axWaquMZRQM4XxDGxDd2IaxjHa5j4WUVgBe3afhdOFseURhqfnmulEcD7jUWfSLBOo8RGWZAjIjx8Vi9x8cXozkTkCYZ/W65dKIe9a2kzKy/4H27CP60HU3iYjNcj0VA7mANWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOi5fbR1yd7y6bQnpqyE9ShQn2uNdI/ffyD2C4WBk/g=;
 b=y16B4WrVS7nUuEQaO7JLoyB4Q6n2fabFVP8cBYZRgxPTeygxcLrYjCrDAqhyioXdxiHx3Z+4QKI67TRP4DqrE9mc3oOyqqZHYkl4PHA93G8B3dj39CS3YWE+zAIGzqTHqQPPWyCYaTPDaGLuslN+4zIbSeFWle2cPRt3//aFdZqjZUPlc6fQt/NTkKG/eKLbjZAEaJ99VNHRsiLFAPclus8LzropihyUfnfX17bD0Ebstzh+BGPBAU12VkPbWbfhuIiylufclbb6E5lA+tmmOW3/UFXU+MnnOe9fug5LRldcwYM+lXu7ut6pVphSR7Wj1YHBs2B18lylKCD/Ev8mYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB9513.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:554::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 15:01:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 15:01:47 +0000
Message-ID: <5b5faf66-f9af-436f-b4ee-31d7e8952126@siemens.com>
Date: Mon, 26 Jan 2026 16:01:47 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] Switch BeagleBone Black to UEFI boot
Content-Language: en-US
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB9513:EE_
X-MS-Office365-Filtering-Correlation-Id: d3384a04-7ed0-4560-8d83-08de5cebd3ee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzFFSkxCdmFNQXpIbDlKMFhNZzlrM1ZMWjJXbk1jVnlieCtGQUYwZnVMbFVx?=
 =?utf-8?B?bzJtcHc4Y0hMS21xTExTSkJBQ0JRNkxWWk5aaWlwUVRpYkVhWXowb1ZKYVFV?=
 =?utf-8?B?QlpiUDRVclJ3S2VWUWhWMFVhS2RFWExOc1luN1pPRHZXdElWUWhNR1hUN3Mz?=
 =?utf-8?B?RWJ5QkhoS1drTHJQQkJNT0J2dTBCUjF6bHcvdTN5a2lWd1l5S3NIRHpGNU9X?=
 =?utf-8?B?TmVoaWJkcEVEOFkwTTc3NWIvMnY5eTRTYlNHS1lmVFNDd1AvN1NLbGpQamlE?=
 =?utf-8?B?UVJHc241QUhjZit2cC9LbURNaGJtS09JSGd1NWFPb3prSFhmOEd5dTBMYjRw?=
 =?utf-8?B?YithYXc3bWJXT21tMEw2OUFhRnlrNTJVMkdOT1BZVW1VWHlmZzhlUzVBTERC?=
 =?utf-8?B?NFFpTjRSd2hlVTlFai9zZGM0RUJSMVFMWXd0Q0hXbld3clU5d2h4bzk4Q0dr?=
 =?utf-8?B?Q3FTT2hiK3YwUm1tZmk5WStVdzc0cElvNWIrTmxudUxRdTUrR01XczlWTVB0?=
 =?utf-8?B?MFp1VnJob2JJbm1nYkVPcXZjTkZ4NzI4V3BpMm1WR2FUZndLbHZFK3BqMUdK?=
 =?utf-8?B?Sk1LcllvRlZ3c2c5d01yMkhjcC83NVNQT1ZTZE14Q3ZFdjNETVR0azE5Rklv?=
 =?utf-8?B?Q3haRzY4L3AvKzE0OU05eXJaa1pzdFpGK0VSYWxmamdoeFJTZWZLdHFia2JB?=
 =?utf-8?B?YjFteVhKNmdQRGQxdnFBMWsxTktqb3R1MWhMaGFpYXdMckw2blM0dW9HZ3JS?=
 =?utf-8?B?ZVd1dGI4K2Foc2Q1cXZUVTRQSmlJVkpnTmhYV1l3ZU1nOFVpVVlKellkZ3pF?=
 =?utf-8?B?Q0FWV2crcmwyaDdSaG1xOFNra0pjSUxVTnJSdHJYUEZPVzRYZWxpb0lONnR6?=
 =?utf-8?B?MTJ4RFd4cHdBWS90TGpodXV5QzZ2N2ZwOUp1cVY1cG53R1lxeUg1cXRQbFoy?=
 =?utf-8?B?QlZqc002ZjFhcFBLLzl0aGxPbnozbVp5UkdvdmlycWZGU3lkZ0J3b3lDNTNT?=
 =?utf-8?B?R0paM3pjZXdBUlM3Vml3UitGakE0Q2s1ZFJYbnQ2SWRnbWJNNFVwOW9hbElr?=
 =?utf-8?B?N3VCRFphZkhhREJraXlobG9CM1hJeXZNQmVaQURDYWZRUlk2TFNaRGE3QmNW?=
 =?utf-8?B?SzVvSmZqNzdZdjN5b09BNEhhUzRsZFRmbWRrbE9CVm85UEsxNnlUSFg4RG0v?=
 =?utf-8?B?YXc1clZIallwc3Y3TEhRQ3pXWVNaTlZWaHFuYXl2TTlJVm9vWmEvWitwMmVp?=
 =?utf-8?B?VlN0UW5iOVV3U1puZ0pMdlpITXBTeWpyNEJCWWxjY0UyZDVWME9hL2c4dnRQ?=
 =?utf-8?B?a0U2Z0FialdPa09mZ2VmOWdwalJicUxJMEZyV2l6bit1aDd1ZEhsbWZ5Wm8v?=
 =?utf-8?B?N1N0U3dBbE4xVTBjNFlyR00yOEpYb3NkL3E5czBFNm12UlphSFBLS3dTUHJj?=
 =?utf-8?B?Q05rb2NXdHhRQ3JOYnY4Uy9EZmc2dGRFejZkbEQxSmdvWm9NRDcyQWNqZ051?=
 =?utf-8?B?RkFQakJqVEdPdVJkbWRnVXpMQzRYRU81YWd4VFZHaUprZytKVGl2ZXpmQjl1?=
 =?utf-8?B?Zmptb2hwS3NST3FTbW45ZkU5ZVRCOHdreEdNU3ZJV25LQXRpczlhc3ZDYnIv?=
 =?utf-8?B?dTZLN1RzK3dGNWFiQWJ3eFNXaGxxMVJqUWRySDZqT1d3TWFRTExOWGlEdEQv?=
 =?utf-8?B?SFlaY1hnSXJJWi9Kd0VuWHpscExJWURJN2MrcHg5Vk5WMFBwU1AvbldoZ2hy?=
 =?utf-8?B?Z1hVMTZJR3l1Mk84Q0tkUlZKVjlKWHJvSjg5bXhWZVpGUGxyYW9qem1TR1JX?=
 =?utf-8?B?L1JUVkJ0dDE1WHBSVkpTdHRNUExyeDdwY0xGRVduSGNNNWRLVDgrQlMreGJo?=
 =?utf-8?B?eUUrbTVaNERVSVA3Nmx6b2FLY2RUYkVmbG5xMzR3eGxhM2E5QW1pVHdVeG8r?=
 =?utf-8?B?ckY4Wm1RZTl3VWZCN1VhZjQ4UmZZaGZTSDBVd3VuZG42ZHA3MGtNb2swWmlD?=
 =?utf-8?B?T25TSFJpYTZPS2hpS3UySE95Ujk3SFV2cnhPN2Y0RE1Ed3NrUGtTV2xrU202?=
 =?utf-8?B?SmJCaGVMMHlUNUhKZVhoc2RpZUFqeFhXR0poZ3ZSN2xKa1RsUVJmaStCUFFU?=
 =?utf-8?Q?Qi5U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cithalhVYUVxbUlpblVIM2JQNDVpUEJtMEtMSjlRS2xlWDRTTWpvTmhhVkQ0?=
 =?utf-8?B?ZXhybnJKRnEwRTVWcy9WOVd3Z1FrWFdrNVYvTm9xSW5namdCb00wS0hPOFlL?=
 =?utf-8?B?emtQQTg1anZ6QVhpdGtKZjhWS1RMcGVOZ2FFdlhQcUQvODIzV1cyd2YwWng4?=
 =?utf-8?B?WitKQm1VVkJ1a1pXWm1kQXFFSm9lVVVCL0xKZmhvajM0MXdEY1BSN3BrTXFm?=
 =?utf-8?B?Rm9QeUVzbWRhTEl3UXhXZ2lkZDEwWTBBQmlpSHl4V3N0L2RkaHA4eXViMElC?=
 =?utf-8?B?alRDQkl2NnRheDlaNGRJRFJkK3hKR2VrYk9oQmc1M051eSs4UllkVHlQNmJi?=
 =?utf-8?B?MjJWc24vUGR1TDc5amRiampYaW1OZ0VzcTA5RCtlQlVQd0hpejJJYk9iaWMw?=
 =?utf-8?B?OENrd3hueTBUVDVWNVhUaGVvckpNS09HS2JhNERpU0wxQkoycVM0R2E1eE1m?=
 =?utf-8?B?b0ltMVgxQWJ6Y0tmSEZ0ZnQ1dVJCM2xWamFVTUszUjdoOHR2UU1zOEtBMmpW?=
 =?utf-8?B?cmFDbWVzV2swOHh2ZVNFdS9aWmVrMDhYWVpwZFp3KytPdU1ON1pVWVFSL1d0?=
 =?utf-8?B?ODdBNWpoYWNxMnFFcFJPQnNwNklHWmdGdkduMWxFVytBbFhwV1QvaVZXUVpj?=
 =?utf-8?B?NlRTWmVGUUxjRndWWlRVWjBmUzBicHIxUGJWTUVaOWszLzdMeUdXZHhkcTFG?=
 =?utf-8?B?a1dXQmtyNFdzcGZMWUdRU3M3THQ5R003eXpmN3g4TzZBNkkzMFpxRU5ad0tM?=
 =?utf-8?B?cHZMVkg3TU0rUTYzM2xVVjJyT29Vc2VBZ3F6dVR4aU1WdzFsR3I4dldUUTVY?=
 =?utf-8?B?WHA2a3YyamttZXpSa2FCbmZWNk9SK08zKzZBWHNiSXhmY3ZQQmR0Y3VVWXNw?=
 =?utf-8?B?d3Rzd1BEem9zNHdVM2hQOCsxOFBEaU5Ccmt0WFZFRWd2Sm12Y0VRV2RzdnVl?=
 =?utf-8?B?SjAvTnVwZThUYjRFQWl3NHlvRE90WXpiN1piemJpek9iMk43UE03K3JWYjVr?=
 =?utf-8?B?SFEyU256bVdsSTJLMXpZOWR2TkhDSkFOU011MktrSXB6SGFlY05mTTdPV2V3?=
 =?utf-8?B?UjUyTTYrdndHK3lXZUhnY29FOWg4aWhySnNsaGRvRzUyWitRV2pnRDhpUzFN?=
 =?utf-8?B?UE1RRFE2OXBpSktEU01mNmhYbElRNlFQYXdNeEVHVnJYek1Da3F5YUtaamZ5?=
 =?utf-8?B?OTRtLy84QllFRTM4UGpmWW1ERkpvV2dsVkgrM201Z0o5c1ZPR2JmWko1cGNF?=
 =?utf-8?B?MVE1alZJY2llay9UUnlHblovOGRsRzdzeFBkVmxtdS9TK29jamQwL0FsMm8r?=
 =?utf-8?B?Zjc2eE0rZ1RqQklYQUZJU253S0djNGtWeUxhNUEvWHhlcUc3eTFoMXZuN21w?=
 =?utf-8?B?TTNYNHh5emgxQmZXZ2NzSGJPaW8raHcxZU9KUEtxcE1hVi9uRmN4UERFRGg5?=
 =?utf-8?B?VDhhTFFaWEU2dFpNek9ac21DWWhoNXZKOVc3cjZNUFlVVFg1SzZ3Umo2alJq?=
 =?utf-8?B?VGxRRlhFdE40dXlSLzZFc3M3RDlSYkR3T3JBRFNYNHQ3bGFHSUpMUXpOV3cx?=
 =?utf-8?B?S3pmeDloSHN5SXBBTFdrSEx4T0I1TnZVb3o1ZDRHQm01VkZ6QUVZTTFRalgv?=
 =?utf-8?B?b3Zhejlrb2trVU85cHBORnY5TWlhMVpxNEcrVXBrVnJoWFF2MGtZNXozWjZk?=
 =?utf-8?B?ZUZnWkVIaCs2VXNkTzkyNWRDeGpVaTJxdDBhMGF5L08rTWFVcXo5NnRGMVRu?=
 =?utf-8?B?UXJDUEpBajZCRU1mZWk0VWl5S05NWWFaOVF6V2x4NENzYUZ5TFJCMU9RZDht?=
 =?utf-8?B?WnV2SmtDRzlJVUNZYzZDZyt2NmFWUUlmSFY1RURWVS80Rk5selpZb3RPVG4v?=
 =?utf-8?B?bmQ1aUFsTjBGZWpOa0RCaXVaYzIySElaWWpCTHRSbzlYeFhnQWM3a3ZJNHVq?=
 =?utf-8?B?QXEvd3JIV0MvamNiMExBRmNScmpHMUFuZmZqZkQzMzJhYXFhdlpZbnNvUDR4?=
 =?utf-8?B?d1V6anlEZXN3TFYrYm01MmpTd0Z2V2MvTFV6V1d0SGRkTUpBelcwcTZxeTdI?=
 =?utf-8?B?b0F4c1pYdWVWN3hxQmF1ZnphSzliTnBkNFBtSUFidy9haW5jazRLZWN2T1hG?=
 =?utf-8?B?TTR0aUpMYXFhM0IzVVM4d1plMXhCN0djYmREM3VrVEZuYUs1ai9tdGZ0LzJ2?=
 =?utf-8?B?enplYTJpMHI5NUo2a0tHZE5tRkNPZEx2bWpPNGoxWVpPRmZMQjk5LzZOUkFr?=
 =?utf-8?B?V3hIMXFkMlYvQllvczBVKzFDRXkxK2tQaUMyenR1QW11dHd2cmRwYkY1WTBM?=
 =?utf-8?B?a25ZVmJkQVN6MThoa3E2K1Q2WW9uVzNFeDRrSjJQUTZnZlBzYlkvb0RaamZt?=
 =?utf-8?Q?hNrpwW0BaDfZSeF8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3384a04-7ed0-4560-8d83-08de5cebd3ee
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 15:01:47.7682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOalXp7Gehjxr2wdaa+gIDR6hvY4jJKuIhoqj7/jvrmWgqDQ1Y4PMf0eoCsmFS+VKOIQ3Dh4e+Ws56l5TmGgAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9513

From: Jan Kiszka <jan.kiszka@siemens.com>

We are using the U-Boot provided by Debian on the BBB, but that one
stopped working with the u-boot-script approach of Isar when switching
to trixie. Fix that by using UEFI booting instead.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/machine/beagle-bone-black.conf | 6 ++----
 wic/beagle-bone-black.wks           | 7 ++++---
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/conf/machine/beagle-bone-black.conf b/conf/machine/beagle-bone-black.conf
index d454326..afe9f1b 100644
--- a/conf/machine/beagle-bone-black.conf
+++ b/conf/machine/beagle-bone-black.conf
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2026
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -11,9 +11,7 @@
 
 DISTRO_ARCH = "armhf"
 
-IMAGE_INSTALL += "u-boot-script"
-
 IMAGE_FSTYPES ?= "wic"
 DTB_FILES = "am335x-boneblack.dtb"
-IMAGER_INSTALL += "u-boot-omap"
+IMAGER_INSTALL += "u-boot-omap ${SYSTEMD_BOOTLOADER_INSTALL}"
 IMAGE_PREINSTALL += "fake-hwclock"
diff --git a/wic/beagle-bone-black.wks b/wic/beagle-bone-black.wks
index 902b67b..ff917f5 100644
--- a/wic/beagle-bone-black.wks
+++ b/wic/beagle-bone-black.wks
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2026
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -12,6 +12,7 @@
 part --source rawcopy --sourceparams "file=/usr/lib/u-boot/am335x_boneblack/MLO" --no-table --align 128
 part u-boot --source rawcopy --sourceparams "file=/usr/lib/u-boot/am335x_boneblack/u-boot.img" --no-table --align 384
 
-part / --source rootfs-u-boot --ondisk mmcblk0 --fstype ext4 --label platform --align 1024 --active
+part /boot --source bootimg-efi-isar --sourceparams "loader=systemd-boot,dtb=am335x-boneblack.dtb" --label efi --part-type EF00 --align 1024 --use-uuid
+part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --use-uuid
 
-bootloader --append "rw rootwait console=ttyO,115200"
+bootloader --ptable gpt --timeout 0 --append "rw rootwait console=ttyS0,115200"
-- 
2.51.0
