Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012040.outbound.protection.outlook.com [52.101.66.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3039D4A843C
	for <xenomai@lists.linux.dev>; Tue, 15 Sep 2026 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487781; cv=fail; b=oLgwIULO0S/3IHwWQG+cCd4VgfLWvcdP7CvV925Bpjphjbv47efa04FXyvbDX5uCCjuzrpGqItBH+Od+CNQdJEw9IOjudFCD34kskA1/DgYP8ItrHSKoKzjuCJ+sufWbdO+LbtOSMP9gBPlq3n+yh0CcNZcJzPFTilrMI+YhgL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487781; c=relaxed/simple;
	bh=44BkdC4eELt3H5UX7b1+WiMRJi/sfc/06lEZq1E4IlA=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=NT63ixvUAQ/axAP7SMMw13OJnBDIAEhfIZ3BJr4o6Oi7QZ2drCNGTARyK1V8Sm0dzSa3BXecra1fTrSSNBd+V5oXhAj2ilYFileMpe+Rgh3tWM1pHV4IC8t5IvBSisff4xDervb0bfb8X2fcA4aWOS4IqeuHNQuKJmtju8j8a6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=W4H0Qgzw; arc=fail smtp.client-ip=52.101.66.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="W4H0Qgzw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7TVDVVbJEIkywEQf4qz14jOVkXvMpBiAjzKNH6S66iRP77WwbyI5gVfcF33xW9qMjewM4Yg8sV9mp1bomBHCsL2EPOTVnSZO3ou/CnnTd6DRVXKzrUS28QG3GeQfP2/B7yM22sKxQyM0bXbp4UWHBusABP8FUi0mkUEfoLn31oG0+w9LtHLuHqSq9q7EeEckuCcxNxqIVpDb6+COe9BSh39HhrZbj2a4Sclusq1cf0YpQRDp6dbGqtNUuimWZ1TQ0y1FA+BQivMtqA4D7P/DdoCWgi2+/1hFDv/+JYBLTvl+Qa6LT2gBKq3zWDecczW1j+8y+//GNwLW4ajCCfGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44BkdC4eELt3H5UX7b1+WiMRJi/sfc/06lEZq1E4IlA=;
 b=yTLj0doCtWR26r+EEQW41Asq35I/t09V/xl9GbvacrGewj3bKdBYjMDG/drrrRzR8LhnRYEdS/aFNFu2ceQXSovGNp8xLqAcy/ikHe9ee6jTjRWPgb8fU96lVA0N8LG45Nk0+IobTGchBBbRE4Kat2+Tk+9sxAS+xrPYYYAyBq8PEiUnrvgjEYg30f6zqD+HxOy+KtUgT2f0fbo3WQz31wK/3NmJfuX0f3cYr7aGfcqojbJR0xLRt85Z1CG6CF+8uK+5nr8VnEgp3gZi8+6A/dWx4a0av3SlIws+zn/jkN8Y+xjFY+pIVwyXkpChbpHL5DGdyvHqqhlIGL6hVh4pYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44BkdC4eELt3H5UX7b1+WiMRJi/sfc/06lEZq1E4IlA=;
 b=W4H0QgzwusT1m5DFiBw3jJ2hDF4snAyU4zxZ4VssJgLz6CFl7zYrLMx8OTwjmt5rDYWJ+44iUoFAwNTmEy8eLHR0TRWthVxy/RMx0ne2rCFXNlpFxjp3E7ftUQMPMqJR9xKmJwgGKcnhEKEQ7tDxQsdn4izWql3G6yzf/fmC+cC6LBT4YwO0G76cKHd5+5jlbnfpQyftXLiWikcZVbENxZS9l96n/HrHpopoDbCjSDc/Sjt3u3wSg93XPm+31/fg2kA+Bi9AEdm8/T97gEwQBIjelNu2TOc5ilkJV0nqoU+aM83teU9UH7DPt4QEIwoqUvFTFnYEoeZLky4HAEny+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:119::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 15:56:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 15:56:13 +0000
Message-ID: <65a4a173-2caa-4f93-900c-e95bd6c0c091@siemens.com>
Date: Tue, 15 Sep 2026 17:56:09 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Xenomai community call on Wednesday, September 16, 2026, UTC 7:30 AM
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3737:EE_
X-MS-Office365-Filtering-Correlation-Id: 196894e8-b8b7-4153-3138-08df1341de2a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10070799003|18002099003|55112099003|4133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	CiaUGtzro3FErGF+ria6Pi/L2kCHdahjS1A+K1EpPp+amE5QXrdzPiwR8gEj/xH2bX3r0xMCkpWAKk3kxswzZDohgOniVtaWhNM9K+XP/sM4tozyuczPhUINNYw+R+3eZfP+MtRiHAMutiqAk4poak71GhCciXOb24n0cfQ+PF0FgdTFZh7VIVMlO79ToH3BXCP/0DdX4ZsO68AahP86ugrY8ppcXk0EpgzVCa95/h3GD0i0Arv8fwnUP0wRFLPZbdQyU8uqo9TkFzZH4Ocx5Ak0HyG0lOVixluu/i7fZBBQXOzIlrjp3x2fscsm7KQTkugUwK/REsaTC0ig0Nt4jAe7XjNXUCDrJ4zK7jjsx0+zz10m0OO8cfd/nswhd1j/ywz2D4XvFs3FeVh6ZiIboHApI2tBdh/BAW+HaBtrr/Z8nSdov609DjJd7EqCLr0TyE+SH0hchCV8c8G4uk+LcVLoy33lB+ZA4f3TpFYRx0BytbfsomAJTqiJzyN9tObwykVJ3z2E0U/rOeSMZL6+e9tR8Sx9VlSX4jTZkWgAQJSRTV9FWrQ94/Wg7KTMA1VrvHTlXEjON88csnofXmZf5NGXaca+fBc9L4bD8ocSxzGisHmN57YY6PtrB9Mmre0Nc5YaQlpSRw1jbCuAfoAC5RxzoU/LbE5H/O7jF4PeFUI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10070799003)(18002099003)(55112099003)(4133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkZhOUhyTzU2QllyS1lEUkNUVVFReFRMUkNocmIwVlRNWmF5ZzJXWlNsczNR?=
 =?utf-8?B?a0o0Ym9ZR2p0TmI2ZTNhODhwVVBDNVA3WHFIeUNsaXhWdzR6V0llY0w1UWV3?=
 =?utf-8?B?cXVlcXZJOFJpMTZ0RUprTWtDQ3dvOENiSFN2V1RYN1llYzdqSmFEMGdwRVN4?=
 =?utf-8?B?SE5XRThlNWN3NzNFc0pBR0tCMUFUUk5FYVNmWU5EVXR0MGlJUTBqSmwvQU5F?=
 =?utf-8?B?eWdjd1g4R3hsQXZrQzlxSUtGRHFlSTZNNXo3RFNzYllxYWR1M0ZldTZkV0tM?=
 =?utf-8?B?NFpxekNVZ0UzcGNUbStDSWZtUGdsYTAzZ1VpRStpQmVhZUNqOXJYcnZpRVFy?=
 =?utf-8?B?Y0kzZkZhaVdGdW5sdGN5akc1UkxiaGtBNWpxb0VrdXBTcHdZUmt2aU9hWnVT?=
 =?utf-8?B?WU1jTkZUU20rNXliUHZnT1lUTFNEWHpGWlJUZk1rRTFTMitIbDJTYjFzZTRp?=
 =?utf-8?B?RFUvRks5MjYzZDJ2eHkyZXEwVzloeXpkV205MnVGMGh2SWNJZGhWYTVEK0hG?=
 =?utf-8?B?OUZQT0l5MFVXNXkxK2gwdzM1SThiTFZ6Ky8yMUNDSTdkclhLcnZDYWdjSzZ0?=
 =?utf-8?B?aXlrN2krcENpbXBLaVF0WFlwT0RvcnliSFh0RFJIN1FHS0ZSb3dBREFMMzJQ?=
 =?utf-8?B?U2MydC9LK21IMWlyWmZ6eVJ3RWxRQTZ5Y3dlL3p0MlcxQm1KL3ZYVnpXK1dS?=
 =?utf-8?B?ZVFocUZGWEpNb0hCQVI3VmZuUjlnN3VSZjVPUGIrVldEWnNRdmtjSkdFMExS?=
 =?utf-8?B?dVBwZEhuWGk4V2dkanlWaDhSNGI3RU5JdUdHMk9VQlFPUFA1M0JVV3JkeG0x?=
 =?utf-8?B?bHIzbU1HWXNjWm50TThlUWtoTFV0aWg1UE5RTzFvWGdkYlJtc3IrR09ZKzc0?=
 =?utf-8?B?ZWZldDJELzRHUjRlbGtCdkJ0OXF4YW03S2ZOMW1mWVVoWVRobS9zSmFXWkhW?=
 =?utf-8?B?OUk3WGdWVDV0eFZ2MXg4YzNUSmp0YWVUY2dhaXljRWFobEtER0hTc2prOHlC?=
 =?utf-8?B?ci9CZ0M1SnZxSWN3czc3R2NzTWRSZTVmNHBTSUNMQnBqeS9BdFpGYkNiTmZD?=
 =?utf-8?B?cHlhQ1JnYVRZWkJra2FyKzhQdUFWZDh4MkgrUlIreS9vMXZ4UFFOelg0em1I?=
 =?utf-8?B?Q2ZTZjRsRlluSUFoaVc5dDN2VDJCcGplT0JjV2xMdUx0YTVjYU1rSis1V2xK?=
 =?utf-8?B?andKM3c1d2xPUGJNdFRPdEZ4b3Z6NzQxMmpRMmpzV2VhTEpOdTFEczcrUW0x?=
 =?utf-8?B?NHFsM1BoTGIwTGNSQTZReEJCYmtpNzVGWm1xUjJsdk9sQXF2a1EyTzliSnZs?=
 =?utf-8?B?a0t3bkI1dzhJK3BjRGtWZ3QyV1lmMG5TK2wwcmEzWjlJQm5lNVZQdkhqYmRP?=
 =?utf-8?B?ZnZCUGFzRjdrOUNGWVp1QjlFdjN2enJCZDBLYm5PelhlcW9uSTloNk9RYk9I?=
 =?utf-8?B?bjZBOEtSenRGcm5mQ0RNSE8zQ2NNa1hxVzc2dEQvU3psZUNtemU0am40VGxG?=
 =?utf-8?B?R2FqZS9kV3JZcEJYZXlLaEZQd21JRVVlbmJEandxVWJERm1XU3c2eFFDWDdG?=
 =?utf-8?B?b1VWc2M2T3JoODBCUnBXaGRLV2h3dFErTlF0d3BuU0w3UXZFRUtpb0k0UVl4?=
 =?utf-8?B?SmxqdHZrL3Qvak4vWlJFalZ4VTdyRzd5dEhPNVY0aFZDWmU1VHBuYXRSSUZL?=
 =?utf-8?B?NW9PVVRhWDNYYWZSSGo5cGNhNWRBQ1JpY0NlcUdjZWlWU2F4bjJhdFV3Q1Zh?=
 =?utf-8?B?aEpXSlV5M1IwbjFXaHQ5QWo4azVXYzZ6SGgwZHk0a1psN01GL1BsTG05czRj?=
 =?utf-8?B?MUdFd3pWM3RjVnlmaTBScjZpYWlPOVNMeEFjQktWR3RLNUwvZ3hnYUMzcFEx?=
 =?utf-8?B?My9ZNEQ2ZDkzaHc2eGNuRGwrT3FwUFdrQUpKY1JFb2J4cCtqTnFxaFV1M1Vk?=
 =?utf-8?B?Rm5Ha29ZRlJMZ0xRVkhoTnRPNzFMbUVleXZ5M0R0c2lsQkxzZkhaaW8wallt?=
 =?utf-8?B?WGFmcDZBNVB2M1g4eHE2dDV1WnlVSVhLZUdrVURyYmpJLzRDMnhPRCt2ZzBw?=
 =?utf-8?B?cEl1U3RKVGwzYUFjSVVPRTdwZEJlU3k3eDl3SVkvQmRybWd6bTFGSWpueHhN?=
 =?utf-8?B?YS92TmxyYXJYOWhKb0dkV3FoV08rckhkOThLZGNuYk90SDBaTWdlV1FFU0d3?=
 =?utf-8?B?NFN1aTR3ZlJ5S3B0ZjdrU2h5V3JKRURxZE1UM25aSml5ekt1OVcvYmgxRkhw?=
 =?utf-8?B?c1p3OHlPN2VFQXVvYkpBbEJaYkN6K09QcElkTWRhVEJvbSt1b1ZySDJqeGFQ?=
 =?utf-8?B?NmFTcDY5OSs5c3F6R0hGWFUzQURNRXlDZkNXbVNucGlhNEZmcXAzZEFIQ3J4?=
 =?utf-8?Q?H9M87Bqwa/8JHXD/Xbt00Yx0kNdNxABTWJMLPseKblFk4?=
X-MS-Exchange-AntiSpam-MessageData-1: GSZO3hK3SyjEKQ==
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 196894e8-b8b7-4153-3138-08df1341de2a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 15:56:13.4071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36YgWviwcy8vOrU/WtMeK7uU6EGhVutLCU5Ekd9PBCJ2CrsUc2PtnUJ9b3rcuX+0t4eBKATnHYN43gjl22EWMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3737

Topics may include but are not limited to upstream/downstream project
plans, status updates, and technical discussions. It's an open online
meeting that anyone can join and ask questions (you may have to wait for
the organizer to let you in).

Time:
Wednesday, September 16, 2026, UTC 7:30 AM
Paris, France CEST 9:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d

Jan
