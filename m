Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEAA25D55A
	for <xenomai@lists.linux.dev>; Wed, 26 Feb 2025 05:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740548874; cv=fail; b=uiJyUK4AXgYifHgN1p5KBOBjmhAgGva0Nv35flcYD6Fs4wPkRx1Rt63+tGsqkSoLxCnXbBBpP7p5jK8yf2R3qxMheL04N+oPNMo3U1PeIFI8iM0K6Yw1RRdxigrwfuqzK4ErS8fvbj2/LXQcgNXoON+2RANEZ8Y/gSkAZTUx/iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740548874; c=relaxed/simple;
	bh=YHJqnpimPKP1Ni/i+1SUz+X6gfCxBVVpp4kGNqrXstk=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=MoKHK0KRdmOyZgnT6TGUr2Jy64EuEvjxJ5ngnq91zSBOzyc+bDjf/p1OkhL/JrEPsaLARPoMp8tr0FwoisWPXPlZt+63KUsjZGQDXHlqHpOtVGWNZGw7/eQCg+JIIn6zL3mMFoEydB0EJTSB9VXC4WhVrYaHkah0GzjHfdeUSRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=CVvfPr4C; arc=fail smtp.client-ip=40.107.22.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="CVvfPr4C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2KSGxKZlHv5Kcr4AP5xifdAYW25xJzsJZM7x6V6JtN8jDBm64+bZ4EftQ10TVxLYWqjs7wq+ZNmI6eb/6s487EEgDOrz99XtDK/iBaMvr3jh47Fyflgs5FFU4vtdI8673d9lEsKkTMcDDv9XosIeL2de02vd+DISbydxbPpXFsi1Qo0HwKl7Un2HfGBXAokK57Uq3aIK6IvzeSdb412wYL+FBHSNgiYSVdi8WdUphx6j0bJjY/wWcvqcoF+6nUGdK22Lyq04QZ9A7k5b4sT0+VXj7NxCmE+bk2Dvdc8JvGDEsP7UyY4VWtbZQHPBl9TNvzUGIGePS5pRV5tBy29dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPNx0C6eLinuzRXRYMEYblt4mctwj8hpQ1d+g+bjLRQ=;
 b=v3HiNk6+uAV/t2CJflFBxzN7T6675DVoL0dII4EutxCBoztdg6qETRwFlxaZNshPD4M9m42XKarM13You5xdoEgiT7zzZQp/vEgY51J47H5vZu29Cu1oqSrrS7F7Ig0m8eyVcD1hPBhPAzHIhfD7VX+XIHqRywb2YXKiI4zzExvjPeKrs7TxnA1D+EMvHxH71+80PI1yGwx2m5rVD+u9x93+pru6LwjTJpiIg5NS97r6MZvlXv+0hIeEAuh/9gNsHc5rlnkMK8NMXJph33j3KYgWSuY7JAZbnP0fDf+sQSsDwnDCqUeX4iHVkHUFN8mOeh4Mz8ZLfjRdiLFLD9WbSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPNx0C6eLinuzRXRYMEYblt4mctwj8hpQ1d+g+bjLRQ=;
 b=CVvfPr4CC/7gkcWjad78pjNOQ3BbY4g9/IhwSB/ZZ6OwFJiZVNFfKsL9wDxpLXRkq7ofCo78+lXKOBJlU2EP5yHRRJNiU30MCHSvm/0iwRkvBk1kGikkJjLECVpkx6+bwOn/iE6bkC/s5KwRescucwHYfdoO2z3qPBzHOwakHqsOxC0JkH6bnsycOiQ8D7cTqsfwU+JN39idgN4pkSc+5twtsdegDVoY9yfHs2bGLQZ2npC2YnmbyeKllAevQd4y+WsKsSosmSFn80NIqmqAdip0TOg0yLiAcWraGwgmcT/8cVLsMm9QYuJAg8anDgK7VDHTZHvxHwV44NWK/dE6rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 05:47:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 05:47:50 +0000
Message-ID: <51ff9147-9af7-4f5c-9407-b7a73bd1d290@siemens.com>
Date: Wed, 26 Feb 2025 06:47:49 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] cobalt/intr: Restore support for IRQ sharing
Content-Language: en-US
Cc: Johann Obermayr <johann@fam-obermayr.at>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 5052e271-4098-4b3c-2ce1-08dd56291ab6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHh2TDNpUzYxZE1wNklicXg3dEgzYmRua1EvSjBpM29vK0MyTm05eU9Rc21K?=
 =?utf-8?B?cTF1VVh4L1pxV3h5Y3pWRXlTa0szTjVvTGJOdVpTU1NQR2plMHFuZ2MwQzlQ?=
 =?utf-8?B?blpabjMwMEpveUxWMGFNRE11VDJyWEN3ZURRNTRHczlVZytkSGk2ZGhJUVFK?=
 =?utf-8?B?NjBZRjBTa0xSOGJUKzdweTBWSlBReHB5a3VpcUphY3Aybml3R29mckdhYXht?=
 =?utf-8?B?VXdxT2JVczA3WEw3d2szNDcvcnZuRC9yK2xPanplN3dCZzk2amoxZUpxeit0?=
 =?utf-8?B?OS8xanhvQ3NpRU5LR2Z1Nkd6VFlsMEJpci9uOWRXZ1hBMms5am1RaVo2WTJV?=
 =?utf-8?B?aXZZU01penF4Wk9aS0V1WmozUlRMUG13MnNKeEdnNFRnRHd5cVRwYTJNbnVi?=
 =?utf-8?B?UXFpVXF1bVZqd2dUTGQ0OHhzVFhNZjUxNW5lRkd5UGlYWnJMcFJRbzhZRjdw?=
 =?utf-8?B?dWFMMHo2UnlFd1VxNis5d1U4TzJRblpwVFlMTXZyMnl1TENHMS9ydzJZQy9q?=
 =?utf-8?B?a3ZIREE4RUtJZndjSVNuQ0I2d1d6U0p5eFVEcVdhVEhNQitLcjJ5cUNpdGp6?=
 =?utf-8?B?S2hKcm82VnJZSDNCUVE5bzFob284enQ5OXdEM2VYSGtJQXMrclFJdk1JY1Nu?=
 =?utf-8?B?K3NrRjRoQnlPTWllTHlnL04wQk9YMkJMN1dSUnRZRGoyZEp6cHlackMzQVNh?=
 =?utf-8?B?SjRVTVpRdEh3V1RhY0t2a0grRy9jaU9nODFiWkNLcGV1UEttbzN4N2Q4QVlo?=
 =?utf-8?B?R1NOeWp6YnVJZXNQeUpBM3pyUThTWnAxMmJzcUJsVlEvM0lrSTJYNFpXL2pp?=
 =?utf-8?B?cUhMdVV5d1NjV2ZYTVovaVMyS0FpV3Bmc0RyeEY5aG42SjNLZXdKa25CTGRC?=
 =?utf-8?B?d05TRjdWc0xRS2xLQ2FyTThmT1V3eHJ6UllkckFJenFZTlFSa015bmV6cjd5?=
 =?utf-8?B?Y2Z0ak1BQmgrWXZqMEFVdHFBclhyMDBESnNmZWVkZG05VXk3U2JOMm5JSnJo?=
 =?utf-8?B?TjFpUkZPVFI4WW5raVpSRTF0enQ1U1NvaXRjU3BHZkk4eXJNNkhBNEFsTVpl?=
 =?utf-8?B?VlI3ZkVEQmtWT3pKT25iSlBvcldvSW1zZTJmQ05qUVVyZGphTnhpdVk1OWtM?=
 =?utf-8?B?L0dRK1EwdkxjUmhGZitOTTBKbzJuQ1VsYzJvVSsxbTJZUHhWVm9XZXBOaFdw?=
 =?utf-8?B?LzIvRnV4ODZobWNuMlUxQm5ucWpESlF0dVRua0p2b213OTNTTE1tcml1V3Iz?=
 =?utf-8?B?MzRxLzM2d29aaWVXU0pjZCtjZUpLQjQ4NGkwUzRybm9uY0ZLMStFV1pNdE9Y?=
 =?utf-8?B?ODlBZzVpWFpIcUhma3c2eEN2YmZXdXJ0clA2RnhVWnJzOGx0RFVwNFEzQjdr?=
 =?utf-8?B?Mk1BenduY3hTMHB6Z0UzZzJIV0RUNWdmZ1RJb1piQXJEdkhyeXpNMEVRVzBP?=
 =?utf-8?B?bkZhNHJUcm9LNjM2YTVsZEJNZ25xaXp5TWJCeHhBd3VtS3BNUjZHL1VlaHFF?=
 =?utf-8?B?Vjc3S0NnVjJmUXZQRFZvbFpRYndkOTdsejE5SC9rK1NvMlBnSnBXMVpIbkJF?=
 =?utf-8?B?Zk0xSkRSd0JuRm5sWktzWU9QcnV5Vjk2OUI2TWFtWHhNVWViVWY1dlRlZDlh?=
 =?utf-8?B?WXBhRTU4M0hXVFpScnlYVGx6SzBzYXVHV3dJdkZkc0ZuSDJrMi9rTjVQS2Nu?=
 =?utf-8?B?ay9Fb1MvbmFwWGI3ZWVaTHo5SE9tbFF3YWQ2M3pOZDJPbFE2czlhQVMvUVIw?=
 =?utf-8?B?NlBmQkkxN2NYTmJ4RTJaSGhXbGZ6bHZPVUlWeGlSeGtKNFVWVlBUajFoM3lX?=
 =?utf-8?B?QVFhMFNIbURFQTYxYTZsTk9YVDVWWkNjaDdoVmxmOE1oeU9hQmRjRHZMTjhH?=
 =?utf-8?Q?5moPwNzemX7mD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjM0M0lEZDFuT1JER0xTcUZKeDZEZlNtL3BEVnFVVkJVZC8wUWlmRXFLQXFo?=
 =?utf-8?B?TVRjNDBjT2ZTTklGRkNtaHk5OTdhRWg0TjBDSTN2MkxKUjJuQVpaUjA2aGdM?=
 =?utf-8?B?QnFLUXoxc1FSbFI2WTI4WGtDeFIrZzhFT3IwVkl2YTYwcGVaQ2xLNklrN2NV?=
 =?utf-8?B?ZlhGYXZlaUlmR2tFVS9MSlQ5b3pXbnVxTE1TU3pndlptTWdTQ1Yrd1dnUkNO?=
 =?utf-8?B?N0xaZ2Z6c2pVM2h5a0pnYXpGRnRqVWdPTUVXUVFzTWI0amxyN3VHUXByaDA4?=
 =?utf-8?B?c2tPVUxhMGFPV0luNzVWSjFqUStVTjlCWmJweHBBWUJ2MFV4SWxyTFUxbDhy?=
 =?utf-8?B?ZXNwbXhsWFlJbjcxZlhyL2hRRW5hUDBsQm9GdjNDT0Q5V1NqdDNWdURrQXhQ?=
 =?utf-8?B?MWMxaER5ZHBTRGJRanVmT1kvNG16TWVyZVRZN2RZWUYyN2NDVWo5YkQ1T1RZ?=
 =?utf-8?B?b1VMSUhMMGkrclpncFJJYXFUdTVzUitNZFI4Nnl2b2FDYjFYWWdObVhFVkhv?=
 =?utf-8?B?Vk4vUyt3a0E4TWhxODRCaXBBQ0xxSTFJMzVzby9jbkVNb0pQQmZud0tqU2tS?=
 =?utf-8?B?UXBFZlBHM1ZRdTZvdkl0SGZ4MGF1UEdlSDZCQ1pFeUVQb2R5YXpMWVZnZzFy?=
 =?utf-8?B?VHpVZElPbW9OQkJTeDlGeXBMTG1nMXVMT0p0aXRxek5nbEZSRFpBTkxhbmRV?=
 =?utf-8?B?WlVmaWhlRHdEUG9XWXFiSGJNeW96SER3Vk1uN28xMmZOd2NVMS9SODhaM2hO?=
 =?utf-8?B?Y3ZxbjlqUXpRekZseTE5bDhMU1NmU3NBNkg4RE9tZkd2c24vLzRRODd6QVBO?=
 =?utf-8?B?b0xFTTZUSkdXcVdNSjUwNGZVRDlTdkNaUm5DMkd4TkhLREdwVU1GSGZRclFF?=
 =?utf-8?B?Z0Q0QVRUeWk5S043dFFMR3BMalZ5ekl5bmZVakdWYlpXNFM1VXN1RVR5V1RI?=
 =?utf-8?B?OHhWb1pqeFRVc1RTTk15KzMrLzhxSnovL0RQVjB5TVZUOUpzRXg2UHRvZ0N6?=
 =?utf-8?B?ZytZMEdvb041dFV4SU5BUFlmZ1hNQUNXMjk2MXNUblliNUFnamsxUThJdG13?=
 =?utf-8?B?RWpvNG0zM0pFNHkxSlJwdDlHd05GbjRRbE96bzY1d2dvVlUzSFJCcjliN1Vn?=
 =?utf-8?B?OHdWcDRBN1BxakVVa21yQmpHS0xvL2trNTB3Z2dqMi9LUWxRdnNWNXNWQ0Jw?=
 =?utf-8?B?aGdyTnZBSENKZFhIbm1uVTJIVjV3NURjODg0VFJabk9YbzJUQ1FpWXZ0dDho?=
 =?utf-8?B?MDFKK1F4N2ZKSDNyLytBN1NDMFphc3JRRU5nVy9Fb2RxYVZ6UitNSHVJZVhq?=
 =?utf-8?B?YkxIakVkOWRLVE9BNWhmWGtta2MrYzJ1L2VseHlpWitVbThWajEySjZ4UHdn?=
 =?utf-8?B?Unp0aDIraklwclZSQ1Q0Wko5WGN2TTgwaVpHRUpYWnB0RGpua0ZXSlFadzgx?=
 =?utf-8?B?cnErVGsyaFRiRWZ6UzNhUEQ2V2lNQ0RBajZ6eHc0cTlLM1NNVktPcTdVTUpv?=
 =?utf-8?B?QUc4REttNW1wbFlJVWQ2N0lIaVV5ZGxlUDBuVmlsWFo0dWlwRTJJQS9xM3lF?=
 =?utf-8?B?SHl6d2YvTFFCN1l2dzhvY3d6ciswblY4VitrVFFTVmU1cEFQN1BFTUhhMmN0?=
 =?utf-8?B?YXZEMDl4ZGpDSHA2OHptN1J4dHRMVWN0bzRmaksySnU4TVdXb2VDTC9YY3lz?=
 =?utf-8?B?V0ozKzkzYnBZeW80OFpwUW9JRkJYL2RZZk9TalVTM01xYjE1YUpSQWxkQzBs?=
 =?utf-8?B?SGVmN1RoSHRxYldSTnhzL3FsYTNVY3BpMlB1Q0tsYzByMWY4NFdaMnVHOVcv?=
 =?utf-8?B?Q0FlMXgvejcwYTlYTTk0Wko3aWd0d09wS09XZG0va0p6bkdkejhSaHBzVTRR?=
 =?utf-8?B?YzM4RFN3SFkwOE1sM01QVEVSOS9ZZlZzOEJudnNGRi9FejFyR1ZFUGFNcnZI?=
 =?utf-8?B?Z0orQVhnK1k1Z1JxajdmT1FINFMxck05RGJDck9xRy9tclBFd24zdnhZQ3Mx?=
 =?utf-8?B?VkRjYlk4c2UwanNrZzFNa0g2YUkyVThTcUdjQXdIUzk4VnJ1czBkc210dzZ3?=
 =?utf-8?B?VFc1QmxrVWFRcHROYkdBVC9aMjZGUjlJQWo3M2lqY0JERkorMXRJTzdCa05q?=
 =?utf-8?B?NjZFMEV4dFpWcHZGUjF5Y3g2UWpRV1VDUkVtUXlrNnBDNnNjZ3B4VzkwVVc2?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5052e271-4098-4b3c-2ce1-08dd56291ab6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 05:47:49.9229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zgSykryZMbmNcKyzfKXUQsSAP78hQPac7SzFXz4aZv/OMjpV4RyYHoE3wnxXGho3ZdHayWVJDQF/QiIJWnrUzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6992

From: Jan Kiszka <jan.kiszka@siemens.com>

This was lost while porting to dovetail: Sharing between OOB interrupts
is also with dovetail still possible, we only need to request the right
type from the interrupt core.

Fixes: b1daf55bdfef ("cobalt/intr: dovetail: implement interrupt management, handling")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/dovetail/intr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/dovetail/intr.c b/kernel/cobalt/dovetail/intr.c
index 88116c7c89..342eb4cafd 100644
--- a/kernel/cobalt/dovetail/intr.c
+++ b/kernel/cobalt/dovetail/intr.c
@@ -86,6 +86,7 @@ EXPORT_SYMBOL_GPL(xnintr_destroy);
 int xnintr_attach(struct xnintr *intr, void *cookie, const cpumask_t *cpumask)
 {
 	cpumask_t tmp_mask, *effective_mask;
+	unsigned long flags = IRQF_OOB;
 	int ret;
 
 	secondary_mode_only();
@@ -105,9 +106,11 @@ int xnintr_attach(struct xnintr *intr, void *cookie, const cpumask_t *cpumask)
 	if (ret)
 		return ret;
 #endif
+	if (intr->flags & XN_IRQTYPE_SHARED)
+		flags |= IRQF_PROBE_SHARED;
 
-	return request_irq(intr->irq, xnintr_irq_handler, IRQF_OOB,
-			intr->name, intr);
+	return request_irq(intr->irq, xnintr_irq_handler, flags,
+			   intr->name, intr);
 }
 EXPORT_SYMBOL_GPL(xnintr_attach);
 
-- 
2.43.0
