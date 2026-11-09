Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794244946;
	b=I4nxZQXE4E6ASoWAFGdJsokRQeiYwHWb37Ecg6o7AfmZf4dj+zWtAyjhtDoPqymqkWG6
	 SFOXLp+990L4YE1e9j4ukzBG/BkuMCUqCBAmnqAVPO0rYdaAWubuHtaU8y0DAKfAvT8vv
	 KrgmPbVc0aJbTpZZ2tyfpd8mU23hDAD3B+ITbY/GEIV3Wf6PCYtPvRPYzqC4oJao9FXyw
	 f9m+fsxEpeq3/8bTKy3xhm6TRBTd3u9qCKSsnTX9PRQziNpprAb0JvLuba6IqwFW14RD8
	 F/dKfW2eefLEe2Bui18QFQJv03copVA3Cfh9ktlQAhOvFbfHK/Ts0bg/cViUKigBCGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244946;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:From:To:References:Content-Language:Autocrypt:
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
	bh=wRpAOFK43RQdmg/wMqYHeHazRHk6+l5ocPzJ3mHwgk0=;
	b=x9cZPLMUHPT0PzYaD75fSLpA6QndEp8EXVWLoQdkGYredDDGGwlxHq2R5+PUkxp1UQ9y
	 yPyuuXfVGvikBYJj4XjOTrOIG75e7d0JTfCwLe8nOLGIJOp2LAcj3P7o0c3t3QbrOBBGd
	 cVTtibqFXAyz1Mbq/lXyiPvUBgJ3wQqanE99t/LbjUCiUn5G1CXnFtGOEOxK3T7zbONdu
	 76ZLUZu+QtPFVH3WsjtsJwjjcn63SlEgIWsrqK2uV4qzSH93sAvQDzb2cHlsYcPiAjJQt
	 IuKnr3FONqlLINBt9JHTK8djegoGUsL3HXKXxqkaUM78iiiWZmKNxasxYd7BBhPJtsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=mf7NDYAh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.58
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012058.outbound.protection.outlook.com [52.101.66.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D658F606A31C
	for <xenomai@lists.linux.dev>; Mon,  9 Nov 2026 17:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D658F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=mf7NDYAh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FesySTNsqtyAXoTvkMN0hEgsdexD8K3hgijAXZLboYXChf+StsTVKpQqHIsmr8Y+Bnbp3RqCF5MbDgs1VsXqTbRUzwNY4QzJgMe7x3mHRE/BpDpMqt/isUUgD2Q78OdB+OCtiZC8Ewfxy5ecWbeATP5cniJpklzWzJv3BtmJfuwfNTxkptnsWBHjqbsKZ0RIUPSUs0SwWv+WGPGlie8cG90t6MLE/NoM2a+G6dRi7pc+yBKIk1Ss9I+PkKF75Kz9b/GoKeOMYh7R5L+yoEF2nbTe03Z0oKIIhqg/I1H1P2iz9h+VXYgOOCD+CLIAdOGNvzvG097v4K79kreEipNM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRpAOFK43RQdmg/wMqYHeHazRHk6+l5ocPzJ3mHwgk0=;
 b=ryXj+/2HVoeTRtN5x6WXdluwewvZyoT6oLnfQVvuyHGizW691PCXvva+hKAx+rFBkrlU0Hd8yYat596MOBR6fpndaDkJ5rEEnunrZyjGIXqFHMdZa3owpg/CsFriq0ZzwaHpDfHETZYLnXW0mnLW7puMdhmxTvI2A1Ok9Ndv2pWrrhiVQjwDbxAkosUZ853obTNMYZT4QrNKVx/cpLIwUMxnCC4wVabcyk4J7aXEN8nH83rglYUrsQgdF3pbUMm+JiV/BCb6KPJ40AejFSutrEVMbiDPpXHgbQbLW8nZUv4VErK7ngMJ4DSisbduolxyHcSwA6GXwZ0jtcoBuNF8hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRpAOFK43RQdmg/wMqYHeHazRHk6+l5ocPzJ3mHwgk0=;
 b=mf7NDYAh4pcAvguniF3pMqarEE8vey7qgztG9IHWGDssKS5tqEFX6FK4xy0j9oKJENfqT0HXCUN3eaTkLRFBfiD9NK/IgEy6ge44q+EZqIaiwiCM3y+JyJkXksdBuSn7B1L8eCH7GFHKdakyZrAZQyBp6vNiNMlUV1KeBj4yH2ds9SDlDSeUdl24uljIVECX7NR1/gFh6flbWuXc5Zw4Y7W8I6PLGYYh4W/PB97k/2qTBOTEH6hfD9jiOGE9MZPpF4+DPDxXlsOcnazgTtpBbYCj3Dh1EVWL1L+v69lNXVL2b9HfPMyWv6PNIO/FqvmjQ0JoR+h4IcoAV1G8iKWjWw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB4PR10MB6094.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:38e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Mon, 9 Nov 2026
 17:22:21 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Mon, 9 Nov 2026
 17:22:20 +0000
Message-ID: <83293e80-9d87-4c4d-852e-6893526a6430@siemens.com>
Date: Mon, 9 Nov 2026 18:22:19 +0100
User-Agent: Mozilla Thunderbird
Subject: [xenomai-images][PATCH v2 3/5] Update Isar revision
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
References: <cover.1787931296.git.jan.kiszka@siemens.com>
 <f5dfdf1fd8749160ec47f73ec60da270bb71b17e.1787931296.git.jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <f5dfdf1fd8749160ec47f73ec60da270bb71b17e.1787931296.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0352.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::6) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB4PR10MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: 53298e28-e9c3-463e-38fd-08df3e860305
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|11063799006|261026130827099003|4143699003|56012099006|261021123027099003|261021130227099003|261021121427099003|261021135927099003|261021133027099003|261022105027099003|261022075727099003|261022115727099003|261022113327099003|261026121527099003|261009221227099003|261009223027099003|261028144727099003|261026135527099003|261026140227099003|261102123227099003|10067099003|55112099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	BzJTGyAk0BZ4cLdwfS6ZgU9JhmRyPnj30FwQD7VjJhgQ0mRj4OefUmXL5rtnzYRuoCg9csNe3/hANHoBF39NYs2uYX+2YOvrum7gkZgyCuI5i7DtRvayLgrEkFrYVQxHBdDbzrLA2hvZslUDJp2a2F0xxXle6JpLduxUHG0AXfATL/2fK2p14eQgZmZT8/cIAOtGWRMunVw34Q0YYm3agpAU5yFrj5LpIKxuBZa+WIcbp6oasypNyVuBgRCKMtEx6GraEfaRFxLFPDVrFgvKC2atFOl3ZirhscFK/qS2/HY7Xv+EPNrnF7iwKztuX8dDbgD+RwLDuk8uLl4/YUaUJEEd6oOegTck4CovztZbY85c0WCymPbPi6w0SQIv7NONKj7rLLqOL1aT/ELstIBl6PimxFcM85ZW8BDCtkTqFsGaB4WhemFouSdSUjoO0MdXWZsXpG/DjszcY2UgaAm7hwaHtpgRPUNiQK7MYQyV9QtYomuIHbPWNioGEf4MywqK26HnDb8U7TRfhAmIhEUCaTjO+cVFo6CEJBSatGqSQR5+UWMtYZUPqChrsfE3EkFkX8UENAAMoX3alHweOmea/XgtCT9blkmT1/6o++/i3+TDIL5zELgrznn25CfpXujZVMu7AaXbx9TupB372g7MeF1sooC1JrovgPLmMGOXF94=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(261026130827099003)(4143699003)(56012099006)(261021123027099003)(261021130227099003)(261021121427099003)(261021135927099003)(261021133027099003)(261022105027099003)(261022075727099003)(261022115727099003)(261022113327099003)(261026121527099003)(261009221227099003)(261009223027099003)(261028144727099003)(261026135527099003)(261026140227099003)(261102123227099003)(10067099003)(55112099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUNsb1FKMHVScGl6anNPcWMzdnEwNnVqTzkyTG1WQ1AvOVRPQ3I3a3VUc3ZU?=
 =?utf-8?B?YTl4bEw1UGc2WHNlbk01R2EyNXBkVFNjcnp2cGRESUwrTm9aYVBLODhjNkF6?=
 =?utf-8?B?NVFNcHkybmYzZXd1YlBDRWR6L2Y2T3dqY3JEc1dVK2hLa2lpU3ltQXI4RkJH?=
 =?utf-8?B?eFJLLzBzMGs0aUdZMEU1SW96eEJjcm5IbE93UEtHSjFTRDJaOUFUV2pGTlBK?=
 =?utf-8?B?MVFOelU0SDhpSStOY3k5N1Y4RjlTUlZCNUVFd0VKcWJWVGxVeEpCV0RxTTUw?=
 =?utf-8?B?VUErNlV4Z01BOVp2U3VnK1p1WXp1OTExSVZEMFdoMU55VHdCYmVJV1Q5UGtK?=
 =?utf-8?B?SCsyWVNicUx6L245dHJCUDBsWHA5VTlwejlteFU5b2dxLzEyWE8xK3AxVUNt?=
 =?utf-8?B?dExXdnJFd3lPMmozcEJ4M1pJTFg5aFBhYkFMVGhmMEdGSG01Q2c2MjBVUkdl?=
 =?utf-8?B?MjZsMk9FY1ZuKzBIcHhoZ25CSkE0V2d3NFlzRHRZSmppQTVIb0ZaMlo3OVJO?=
 =?utf-8?B?dkw0UjFPY2hBZVlIUDJIZXZ3NVUrY3VJRkRqSnpUWWpCb0VFTGZac2dna1pJ?=
 =?utf-8?B?TVhsRFo5QysxRnpPZVZ2Nk1Lc3NoVzRlN0M3d0h6eEY5VDE5cWZIOTJUTyti?=
 =?utf-8?B?SjA5UTRtY1VNaDlMeTRUeWUrc1g0L2lTeWVsdjg5NndyTnMyVnB1bE1hZTh4?=
 =?utf-8?B?TDdFVjJMaG9GcDB1aFUyd0dpbXRYOXZoWkZldjRNQjRWcDY1WjBlRDVqYlFG?=
 =?utf-8?B?TmZMQlhpRlloWVFpSFZZUDEyZGNnbjhoTHc3Q1VuSnVja3VtZ0dOU0ZOU2Vj?=
 =?utf-8?B?MTQ1L0ZQYnY1dVlhcnBSMnhuQ2c2eXhvRmx2aWFHWnA1OHlCK1RtMTNGYWxw?=
 =?utf-8?B?MXVycURrOTZGV0ZBUjErVEJiQ29VWTVPNnRod1VFM3lCSkYzT2toMUwyQTJj?=
 =?utf-8?B?VnowVU1KRjlQalZDM0NUZW1QenNLcGZha3pRcFpjWlJXUURZemFPcGJJV3Rz?=
 =?utf-8?B?Y0NROHFNa3dyVFdkdTk4bjVxdGFua21JKzJhWmdzcjhFdkhYWVB2NjhMNldl?=
 =?utf-8?B?SUxvSW1TRWJtOGhnSS82ajlBZ2gzWGNialRjeENWUjJ1MktzMC8wQkNPN1pS?=
 =?utf-8?B?UEdrRlBCa2hodmdSWW52VGZ4cHdQS25scXpUbVNKdWVsQnZXZkJlcTRSVkhQ?=
 =?utf-8?B?enFBMGxDWVZlaWtrYzNZZExrS3B2U1ozNjBoU1FHUzVNelU5ODJFWVFzVmlD?=
 =?utf-8?B?UzBNTDlHS2RXWG1zWEljNmw5aEd3bllTcG9HdHBwUytGdmx4cEhremlSMVZG?=
 =?utf-8?B?R0p5UWY2OGJHZ1ppRi9pUDVrRmJ3V3dMV015aUVUY2U0bzRoOVp1dlQrY2lh?=
 =?utf-8?B?NWl5ZGU0WVF5eU9BbzlxcXlCbCtiWFFSQmxsdDN2ZVpvTFEzYXJmaDJiWUtH?=
 =?utf-8?B?NkFSanhxaWg5S2NtNUJ2b3hHUnlDYzNqMTZoNmVDWHBQck9lbGlCQkhIb3Mr?=
 =?utf-8?B?b1JoTjVGT01UVkFDb3gzdFc5WlY3aUMyaS9iWFI1Ty93ZVRFek85WHN6YWl3?=
 =?utf-8?B?L2pOVVZWNkRmVUVyL0kwYVpKU0U5NXd2VHlnU2l4dDhQVCt6Z3VGMUY2UVIy?=
 =?utf-8?B?Q0o3bUhnd1RlYnZVQVJQS0hXQ3AweWlkMTNwV2xpOGl1UnlsaWFRODJPRXBm?=
 =?utf-8?B?NEhISk1FTzd1WFVoZWI1Qk1hS0Z1eUIyWlJqUjFZT1FrczVacjAzcytnMCtT?=
 =?utf-8?B?TFl6eVp3SS9rLzZwdUYzamVNSEs0dkVPVEhGUm9LNVdSVVhNMkdLSGE4bWVk?=
 =?utf-8?B?NFJ3VE5jOENvcEpkVXk2RW9Oa3h0QmZralp5UjVRU2JKVi9Wb3VQb2lIYXh6?=
 =?utf-8?B?TkR6aW12T2VtK1JBRGltRDJuZ09VSjVGb1F2QzkvZStjazRQZHQ4bTRzbUlD?=
 =?utf-8?B?YXBvZUFjNjE1Y2xOdkxvY2laVmZRcjdXS0o0T3MweGZYTExhVUpiSS9PMmZM?=
 =?utf-8?B?S0dhVGtld0oyWkxWZTk0Q1h3MjRYOXBUMXo5RVlSWC9zSGdxSkd4eS85cmhH?=
 =?utf-8?B?RjZtUEFKeGFsWHU2QkdGRmJuWmlRd0pZS1V0Q0wvNDM1SUVwdmd3VzNRQ3JX?=
 =?utf-8?B?anR5cloyMWIvUjJtV3RLTjV0KzZ2dURjVzBRTTZMVUx0Wm01VWJVMVNFeUln?=
 =?utf-8?B?SmlDaGpzaTNhUmV5SXJNS0NuWFNzOUoxYjJtTW5GYmdUOVZuOE5KTjdBZmZC?=
 =?utf-8?B?R3k5S2trZFcxSVZVRXBjS2EyQjAzZVZ2MW9TYU9MYk40TnpOcXoxMDZpc3I4?=
 =?utf-8?B?Y21sKzhQUjlKeXA5MzlsOEpVaGwwMnZKK1JIUS8yWjk3d01YN0JwUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53298e28-e9c3-463e-38fd-08df3e860305
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 17:22:20.8242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pX/iQy3QdDouyf/9FEwYRlL6hQeQBdF9/rKvdUSyAFV+hXpyOt+IVMJO/kPAecCG2R7vUkIlSwQv7zp0HM8WDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6094

From: Jan Kiszka <jan.kiszka@siemens.com>

This will allow us to switch to rootless builds.

We need to adjust the dependency chain for the arch-all package
xenomai-kernel-source as Isar changed its logic here.

Furthermore, a xenomai-native target exists now to provide an arch-
specific source package for the kernel. We need to account for them when
setting preferred versions.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2 (v1 was still in next):
 - PREFERRED_VERSION for xenomai-native
 - bump Isar to latest master (some more optimizations)

 conf/distro/xenomai-demo.conf       | 3 ++-
 kas.yaml                            | 2 +-
 kas/opt/xenomai-3.1.x-head.yaml     | 3 ++-
 kas/opt/xenomai-3.1.x.yaml          | 3 ++-
 kas/opt/xenomai-3.2.x-head.yaml     | 3 ++-
 kas/opt/xenomai-3.2.x.yaml          | 3 ++-
 kas/opt/xenomai-3.3.x-head.yaml     | 3 ++-
 kas/opt/xenomai-3.3.x.yaml          | 3 ++-
 kas/opt/xenomai-next.yaml           | 3 ++-
 recipes-xenomai/xenomai/xenomai.inc | 2 +-
 10 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/conf/distro/xenomai-demo.conf b/conf/distro/xenomai-demo.conf
index 1a58054..5cdd42a 100644
--- a/conf/distro/xenomai-demo.conf
+++ b/conf/distro/xenomai-demo.conf
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2018-2025
+# Copyright (c) Siemens AG, 2018-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -19,6 +19,7 @@ OVERRIDES .= ":xenomai${XENOMAI_MAJOR_VERSION}"
 
 PREFERRED_VERSION_xenomai ?= "3.3%"
 PREFERRED_VERSION_xenomai-compat ?= "3.3%"
+PREFERRED_VERSION_xenomai-native ?= "3.3%"
 include conf/distro/include/xenomai-version.inc
 
 PREFERRED_VERSION_libevl ?= "5%"
diff --git a/kas.yaml b/kas.yaml
index 1eb2469..dc3a48d 100644
--- a/kas.yaml
+++ b/kas.yaml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 22ee5352eab6c38ac395da60895d09bacfe7b201
+    commit: abb61d6d9e0323f8d998d2643bb76757a0d1bb1f
     layers:
       meta:
 
diff --git a/kas/opt/xenomai-3.1.x-head.yaml b/kas/opt/xenomai-3.1.x-head.yaml
index fc2f30c..fd82f23 100644
--- a/kas/opt/xenomai-3.1.x-head.yaml
+++ b/kas/opt/xenomai-3.1.x-head.yaml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2020-2025
+# Copyright (c) Siemens AG, 2020-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -18,3 +18,4 @@ local_conf_header:
   xenomai-version: |
     PREFERRED_VERSION_xenomai = "stable-3.1.x"
     PREFERRED_VERSION_xenomai-compat = "stable-3.1.x"
+    PREFERRED_VERSION_xenomai-native = "stable-3.1.x"
diff --git a/kas/opt/xenomai-3.1.x.yaml b/kas/opt/xenomai-3.1.x.yaml
index 8a7f593..22e30f3 100644
--- a/kas/opt/xenomai-3.1.x.yaml
+++ b/kas/opt/xenomai-3.1.x.yaml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2025
+# Copyright (c) Siemens AG, 2025-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -18,3 +18,4 @@ local_conf_header:
   xenomai-version: |
     PREFERRED_VERSION_xenomai = "3.1%"
     PREFERRED_VERSION_xenomai-compat = "3.1%"
+    PREFERRED_VERSION_xenomai-native = "3.1%"
diff --git a/kas/opt/xenomai-3.2.x-head.yaml b/kas/opt/xenomai-3.2.x-head.yaml
index fa13e2a..fd20b22 100644
--- a/kas/opt/xenomai-3.2.x-head.yaml
+++ b/kas/opt/xenomai-3.2.x-head.yaml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2021-2025
+# Copyright (c) Siemens AG, 2021-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -18,3 +18,4 @@ local_conf_header:
   xenomai-version: |
     PREFERRED_VERSION_xenomai = "stable-3.2.x"
     PREFERRED_VERSION_xenomai-compat = "stable-3.2.x"
+    PREFERRED_VERSION_xenomai-native = "stable-3.2.x"
diff --git a/kas/opt/xenomai-3.2.x.yaml b/kas/opt/xenomai-3.2.x.yaml
index 56c29f7..0c769df 100644
--- a/kas/opt/xenomai-3.2.x.yaml
+++ b/kas/opt/xenomai-3.2.x.yaml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2025
+# Copyright (c) Siemens AG, 2025-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -18,3 +18,4 @@ local_conf_header:
   xenomai-version: |
     PREFERRED_VERSION_xenomai = "3.2%"
     PREFERRED_VERSION_xenomai-compat = "3.2%"
+    PREFERRED_VERSION_xenomai-native = "3.2%"
diff --git a/kas/opt/xenomai-3.3.x-head.yaml b/kas/opt/xenomai-3.3.x-head.yaml
index 1cab9b9..d2fe7bc 100644
--- a/kas/opt/xenomai-3.3.x-head.yaml
+++ b/kas/opt/xenomai-3.3.x-head.yaml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens, 2025
+# Copyright (c) Siemens, 2025-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -18,3 +18,4 @@ local_conf_header:
   xenomai-version: |
     PREFERRED_VERSION_xenomai = "stable-3.3.x"
     PREFERRED_VERSION_xenomai-compat = "stable-3.3.x"
+    PREFERRED_VERSION_xenomai-native = "stable-3.3.x"
diff --git a/kas/opt/xenomai-3.3.x.yaml b/kas/opt/xenomai-3.3.x.yaml
index a33a3f9..ae66f8f 100644
--- a/kas/opt/xenomai-3.3.x.yaml
+++ b/kas/opt/xenomai-3.3.x.yaml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2025
+# Copyright (c) Siemens AG, 2025-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -18,3 +18,4 @@ local_conf_header:
   xenomai-version: |
     PREFERRED_VERSION_xenomai = "3.3%"
     PREFERRED_VERSION_xenomai-compat = "3.3%"
+    PREFERRED_VERSION_xenomai-native = "3.3%"
diff --git a/kas/opt/xenomai-next.yaml b/kas/opt/xenomai-next.yaml
index be63175..3067015 100644
--- a/kas/opt/xenomai-next.yaml
+++ b/kas/opt/xenomai-next.yaml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019-2024
+# Copyright (c) Siemens AG, 2019-2026
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -16,3 +16,4 @@ local_conf_header:
   xenomai-version: |
     PREFERRED_VERSION_xenomai = "next"
     PREFERRED_VERSION_xenomai-compat = "next"
+    PREFERRED_VERSION_xenomai-native = "next"
diff --git a/recipes-xenomai/xenomai/xenomai.inc b/recipes-xenomai/xenomai/xenomai.inc
index 9dfef32..fc03ee5 100644
--- a/recipes-xenomai/xenomai/xenomai.inc
+++ b/recipes-xenomai/xenomai/xenomai.inc
@@ -14,7 +14,7 @@ inherit print-revision
 
 MAINTAINER = "Xenomai <xenomai@lists.linux.dev>"
 
-PROVIDES += "xenomai-kernel-source"
+PROVIDES += "xenomai-kernel-source-archall"
 PROVIDES += "xenomai-runtime"
 PROVIDES += "xenomai-runtime-dbgsym"
 PROVIDES += "xenomai-testsuite"
-- 
2.47.3
