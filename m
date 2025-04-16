Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012055.outbound.protection.outlook.com [52.101.71.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63979347B4
	for <xenomai@lists.linux.dev>; Wed, 16 Apr 2025 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791139; cv=fail; b=ojmclkzWwYa1mmePw90rdP2Ltx4cOk2sBE4foZamVCXVgacM6tORcDqLmPxw9UN0CjMkclJizL7p6HdTwmXMAHN38HljK45hNwHPBKr1O1EAi+1AfJteAioeqpj/0FXtf83T7/fwe2E4ZYTos5loa4gk9ACz05D3KCMr14M7v9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791139; c=relaxed/simple;
	bh=0arF02TVR7GPwdicHLXH8C6n6ReNCZNuxDcXUJ8SJ4c=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=tO0/eNsAVW7jRRrBXGW5nfLH2St6P07MVuCqXO37MecOz7BIJh4qGegNlsyNYojfeuEX8X07M9demhH/McpXiuXJh5GVpEhPrva0px/XnFq835zTbkUmkDQlsDWjEgMAPrW45vIUf7Kq6MlxFz+/wC0XDcQjcCd50wW+v0mIbqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=JD6bw/AR; arc=fail smtp.client-ip=52.101.71.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="JD6bw/AR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7Ua7L7Hyuc82yJCbFo7pMU7n7NxedxJDMuwIzbjJaUdpIO99Yu2ts/LtZa+T0/OBy28mEu8boqo+hVHKVER4YIn1Mhqsb9/KHmV8F6fJqYsJijRjuDW9YXS3HwQAZCWHlk58Ha7VHvqiLcJdm6KKl+Wdd3L+K5FFPvlpMgoR1aaUvPDNCx+dGrbVUmoY0jN2Ye9OvculSMdpLxiGLIudLquYpmylHAAnqafw3qPaIZjoFW3enYhTHL/oUhtAz5LdTRPaCtem1wi1Fd1pgmj2m7ANRCLg65BIXfuLHX2wnxFAsra+1iiCV2rrkFN/kFvn7lGgFoN1S99BaW56l1r5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CN+7M5NTNASJKWbeyZgQcpcWXpixmTUNoTBIye2xgxU=;
 b=mYGpJwMnqlETa4n8gIfsVcjmwVihDIVjEyROD4DKq+AMZKu7cE+Z+eHgLbk6TKQCv5+smYRUS9cHGOfeidSbEa+pt2ABtJ6VDHO//1tZC8TsfXT/jMdc+8SzoZrluSJYhI8hBSzS1mv60l6ZfDYC1+CsZoRoECmsif0P7JiNcbh+OJgiChXvkDDtgU0vbTjtc5y1dy7QxdwlcfO4/yiBALkFkJgmmr6oRRUjsPWUPIhbTKFsDIBhRJ1Rh3iq/Z2dAL4R2SnD9HcNGB85nCH1K5csUYa/dSKp64AaB+lms4KEqy6L1qDzVeIACnbO/whxB6ol+BXKzovaxDMYnj0iuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CN+7M5NTNASJKWbeyZgQcpcWXpixmTUNoTBIye2xgxU=;
 b=JD6bw/ARK4t3Maby6/ETOI1N8HHakhZAJpjFkOin3piUFq3yt2Aq/NIrBX698xd0JIFssmX5eo8UPw3R4UYNBsHqZUEG1dys8L6fL9gO0k/Id00vf44Z+lkbxuRjGvCzoKKGUSlvpZ3bmflRmEggwVY373YanT005trIgCGItpWNrvpV+b+QDl1Lrwz4rpGjIqUEyEhCux6fTWT8zS6y9XEguHuT5rMjGM0oLhI3qKoJIJjbXk1lbxBQXaL7ese12KBQkSqwZVwGlz5rK6VRZMibkiW4VMSk6rkO5rmqERMJwznuRSd7EXts3uKbWn3RvxPp8k2ChL+QecC5Y6ChdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM9PR10MB4104.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Wed, 16 Apr
 2025 08:12:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 08:12:13 +0000
Message-ID: <f9de24cb-1c80-4880-929f-20ddd8fc6ec0@siemens.com>
Date: Wed, 16 Apr 2025 10:12:12 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai 3.3.1 released
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM9PR10MB4104:EE_
X-MS-Office365-Filtering-Correlation-Id: 51281d04-ff2f-4ff1-953e-08dd7cbe64c6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0RhR0VPUURscFh4eEE5K2ZrU090SmJtZXhPaVhXb2JHMFNGdWRDeHQrd05r?=
 =?utf-8?B?ckZUZnRTaWdLR090RXEvRGdlaVV6a0IraEFITWJoZnVUbzN1L2dUZ1l2SWd2?=
 =?utf-8?B?ODE2bHZyVGxLdFN3Z1dxVFFBcjBFZStCb2I4aEtoMDQ4aDVyZWtjckRyaG0r?=
 =?utf-8?B?c21wUEVMUEhkTlRYb1dmVnpwY280a0ZCVGd6QU00alJTSHNXTE9BS1RkUW55?=
 =?utf-8?B?by9kUU5wOC9qOHBQNVFUTnJKeDZJZjlOem5pN2YrRTNJUXdRMEFERWZwNkND?=
 =?utf-8?B?R0xVMmxKTFc1VldKa3EzYlhwcER5NGJ1VVFQN0RPWlJKZTZydTJPTHErR2Iy?=
 =?utf-8?B?UzhSdUZ0MzJNNTk2MUd2a3l6NmRQWCtpMlV5WG9mV3ltaFpldmVsVkduV3J4?=
 =?utf-8?B?My9URGhiRjBiTk5yb3Jwc1MveE5lNnVrUFNUR3gxRkZSSTI5VlZ2OVNqZHUx?=
 =?utf-8?B?bVQvUSthakY3UUcyM0hKN0E2Y3dHT2FwaWJPZkIrQy9KT3BrZ3JibVYvS29Y?=
 =?utf-8?B?ZXVLbmxPSndMY0gwbTQrTUFaYUFLNEJUeTZCT05JdldaY3VJS2xZemptNDhI?=
 =?utf-8?B?NThIMlBIZXVGKzlud2Q3SDYyNTdxaHl3RitJNTRnM0dIODlkNmF3WW9DenlY?=
 =?utf-8?B?UjZVYVFEbGNRYVZsWmZ3NmI1dmRPNENjdG9NdDhJd256U2R2K09tQXZVQk9X?=
 =?utf-8?B?YlFDRTNqL2U3QWlVTDA3OWZORXpjamVMWVJ5RW1rdkh0YmtrR2xXb2pLb1Rn?=
 =?utf-8?B?WkJrZ1RWVDhNcEYrWEczZURGOFRad2FHVUU3TWtoN3JXNlB6KzY5V1Y0VmJh?=
 =?utf-8?B?V1k2d2RRSlhoenNUaGZ2K2paS3puU1E5dVZPU29oYzg2ZTBaaDloR2x2UHIz?=
 =?utf-8?B?RHFzTXVrSkZidUpqMHZZV1VxZXNjYVdDYUI2bU1OWkdudUc0VGZiSXZCYjlE?=
 =?utf-8?B?dVMzbUxNdWNaNkxBV1BFd3VQRkZuMXNxMmJqZVFtZ09ubG5jWVMzVXhueXBx?=
 =?utf-8?B?ZmJkMnA0TFJ2anhFaER5aFhXUUhyaGM3eDljczlSRTNMNHZNU3lQdkNzTjcy?=
 =?utf-8?B?bW5PUHJCVVZVU0g0R0lrSnBrdlFVTlcxV3MxY0tEUzVCZkNpeXk5eGxCNHkv?=
 =?utf-8?B?d3NhdzZPaXI5VW54c2tSWXVaZllsQVZJTlVROXptUGJhWExpY0NNTTFXY1RC?=
 =?utf-8?B?ekgzMHgvWjk2QnJKU2ZHT0NORVE5clE4dko2MXhiSUsvM1VrQno3dGUveTYw?=
 =?utf-8?B?R0NJRkZQRWRwSkxwQ0F1YXJ1bXZPSlFicjU4SHZSYUJRQnJBUjFoRTlIUXBv?=
 =?utf-8?B?b2hUaStIenlyVERITlEyUnlrZnBRNWIzUkhIZnM0Mk1MT1NacVY2M0ZDQ0Q2?=
 =?utf-8?B?c1dpZWE2eU5haE56cytMdFpIOEM4RVJmT1BYTW8vZFNHY1lRTlY3WG9salhq?=
 =?utf-8?B?bWl2Um9Ha0ZNWXlaVHJIMlZkaDZIaENPTlJVNHpGU0x0RzZrVDJ6dEcxWXRR?=
 =?utf-8?B?ZjVEcEY3Sm9QRGphMkZWUVpVaFoyaDdzVFhyd1I1UnVUUmRiMU5rdXJ6Skpp?=
 =?utf-8?B?QWZSQURPcEpnVTZ4S21ObVVsbXRCWEtqTkt5YVMxdmZ5MndmcDJJWEoxclB0?=
 =?utf-8?B?QXh6MmxNWm9jKzNNbVlLNm1YK1ZKS2F2M3FKSDdRVUdKdklQcGVWZUEzVGdG?=
 =?utf-8?B?R0tzTndKYWtwYkN5UFd2YUYwdCsrWkF1bjhIbWo2Qmt5N3hmM2FxQi85cGg1?=
 =?utf-8?B?NDFsL1BHWHFnZTZQdUNzalVmL1lCUGRHUFh1aWpRS2JGUG5Jd3Ezb090cUdk?=
 =?utf-8?Q?R3Gp6TTO6faPcVnh77gV/59c7BvD1vBk/myXw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEdmU1F0cVNGeDYrczlUd08wVG40eXEzeXFXNUhLU05IUjNxY0lndFpXbS9z?=
 =?utf-8?B?V1BxZU5Nc2ZCekpsNStJT0tzYUpPQ0plWmhpc2F4RERjbEdheGlKcFBPSVhE?=
 =?utf-8?B?L1habUZCQit6MlVGTE5xOWxaVHk0WWgwSnZUOTNqK21nOVZZN0RHc2tsNitH?=
 =?utf-8?B?SjBmYVFPM3Z0MjdYRW9BU0haelkzNVlYSjk3OTkzR1JnQlQ5QkNaTGVrSjJz?=
 =?utf-8?B?dGJsL3pEVTdUTG53akFnOWxkdEtuZ2YyajcwOWYyc1c4S1VDa05ZR1NSTThL?=
 =?utf-8?B?ZE9naHpQcDNPUzMvTTV0ZEF6dDNpamJ2N0Y3UXYwblc0azV6M0dNQ0V5Qkxz?=
 =?utf-8?B?TVBQVk9uQlJweDJkV0RpMVpMK2lCREJheXBsZXBjblNid2VWNnkyNWtvWFlJ?=
 =?utf-8?B?S29xRW5laGhQL2p1T0Z0L0dwYzJvUTlVdlByd2pYTGsrQVl3UmdtR2MvMFc5?=
 =?utf-8?B?czRXR2szeWZaRUNDUlpnSFk1Q1loSHNCb0dsSG9sMmJ4UmVKSThBZFlNVlMz?=
 =?utf-8?B?VWl3UzErTFRKUUNzcmgzRjFDSTFvNDNOUnFBakRoQVluMjN5MWxQTmhySU56?=
 =?utf-8?B?RU80OVZVRnQxODJNcnJrbXdNditodlN5bnAycDFCZGVFR3Y2WnFiWktJTGFN?=
 =?utf-8?B?SGpzcWRPa1ZwSXhScFV1WkZJdUpkbjNMTm03MEtaUzlMcGZGSVNWdXBhRVIx?=
 =?utf-8?B?RFFzclJuMlR6aXRzNUhsTDZEMExCeGVHakFBV1FQZDBTTHdMWnNmN3JmK096?=
 =?utf-8?B?TUpQekhzbWdrYzRJaDE2YWxXNWd1V0NXS2Fadjlaa0tzcnJ4dnhwSmgvR0Qr?=
 =?utf-8?B?aXVUZS9LM3UyY1lZOGhOZWJmSGJEREZ3ZVNFdWE2MlYzbXMxaGNVb3I2OVNh?=
 =?utf-8?B?akErRFFxQ3Npb3VhY1F5WFJRSG5mbTZPOTVGWDM5bUpQd1VnUFdkUnU0Q2tQ?=
 =?utf-8?B?cmhqVWVpQzR0RVlxaDY5VVpIZXlWQVZWNHRqaks0bDFkVTBxa2V2UDArTzVZ?=
 =?utf-8?B?b1kzYXQ0eEt2cGxPNG5PSG9XTDlTQ0NLNTVzNllhN1V6a1NoQ0lZejNualU0?=
 =?utf-8?B?SDdEN29mbU5mMXdSN3ZlWFk2aFk3L2RhaTVwdHA1bldqVmFmZFVNWjZxOWcw?=
 =?utf-8?B?bW5qU3lMTFJ5THFFaUw5UTkxYkp5d1ZIYmpGU2Y2NkRwamFJaWJQbGViTkcw?=
 =?utf-8?B?SU1lVTE5VXRxNGdnZDEzdk5CM21CQzIxZW1IUlRRTFRVSmtqK05vd0lOeDlD?=
 =?utf-8?B?RUNDUTBmWExEcEhaYjlYOUpuemdNUitaT01LZ0NqejY4N0hsbmVvSmkxNjhF?=
 =?utf-8?B?ZDZBVGdtNUplNVVrN1dtZ3NLTExhemlCNXkvbmlBMkMzSFpNd3d4SWxncksy?=
 =?utf-8?B?dE9VZEhrT0RpWGNqcWlkeTdtUlJYUlNmcmwrcWFMQ3p5NDgzY3FaR0ROUXh3?=
 =?utf-8?B?RHNGT2ZYdnVQLzhPc1YvZFFlZ0F2OHBPazhCU3hBL3lUUldtSk92c3hTa1Y3?=
 =?utf-8?B?QUJnd0owbWZjZ0Z5QjZBZVVyUFRacXBKT3AyL0JjaTJndzJSMUowWFVIOHNi?=
 =?utf-8?B?RFV0VnM5UjJnSTVMN2ZUM0hjRnJ4TEM0OCtPa3IyVS91aEN4SmQ1a0hySW9V?=
 =?utf-8?B?S2ZoL0hQSVRXK0RGUmdXTnZiQlFYMEZUTnlQMjZ5VEVYTXF0VHBNK1RvZzFY?=
 =?utf-8?B?bHFjUjlJRFhIdzhpbVgweUVxenZmTWk1U3Vkc3g3RFRLMmVuTVJTNlZadG4z?=
 =?utf-8?B?ZUNxQzNYTC9uakg0ZU1GWDNEMkJTUG40SHhVbHJMMTA1eEF1MUFwS240TU1w?=
 =?utf-8?B?TVh4K29rSnU0Rkt1RDNVa2RBa3FNRnl6MEtzK3Y2djVZWFdrRXRqVTVNTWdu?=
 =?utf-8?B?dWdreTFteEhsNnlvZVYxQVBNbzdRUkloV3dYbVgrZ3ZuUTE0K0NhWG1JZkZp?=
 =?utf-8?B?SXdiZS91TzBuM0NWMDRkUU5aYXdEQzhuejZlQ0NSZDh1aG5ZcUFYN3ZFd05C?=
 =?utf-8?B?RWZ5ODUxaTdhL05xRDZaT0lNZG9ETzJYamJlb1NUMVA2QS9YZ3E3OGQwZTVx?=
 =?utf-8?B?ZXlqS0lnVGllNnZodytuQVRySXg3SjEwa1Q4ajNUZjloZ0FKWU5GLzNTSjdI?=
 =?utf-8?Q?5zyyodOjqW3uZ3pITwEE6O/mR?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51281d04-ff2f-4ff1-953e-08dd7cbe64c6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 08:12:13.4654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b7LTUeFikV6kOt78R4FEmWnXaDznGV7Fk62hE+W88ZSn1Zr6WiaXLuGZaREjYIgEWunJP56yQEE9LS2eBUa9HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4104

Here comes the first update for our 3.3 stable series. It brings support 
for latest kernels but also a number of fixes. Among them is the by-
default disabling of the timeout parameter for recvmmsg for reasons 
shared in [1] e.g. You can keep that fragile feature enabled, though, if 
you really think you are safe.

Download: https://source.denx.de/Xenomai/xenomai/-/archive/v3.3.1/xenomai-v3.3.1.tar.bz2

Changes since 3.3:

Ethan (1):
      testsuite/smokey/y2038: replace gettid() function with a wrapper of __NR_gettid system call

Florian Bezdeka (4):
      y2038: lib/cobalt: Fix __STD() macro usage for some services
      drivers/spi: Add support for Linux >= 6.13
      cobalt/tracing: Fix cobalt_tick_shot trace point
      drivers/via-rhine: Fix a build warning in via_rhine_init_one

Haiyang He (1):
      lib/cobalt: Fix a deadlock when release_buffer() attempts to re-acquire buffer_lock

Jan Kiszka (14):
      Account for moved unaligned.h in 6.12
      cobalt: select: Move nfds range check to caller of xnselect
      README: Update links according to our new homepage structure
      doc: Fixes many broken links and some outdated information
      cobalt/vfile: Plug race while opening
      cobalt/intr: Restore support for IRQ sharing
      testsuite/smokey/y2038: Plug race between interruption signaler and waiter
      testsuite/smokey/y2038: Always present valid u_ret to monitor_wait64
      cobalt: Add missing access_ok checks
      cobalt: Add missing evaluations of __xn_get/put_user return codes
      kernel/cobalt/posix: Stop supporting timeout parameter in recvmmsg by default
      ci: Tag build jobs
      ci: Drop xenomai-3 prefix from downstream trigger
      config: Bump version number

Léo BRIAND (1):
      y2038: lib/cobalt: vdso: Fix runtime error detected on arm/arm64

Richard Weinberger (1):
      cobalt/dovetail: Fill fault statistics counters

[1] https://lore.kernel.org/xenomai/8e0ce080-1167-486e-8887-9fd8a3d250dd@siemens.com/T/#u

Jan

-- 
Siemens AG, Technology
Linux Expert Center

