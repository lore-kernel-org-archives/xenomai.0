Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2064.outbound.protection.outlook.com [40.107.103.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F20E8F72
	for <xenomai@lists.linux.dev>; Thu, 11 Jul 2024 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714809; cv=fail; b=ioYYUGXVq2jSXEDHhrEjoszgSkuLi9Eei9ABYq+72lku7BKIFSsVV6WlM+Ex4AZzBQHY/lLiUMwngT2qDJq2wj1YuncNUsxkQLwtC4csCG3m6tzCuMPzEXfDinqGMjsZoNGRZ0bJdqFUgf84TWFEbBTGpnVhmM5+GvOgpf5jqSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714809; c=relaxed/simple;
	bh=r6gVBeRaMO6b2ce4LGYn3vlss4piGtAXu2969R3eaN8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O/go8glyYn1AK8jcbtb4wEDtM2O0RPTegDOlJtRo9ZPMe2DdNWyYSbt8zLW+cCeVSVYFRj6OJNjN3PbW3/gk97agV3nTNqidOR4O5YzoY+eKSf/YV+etQ0PwdATGPnyMVEOlmzHWHwHxaL9/Bh6ANbdOBjgtXK4sy6WG2rAbkUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=wQLcllw/; arc=fail smtp.client-ip=40.107.103.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="wQLcllw/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUErHYxTAHEEJ/Qa8ugO4yHZ1kLZbuRKEfkvHCwgjg1yWt5SelBCDpWoklvTHA/Sb67GBd+ZCX8Xdx/ZGQKSF+DmKw+14Y7THG1iLAx+WPNU6sn74sFHym3wrwjwWIAhlGtEqpYaiLWFOZwuhMAdsKQ2dW2rMXDsWGXIgKRZdgVofxx6C/WJ5FeW7iJCz8e5syywunHPAF4Wfa+Gfos4c9+sz6ly28hTEUdU2p/0LHjRxTln9GcRx4I4hBZo+a7eH85M0eO20DMfwE887DqqnC+M7btAsDOPC5Fn8cgMrHDqhG8fedtBqfY5Z8C5lSUt4R6+dIWEBLP5PRfuOIB0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAJDTrqLGbfSE0nkWvUrWRcrlEtIxQZ1Y73LJXDXMis=;
 b=j0gQmKLVpH3HRchBpXJUli4Q1SPY4iwyRbV/7cKCvu/o2hCih5og1z5+0pwCcQ+iVr0zhH274KZU+FVw9tu7rq2Bmm+v2y+bYvDdyZC3reC+fOoux2zArEbEKX2052jhWMiKmHsDoC+AQ3+9R3VPkwgF1qRIFZVvqClK3SUwCy5H1e1Ltzwrj0pB8hNkv0ddOnmIxWRdymi9BxNv08t1qy247qu70mA8DNxuImelMlRBn/KTU+S5kltwCA4E1JEGEij5dqHn9uBiFf3HDt8HvLhpUEwhMw2mYtBQDIpD+eHFvWE+S3QujFsf6A0dF+/xnacF6fbsdMQPiPqMMGXcyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAJDTrqLGbfSE0nkWvUrWRcrlEtIxQZ1Y73LJXDXMis=;
 b=wQLcllw/GzBfSRVyFvh3/POONWUiBriN4Jos0stiUjDCKsBRioMlrxppD22w9FieJNO+XTmGhEpxQCsuEs6Pzru2nYn9FuO3SVFPU9/NTHcdoKjs6Ez2PrIFSoNHleBFZefY4S5OvOCNpslG8HgzeJuQAVTROAo9Qb9/L/DsbIgutfDvsqKMLu+ApRACwGsgBQUxBWDFq9KhyRDCPbA3haL/kE9zzDkYO01FjcwrW/SQcjhKjlLEPoO2X80xt9MXSW/1FoL44oj4On64x0vAdIZBSU94ehixXtNqJiSo+Y5Rd1HMmXgKPfIQpZe1XIhgct3r0wkixzAmrCoYqy+yxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6509.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:407::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 16:20:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 16:20:03 +0000
Message-ID: <74e5a98e-22b1-436f-a96e-93259572b762@siemens.com>
Date: Thu, 11 Jul 2024 18:20:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] drivers: Fix missing printk log levels, remove
 rtdm_printk()
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6509:EE_
X-MS-Office365-Filtering-Correlation-Id: 66706956-98b4-48fe-d846-08dca1c551a1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzFCc2dwL295amNMSHV0QnJ0QnFIUUZFaitYWlZPQkRFNGpmQ2RQQ0ttbVpu?=
 =?utf-8?B?aE0zUDhVWHFzcXF5YnRxaEl5Z0hlaUpKdEVFUHVPc1FLbU5aSXVuYjJlazVq?=
 =?utf-8?B?NDZUVlUzOSt1SVdOZ05xRENIT1BDeGpidC9mTklOUjJKSTV5SmZhNFhIdTgy?=
 =?utf-8?B?N0F1TjhtMjFwdUlvSkhDTHBlLzZ6azlvSEZENUdVNm5RMHJGTS82SVJZdkd1?=
 =?utf-8?B?V3hucDJXVzBkQkJIV3RrWnF1c3J0OG1mM25YbEJKc0VmeHBqcjAxL0NXWDIz?=
 =?utf-8?B?ZmRQUmlGdEd3MmljTjkwSVhxU0VPQ1g2akR3TDBtRmcrcGVKekZ2VFhMUG9G?=
 =?utf-8?B?YmRGSUYrL0ZrV25SdjNTMlZhK1FWVUtSSDdpdWFkdmtQSE9aTzQ2bENQRXYw?=
 =?utf-8?B?ZDArNnpTUVhPVjRpdW1xcVg3TS9vUFUzTkxZOTdGVFR0RTdxakdmWWJhcEZN?=
 =?utf-8?B?bENLTTZQbFp3UE5KNU1tazhPYVBwN205eHdadUxNWElqMGNwa1hkaDQ2K1Vr?=
 =?utf-8?B?cms1ZCtZU1BzZ0RmWUFNbkRLWU9VRjlKeU9XaEd5TkFoMGFvUXdqMmpkcHdN?=
 =?utf-8?B?V1VadVptTFJ4WE9VQ2hEMDYybzI0S25wVHhYdDI3dnplLzZLbU5TYUg2dkRa?=
 =?utf-8?B?bzZNcnlhT0s2bFZlQm9VdCtkejViRFdwekN1K2dsckF2OFIyOU9ncnBLV0ZF?=
 =?utf-8?B?RnFaV1kxMHZGL0dyM0RyaW01dlhJWlhDS2NCdENxbkZ5cWx5aWRPZHMrNXVp?=
 =?utf-8?B?c1JObkRETGFOZWl5SmVnK2N5Z1ZBaUIxRTNWSk05ZnE2L2grbjJ5ZE1NR1Bh?=
 =?utf-8?B?Q3AvbXdZczB1SUJ0d1Y4UDVvczd5bUFSQTZtUU5LeTRjWk9MQml2OUZNVWYv?=
 =?utf-8?B?ZUQ3dFlQbFJjTjk3ei9BeXRRRVpVWittZDQwNXdubmhCWWpTejg2Y003Z1oz?=
 =?utf-8?B?enRwRVJoRU9wSWQ3ODhXdjM3S3QyY1dOWXFrS01LZ0poNzJiOHYwc2ExZGV5?=
 =?utf-8?B?aHUxcVpjTkNMbmxOTWh1WDFqZ1RzeUpmTHY3Q3prY1kzaFBsNm56WDBOVmZm?=
 =?utf-8?B?OUx3SEFXZXRGeEUrVHJRRW9pZlZic0dHUkpNWElpTWVlVGJqZE42Rk9zWjVh?=
 =?utf-8?B?TU9wcEluQ3NSQTQvcnNUWk80SVBobUhpem9SV3NlV29McCt1S0NmTkRMVDlT?=
 =?utf-8?B?MC9UdlRGWm1mTzFmMytZeEw5ZWRMUXM0ZXoxaUNuZGs1d2NKR3lsMnQ1R3dI?=
 =?utf-8?B?UlJJM2NjYmxaTWtSNUxrck0vMFU4bE1OTjd0TkNoTzd2K0JPNVVFYUhkS1BZ?=
 =?utf-8?B?R0pDUHVSb25uc3JaeTdQRjNlRmZKeVBCZERjdzdncHorbVA1dUtqRUJTVjBI?=
 =?utf-8?B?RFdOeXdJbDlxTU1lWklTL1pHeFlic2xNR0V3dlZFeHNhTjJ5Ym9hTThFZnND?=
 =?utf-8?B?QjRyZlFPT1R4T1RrTjJNSlpYU2FoVzNtYjg3S09RZlJiUkJuRXd1dXFydC9T?=
 =?utf-8?B?VUNlbkdWS211aEVKNlllUk1LNVVPQUpLTnlZZ0x6cFVoMnpXbHg0ZXlFd1JY?=
 =?utf-8?B?Z2RsdHhrYTZHSUZZRXJrREVJMHRTM2xkNWhZSzFOODZybXdTYkRlZVlwUGlZ?=
 =?utf-8?B?c2pGNENlaGk2bjJ2SnlXSmhiVkFGZ0EyUnlCUWZaL0Y0bzZWNGZ5S3Rta3Ru?=
 =?utf-8?B?aHdEbHJCZ1kxLzlZZVZKaExsZnR5emFja3VCMDhHTFdueVVwYkRPYzZLTUtU?=
 =?utf-8?B?ZGdvQjlyMUR4cWtrSFNncGU4TmdZRStidVFTbCt6RHJQak9ockJFdWdWS1VH?=
 =?utf-8?B?ZmtBc2k0dmNCTWR6VTMxUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDJpclJ5N0hGdmlJYVNqUFdBc0ZKSno2ZTQvT0tPbmlrUnJCd1UzbUlLWFRm?=
 =?utf-8?B?Y1BTZHk1aHg3djF5QWNhQWtDMGlhSld1blVTL3BtbzZUVktuaHRTMTE2dFlZ?=
 =?utf-8?B?cWdNSGxvc2NTd0d4SUthcFlHcUZTSTZ6SFFQbWJpTGNDYmZycmpsNkpaMDlS?=
 =?utf-8?B?ekY2RjlqQTRpNjVtZThjQ05BMkpoM1NrTWhJRXpMdnV3M2MrL3VRaVpqaG1L?=
 =?utf-8?B?UHEwcUFacDhKQy9aL3VXb2NKYkdzNytLOS9SL3gwaTg5bFgrcURod253Qmdw?=
 =?utf-8?B?eTB5OHVrNkJWekhLaEhDYzlVbFA2d2oxOEFCbEZYTytmb1U3YUNndDBPWFQv?=
 =?utf-8?B?T05JY0EzOCs4dWd2czhydVJvMGRWVkx4RUdvODR5YUZ4bHg3K2N1MVNzWlZn?=
 =?utf-8?B?dHo3bjJYRVZFTXB5NFVzOXJVT2ZUbHAzQ0NyazJ0eWZqZXFEK2V6Y0VieGxX?=
 =?utf-8?B?WStkblJJdFJVcHREajJoVVhZMnk0Um9hd2lXVG1ESHFlU3lPRGpWeGtZdVNV?=
 =?utf-8?B?T0ZYWkJac2xZcXZQYzRBZzIrTld3dm1kZDl0TzRmRTEwU3ZsVHQwVk5jZW1J?=
 =?utf-8?B?T05ocjhDdG80SStRV2g5QkFjZWY2eTBTeHp1cnYvY0I4cmpGdU85dm5GNGlD?=
 =?utf-8?B?RGpPTDcrUE8zbGFZU1VzYjdJdTVnSTllTTNWUmQ4OUhibEM1OExVb0gxRnVx?=
 =?utf-8?B?N1VDRFJWL0RFRGNEWmxwL2lxVEJYOS83ZkVrVkc1NkF5YlNLaFBVSjNvSDNL?=
 =?utf-8?B?dDRKTnBXZEdLUkNKeVVBY242WHQ1TW0wQTN4a2QxbGM5cWl0TE9QTnhvSXNS?=
 =?utf-8?B?U21vZ3dKSUUyLzV2NC9EYkp2REVLZkpiaFY1djB2VDJCU0srblpwU3hiQ2VY?=
 =?utf-8?B?MXVZUkg3TnZONFh0V3pzancrUHlFelFtR2VsSVFiWjdnRTZuTWFKVmdLTTNN?=
 =?utf-8?B?KzZQOE5BTzh6YjlVNEhFRTQ1Q0dUckM5K2RBcklwUkpRR1dWeWFVTHBJSDRP?=
 =?utf-8?B?MFc3WWE1d2x0Tm1zUGs3QU5sZTVIV1ZUV3F1bURiZ25pa1VuRVNBTDdzdmdr?=
 =?utf-8?B?R2lwN2ovK0RDSWZ6S1lyWDU1MXpuRnlWSzR1eXBHTTVIYXBUZmNrZ0xJNzZK?=
 =?utf-8?B?QUROeE80OGsyWTI5WmRmS2ljZEVHdmdMQTNOYmVweFFxZWJJOWlMZFM0bjVo?=
 =?utf-8?B?amtyRzFRcnZLbVg2elRxMTA1UXhEWkRaajRUZC9iWUtTQVVhTS83N2VkVmZk?=
 =?utf-8?B?a1BBdWVOM0JNRzFuYnhDUGFmRzZFM3RpajdEcGtxOFBDRFFweVZac0dNdEx3?=
 =?utf-8?B?T0psSnVySy80bjVRSU1hZkVDV3hHbkY3cmhNNmxSYXJBMVB6R1FyMWx0WUxN?=
 =?utf-8?B?VkFkaVA3c2JLR0ZrMGVRL1owRktCRWd1TXFqY1dwdktNdzJvWDJZeFVVV005?=
 =?utf-8?B?TlpBRldDUGtxK29aYStvdDRJTER1NWUxWGdNSXV2WEptS3dPb3BpandPQXhq?=
 =?utf-8?B?Zk5XZEVOMkphcGIvUGJ5TTlpWk56QlBvUCs4dERuT2FTVWd5M3BQR2R2aVV6?=
 =?utf-8?B?ZldHa0tlNm9MSDUwNmJWNDRRSjhQRnQ4bGZ1cGQyckxVM01JTkVOV09VbHJR?=
 =?utf-8?B?VDY2YTkwZzR1M2pubDRMd3R0ZnVKb3pFNG1FVFJxb2orM1NoZk1YdXlEZG9V?=
 =?utf-8?B?c0lLTHNRU0Y5Y2dDdDZ5ZTBoOW5JUDVmNHVMUCt3aE1UWE9XZDNIR3hSNTdU?=
 =?utf-8?B?NHZZN3ZGMWE5SFhuZy9CYitRcXFLalQ3Zlh0Ym13N3JTMXRncEJDZWpjdEdI?=
 =?utf-8?B?ZmRES3hQSStBNXJwQjNqQW9PMnkzR2JGbTNQZnQwNFY4bDloN1lHemxLZXZy?=
 =?utf-8?B?U1BkdUpoZUU0aWtXTDdFbXJFS2dueHNtYy9KM25nTWEweC9YekhLMCtST1Fn?=
 =?utf-8?B?WlFLYXowYVJzQVZ2QzZrSXpzbXpydkdGbC9mS0hMeU51VFEvQXJmUlhpOGcx?=
 =?utf-8?B?dHpsNE93dWVrYXJHTHdxaVRWbG51VkVzMlFoVjNtczEvYjQxWEJDYXFLMjhO?=
 =?utf-8?B?SWdlRXZaOG45c0dPbnpRV0R3NXFrUE9iaUhOOXVLNzVOcFNuajYzZUdYc01J?=
 =?utf-8?B?aVg4eTZWOUo5WXVDOEVHYWtUMGUvUjdBMUFVZ0M0WXlTdEdQb2VraFZIWW5X?=
 =?utf-8?B?S1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66706956-98b4-48fe-d846-08dca1c551a1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 16:20:03.1021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNvGk+WsJb22O0gEF1EvPvybM2vfWqyy/PLXXbSq5NpjlPN9SumW/mmPQHeq0NkIKOqh3qXnhnDEx7jodjEEEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6509

On 03.07.24 15:25, Florian Bezdeka wrote:
> Hi all,
> 
> some background first:
> 
> It happened several times now that logs produced by CI runs contained
> important warnings (or any log level above) but the actual test run was
> still marked as success.
> 
> The idea is to add something like a "dmesg check" script to the CI
> infrastructure that basically fails the CI run if anything above Warning
> (or any other defined log level) is detected.
> 
> That requries us to get "warn free". The problem: The default value of
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT is 4, which means WARNING. So whenever 
> someone calls printk() without any log level it will generate a warning.
> 
> This series revisits all of our printk() calls, making sure we use the
> correct log level. Especially printing version information is no longer
> producing warnings.
> 
> As most printk() calls reside in drivers there is another point that is
> addressed now: Migrate away from rtdm_printk(). This function will be
> removed at the end. rtmd_printk() was only a wrapper for printk(). We
> can remove this wrapper and migrate to the "modern" pr_*()
> infrastructure.
> 
> With that series applied we are closer to the "warn free" goal, but not
> there yet. Some remaining "warnings" have to be addressed upstream while
> others might not go away in all of our test scenarios. Some filtering
> might be necessary... We might find some inspiration at the kernel CI
> project.
> 
> This series is compile tested only, no runtime tests could be performed
> on my side. I don't have the necessary hardware at hand.
> 
> CC: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Florian Bezdeka (33):
>       cobalt/clock: Use xenomai specific log level
>       cobalt/x86: Add missing log level to printk()
>       drivers/analogy: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/serial: Migrate from printk() to pr_*()
>       drivers/can/peak_canfd: Migrate from rtdm_printk() to pr_*()
>       drivers/can/sja1000: Migrate from printk() to pr_*()
>       drivers/can: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/net/addons: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/net/e1000: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/net/e1000e: Migrate from printk() to pr_*()
>       drivers/experimental/e1000: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/experimental/rt2500: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/freescale: Add missing log levels of rtdm_printk_ratelimited()
>       drivers/tulip: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/8139too: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/eepro100: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/eth1394: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/natsemi: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/pcnet32: Migrate from printk() to pr_*()
>       drivers/r8169: Migrate from printk() to pr_*()
>       drivers/r8169: Remove RT_DBG_PRINT() macro
>       drivers/r8169: Remove DBG_PRINT() macro
>       drivers/r8169: Remove rt_assert() macro
>       drivers/r8169: Rework assert()
>       drivers/via-rhine: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/experimental/3c59x: Remove unused / broken driver
>       drivers/stack/ipv4: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/net/stack/rtcfg: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/stack/rtmac: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/stack/rtwlan: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/stack: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/spi: Migrate from printk() to pr_*()
>       cobalt/rtdm: Finally remove rtdm_printk()
> 
>  include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h  |   16 +-
>  include/cobalt/kernel/rtdm/driver.h                |    2 -
>  kernel/cobalt/arch/x86/c1e.c                       |    4 +-
>  kernel/cobalt/clock.c                              |    2 +-
>  kernel/cobalt/rtdm/drvlib.c                        |   13 -
>  .../analogy/national_instruments/mio_common.c      |    3 +
>  kernel/drivers/analogy/national_instruments/mite.c |   68 +-
>  .../drivers/analogy/national_instruments/ni_660x.c |    2 +
>  .../drivers/analogy/national_instruments/ni_mio.h  |    2 +-
>  .../drivers/analogy/national_instruments/ni_stc.h  |   19 +-
>  .../drivers/analogy/national_instruments/pcimio.c  |   21 +-
>  kernel/drivers/can/peak_canfd/rtcan_peak_canfd.c   |   41 +-
>  kernel/drivers/can/rtcan_dev.c                     |   12 +-
>  kernel/drivers/can/rtcan_internal.h                |   14 +-
>  kernel/drivers/can/rtcan_module.c                  |   10 +-
>  kernel/drivers/can/rtcan_raw.c                     |    4 +-
>  kernel/drivers/can/rtcan_raw_filter.c              |    9 +-
>  kernel/drivers/can/rtcan_virt.c                    |   16 +-
>  kernel/drivers/can/sja1000/rtcan_adv_pci.c         |    4 +-
>  kernel/drivers/can/sja1000/rtcan_esd_pci.c         |   10 +-
>  kernel/drivers/can/sja1000/rtcan_isa.c             |    8 +-
>  kernel/drivers/can/sja1000/rtcan_ixxat_pci.c       |   17 +-
>  kernel/drivers/can/sja1000/rtcan_mem.c             |    8 +-
>  kernel/drivers/can/sja1000/rtcan_peak_dng.c        |   25 +-
>  kernel/drivers/can/sja1000/rtcan_peak_pci.c        |   22 +-
>  kernel/drivers/can/sja1000/rtcan_sja1000.c         |   25 +-
>  kernel/drivers/net/addons/cap.c                    |   22 +-
>  kernel/drivers/net/addons/proxy.c                  |   10 +-
>  kernel/drivers/net/doc/README.drvporting           |    3 +-
>  kernel/drivers/net/drivers/8139too.c               |   50 +-
>  kernel/drivers/net/drivers/e1000/e1000.h           |   16 +-
>  kernel/drivers/net/drivers/e1000/e1000_main.c      |   18 +-
>  kernel/drivers/net/drivers/e1000/e1000_osdep.h     |    2 +-
>  kernel/drivers/net/drivers/e1000e/netdev.c         |  205 +-
>  kernel/drivers/net/drivers/eepro100.c              |  235 +-
>  kernel/drivers/net/drivers/eth1394.c               |   83 +-
>  kernel/drivers/net/drivers/experimental/3c59x.c    | 2752 --------------------
>  kernel/drivers/net/drivers/experimental/Kconfig    |    4 -
>  kernel/drivers/net/drivers/experimental/Makefile   |    4 -
>  .../drivers/net/drivers/experimental/e1000/e1000.h |   14 +-
>  .../net/drivers/experimental/e1000/e1000_main.c    |   32 +-
>  .../net/drivers/experimental/rt2500/rt2500pci.c    |    4 +-
>  .../net/drivers/experimental/rt2500/rt2x00.h       |   37 +-
>  .../net/drivers/experimental/rt2500/rt2x00core.c   |    7 +-
>  kernel/drivers/net/drivers/freescale/fec_main.c    |    8 +-
>  kernel/drivers/net/drivers/natsemi.c               |  188 +-
>  kernel/drivers/net/drivers/pcnet32.c               |  136 +-
>  kernel/drivers/net/drivers/r8169.c                 |  219 +-
>  kernel/drivers/net/drivers/tulip/21142.c           |    6 +-
>  kernel/drivers/net/drivers/tulip/eeprom.c          |   22 +-
>  kernel/drivers/net/drivers/tulip/interrupt.c       |   42 +-
>  kernel/drivers/net/drivers/tulip/media.c           |   38 +-
>  kernel/drivers/net/drivers/tulip/pnic.c            |    4 +-
>  kernel/drivers/net/drivers/tulip/pnic2.c           |   14 +-
>  kernel/drivers/net/drivers/tulip/tulip_core.c      |   96 +-
>  kernel/drivers/net/drivers/via-rhine.c             |  184 +-
>  kernel/drivers/net/stack/include/rtcfg/rtcfg.h     |    5 +-
>  kernel/drivers/net/stack/include/rtmac/tdma/tdma.h |    9 -
>  kernel/drivers/net/stack/include/rtnet_internal.h  |    2 +-
>  kernel/drivers/net/stack/include/rtwlan.h          |   14 -
>  kernel/drivers/net/stack/ipv4/icmp.c               |   25 +-
>  kernel/drivers/net/stack/ipv4/ip_fragment.c        |   17 +-
>  kernel/drivers/net/stack/ipv4/ip_input.c           |    4 +-
>  kernel/drivers/net/stack/ipv4/protocol.c           |    4 +-
>  kernel/drivers/net/stack/ipv4/route.c              |   21 +-
>  kernel/drivers/net/stack/ipv4/tcp/tcp.c            |   62 +-
>  kernel/drivers/net/stack/ipv4/tcp/timerwheel.c     |    9 +-
>  kernel/drivers/net/stack/ipv4/udp/udp.c            |    4 +-
>  .../drivers/net/stack/rtcfg/rtcfg_client_event.c   |    5 +-
>  kernel/drivers/net/stack/rtcfg/rtcfg_module.c      |    6 +-
>  kernel/drivers/net/stack/rtcfg/rtcfg_proc.c        |    4 +-
>  kernel/drivers/net/stack/rtdev.c                   |   20 +-
>  .../drivers/net/stack/rtmac/nomac/nomac_module.c   |    6 +-
>  kernel/drivers/net/stack/rtmac/rtmac_disc.c        |   14 +-
>  kernel/drivers/net/stack/rtmac/rtmac_module.c      |    6 +-
>  kernel/drivers/net/stack/rtmac/rtmac_proc.c        |    4 +-
>  kernel/drivers/net/stack/rtmac/rtmac_proto.c       |    9 +-
>  kernel/drivers/net/stack/rtmac/rtmac_vnic.c        |    4 +-
>  kernel/drivers/net/stack/rtmac/tdma/tdma_ioctl.c   |   10 +-
>  kernel/drivers/net/stack/rtmac/tdma/tdma_module.c  |    7 +-
>  kernel/drivers/net/stack/rtmac/tdma/tdma_proto.c   |   15 +-
>  kernel/drivers/net/stack/rtnet_chrdev.c            |    4 +-
>  kernel/drivers/net/stack/rtnet_module.c            |   10 +-
>  kernel/drivers/net/stack/rtskb.c                   |   13 +-
>  kernel/drivers/net/stack/rtwlan.c                  |    6 +-
>  kernel/drivers/net/stack/stack_mgr.c               |   10 +-
>  kernel/drivers/serial/mpc52xx_uart.c               |    9 +-
>  kernel/drivers/spi/spi-master.c                    |    2 +-
>  88 files changed, 1187 insertions(+), 3985 deletions(-)
> ---
> base-commit: 00454d5d127c29b93f8c0babf1336bfc35be3b98
> change-id: 20240702-flo-removal-of-rtdm_printk-b5320a2a2930
> 
> Best regards,

Thanks for the tedious work! Looks good with only few remarks. Once
addressed, I would still pull this into 3.3, probably issuing an rc2
afterwards.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

