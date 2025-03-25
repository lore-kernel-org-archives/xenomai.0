Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20491991B2
	for <xenomai@lists.linux.dev>; Tue, 25 Mar 2025 05:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742882384; cv=fail; b=oCRci4ZRo9lANKelYOQwb1dApbAxQOcYSw7ljcCD9udg/DFGXdVMrwVDxyNokxCVZjkx4/5dQiJktC2GYdozu0o9vp484A8W1iS/Af0ZT0OS+OG4w58pJYh4UL3vTZBtw5DtTgt2ltbpZtpPZ523qCtU1FFYsq6E2u4W/xOoUnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742882384; c=relaxed/simple;
	bh=C2RubPENlb4bhBy3pNRVPi/xRs1IGK5C2Vpcqm59BIc=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=f6PD+ztZFsWuX1S/aa5nxCtjarPuePpzo/9xt7qzMyLMe6vncsjvYGuZi4Bn9ujSg+VrXSrX6h4qJaolLKW6kFhA1AOLn8HqJHihOPtHbhaPVnCOzLtEt4Xr+9C5b9h0scIt1bOSF7MiahXOf8seNJlAHvvlRq94+LsgFFCaY/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=WVmBzym4; arc=fail smtp.client-ip=40.107.20.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="WVmBzym4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQnH4REApqo+f8shp87jOh3rXE2VoFrWJzVTS9r1U62pwE2KIB+/CmNECXvr4zwjeojAI1xPvk7jBF4r9SZI79cfPVYAzTkNr2y0kejmC0lY/YaMVbXwXfyROhgwQl89dv2P1tNDoFvyLjW9Yr8e+oAh95NX0d80xZ6vaY7OGIVRpQc6Z47Z0HsGGXKaeEKnUG79Dryr0y9cpxc/WChXyyFfeVtALQtkYwlpKJZTH9w9Txa/bqiuq/nHO/SKbBS3BjjKJGv/gOhlNvfkOXTruxXiTbVlmsqO2cYEK0TtSw+T0WnshNx/pVZ1wYtfJhqmo5DKMbXvBglISEcRLkW6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3dmtqT4ZDweh2vicQeDHDO1uoHLdWT22k47ZQqjn5I=;
 b=WTZ4mcpOlgVzdL7ZEZNxAxM+Y8sCZdSPRAVvi0fYTtZL2WJqr1IXlgeEyIg1yEv8Ungt36btnZLkwdg6xlBuzSuaeGaBoK0+FNHd2r9hfgQe9IN1b2MwikNKDHf/R34Gr0dOydojkQl4VAqhc72hak5l/e9lgyp+dHU+bStAQ7Gm3I8LFrge9rV0Y63Fuz8L22b2VgUAntF1erb2Y7kImTwD3c01ntnqCG6W4xNt5QzQbL8lRKYOkorYOjHj7O+PxfSN6ZQIWgRb3MXLaQHi8wJ+dkjFchZwk/uSmCrlAXPTLVc0bjOAeR396F9FgwSrwyigwtNLJBobisJ9aDbbjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3dmtqT4ZDweh2vicQeDHDO1uoHLdWT22k47ZQqjn5I=;
 b=WVmBzym4ISQ9mGYGcD5w46UNkO7TFxoDdsSDUWkFuUZqpefvJzXWq9OPsJQwDTradvlap2Szs9PPCFOwSvfmNM/+hJ/QCx/V5Xhs9jPhBlL6FjormM7JUuRRyOVNnF0zk6KvBomxqLISFqEfHvWhfayDfEyoqYFNJb8N5oX2zJKnH4PAZtV2ZBkRAGh7Ub93OFeGxlmSfUGpATDhywPo25OjNw3GG27ObkqgjocBxFCPzeFOlAnBGwD8s1yxdW0jvkfscF+Sg8OMqSOorxa7IA678JBUSe/G7+M1NgLVkxYcfHhmunHzgbp/f0yRv656Z3Mkxj5rwbLPgIca8hgLxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3861.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 05:59:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 05:59:39 +0000
Message-ID: <fda308dd-1e66-4753-a021-6369c9e43782@siemens.com>
Date: Tue, 25 Mar 2025 06:59:38 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] x86: dovetail: Fix inverted debug check in
 lock_vector_lock
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0271.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3861:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb14b57-cc50-4a05-f17c-08dd6b623b06
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enVNSkQ0Z1pBNHlnZzcrUllhYUQvZWR6NHlTZFd2ZnlrdnhNbGxvb2l3R2ZE?=
 =?utf-8?B?QU1oZ2ViZWlLL2hwYkdFZitoeU1LYmRrcjJtaEZIMVZoMkpZUlZYT3pIUEtL?=
 =?utf-8?B?NDBHTHg3eDJUektCSVFDY1pkS2FlMTlOVDNDLzdGdWRGMkV6RnFIWVdzaEtl?=
 =?utf-8?B?a1BEeE1wUmlxajVsemJ4UEF5NTZ1Z29OVnZ2emJaYys3akQrdDk3QVdtL0Q3?=
 =?utf-8?B?OUdIdG13M0xmY3FOanR4Qm42SjU5NVp4VHRtTHhjbW5ZMHhDSHZVRGlWamQ5?=
 =?utf-8?B?NzFwUTczOVlwb1VzVGJFZjFJdjhzUml4b3NDSlNzeGdJbHczaHpzTzRIdVUz?=
 =?utf-8?B?cFZ4dlVBb2c1NDIwRVpVUWNuOHA5VDVIUHhVN09SQnl6L0IvNUZjMUphbExl?=
 =?utf-8?B?V3ltQjlORjZsNHF1SWo4bEVmV0NPZjNzMnFWNGtvcTZCTWxjK0tLOVNrUXI3?=
 =?utf-8?B?cStXNWJWNmUzZzM3UDVOQm5CcDNmdDhLRUFwWjVVSGFhZGFjZktaWHZEYlRQ?=
 =?utf-8?B?Wm80V3VwOWFzbjBPSFlaU1JRY1NTTnhqeXFhOW95bVdkNERoOUllWGpCNEtE?=
 =?utf-8?B?amFodnJ1QmRoM2s2cU94NjcrRm0ybDV3RUEvMzhWMW9ydHpHcFJsMlp0RWQ0?=
 =?utf-8?B?bnRUSFRIMjdsbTRXTEhDWTRQMVJPbWtNV0daSGNaOEtrdXlBeDh3c2xsL0xk?=
 =?utf-8?B?TEhoc1kwRWxwQlM4WWl2VEJDZTJGVEp0YXQwMFJUQXdza2F0ZVNyWjJ3Zkxl?=
 =?utf-8?B?OVlJN0pZbTd6a3RoYmZEbThBdTZtRTZWdGl5R3FLU2ZFb0RvY3FOaVNoMGNq?=
 =?utf-8?B?Q3kwbmRkcjJoRnpvbGhKUjNnNHc2Z3UvbHFibXNEeGxlaXBkQnIrU1BScU96?=
 =?utf-8?B?eTc0Z1FESmNLY0Q2U1h0RG9wVG9FZEh1Sk1IbU1FaHVlbDYxd1RiREM5WThv?=
 =?utf-8?B?S3ZIaTR5LzZLdm1ZeEwrVTRLTjM3NnJldjlLUU8wbjZtcFhMTExKeC94endx?=
 =?utf-8?B?QmdaaThDL3Q2TkpIakZ1QUxyMkxxYVlvclQySEF1VUdnZ0dScWJvSTJUcTNZ?=
 =?utf-8?B?M2RIOHRVWUFreXA5bHJWeW1JUkVtdkFvTjRlMzJ1dHRqTitiK0FjMUpGdDAr?=
 =?utf-8?B?VXJ5R0FtckNhd3VtS29FL1Zrcnd2R1pyQmZ1ZmpuQ0psdThqZWJycjFpaDQ4?=
 =?utf-8?B?NEZteXN5dDlDbjV2TWphYmlmOGNuUnlEdURjVjlDZU5qYkduTjhjeTlkMEpv?=
 =?utf-8?B?bGd1UDY1Y2FJdjhudVNVSW5EVnlOZklLanBvOWw5Nmczc2NNRkIvaGxBdi9n?=
 =?utf-8?B?b2RKYTRsd2hyVVZrM3gwOTFkUm9nU2NIVzlXS2xSMlpXUzhXRmxOMnlOZisx?=
 =?utf-8?B?YllxcVM3SmRTUlZyaisweHN2TjBEWWVqMXFOUm5taFIxRDJmZ2x6aG52UHhp?=
 =?utf-8?B?eU1pY3JjZjgzU2F1ejk0Q0FncnhlTWdsc2FkaGpRMmFCdG5qbkwzenlOZTc3?=
 =?utf-8?B?TlRFT09JVUY2UU1kNE50MVZXT1ZOTy9xd1pQQ0lYVGJ3Rmh5eHJ1S2FKdnJz?=
 =?utf-8?B?d2tKWUdBcHJxK3NobzFLa01xclZSUkhvZWVQa2xmNmNkTWxES1FReFFaUjBm?=
 =?utf-8?B?bVlQdFRHVFd3TVc3TzZrQ2JoelZaZmVDdGowNWVOZVFpNmYzNjFJbVhjcUpa?=
 =?utf-8?B?VktZd04xMWVVZ0lpcFUxdUxibVFFTHBtTXEveDJ2UFVvK2ZUMkdFYjJuNVBv?=
 =?utf-8?B?Y0lvT3lMRVBuVlBoKzlnNFJrc3M1d1VUZGVFbXdhSWthbitCVkFxZTJFanpF?=
 =?utf-8?B?VUExSkhuS3dlMnFuVjFneUc1cGRBQUM2UFBIUXZVbXBpOHAvYzRsbmhaWTlk?=
 =?utf-8?Q?U+HofvP6/xAvb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWZOOUJ4UTlDb1F1ZFBMekFoSVBENVM5YVRTZEk5VTJLZnRCM2xUVzFOczAw?=
 =?utf-8?B?cXBuSkhNeHZnbTRHeGdqUjE1VGdrSG9jZDJ3SkZ2YjRjaWkrc3MxdE1lMFp3?=
 =?utf-8?B?bjJHR2VBNUw2U2lVaC9WeWIycEV0UHBDZk1KRHljazNIU21UZk94ZHZKQVc3?=
 =?utf-8?B?RjNlRjFVZDJ6V3B4S3hhSlh5c1REL3pJd0M4K2lUVjNFTldCVGxDanJySHdG?=
 =?utf-8?B?TlBZdzRBWmNiUHdiQ2NXNGJjcldkVDEwR25RV3RvT2taZHJ3cTc5cUhQMVU1?=
 =?utf-8?B?eGQ3dWthZEoyeHV6NUZ1VDE1LzM2OFgxMGRiWTZzT3dzbmxCZ1hqcjFhT0p5?=
 =?utf-8?B?dzZ2cTh1V3VRbC9NaFNha2E3UE5GdWdIZjVRVHJPQUtsNXJuNXdsZkd3WDBj?=
 =?utf-8?B?TWliZkdMRU5DQmlEUkVGeEFxVnBZQ1lPOFJJV2NiTGtIMGxUSjhpRUh5UDJy?=
 =?utf-8?B?dFNxT2xsTWdMRFpPdlM0Vk9HL09NNkxZdXRkb1RlR0lwd0lRN3k3eEEyYlRj?=
 =?utf-8?B?WVlCMEhiN0dWTmJMdEY2THpHM0haV2c5SmlNNW9IT2ppdnBHcXBrK3oyWkxv?=
 =?utf-8?B?c0dwZVRqV0Y4aW42ZTR5Rk54MWJSa3VmTTNNT05wcGVTbFZWMmxndWZBTWlT?=
 =?utf-8?B?Zm9tK1hjU3RKY3BxT1pORW9vZW84aGZCSlV5Slp0dXkxbERodHVtTjVLaW5W?=
 =?utf-8?B?MzRBK3I1bEJJcmJxWmNYNHBBcG9UNmN5bi9LcCs0TlYwVzlYb0Z4N09OdS9J?=
 =?utf-8?B?SXdkMUJsd1l4OHRVOUtpSzg2VFBPa3p0c0FZRi9ZUGxCTU13bkVNa2JmNW1H?=
 =?utf-8?B?aTdmQ2lTZGV4L0tBOTdQUHQzb1grN2NDN0RFS2F5TTAwSER2S0RFU0pXWEZ3?=
 =?utf-8?B?VjQvaWU4VkJXVHZ3UC9lTXhMSksvVCtwN2pWVktDQXh4RjU0VERJV28xUmIy?=
 =?utf-8?B?a1NPT0o1eG54cS9zcHlGYjRlcHoxa25WWTdkSlAyL21GL0FZRjhiQndvQ2NF?=
 =?utf-8?B?eVJFMU9UcHdZcFBwWnJZMndHVWI2bXFPYjlOSHNvaGJjTTQ1MUJra2NLV2Uy?=
 =?utf-8?B?by9Sakd0aFQ0cHNpSDNiaStUcWtabE9sV2VPUnlaWTlYM0F6dlppYnRRek5s?=
 =?utf-8?B?ZTdwVzFRWmh5MVI4dThGanE2a2pmcFJUL2FVNnpISlBFQUVSemdmVGNDV0I3?=
 =?utf-8?B?RGtIV0NSTGVkdlVrSWR5anBNYTdERGZsb1FjZ0RTeDh2UkdpZWRuSGR4L2Yz?=
 =?utf-8?B?UGJKVVluOTNVUXBzQnI3TkpIb3dnNjNnYk5YMGdBM1VjSzBBMWZ0Zy9idldu?=
 =?utf-8?B?bHZFK21FaHlLV3hqdXZYVS9zYjdkNlIwRzNMcEszR1I0aDl4Q2cwbW1wOFBB?=
 =?utf-8?B?RG0xNU80Uk1Fa3YxNHlHSm9ad2ltbDVGNWFvSnhacDVMV1RCL0FITlN5Rmkv?=
 =?utf-8?B?WGJCMjFtSmIrT1dXMWtUYTlEK3k0a1UvM0J0WHRhSFA3WTM5RkgzeC9uVFJt?=
 =?utf-8?B?cEJCbUtoOXVWeiticFFPaUlZMlZkSUFweklNdjg2aDFVM2lyaXBBR0tQVVJt?=
 =?utf-8?B?bUFmdXYzQ1hXenFUZGZGb2IzZlhwZnF3YWRtN2ZWRnpIM1hNMnVLQU81TDRP?=
 =?utf-8?B?dTVXT1hXNlFnWlhqNUYyVVVNUUhOemVmVHY4V1FqU2l0Z2Y0emZONTNkSlVJ?=
 =?utf-8?B?TmQySm1GdVBUc3pmR2x2QlgwREVwQkZ4b3dRS05lMUI1VTJtSlRiREc0REEx?=
 =?utf-8?B?SXVLTmVFQTNhMjhqTEw5U1RwVjNTa1lrV2U4U0pPWUpjN3JheTdvT1NWTmtj?=
 =?utf-8?B?VVR4ZUE4U2lYdGNwQmNtNjhFSEJSeEJ1VlpnYVVkZ1RlNVFGMmVNaG9lTUVk?=
 =?utf-8?B?SUNjRC9KcmR5QUtreE1xZnBiUG00RnI4Y3Y2YXppdUplZEEvMmVqb2FINi9a?=
 =?utf-8?B?Ukdnd2V6MllzMTVTSHBlV2ZmZkhJVVd1OTZ2Z2VZUWkyUWFCdjdhWmdkQ1Zz?=
 =?utf-8?B?TnRwNmlIYlYzSEw1aFZIanlyaHRjbGpHSTQxSU5FVFBuTmdnV1VMVFVDZWl1?=
 =?utf-8?B?R2ZPTEpzOXByenJ1cHlNekQ3STJFTFdXSU9lUnFIR1lsQ0xkUnNKWVZzaGxw?=
 =?utf-8?Q?L8TWXAak9eVZPRYOvMcUDxGoN?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb14b57-cc50-4a05-f17c-08dd6b623b06
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 05:59:39.9142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13xCUAZYqNouhuUOirGJZ5T4nsswq5oFW+zgv3h8yHi5/4dELio2eVfoNDGWEAbb75NjE4sMwx79YL7hHqubiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3861

From: Jan Kiszka <jan.kiszka@siemens.com>

Code and comment were not in line, but the comment actually makes more
sense here, given that unlock_vector_lock will unconditionally reenable
hard IRQs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - spelling fixes in commit message

 arch/x86/kernel/apic/vector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index a08b0dff066ac..af60f138d590b 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -142,7 +142,7 @@ void lock_vector_lock(void)
 	 * entry. In addition, we assume that hard irqs are on as well
 	 * (which is the regular case).
 	 */
-	WARN_ON_ONCE(irq_pipeline_debug() && !hard_irqs_disabled());
+	WARN_ON_ONCE(irq_pipeline_debug() && hard_irqs_disabled());
 	hard_cond_local_irq_disable();
 	/* Used to the online set of cpus does not change
 	 * during assign_irq_vector.
-- 
2.43.0


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
