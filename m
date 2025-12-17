Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B150025CC63
	for <xenomai@lists.linux.dev>; Wed, 17 Dec 2025 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765991216; cv=fail; b=KTTZ2K69ILgs6pPvEv/mB+oCuRfcPLXvjVSBXpCqnAQoCoaFGMegFIlWte4XlfXN/KEyM+VsHMeDba3HS476Iv+ttvphq1UzQGCIuyfIiZkLM7aIjOwJC/IViK5IZueMAGgoixjpubVeM+COGu38b3JbfirUWSC1f1Ukq3/TmIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765991216; c=relaxed/simple;
	bh=cItKWhtk5IpTDVQWdi8HclLovClQoc0+kS/J3wpVuNc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KG7iX2oDqBBk5OBFqNRbaBgGiyF3fJNuekVSWhonCSchoAXlwuCAqNcYFdIoXmSuox05tk29q2J2CulPcsYIbQ/IW50gGKnyMCBl9boiccYS2IuOwrotQEc6akpsT4hazbxLw2kg6XxE4huV868DeStgJk9mnNp796NgAwkxmsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=JfmP0Xgv; arc=fail smtp.client-ip=52.101.72.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="JfmP0Xgv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTPSZaoBDtmV3q8oqqYo2Xft+NwrgcRDqMzspOSopT2nSsBpHfIKSzRbqOUErhGMmVq62JOmGj7SerWLrksEwAgwQG+kCUne5dSYYjcz/FslcjZlyv2dQIKSQThPxTKfxlYVwecfYsfjwOIB4OZiVQmbtrmzXN0mqVR9vTact2L7t9C1JZdFsBn4NeXPhQDNxty2np2TdhcG6kGW/Ivmg65jGk08UMpqTRfBEIKObpoj4AhZtkclWynCaSeurAJ6IrhwPfvzU4Oi0hm7whYjsVKfXcykTTUkCp073XVIonaykXAB4b9Nc7LycyrfNKC56nd3cNXLO5oiFMFE07fstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJOSAsXjuH1tzWBx03EuRtIMBBNBhv/+jqyBTc+PbTM=;
 b=MyKpjbkvHVSM5S8gwFuexvTDVJzAjNjnLPcdT2ZXfnPHKWW6oKw3FzRszasy2wscraU6CzLrO+vWbyr3gBY2G/aHT8ncHqjo3Dc8OMEmx2NDafgsTmdvjlzqZ+Y/FP5CQWACp1/+EyjiZGWUMwmBcHN9aCLOLOUh1Q8Yts0xMhx4WO67wB6qB9+jp2u7+479ztpdVLS+BOJ4HEQxKr0OQIT4VYFTb8dH+96YbrUNrTzi+U67Qc2Wd/mBI5ARlo0VERoq+QmxRxBZHADaVkEWrltr0NyabB9/BU2INg3Av30+uJG/2z32WXMzDnT9xEUVPp3GBKiF3wmpZDVrlrtlaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJOSAsXjuH1tzWBx03EuRtIMBBNBhv/+jqyBTc+PbTM=;
 b=JfmP0Xgv3yHYUE87nkPe+Yg1nrRsFlge9TZJHSqgfDqxG66Fxt6xXk2iV6s3uDsrDqrvzWoBtIQ4FWUVr9lpdz2trLIvMReL7rc3LnRGokmcP1AzKWh2IeJPOmcbSn+4W+Brbnlbk3XidJW9z3pPh91rO3svsqzS2Z6vIxGIQ6qPyjIhjpLostvT4GF9NZqBwx/gIHjuU4L5jKMtubHNGUL2z04EKlZ8SpDIPoUXvwtGZ23fYu19NcjSq8tWfCNLmcYPCILUtHsU5Op92fxMiEnzrQHKthACkmEyR7qJ9StS/Eg+ABwgX6E3W73TMbgLr8Z4J/6jG9TSxv0BTxcBwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5586.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:260::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 16:51:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 16:51:08 +0000
Message-ID: <181afe87-4b2d-45e7-8ede-eed5e95e04a3@siemens.com>
Date: Wed, 17 Dec 2025 17:51:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC Dovetail 6.1 0/3] arm64: Enable in-kernel FPU / FPSIMD
 usage
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
References: <20251119-flo-6-1-arm64-fpsimd-test-enablement-v1-0-8653c0b573fd@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251119-flo-6-1-arm64-fpsimd-test-enablement-v1-0-8653c0b573fd@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d8ea92-2506-431d-8225-08de3d8c7a13
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TVRJMlJEZy9WSUgrdGxSODBicHdyVzRlbGNCNUVnYldCdXo5SWFrQm8rQlcv?=
 =?utf-8?B?WmJxemxOSG9vZkJtOHUyWHN2T2Y2OUhPYWFCd2VsUXRibmc5bHdHRHVNby9m?=
 =?utf-8?B?NU5xY3JacFkrdFNQRnU5YnZIdHcrRGdyYndtbUV3citWL2hwYnpBWWNOY2VC?=
 =?utf-8?B?ZFBldkhBM3pFZVNWemtiZ1Jsa1NzeXFna29nczNOb1F3bjE1NVdSTEovVm5t?=
 =?utf-8?B?VTNJdHVvaTA5L0VSRnJDMitMYnEzZ2htRUhtY281RmhCWGFoSFJNV3BublY4?=
 =?utf-8?B?NEV4cEtENWZYTkxzNjNmMCtOejFoRHR4Vng5dE9HdGpneGJwVzJGcUxSRFV1?=
 =?utf-8?B?RXRXYkc2TGRENFZTQUk4U04vMExhVEczYU00VXkyN0JvK3U3bVlRZWhTSVlM?=
 =?utf-8?B?dFRRVm9uOVhHdzZ3VUJWQ2VTemx4VnRtSkpHRGwxaERza1RtMmRnTzBFb1RP?=
 =?utf-8?B?SXlKWk5DN0JnQzE3VzhXN2xKU0k2WXp2UEhaakd3UmZrYk5JWnFpSjQxa2tp?=
 =?utf-8?B?cnRPdHZuS01XNGRoY2p1dldpYlV6UXlmUDlQMEozUU5PanlBcFhpVEllVlVC?=
 =?utf-8?B?K0IvN2ZrVnYxNS9xKy8vUDdUQlZhRXNFOENSeGYzWVREeWdMRnlvMW9lMi83?=
 =?utf-8?B?R3JwWjRaL1RVQTA5cXBYcWVMQm5iY1dSSUEza0pieFo1MUhEYythTEMxRVNm?=
 =?utf-8?B?clpGNU9qZnJ6ak5YWXplc3lPYmpMeWp2OSsrc0g1eWFRL09DT3ZXSkh1a0tG?=
 =?utf-8?B?OWJsSW9xWmlydGUwc2pCZ2s4NkE4OWtUcm1ja1NKL242azUxRVZJYkVuZ2J0?=
 =?utf-8?B?enlpaUlQb0M4YmZjTm12a1J2T2lVSWtnbEZWaUl5VzZGZnRmNVNIanhLZEJI?=
 =?utf-8?B?czgvMTFzYldVWHZ0WUpURFB1OGF4VVRnMlpvSjYrUjdJcDd5b0lod0lweEto?=
 =?utf-8?B?SVNYQjBnNzhNSVFnay9lR1VlZTlSTWtSRGdndGRLbHZmVlpjTGJtRUZEZkQ0?=
 =?utf-8?B?RzRkeGJtNkhxaGd6Mk0wVytKR1JRZDhnTFBSRnhyVE9ySDhpOVNWaEhDUEcy?=
 =?utf-8?B?eUV5WGtMUWhYeW1CYzNpTHp1UWNsbWR3WG5UZklPbU1LMWJZWithZXJrdmZw?=
 =?utf-8?B?K2o3N09Bb2h1ZVRzNzhHdVQrQmE0bC81ZmdoTDJYR0ZTeldoU1RMZFFKU1Jp?=
 =?utf-8?B?L1NrVVFBeHQ1YW9uam5qK3VNL0tVaTQxUmhXSmtxdDJWZmRrSWROcjJFai9u?=
 =?utf-8?B?MGNBeko0WTEzM0RSbjBicS9zTTNBOXhzbVc3MFdVZ0VVaTFsMWZrNW54elJa?=
 =?utf-8?B?Qjl5aGpLNXo3NXZ4MUVDandYeUZzRU1Rbmlxemt1OWRVKytaNDZqQlhyK0hE?=
 =?utf-8?B?VFozQWVhdXdoTVpxSjNwcE05TEV2WnpBMC9kNVdqSHhqVzF2K1NKM2o2NkFL?=
 =?utf-8?B?RVBLVld5TkwxNE54eWJBaDBwc2RzR1JxbCtBSWZrQTlmVmFPc2M0Y015L2h0?=
 =?utf-8?B?d0VNYXJqUXJGK05pWWczZzdoL2U2Sm1zT3lWSWRZdEpPcjk4T25JVUk3eEp0?=
 =?utf-8?B?dXlvSXYxd0VaYVpkeVd3bE5CZVdRUFB2ZlZGZ3l3alhkV0lKbTZoOGQraUd2?=
 =?utf-8?B?YU42aStvUVh0Nmk2ZGJZUTAySGRHTXJOandaVkdjMjB2R0QzQTk4YmgzaTkv?=
 =?utf-8?B?b21IOTVUWEdrQVNJTzlsT1Y3QWd6NGZFalNUQkJReE5HTVVsTUhBRXNiRWw4?=
 =?utf-8?B?REIyRU1DMkdSeG0vWFJyMDRNWUZJZ0lzQTlZRVdkTnF2V09oYmRlTjl5YjZN?=
 =?utf-8?B?NTR5NWcyOW40a2lFeDk3SnVjcnFhZGcxOXdIVFpRRUlYbWlXZzgyWmZ5aGVE?=
 =?utf-8?B?Zzd2U0R3d05PcHU3TVpVSmIzNG10MUw5Y2d2M1NEWk5xamhOSUNRSlRsc2xG?=
 =?utf-8?B?dXhFRU5CYWhKV1RMeXdYVFhlV1hSYnpXMzZlSjRSYkpZeUo4WU8yWHRtUng0?=
 =?utf-8?B?NGtKbXZHL0d3PT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Nm1Ja0R3aS9PODlJZ1dSRFZwRTIwWXF6VmhLRUtjNHFKVG9GaFdIUWQ1RjJs?=
 =?utf-8?B?QXlWTmhiMlVMWlcyTFl5NkFpL3k3VENFOG4wYnI2M1RNTDdVSGNKWG5DN0tT?=
 =?utf-8?B?TThXaDZPeHZ0QkdmaEs5aU5YSHRXNjB3M1NudTdkTDU1MEkzbVhKU1V2eGpS?=
 =?utf-8?B?RjlpRzlRYmlKcWpOTCsvZmhwaXpPd040emY1NjAzNVdUaE44V1d0YnA3ZGRl?=
 =?utf-8?B?VFVXMWVXTHhjb0IxbnRWSWdldms3R2Znc0lPc1dQay80bVRwd0J4ellpajNr?=
 =?utf-8?B?cDJJbU1UMEN4dHo5cnY5K1BkWitMWWJLVFFYSXMrRWdGN1Q5cWY4eS9id2FO?=
 =?utf-8?B?cy9wNTVpejZkQ1cxb2FEaEV6UHJWclVMT2dNNDlFK2w5ZlVEaDN1UGN3cWRZ?=
 =?utf-8?B?aUhnNEtaS0N5UzdvN1MyMlJWNFVKSlVHTGs1RjdXKythSDVzNFlvNzE5YVZO?=
 =?utf-8?B?S3RNVzBQMGRTOWdSaytLbDhyVVVOdnJKR3ZwNkRoWkhlL2dZS3pkZVBobWVa?=
 =?utf-8?B?YytsNUx4bi94R3dnZEY1c2I3MHZkdXJsd0N5YlgxeWNKeWhiMmRWVGdScmI2?=
 =?utf-8?B?U1dUUHZIcFhsUWRyd0pIL3BiMkJjRDFWOU9Qd21VK1BSdUZHTHNvZ29ROGZ2?=
 =?utf-8?B?eEEvQkxsT3lRc0U2SGhzN3FLU1M2ZCtSRGNHTXA1VmRuUFR1d0ZzdDByV2xy?=
 =?utf-8?B?cnlHK3g5ZGpRdEhGWi84c1Bvbzdza1JYekczUE95MXVONTZVZmZseldrUXky?=
 =?utf-8?B?QXRwQlJ6WEU0VytXQnhGRXNxdWJpK25zMUlsRU9kcktnaW94NU9ET1doOUZX?=
 =?utf-8?B?TVBzZ3pNaFhLZGFjQk9uRmdkaFpLOUV1YnJ2UmNaMVVscDRZWWxHTGRjSkUy?=
 =?utf-8?B?MEQwSWpNcjNTdllpOW9tbmtkbVFqdUNsdVdTVUl2Y0lmSU1KL0VIM3E2cU5m?=
 =?utf-8?B?QjBVdnFiV2ZBTURhSitONVBkMDRCL3NNQ2FvMU9tczlaRnAySjNXdFM1eFhl?=
 =?utf-8?B?TUdUa3QyZVIySS9MYjRRdmJ6cXNDZVdRWnh1V09sSG5lR2FmWDV1UzBuSkNE?=
 =?utf-8?B?cEFaQ1Q2V0MxSTdOT3h0K29Dd2JZZXFnRFc3VDE3d0NScEhMejBUcGJqZnll?=
 =?utf-8?B?MGJjSXdWUzBIMnpldWsxL0pvY0xVSjJEWXAyZWJGbTB3QXBkeVg1S0VjUUFO?=
 =?utf-8?B?b3Qvd3dpNlo3SzR0cFo1d1ByVGxoOCtPM0hDekNVbVk3U3NEcTlxeWtiQUgw?=
 =?utf-8?B?S1REdDF3eGYyQzI2VjVoVTlHZExyWElSOFdQYVdWZFh0MVFpSWhPQkwrVHM2?=
 =?utf-8?B?eVQ0ZTZNS2RTMURLaWFuN1h6MGtpYjFmbnpocDNFTWY3Y1NDSmhOQ1ZMNkV5?=
 =?utf-8?B?TUNPb1REb2hRc0pDamRvTWJFTDFLVUNySmFnbGVyWFljQ0VLUEdtbDk2K3Jx?=
 =?utf-8?B?OHU2R2hWbGRBYXhlMWRidmlZenk1bDJrUlRyZHVDc1ovL0pKK2htZklIbTBT?=
 =?utf-8?B?VVVZYjlObGpwRkhlWk0xbFR1S2RHQVdQY0dTdFhBd21VdDBJemRrakkramJl?=
 =?utf-8?B?MmxHeVJ6dGJZcHVia2FoSDdDN3JxYk5lMTV2SWQ5eUtuZHVmbnVXUXhwdUJQ?=
 =?utf-8?B?NmpGSHJJK0dOQkt3V2pRR2NmSGtrL3kwQWxmZFVWUWV5ZjNRSVozR3JEZkhP?=
 =?utf-8?B?SG1XTnJQU3pReXl1OEFqSnlRbVkxaGFMdkdpWDdOOTQ2djVGVzlTUlpJUDhD?=
 =?utf-8?B?WjFTQnVlMFJzNFg2RDdVSlBMWVVkTUN5dDd1cEZlMG43WStkc0JIMHFCb2pW?=
 =?utf-8?B?YjFkMWRUdHg0S1hkdTBHbnlrc3JCd0N0S0F1UnJTamhZdzhMNnduS1IrRnJD?=
 =?utf-8?B?VEhtajlHNzJKRGZuRmdWNUZvbFozTURxbkZ1dmpDRitTT3dxWDZJYjdGTGdT?=
 =?utf-8?B?Z1YyZjYyUUEvRllOV21ZOUtDbzRhWFNSamViTnJRUEhCekFJMzRBbEtyZmdK?=
 =?utf-8?B?cWp5ck03Ri9GOGZpVlBncWZocVlyM2xCOXZPb0JWRFFzcHpDOVA3RkFQdExx?=
 =?utf-8?B?NVV0NlpOYThjMEFKTWprNXFISXJmTFVZdTI4eGg1d1hNQXJUaEcvQWE5UUdw?=
 =?utf-8?B?T25ERGpmMGNpNDdYRmdLVWRTWmxLRXIwMGJRTlBUWTBhRWVCdjVuUTZVMUli?=
 =?utf-8?B?QlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d8ea92-2506-431d-8225-08de3d8c7a13
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 16:51:08.8017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXh4JDwLJnNtuVpqtQ0E5KTLMCrbublNl5wz6N2YOrKi2NumLloevfplkYAXjVn2KhozZjoEBK1d2t66E0WSqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5586

On 19.11.25 15:25, Florian Bezdeka wrote:
> Hi all,
> 
> these are the necessary backports for dovetail 6.1 that would allow us to
> enable the in-kernel FPU usage of switchtest. This is currently not
> possible as dovetail < 6.12 does not allow / implement the necessary fpsimd
> context switching.
> 
> I have backported the necessary patches down to 5.10. That would allow
> us to unconditionally enable the tests for the xenomai3-next branch. I
> will send out the 5.15 and 5.10 series once we agreed that this version
> (targeting 6.1) is correct.
> 
> Please note that there is a small problem with this series. Patch 1
> removes the check/flag that was used by the dovetail enablement code to
> detect in-band FPU usage. The new flag is implemented differently in
> patch 2. Patch 2 also fixes the usage of that flag. I had no better
> idea. Otherwise I would have to delete? the in-kernel fpu preemption
> code (temporary).
> 
> Previous discussion can be found here:
> https://lore.kernel.org/xenomai/cover.1758264904.git.jan.kiszka@siemens.com/T/#t
> 
> Best regards,
> Florian
> 
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Philippe Gerum <rpm@xenomai.org>
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Florian Bezdeka (3):
>       arm64: fpsimd: Drop unneeded 'busy' flag
>       arm64: fpsimd: Preserve/restore kernel mode NEON at context switch
>       arm64/fpsimd: Avoid erroneous elide of user state reload
> 
>  arch/arm64/include/asm/processor.h   |   2 +
>  arch/arm64/include/asm/simd.h        |  11 +-
>  arch/arm64/include/asm/thread_info.h |   3 +-
>  arch/arm64/kernel/fpsimd.c           | 193 ++++++++++++++++++++---------------
>  4 files changed, 114 insertions(+), 95 deletions(-)
> ---
> base-commit: 501e3ddd3ff59f522d9c7a1f2ee993620d5389f9
> change-id: 20251119-flo-6-1-arm64-fpsimd-test-enablement-67294b3d8f0c
> 
> Best regards,

Ok, I've started to integrate those bits over a refresher 6.1 kernel.
Please see v6.1.y-cip-dovetail-rebase, I had to resolve some conflicts
again.

But as we discussed and as Philippe also pointed out, we need some
solution for the softirq oob preemption as well, not only in 6.1.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
