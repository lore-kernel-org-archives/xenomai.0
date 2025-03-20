Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2041.outbound.protection.outlook.com [40.107.241.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87289221F33
	for <xenomai@lists.linux.dev>; Thu, 20 Mar 2025 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742488898; cv=fail; b=pgpNioCO52g1uxa3B4k4unUdzW+nDV4M/vYN0DGf/aEnjs9A1+ggynpYCUmtcjub2YJU5TwfmPQdh1PeZbRZJOwB8ELxG44cB5Rm53iFGlT0hpo4gT58NSWHI1JscAPdB+DK7iygSCaRiX5PBICcopd16uk+MG8HzmrfBSdh/v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742488898; c=relaxed/simple;
	bh=Rd0vvZzwoHwaCU+78GwgGpAtyb1BD3Ee7pO0sLrFEsI=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=gbdAau9WugKCymyUyTTb3XjeSkTYHK5LTTi/zcnEe4glF2qLmGG7cDwu9EJZPD23rp4z3VNY4Ut+qB7uN/KJjti6vXdQcMU/DthfouJR8BnprquJ8dgqp9VmJw7cmPO5AdNIZeEOmEaahSvwyaaWfwiMjBLTsjLOMwC5436KVFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=JXWQ1cO5; arc=fail smtp.client-ip=40.107.241.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="JXWQ1cO5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTR5bqSJWwReAssvh9ketw/GTLjtJ79KIwRLNR3WlInJ3Bl6YYuTlKwL1372ZMlxXgqtBMGvddJqn8exBj3+9HX/dLtfJHLzW3w/SgjzZVLEPkLbCJO0yNRDXA77StqcxGhc0g3u3K2irdxa0ebBMRAavNbd10F7k2dPwal14wYyay+MCtSemXfRvZ+V7aSZZLeQT/30N8ISjXDexlH/L1xE0MXkwHu2XJJJpDElkWOXjXzLNizkesfKlT43dkQWwGuSLpgnYFhXUoQmfL3BIM3btZ+0bfOO6OKewexdfCuAhzfOFnez7KznwatiwQAzawjoVf11B4m1OIrfaKEnvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hI73GDid0JmtCQ1UEX9IBirdHqbHPDMSw9+vU911ea8=;
 b=jgoR+UWmBRrvexJeoDJyvFjoKbsdHlxAJ3AmtPaJyjW0eW8G/GB61tM5fSPDw9K5MyXLXG7Z/2Fblth97JFALN/KPpYLjnFMcRRND6/ShWcCT4GcRDbjrM+5mIeRDj6Dk4Jxba69X1cRYcuQWnFzOgdltRPP6joNMrEY4mQNhOZyO9/v0tLmdaJDuPw5fnbZwIjc4FhVbxidr++fmerGg0W8/ZIuPGINtmsSShcTv+XG9XKurhlC+wGnGAeaabolwY0qcPjty0UsXGmEROded196eS2uRgDjlqkDEgoln9NY+yme1h40QuMxwxNFW/3kHbCdHNZaZ12oFy0/s/+9UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hI73GDid0JmtCQ1UEX9IBirdHqbHPDMSw9+vU911ea8=;
 b=JXWQ1cO5e8zafnZ61HynvD7RuGOpXHc9DisSxosJoCnGR/OAej3pwNfNkbtbkb4gqZ4i7wOBUAkCZiCKzOvw7ojwA6+r07jmNdC819AeQQZyggVjyCl2n4Cv27c6fek2eoycUbl+3IdXO21o5q3EVLpsgRbl0l3Ce0ZqL3GEWF7fnfODA6K9Mit2IJ4O8FA+Zi3+gLIfw7ofM5kqxJB+KTeZUxAh6IA3fEfpfZBBhcDEBH2oLB26CuLEK3E0uGh1y9fRXyTeBCip7rgB16mOr3mOc4+Lky+QdzG9fTBU4HeC2YxTXCpIONBGazZVsdKcWYMQzpTaexrOK/NWmqoovA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7301.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:617::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 16:41:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 16:41:31 +0000
Message-ID: <68cf84b9-57bc-4a6c-9546-101a13c7acc4@siemens.com>
Date: Thu, 20 Mar 2025 17:41:28 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] dovetail: Fix interrupt re-enabling after hibernation
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: c6334bfd-90cd-4b23-5c81-08dd67ce11be
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WG9nZFhNaGhsQk15MlloSWE0MXNHNlhRak05bEJQMzFrTzJyQnhnS0licHU4?=
 =?utf-8?B?UlFEa294YUprM3hDM2ZnbjVNbWg3S0c2Y3BpQkc5VE9tc1JuNGlkM09YRmZD?=
 =?utf-8?B?UzJGZmpoYlNEZFRnWEZ4SWFYWGNnZ2xlTm41RHA4bGxlRGRSSG15a3dyamtp?=
 =?utf-8?B?a1ZMbEd2YVlkNFA3bTBxa01sYlZpRytRNFI0NDRVckxRTkVsNTE2eDBJQ0Fk?=
 =?utf-8?B?aFVTeWVpYTFXVGlNNUllaGJJL0N1VGdHSkpPOFQ5djUzNkR1eWJ6TEFLMlFM?=
 =?utf-8?B?T0s4Uko5ck00Y3pxdFljcHhMaWVteUp0bGhWWHhZTzJXV2pZdWJocTFMQk5S?=
 =?utf-8?B?R3lDd3B1Mm5lUTNqMWRwQUFkeEVNeFh4bUQwUWtOU2tKbG9UYUZmK21TYzZj?=
 =?utf-8?B?dWM1WmpzZUJVT1FjNnduandJVE1ua1labnh5a3kwQVdSMUdzWE5uem5jR0ps?=
 =?utf-8?B?WWhWNnNoY00yM2FnN3R1cVFkR1lnWFB5bElaK3VPaTZWSDU5ZUlBeERZWkFT?=
 =?utf-8?B?MXlFWDBKTGdwcks1clg5Rm9kamNBSFBPa1BVZXNoQmZaR1FWNkp5WjJFblJy?=
 =?utf-8?B?TWNNZi81MGE1M0RyNVdoSDM3YVFEcFI5NXV5dmd5QXdPUHliZ3NDeTVLZktN?=
 =?utf-8?B?MDA5U0p0WjI5a0cvZ1FlZk9RTk11SlV3aVhlUWZqV2N2VHhUYTNVZXJKMm9o?=
 =?utf-8?B?UXIyV2N0eUlVa1JsWjB0ZWVtc1BGN2dOV1B6cHNlUWxiY0ZXY2thQ29hRFRw?=
 =?utf-8?B?SlM4RFVnMXFoMHhZUVRVNmRKUldhbUVnMC95VVhwMWYrZU12TlVkS01BV29L?=
 =?utf-8?B?dmphQnlYcDd5TWVRZ2RUanpIalhWdjJ0RldpblhKY2xPbVJ2eVk3ZUh0S3J2?=
 =?utf-8?B?N21Dc1BnUGZsZE14eGhlbXRHcmJRaW9TUDFUTitSV3BMdk1leHlrNWJCTldT?=
 =?utf-8?B?Wlh3N0xrbW0xYmJ2dkQrSVRPWm9LTHhudVZORXVWRDNKKzZaaFlzcjQzZ09q?=
 =?utf-8?B?Q1dBeUU5U0F5dWxCNTVlZUJQczR0dS9vZDlTMVFOSkg1NHF0RDJyckx5RSto?=
 =?utf-8?B?dWlUOGZORS91TTRsOE5zSktTZU1NNk1NV1d5Y25rRVFvbFFQUmtvKzNCQzkr?=
 =?utf-8?B?WDhmTUJkaGZiRG1xeXNVTVZWNmRka0N3aWdvbnBnWUl5K3BGbHFhbW5saWVN?=
 =?utf-8?B?REFkekl0cUlEUWl3WTlXYlF4OGxyRFp5M000cW5XVHJCelhuNlRycTVLeFRn?=
 =?utf-8?B?dzltSjFUK0dhalBKZS9LWW4rcUFSaDFiS0JIZjBIWWpURHpqNE5KRmNXWkVq?=
 =?utf-8?B?b29Db3R5WHZHTnpFRUM3ZkpuUmhRTE1odG8rd2RKYWJUMFh3cEZlR3kwbzZG?=
 =?utf-8?B?Rm83Q3VENHdvRU1NbWpCeEVhYzMyZm1xWVhXZ0t0MU1iVUQvUG1GK2hnR2Nn?=
 =?utf-8?B?TW9RZWR6aU82dWpKS3Ficzh0TElkS2cyMC9SSEkwdTV4R20ybmFEajBHR2FB?=
 =?utf-8?B?TzFZNEFaNFJWOGVodXlPOThxTGNmRzlBdVZCb2k1bzBiaW9yWFN0czBEVFFE?=
 =?utf-8?B?SS93WnlHdlZacTBnY2FudkdTU25sN0x1WEdNakwrVHpEQURnaTl2a0hvSU1B?=
 =?utf-8?B?WmIxNEMyNUZNS0puR1I5ZFR3em1LWUtWOVZlS3llUTZiV0FxMlRwWWh0K1Yx?=
 =?utf-8?B?NnJlL2pNb2NsZ2NMMUhWY0FoTUFSVEFUbUVxSEdUc251RzFmRXNHK0pjeHZQ?=
 =?utf-8?B?SGpNS3REU2d2ZXFvV01nQWUxMHhZUTJlQlRtMkJ1ZTVqK2h2NVRoSWthcnhq?=
 =?utf-8?B?KzZBeUtyQ2VsYyt0VFpxa3dxV0swSHJmc0hEd1MreWEydnBzZDZwUjBCNERa?=
 =?utf-8?Q?B8UHc/MMjxYMr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0hKUFRoVDc4S0RHandKR3ptWFkwM2cxYUFEejZaN3RKYWF6MVVsQUVHTGtM?=
 =?utf-8?B?aW03N3JteGdIV3BtR0s0KzBjTXZJM1VoeWFuQzZ3YXFsVUl4aFlLM1BOeEdD?=
 =?utf-8?B?c0hjS3pRUkVJcHZLblRGbUlJODhONmZZSFc4TWVjc0RmeHZwM3h0NmVsdkp2?=
 =?utf-8?B?SkpzVC9aWnVKMlpHRGlna2gyalQvV0ZIaUJRcys1MmYxVCtJWkZFdUNLSmk4?=
 =?utf-8?B?bUlQUzJKK0hhZmFNc0FsaGZPWWtpLzJKVzZwRytKMVNqeWhOSW1abkZ6Q084?=
 =?utf-8?B?YlpMSWgrMm05ODAzVVY3RkVqUEhITnFCM1VkY0FFRzVjcFRSaWllTlNCc2dB?=
 =?utf-8?B?ZHFSdjhWRkpYMWxFalVMVmxrMUpUZEFVS2NZSGEwUjJtWkJKb3VRU3F5ck9X?=
 =?utf-8?B?cGZhUlo5alRsN3Jqdkp5c05GOHBTZFlzdHZNZjU5bkZZZWd6Nm5ESFVmQTVT?=
 =?utf-8?B?b1dackg4VHZYRWIrclJkN2cyekp1RnVSNlNUVjh3Y010RDlQRXVHVXVCMmFr?=
 =?utf-8?B?TnVXQ2wyQzNDaDZtSE9URlNuNUtkNU5CV0gvSytIbUM3Q2Q3WFBCdUxxV0hU?=
 =?utf-8?B?TExmVjNEalpEaXFGUm13Z2lnbEhxUy9JLzJjU01rVXpzWG5EZE8vZ3pJTVg0?=
 =?utf-8?B?aHlvQ2VSTWdZSi8vN3h5RTVwQUs5emJMbi81Z2VlOVFkZVlGNFdRdnJBR2ln?=
 =?utf-8?B?Qk1IQVRQMUhPNDhvNTg1OUZoSFMxMDN6eS9Sb1ErdnBTRjZVR2poOE5LdUYx?=
 =?utf-8?B?bEpyRzNRelVUM0xlZGVVMVZaZndJSGpWMmRHUXk4N1VCcjB5TDlrZ3R0TC9w?=
 =?utf-8?B?S21uSytlQUdHdGlJMlYreTgyanEyYk9OemR1WFI4bEFKNWw3TzFWM0JtMVNq?=
 =?utf-8?B?UmZncHZTSDhyUmtJRyt1MWN0WUNkUHRNZGZ4MGxKdGJaSG8ycFlyaFZkOTNI?=
 =?utf-8?B?aDltYVpJL0ZxeVRoRHFSSmlEUkRTbW82enliT0hVVzd0WFFFaXlGditJNlJt?=
 =?utf-8?B?SE1zNVNRV0dtSVlzS280ZDc4QnErV3lGN3BlSGdQdW10V0pFVVEwYjdkbXEz?=
 =?utf-8?B?WkJyVXk0TkdEc3FnYkJoUXFQTjVwOGErYUdMR3I0cm1ydWdQb3Fjenp6d2lE?=
 =?utf-8?B?cHRENjJScGxVaVNTbnRhN0xta3F2SVJjL1pza1lwRHIwbE9WeFpnQjdFZ3pw?=
 =?utf-8?B?aVNPMytkaWpsSXB4c0dXa2NTb0M3R2xrckdUQk9iWm5tWHlOT0lhNzR4aEQ1?=
 =?utf-8?B?SlRTejRDU1dmY2I0cVQ5N1V3bWZpSE1kZkRxTU9OMVI0OGJWWXltSnk5UHhU?=
 =?utf-8?B?YUtadk9ObDFpWW55QlcyMTdqZWFDV0VtZTdlR2dvZXk0cGZNSVY0RURFNC9w?=
 =?utf-8?B?eGFUL1pheHBIQnozUVNhY3BHWFFJbzZ0YVpXWFNreEFOaVRJZTVqS2lad0Rv?=
 =?utf-8?B?VFZubURWZ296UWtHbTVxM2lxc2hwU21BWFgwa1FQbVRrMFpKL2x3VlpsMDhv?=
 =?utf-8?B?VjJwZ3JUbFluR1dxWkhwa0VFMWllK2doNm1qWnBDQ2FJMUxOOFY2THh5TVRT?=
 =?utf-8?B?SUhSaHJ4UjhxbjVVVGk4M1BRU2V3ZVQya3lqcTFlV0RUM2lGenlIV2NMV1VT?=
 =?utf-8?B?Y21hZndYMkdPaUVHTGZhV1lxWDRwMHAxOWkxYkxrcno1YnYrVWZqcGlNME1u?=
 =?utf-8?B?MWFldFJoRzVCYThYZ1M0emtJRnRaSGw4bzlvZ0JTMklWcVQxTXhra0NpRzZi?=
 =?utf-8?B?ZUtkdUd0dHdpb1UvWEtEVUhOUnVya3kwM0prY1VLTzlXM2ZrTDgvdnVGalNT?=
 =?utf-8?B?dlJwUkllNVpMMjZ1VWJHa1ptMTZRaHVNUnVLZnVLbTNHOVBMdEkxT2pYdnQx?=
 =?utf-8?B?djlMcjlhdldGRFM0TFltSTRlYnFOenBZQmpBWFhub05NbUhuL0RRaGN3Tk1x?=
 =?utf-8?B?VG1aR1NkWVZ4aWpoRkJ5M2NLMk92QkFvZkQ5UEhBMmx6amJvdmdRTFhEMzIv?=
 =?utf-8?B?NmdGTUFCczhxUXVEN1RHSzZWQzF3c1FlcHFQU2o3bnpYTHJ1QldGT3hIN3RM?=
 =?utf-8?B?ZUtGUWQvaHNsc0V4TFVOdjNDYVhuaEJUWWhKandwWHhyY2pwYkhkRGNTTWpx?=
 =?utf-8?B?dnRLVjlFZzZsZWtsek5wVXFINGxrNUpxazdHY2ZVWjQ1SUFxTzd4RSs5SkhQ?=
 =?utf-8?B?Rnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6334bfd-90cd-4b23-5c81-08dd67ce11be
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 16:41:31.7305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGKyubDXxZGK010o886snmcwxh6weV8JDf+Wk92xYiQ2sLzun24gh29sWxB0rmM3ijCuTlYW7eSAb8b6X+p/0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7301

From: Jan Kiszka <jan.kiszka@siemens.com>

We had unbalanced hard_cond_local_irq_disable here so far.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Minus one hunk that is already in current 6.12.y, this needs to be 
applied to older stable versions as well.

 kernel/power/hibernate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 733b1a196f09e..e1c05f276a453 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -352,6 +352,7 @@ static int create_image(int platform_mode)
 	syscore_resume();
 
  Enable_irqs:
+	hard_cond_local_irq_enable();
 	system_state = SYSTEM_RUNNING;
 	local_irq_enable();
 
@@ -522,6 +523,7 @@ static int resume_target_kernel(bool platform_mode)
 	syscore_resume();
 
  Enable_irqs:
+	hard_cond_local_irq_enable();
 	system_state = SYSTEM_RUNNING;
 	local_irq_enable();
 
@@ -628,6 +630,7 @@ int hibernation_platform_enter(void)
  Power_up:
 	syscore_resume();
  Enable_irqs:
+	hard_cond_local_irq_enable();
 	system_state = SYSTEM_RUNNING;
 	local_irq_enable();
 
-- 
2.43.0
