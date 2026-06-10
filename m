Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013059.outbound.protection.outlook.com [52.101.72.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291172DF3DA
	for <xenomai@lists.linux.dev>; Wed, 10 Jun 2026 06:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781072677; cv=fail; b=A2ruFGqyjizLBgELt1SQ1KN9Csr0GfZ6nkuoj5pZmcUwukvpi31XFQ1cvQiJk6AE4mBgI7keyctRgah0LFjGg0qTDpeiUz8IDA0XW4IN8Lo0invghqU39AUXKxEN3XcNDZuTV5/fdEHVn42ZJZ9r2qNUG7oJkPQLksv1ExQId1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781072677; c=relaxed/simple;
	bh=Jecdid1GSC8kcTEkK3GUABiruSlkgEASK45XQmHPL1o=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=AHZEhxApzyAbEgg29keXrPvIRtirbfpTMwSgfvyXFOVTftpB3CMGyE+4b9S2N5hSFeAwukpb29RLZj/vkcAhZzSLMlYZZ9skZl9cH3S9DPDIj/R4N1DiJ5pcDFZgiHsMQzcZTGxIQiLm9oREKEwo67BbrD7JyHIRqL+m2cd8tMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=crh+O7zS; arc=fail smtp.client-ip=52.101.72.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="crh+O7zS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjmP6pYUd8YncjM0XUid9alRCnkI1H07/VzvOloASHdzXns0/bTiITZT4sPd2bz7Bwkp6BXn1/35y36QST+NDtLLBdoUbPImA6zciixy/7unSvPB/2jctvcQmmfreKjxQ/J66QRST30qXgUYd0T9BCTksX5TFsPyKu6Vdu8sG1B9Q/8A6SRB1ztYlDNWC8TUuSPqZNCVstkmmDV/zLh62S+tsMDO1tSJcCMqYm3omk24Nd2hM06b41CS7qRQlwFM2xaUHc9ncuXF3SSGbHBOrLZeQztstNaBa1qYnOGJqyWgPFZae0dFvbNEuw9pFkmXpiZ7Coa0xn/NGV36i4qXFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05G1KuYvNBR30vu0f9NQQGK10ndNmpMyqwxaUqCBJQM=;
 b=oMRe/jiu3VlSEiG3hzyZAjo8GT+iC745c0haY/b1nkjkFzJ3itxv8CZYyWPLVVjkl/B3YIBGtX8g+vxTxiGcBLKS2l/Av7ZtG/grafpJXmZ9CrwV0nq8+Qh/zx4hWp/TMoLgX1ToUiPz6xivIaK8WaCZcJfeThDhhB9H4A/ADU2IMqqyJJxvvddCK8l6XK0NFLn7YdvwijfLiDI9mm2E/qcL57uYVSo5P/+R9bj3QY9ooA1/VnIan/xyCir2lgexX7Goi23ygZwAONAOErdCzcpFY4HbSAUDEwDmCfgTsk2xwlKtcIx2SeeXTb5dfwaFa7LHpLMltipLNRyNiFwcTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05G1KuYvNBR30vu0f9NQQGK10ndNmpMyqwxaUqCBJQM=;
 b=crh+O7zSML4j7h9spFjSo2L0s7c8hTdzxzULg7HtxyW5+kSfd023C/P8U+1EiRzigx3edE2tyn+ZsYTl36j2EHuHwXT7432jRzuNstqQ5Rx82uuodfb7XmAMQm4Tnh0UW/456Id4NVT2nWvS8b9xVIAJK4LfYoyPnYMRaZkZL7pmR0U4pkOxEfUJt95An8a2DTfM6RqnYCvswa4lF6E6TWW7Zkw+EEk/Agmt/lyjsaiKv2KJ73IdGFMLlQ6SGwFxwuQxrAjCNwG56EunfuW0kn4FHu55GjZrCDqAoO+q1hDVlu3s77x8CDOwdZQtAs9wrQ4HQ39nJGBUwecnRdNYuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7057.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:302::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 06:24:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 06:24:32 +0000
Message-ID: <19c8bc29-9eb5-4265-931a-1cc5c34ba1ac@siemens.com>
Date: Wed, 10 Jun 2026 08:24:31 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
Subject: SCHED_SPORADIC in Xenomai 3
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7057:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f920042-b7d2-40c0-234e-08dec6b8ef12
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|55112099003|3023799007|6133799003|56012099006|11063799006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info:
	qAcI01D4cG4xKiS41M0VxqT2pHxNlWWH043yC9xlVPUDpJMhrJyaFNVuvw5dMtiyjz7wU0WyOKRNi0Ij65HtjJAzMz+dzaSqNTh5jc0EHygmf1vsV/a+7SAOOR4GYLhAqxyom1yd/pdvimO3FY6m7LsAuDp9Z9u3GL/3MrBNf/sbrxl7VKcO3io3HMtpU5CTtidjYlEZL+tF8oCSlPKF2Q/ljWOyZM9MD5z9KXPWw/ZbgNo+Y3bfyFSc+zwTkDawzzrU2gebYkpj/xzE5B0xEOXszx1Z8F0eugT8WNLfTNXwTyzg6ns1gLMsTSdx3MUYsMoKvwxlYaJsTAFu8VBLSzW7areOQBOVpPIdkboyX5K0VVfOm2ParsyyeyHEoU6mrbMN2KkNm1PIb7jgVHGS667ukGqKd0keZpJdcGrugnxEaqmV/W+L56+9fHKhy1+xZrwAva76LdSL+dOO/P2MFaunS9SLL0kfxCkVYuntGrHG5RO+W2valvlorch2XZqMx+yOolm7liRIqG+f5otvGLzGKffS/BZKkr2qlqZwD1XYPQUDaDPOn35xXTgjlzmyX4fldqdfMhh+CDHFS6eJELdwGBoWcY6uJmPf7byvOci2aLFgf9iLPQXZBEmMrkY5Tcz9HBXuXU4Zb6GPIP2IVREe/VGEqzCXHwyTJHd0hIyFRBy9zjtCba7i2/D3/tYh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(55112099003)(3023799007)(6133799003)(56012099006)(11063799006)(5023799004)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2Z1RFVYRkJUdkN4R0luTXVDdnVPM1l1K0x1RFA2dnlqSlE0UnROZ3lZNEFM?=
 =?utf-8?B?N2ZXSnk5UnE4NDVOdG11eXd4OHRodlhTSCtKOEYyZUZEaVM0ay9naVVMU0hj?=
 =?utf-8?B?dEhRc2tVOFl5b2ZSanZzei9YcGNLeHk4Z2tUNzVZOVVsbnRHM3AwRnRkZHpZ?=
 =?utf-8?B?aUdEbGRGTTl5N0JPaXBsTkErMlFWN2VpYVhjcmozbGY5aWFCMzVUaDhMM1Qw?=
 =?utf-8?B?N3NFbW1xams3Ri9IRks2TzF3K2dWd2oyMGw5d1c1M1RpUDU1aTB4RVRXLytB?=
 =?utf-8?B?bFk4Mm0ydXVHTWhrRkNGclBncVhycCtLaXRvUVVZKzRTcHQvY2IzT3U2Ymd0?=
 =?utf-8?B?TUpCak5hazZWNDVRNXhmcXBmckd1bEhjVUxHdkVQTzRGd0U1YkpFbGEwdUZw?=
 =?utf-8?B?blN3NGdOM1NjMTlPeE40OFdicjIrMGZLVG1DTnRKdzRVS2NNZFJlaFU1MHBl?=
 =?utf-8?B?ZG42aDJseWxKTXNsSVJGTmw3U01TM2g1V1oxTW5LWnNYbTNleHVLaUFaZTBm?=
 =?utf-8?B?OS9pNnVEblFOWnBxcDQzaG9DMjYvREtyTndoYWFxUzZmMWl6MDlINGtxUnFZ?=
 =?utf-8?B?U0dWeUppaDVaR1BsYjBPMnRMMFJzOFQrQVpkSlF5MzRpK1Zlc2hZQTMyMFhm?=
 =?utf-8?B?TXJRNTVPdDdwWEcrcXBwd0M0cWR5V0ZwUFZNSTFzQ0FQTnV6c0Q4MXUwOWFu?=
 =?utf-8?B?RWxzSE96Ymo4WnlmR241bFJpY3NaeHJxdHRTa1FkdHVlTm12NUpMS2N5RjFX?=
 =?utf-8?B?WDQ5MGw4aERlS2xIOEk4VDBFcmhZeklDT2xGQm5MTWE5QVk2UHdSbERCWFNa?=
 =?utf-8?B?WFpJOGRxWGd1dWNVRTYxektwbi82SWxRRVcxd0FEVGwyZmUwdDBLeFNEWmRa?=
 =?utf-8?B?cTI4QXlSdlpBdHRVNVVIWXp4TVNFY29Kb0hlb1Nzakw3THFBcmRuQmZ6bHA2?=
 =?utf-8?B?MUh5N2c3dm82K2MvS3hGWFZNRXBNSmI2S3R0OW5FTUNVTzcvL3BybTNSOTMz?=
 =?utf-8?B?dEcyZ2MzSGRwSi9WTkx0VUVnT0dCOVdLM25IdXlORlowTG1Vbnl6ZThuZEQ1?=
 =?utf-8?B?NjhrTWl6OS9rR0ZQa1dBUmVNTGN0dTZHN1ZzQUdRU2xNcjNvQXlWQjVuVVRw?=
 =?utf-8?B?ckYwZFJuaGswY3hsaTgyUEpBY3k1MEhBYU9aQUhRZExteVJsc1ZEMzBPU3dS?=
 =?utf-8?B?Y2xmZ013M2c3UVNYR2xGazVuVXREdFpZcXZFTUx2cVRmeEIwdkg5SllURE9Y?=
 =?utf-8?B?ZWFwNFptVkh5dkZEanBrQTFXcWRBLzVUZHkwMk1hbjNBSG1NbElLRThESVJz?=
 =?utf-8?B?WnBNcFFueCtGQ3VoVGExeTRmclAwL2JiYU91VUVHTFJUOXFTSkE3Zmx4bUx5?=
 =?utf-8?B?OHJrWkYxYWtqUzVzSVgwM0x3Z29KU21pNlNxSEV3ZSs0VXM5dTNTUElzVjAw?=
 =?utf-8?B?NmhHSGkxSmxQT2ZZVHl3QzdLUGN4aXhyYmUwaE5pL3h0d2VCK2RqNXNLb0oy?=
 =?utf-8?B?TVFBSS9EVENNa1k0Y3N4YzhtS0U4MzdlRmdYckk5Mkh4RFlqQlBDSnN3V3BB?=
 =?utf-8?B?ZFB4aFVSaW9vdHZnRWRsOWhnOERSLzlHVTlVTnRzVlFvQjdFTCszQlYrWEdt?=
 =?utf-8?B?WnNzUzIrNjRoTVp1bTBxK1A4b0VoajAzU2Z4U2g2K1IvaWxEVEJLVWhheldx?=
 =?utf-8?B?WlZ2Yzh0YkxSWTFEUEdpWE9HL0Z3MjB0dkdHN2FBdGsvZmlLVnpNV3VDUlZ3?=
 =?utf-8?B?K1FEazZZRFNQSEEvY3ZvZWE1QmJLQ1FaUnh2Y25YTStjMWk2WVVMTnhEOEx6?=
 =?utf-8?B?c2UyTXZSOTRCakhLMXN5Q2J2RnIxRDVGVDloRUpEZVo5dlZWOG1pVjZZN0Rp?=
 =?utf-8?B?Y3hCT1VyZ3lrZXZYQVhXbU9kV1dOaXNPZ0NVNkUyOEpUbE5lV1FGSFNtRElS?=
 =?utf-8?B?TWI1Q0NackhEd1FUSnJQRWF4U3ZjckNqK2VZMmhBMmZsN3ExNUcrNGx1RmxO?=
 =?utf-8?B?UXJNRjEzYWg1cExmMHFVSkFHYUtsUTRPY3VYalFzZ2JESm5hY2lMQmdyWjdO?=
 =?utf-8?B?eVNnQ0w4TGc1L2ZSRDV2ejBObVhaUE92SkpNUXQveVVudnBkbktOZXRpSEg3?=
 =?utf-8?B?NnZuNTRCMEd6U3VJQWdvaXNiVS9RL3ZXZHNxV1c2YW9PM1U5Y1g4UHEzbDlF?=
 =?utf-8?B?YVFadm9kcEU0NDVBempvTU5BeXg5aTJyeWY3SXRWNm1KdHRpK1VGc1EzNzdv?=
 =?utf-8?B?WDVrR1d5THlicG5VL2FtMjZscnhTUkt1ZlVFa29ONk51VEdnSEtOOTVKMUlS?=
 =?utf-8?B?MXlhdUJtaWx4K1JKT3o5NUxLdFdOU0VNSXRqbW5LVVVFbjA1TWY5Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f920042-b7d2-40c0-234e-08dec6b8ef12
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 06:24:32.3072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fnGneiUfacwN+y0I7TgzTZVpI930nDaU8clKKhzGwKjUbf+/rE7ZHPJDKAdLgjT/+UkouI1pAqeJrg6HGPm2Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7057

Hi Philippe,

while trying to port the signal-while-suspended fix to Xenomai 3, I ran
into XNHELD, a state only existing there. I suppose that was once
forward-ported as EVL_T_HALT. The only user of XNHELD in Xenomai 3 is
SCHED_SPORADIC - so let's dive into that scheduling class.

Turned out it was never documented, not even linked to the POSIX
standard. But it also slightly differs from it (low_prio = -1 -> suspend
on depletion). There is also no test case, so I asked an AI for one.
That worked fairly well as it seems to have revealed an issue:

Could it be that we are not properly suspending the budget tracking when
a higher-prio task from a different scheduling class is preempting a
sporadic thread? It looks like that xnsched_sporadic_pick is not invoked
if a thread is selected from a higher-prio class first, namely sched-rt
with its weight 4 vs. 3 if sched-sporadic. Or is that an (undocumented)
limitation/misconfiguration? Is that issue even affecting other
time-slicing classes as well??

That furthermore makes me wonder if we actually have users of
sched-sporadic. Likely a hard to answer question, as usual. But such a
limitation should have been observed earlier under real workload...

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

