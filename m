Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F155183068
	for <xenomai@lists.linux.dev>; Wed, 17 Jul 2024 19:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721245278; cv=fail; b=Jmuh/rlX0dPbCCa9jbfBoGNjAOa+3wmV2U1/0AUjZCzck19wBiViNAUuLarhInlkQzp8fyno4enkTHMk18Ils6tHqYSPVdVh6FXculHYF4Daesj+SPd9CysjEslUasARLdye2XFD7fIN8vn7igmrHJH1a/jGqu+HKfWlGAci0I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721245278; c=relaxed/simple;
	bh=Y00Nzcv6g6BPgbjAMpBbhOrfc9yz41SyCy0+jNG7K0g=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=t8YPahczb0T4a8TZY4lJPRWdXjOvsCjQOd2PnInWJsY9Mcu820IfTsUpyu5Q9xwYAGgwHzAl9tJ6MVuAfNSzu0gZ0cTJKponofO8ry/BBfKqXU2BHGmsyfBx+CNEfMgkNSaNPqfjxRGa8x6UBwgZBPva4MtTKPJrNN/8JeRkI0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=alrXSLcY; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="alrXSLcY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4x8OMvQUDqrkdNUflYxsXWw+JEkdxTZjNOetk58xLHhqU/zSuyVc4QJVkq4e7Aw1lsyXnkmcSgauAf3I8fSr6T7c7wn8jIdHBBmIOMMb0wa+Q13j2R3tVcbdq4PkqlfP0Gc+i27jlvP1kHvPWstcb07Z5fv/yp/vDw2p5ohnchDIwGdt67B6ZI0SVB6GEQnCPshCE3oqZKkAOepUX3MCv+HPCzLkwklVguntZ3fIAmdIIC/rN7EbXkhpDk1DNKrI3a8BJnMj0OcSNuBpVi//Qe5cxEdnMjOPlaZJr5MeaSCbmixxVFCcMw4fygZT4+v9jLf8/LVAhAfid+o1QTkEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pUbTO5/aj1Qt4kT9JqM2yd0wq148kusqe7GPeTz8TY=;
 b=OrVZPj0kNSP/y73ADQY0dZWHt1uUe/o7wHD95dTcL1UXW0l4D5Np2OeWhB/dZBOlrBT5ywZ1QkI21fPAWovGD54EKuszdu2tX+Y1twBXxPUHGWcXwM2yBq48FbgUAz2gULhGY3OPEPvqZ3ON2Akjzqp1mILnx0XtKKHepLKWQTwGlCyVTd80qlC7sQrLHXzVmey/FnI3pOO2oltq0nEQJ7XeyHocqvUoCx3+9NplHkcyE6rqZtKXW8eOVtODDiPXITSwX86A9tOU+UIHuNnS2Vu4dCtFXRJo8TVTk25K6KXZKVdA0fxAMJ0xK70aWs2UxDU2cdpLtDAd4tW9YVm/MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pUbTO5/aj1Qt4kT9JqM2yd0wq148kusqe7GPeTz8TY=;
 b=alrXSLcYfMCVNrdm3ke2Tuf7IJSjPMwcZMTcyXkpm5cg0Z0wVgV0s9pqd6N0fNOC0kTUBNxuaHh7ZF9ddTBYicnYUYdiwBeCYdKX13oNpimRMSCfN4xtigyEQtWFDXx5cQAinhwxS0OBJ0cQaYdfxa7adDRXWJ902mFSj5g7Kb6zuq3hf82lLtyaKXFNxsLJ1bQdND2PJdvTpfKSTdOI6hR33UTE4lJUQRq2eVifges4T39LrR5uZhtau/R2RKyTwWusCCSmpVKsU0yTZSXq10Ntc2+R4/W7gMMFkogk0+DvLFsirRLgitpp4eSj5v1D9y3RxRuihESl98WAvHqMtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5834.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:391::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Wed, 17 Jul
 2024 19:41:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 19:41:12 +0000
Message-ID: <0199a41b-f42e-42f0-ad1a-b59e90acd2aa@siemens.com>
Date: Wed, 17 Jul 2024 21:41:10 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH v2] Update isar revision
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5834:EE_
X-MS-Office365-Filtering-Correlation-Id: c937c5f3-fe73-4158-c367-08dca69869f1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2FOZ0xLTjFMbjk5SUtxSC9pU1NMWUVRUzNXOU53RW5ZZEpHR1luTmhtOXA4?=
 =?utf-8?B?S0srTGhZMFU0ajg0MGszNG1Ua1NNY21ZWjlvbjQ0ZWNST3J4MUxFazc4cno1?=
 =?utf-8?B?RW1KcEk3cDJscG1GeFR6cUFzdUs2TElzQ29vQ2dtdHhWbVNxV2syaitrOGhD?=
 =?utf-8?B?a0lpVFhSZmZySnJCWnNuUEdsdk9wQi9DQ3hPSE5HTDF5ZjNRbzM3Y1djT0x0?=
 =?utf-8?B?Sld3aHg0OWtkU0V4bjlRM2hNNGRGNklUNFBhNFptUndTZ0padGhnU1lGT3ZG?=
 =?utf-8?B?MEF1M25MVTlWZHpyZDFlWDlxUjZ0K1hORFlPOW1NTXR6NU1IQWhubXduZEEv?=
 =?utf-8?B?OVgzNUEyUFd4UXNjWERYWTRlSFBTQkRkU0RxSzhhS3RuUHRqS0JJTXpSV1JT?=
 =?utf-8?B?Nk9oL3h1WHBwQTUzcTZLdjMxNjB3dktlNVBQUWI1clIybVpUdnBsVWdrZVFl?=
 =?utf-8?B?R1NWVmNwZHg5MHJqK3lXbDlzM242WDlxTGwvTWRXbmFKaXM1UGRLcnpvS1JD?=
 =?utf-8?B?NVN3dENkbWNaQ3dtNDNHZU0rYkZtRzl5TURjNmVGSlMvc0pEbDNPVmttQUhY?=
 =?utf-8?B?b3NUa0M2ZXRGbWlUc3lRVFpNRG1tL0RlNEJzeXUvakNTMXNvNlJHUmdKWUxF?=
 =?utf-8?B?U05KNFBLdi92ZThVMFdBOGc0TmsrOFFsd1BJZ0tQRDdMRHF1L01EdVNacHdU?=
 =?utf-8?B?dTZSQUZUdzJLRUNZZnZCUTRMTE01bkdjT0pPUU9vMEt1RWQ4UmFVdXlsVTdm?=
 =?utf-8?B?SXE5a2lHYlZhb1hSRklES2MxbXNEcXdRZW1GdkZzNUd3M1BHdHkrL2ZOUDVS?=
 =?utf-8?B?ZWFGNURzbTBlaEJWeWVvVXppdTloK1Ntem05QkRBRU9LWHRKOUpkSzFxNUgv?=
 =?utf-8?B?eUgyaHArNStJM2NCSmVEUnFDWmszWFhmcmU2d2JOek1ldGorSnViaUlDcktD?=
 =?utf-8?B?UUVrZDdGMVZVMWp3N2ZobHQ5UGR1WURlOTlBMXFUUjdLVlpWNit6cEUxMkhN?=
 =?utf-8?B?TjhVZTFwNFRBSEtwUGNMaGpaWkZaSzYxOVBWWW9wc3NzcERjMXNpQW5jcGdZ?=
 =?utf-8?B?V3dGems2Zk1ONE1SMTRSS1NXaFNEZ01TbXpkRGh0UFZEWk1XVWRhNHhvYjhZ?=
 =?utf-8?B?S1pqRldXRWZTVUcvZ3MyeWx6WTRXSDlkaVp1akdXYUdjZTVSQWJuTE9pRkF2?=
 =?utf-8?B?R0p2MXYxV1ZMTHV3WVM1R29WN3I5Tk5QeWZNdjExRDNHZndkZlFyR0xteWli?=
 =?utf-8?B?TnR2a1N2T1dSNVVLZDhGMUdCRHJ5VDZIYUkwUUtOVFF4Vm1iTElsWm5yK0Vr?=
 =?utf-8?B?U1AxNXdnTzNWSWJQZklOdEgrVndOK01YalF5dU1UR2Q3SlV2SEJsdGpXMS8z?=
 =?utf-8?B?WlZRS0k5OEljZVZPV201R2Fsem1hcGZqTnArazI2U0xUVklsUDNUOWVpM05r?=
 =?utf-8?B?VE1DaWFyRUxxTWMxMEtrOTFDRmlEM0krbVh2RlFjUlBmd2RqditWNEJ4TWZB?=
 =?utf-8?B?dVpFQVA1SUlVV0dxTWcrQjZ1YkthTTFSMFRrckt3YXRkeDdRS01UaDFiRjlH?=
 =?utf-8?B?OEJ3alFZdkNrb0JDSHhyellHOGJxODltOENMT3N2NmNSQ1NPKzdwLzNxeGtP?=
 =?utf-8?B?Nkg0L2ZIeS90c0FuS085YTdzb0RqcHY1UDM0eklNTHJFV2RpcWFhODB2VjU3?=
 =?utf-8?B?b3BFQ3E0N0Y5dUNSVWh4ejdJVmVLT0hnblBCd21ZRTFORGFlRFFIeGdtbzRz?=
 =?utf-8?Q?j2pHOSSf+VxiDvVjXc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?My9Sa3lVZVE1RW9Pb0NlYlRmandkZUNDSmo3bURvNE96azkxdkxwaEJIWlRS?=
 =?utf-8?B?Q3FQUmN0UFltSEM2RHJGUS84ZFVhQW1vaE9iek9iOXQ2N0pPYW8xUk1FaWYw?=
 =?utf-8?B?MmNuUXRUcGt0NlVXRUZJSlRmT1ZRZXZvanBwUFhQdC9hVVZldlBXNDhwYjlF?=
 =?utf-8?B?c1ZiMG9TZ3Y1dGdnRjQrUDlxRnIybmhTMEZ0czVHRUV6MzR0azJtQndmT3Zm?=
 =?utf-8?B?dTl6OTJTYXlSQ1NhcGxaQWJ4bVltRllpbXRPWGJobkc3bGNlZnp4U25lVzBL?=
 =?utf-8?B?QWRRODUzODlhbktwTWxRQ1NBek5YcUxJM3RWNlNZdllEa2I1V1pkeU5PYnp1?=
 =?utf-8?B?VDI1eStReDdDSE9TMFV4ZVp6YnJEbzFaQXFVNVhyck9tRTh5MmtGbXhCY1Ez?=
 =?utf-8?B?bUdiYTJUUGs0VTYxdTAxcnhtSVVYS3ZwQXlyOVgxb2hIWVUyWUVIczFWQi8r?=
 =?utf-8?B?TVJuMzdNbnpSbTZUMlhLMGo1SnVVZXlaM2xqMXpoeHhYOVVRSWx2N29jZlJi?=
 =?utf-8?B?V2NIL2V2SnlnRTg5TnFDdFBCaXFFc0F2NTRYakViUGo5aGNobjVJOFE5MGpO?=
 =?utf-8?B?Mnk4NDc3Wjg2cUlreFJGbTZ5dmZDK01DS2l5L0daYkkwWW91a0xGR0pPanJs?=
 =?utf-8?B?bUJpY3ZEVzhKME92M1BpQzN5YURRc0M4czhrZEdaVDE0Rm9ZeEpLZUxVOEx6?=
 =?utf-8?B?Vm9rbkVtY3ZLRXNXWTNWVkdRQjQwUVhhUTl0aUUwVG9IbUhjTzlpQ3FVM2Ft?=
 =?utf-8?B?MHVQZkt4WklPanBrbnUvcWVva093endGaUw2VkxGUWFHUUdJL0N5TDlJZ2RJ?=
 =?utf-8?B?SnY4YlZFaFRTdThqM1VWMWFEYllnbk95ZEtqajZNZk1kZE1QV0FOc0hDWUo2?=
 =?utf-8?B?S0t6Z2h4MnRPZjdSZnRWeE5Wbmx5OC8vQXdMZ05yMndnaWgrVnRxbU5MNmlH?=
 =?utf-8?B?QkRkNVJXdkM3OWhNUWhXQi9EcFFYck5SM1haRnZZdDhBb29QeTZqdG92dTQv?=
 =?utf-8?B?bk12SGVURXJ2OUdqVmlGUW1qZ1RoZ0R3WVNocGdmVlhSaXo5NGhSQ1BLZ3lR?=
 =?utf-8?B?WTE5ZklsaUZ1UzZQN2xzZlVZRkh5ZVJkQnp0TFpnVDFHajVMdlJhcE1PeVdp?=
 =?utf-8?B?dEZ6RUkxaElYN3dQM2NVSlNDT1VLWTEyMDc2NEVmRE9qeGcySXhFZmRXZkZH?=
 =?utf-8?B?R1hLVVNWNytmWXFLdHZOdFQxNkU2ZW5YZTlnRW44NmZKTFNNaWlxODE0MHEv?=
 =?utf-8?B?cDMrTmFEVHhOWGNlaVdvTlVWRmkvTFVPcXpmMTNHNkxHVUFYUCt2Mm1ORmVC?=
 =?utf-8?B?VzlyUFdJM0pLV1ZOUVhOcjczU0wyQkxDVUR2SDUzTXVuZUVrc25YVXl2TGQ0?=
 =?utf-8?B?TkhLRjFld0VWYlJiNTJDVUFXNWpCMnJtemp1OWZHbzVBLzRYa3hlVFBRUTQz?=
 =?utf-8?B?MjQxeDVabGQ0RStGZlZUL3JwU2ZweU9KZzVWazEwdkdqamo3dVhLOW5lTlRK?=
 =?utf-8?B?L1Z3MC9iM0I2UXIwMVdjbWZscndrUnVkMUR5U1BuWnNhRkw0clFhbktsdFpI?=
 =?utf-8?B?YWFvMFZIUkVkZjlDQkNiWjdJay9EaEdmdEJZS3daL2tielFVR1ZnM2RhVzZk?=
 =?utf-8?B?UFlWdWJVTVdxTnFrQ1E5ODUwb25HNFd3WmJqMGxsSERZaytsU3NMZTBFdG1k?=
 =?utf-8?B?U2hJemtza0d5SS82ZDZCQy9RU2ltUmtMN1haTTdtZjllUlp0NHFBbGpHQ2ox?=
 =?utf-8?B?b2JwMit3KzF5bDErY05QR0lFYWErSVBhV2M3R2tDSStNUGhLcG9vb2VWMVRB?=
 =?utf-8?B?andObE55anIrSDVic1N6RVBzZlpzSXIxTnhiU3lNbjQyNTlQRjRvRW1qSFha?=
 =?utf-8?B?S2hRVWp5dGk4VTF3dGtnUW1zUkVVdmxtVDFCaXZERm5FYXB1Y0hCYWJGc2Nz?=
 =?utf-8?B?cFdCQ1pxdUlLeVQrVitPdGlUUURLU2pQZWp0U1A3VVFJTXN5Q3NPTktkN3VF?=
 =?utf-8?B?em1pbjJsd01ybk84K3UvNkFVWmhFWVBKUnArb2t3SUV6RXlEanV1dnVrZ2Rp?=
 =?utf-8?B?bEllZkNwYlh3OGdIMzVTQXYzcmJjQS9xak5Sc21KR2RIMTlOSHhpQ0hFWExh?=
 =?utf-8?B?RHN5ZlRuWWd0OUFmN3Q0TEJVZjZCckh5TTVqQmZTODFqMFFTU2ZDbmJPNjdM?=
 =?utf-8?B?dnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c937c5f3-fe73-4158-c367-08dca69869f1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:41:12.3135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rfi1wJOgJW6tMuvkRpH/MLkKY6FaITItXt2yCajkd95q+a00oivxqkGAhiW2RepSrlXKTM27RiCSnNimYkPM7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5834

From: Jan Kiszka <jan.kiszka@siemens.com>

Housekeeping, almost no impact on us. We just need to disable dh_strip
for the RPi firmware after the generated compat level was lifted by
isar.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - dh_strip disabling for the firmware binaries

 kas.yml                              | 2 +-
 recipes-bsp/rpi-firmware/files/rules | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/kas.yml b/kas.yml
index e63bf3f..c0cce41 100644
--- a/kas.yml
+++ b/kas.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 962a4ee24854db8b3cf0ff2499e26705f54808ad
+    commit: 1372f428223aea046e8efaa04202093d0d73c52e
     layers:
       meta:
 
diff --git a/recipes-bsp/rpi-firmware/files/rules b/recipes-bsp/rpi-firmware/files/rules
index df0582c..0b39414 100644
--- a/recipes-bsp/rpi-firmware/files/rules
+++ b/recipes-bsp/rpi-firmware/files/rules
@@ -3,5 +3,8 @@
 override_dh_auto_build:
 	dtc -O dtb -b 0 -@ debian/aliases.dts -o boot/overlays/aliases.dtbo
 
+override_dh_strip:
+	true
+
 %:
 	dh $@
-- 
2.43.0
