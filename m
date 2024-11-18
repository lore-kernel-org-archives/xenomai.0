Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2085.outbound.protection.outlook.com [40.107.247.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A51F41E4E
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 07:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731916119; cv=fail; b=c+zZYMWnGc664yAyahXldSJE0hRi8f2ZkIyEatKnwAKMATVNmeIS6E5zDnWEPRoPWHYnb+O73xkcTq+IQTb2/0+rf3WhYXJDRTUZWCdaYcsLwFU2ibkrvkc0R0/fD5+dFNOjTTznZM4ojWvQmLcHfE2dXMQuDhGo8rRQRLeM/JM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731916119; c=relaxed/simple;
	bh=Uvc8SY1f+XuHn+aja8vyKViTK3/ylICKgmPOFuWrYqY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ya8iM1r4nWdKt8spCymn6OM/9QwrznqMiH3Wp3e1lGvh8PVsNqUxYyVfSdXpNSzZmyU1tCMY1lHDfiw0pWvtoXKhC4kMDB0JvVp0K/Tj16+g5IEPZ9ZLWqMeWgoDIoExaeIzxMh07FLZhMSmJp/+/g5k1vCRhU2X6V1Y3xrAmYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xXsgrTgH; arc=fail smtp.client-ip=40.107.247.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xXsgrTgH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qu0mwvt1xX5fHwJB5nrdzDnttRyeC8xkKrnLNJoH6iePNE4Fabw/hhmN7p4qRAukRuFzf9RL/5ugkZt2EpWrvgzmtXmC9T+gszcvccQVwtB7VNVZSrzNcYRTUyhGa07fxg2bkpufubYurKlu2Aqk94Nta4KpjwLXKG4pZZY5i/Fx6oI5pNAPDECSKTMR7OucFX2kCGeH2YhA+5U66GFs0N5TAMykXKgAB3j7JWSXdzkQDOIZr9gXOzH0/iju+ayiqni7adRfuUWgcceQL/E51yLDh6LX3R5frdrVVZhc9y5Cc/Q4OU2DZmo7R9+Ice5l5LmGpeA0adQyNxGAElDKrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mk6LoywngJ+zPHNv4it62qvsdAL3JvCjYmRKoXyUUIk=;
 b=DCUibqmVz2RmDvC+oPwUWLib/NBgd/rURd8dFEG2NUUPaPPM0jLtTjtQ39QBdytTr8+vaIAW8AjBE6BwZ59c8uH+Vx5OtXLFmtPrEH+P2t5aCYDfh0tHRvb+zRepHQh60nCTXATiuBB5Kgpa7BHrBcDAOPNKxHb75fUC+M1FGrbYBCqSQE3exzkS9rPgDIEtLEtWVzw8xKDruos37UbNoyA3tz6rZucmUuvvKxI6B4KOVlCFCTq6ddjrDAs1cYGU5odIYFFAkUgdDAmr4VRKWd669Ou+atCFpoaUaMyGr/UovLJP3Wy9QgeKXfYXYDX8d38la9rMd11bL/rCjhjMVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mk6LoywngJ+zPHNv4it62qvsdAL3JvCjYmRKoXyUUIk=;
 b=xXsgrTgHlAjwAxu4nkHlLkVSlAly7GWpVE4J+pK90mH5Vpcua9Su7IjVK6cotsFstOduh36fGOc6NWGWmdaYcIJSGgCY94fOTRF80t8vVsGulTufwvA7+3laWRr83Sy2f4u5jWXPVorl5t8FMnK3BqSsaz/MM04wCfFqCxWTfotD38r0m8vYpzbY/Xag6OoZKdjdh/3jxfwfXTTeD/21wIqyPm1Z0x1yMPA0bCO+RIchMPlmeCYZjUVJGbAx/u8ho9zFts68ojSnFa3roGvaxDaD8SIh/5huufoZ3z+fE1UhShljOkFci/apT6nl9XS5Rz0+J/Z/yOxKd8U2a0BZXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7996.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Mon, 18 Nov
 2024 07:48:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8182.011; Mon, 18 Nov 2024
 07:48:32 +0000
Message-ID: <49554ca1-4f91-4d9d-8b40-7561eca99908@siemens.com>
Date: Mon, 18 Nov 2024 08:48:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [libevl][PATCH 3/4] evl-test: Start evl-test with load by default
To: "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com>
Cc: Philippe Gerum <rpm@xenomai.org>,
 Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
 <20240613134557.4013044-4-tobias.schaffner@siemens.com>
 <87jzisrkfo.fsf@xenomai.org>
 <dbe94d71-1fdf-41d5-bc84-76923a66bc2a@siemens.com> <ZyUJFhSxPyAcfSHI@trex>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ZyUJFhSxPyAcfSHI@trex>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P191CA0002.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: a7778464-0db4-460f-8955-08dd07a5662d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzJJMjAyK2FmVG1ad2ZRYTZSZmtzc1BZcGxUTStSNno2M1BVNEhXbHVNQWhJ?=
 =?utf-8?B?elp2c1lmcy9jbjdXakwvK2hXaEFiMHRvamR2aW5rVEg4eC9TNWlUNFJoazNT?=
 =?utf-8?B?aXNHUVQvbUZhN09rZjBSRTczUWphenNTNXdBK2FEN0hTaVBsaWJna0R6WFY1?=
 =?utf-8?B?cnJqeFQyeEQ5ZzZtKzNoMkN4ZDI3WjZWNEhhazd5U1RwenVxbHQxS1Y5UC9L?=
 =?utf-8?B?MnVvL3FOaEJxY0pCRjR2VW53T0dIU1RLWWN6dnRxQndZSVNmM3VjZ0lEQnBi?=
 =?utf-8?B?Vmd3Q1RQNThIY2lpelZyd1ZWbEVrTDF1MStNVDVqK3ZpdkRUMTJjcE00V082?=
 =?utf-8?B?U2hpdlRxTEppcWgwNkg4MFRkSW9ramlnTnVJQlE5SlJnMld6QStqL1oweW5O?=
 =?utf-8?B?RDBwNzNsblVHSi81bnF5UTFra0tURU16RGJ0TVNoVC81enlPaTRkbzdFRDBa?=
 =?utf-8?B?RU4vVHVWZ0hwTFQyOEFRZXZYOXRPLzBzK1g4bFVxNEU2R2ZzeEpqSlFHei9S?=
 =?utf-8?B?UkRUT05tOXBESFBiSXZRR2hxWFd3a0hPcGVrc3FPVkFuUk10d2xVRVFHT0Jo?=
 =?utf-8?B?aUR5dU9SSmZ4d011cGFXUUpoYlNWb2pUMlUzMG1YaHZKYitINVgzOHV3NnE4?=
 =?utf-8?B?OUt6T3o3YytUZkdjYTlJWVgrWkhZWWRRbnZZdFJzS2tNQy95c0laRFAzME9I?=
 =?utf-8?B?dUY3UkpjN0pPallVQkRCY3dIZHRLbXdwV0ZCc0xuR25sTzZzUSt2bmZmMHAx?=
 =?utf-8?B?Zjc3NGU2NE80OGRaNFUvK2lOaVh1RndGZU16djNHRll0UEVvTm1xOWZqSkN2?=
 =?utf-8?B?SzBmQ3Y0NU1EN0VoR3NQcUdxRnRueGJ4c2xwTFFiY3paUlN5cWdwWXFvNlU0?=
 =?utf-8?B?bk1hTjQyTGF3dEJCeW1PZE94VEovcjhIM1NnM2FLME1nSEN5VkxJM3R5RjFM?=
 =?utf-8?B?TkczWmdUVU4zR3RyVmVzUmt3MGxPWW5YNjJWOXNsb1ZTaWFoSnFvSWhpOGg5?=
 =?utf-8?B?TlJUcXdHVk82a3BkbWFNdzUrUGhTMU1scEpURTFURWtBTkNDWE5RZE9iL1BB?=
 =?utf-8?B?S1VDVldiOXBxMGErWXBtTUpwekJrTjloMzlBeGg5REhJeWlOTDRuWCszejVZ?=
 =?utf-8?B?ZVk3cWdPU21hRUhNY2lJWnVqZFN2K3lqTk9xYmJRWExmTk0yb2tyVytsTWhG?=
 =?utf-8?B?akx5d0wvMEttNWI0MUpsTWJxZXBpVkJxeFFEclB5T09ZN1ZQTlA3cHhqbFMw?=
 =?utf-8?B?Wk56eW4vTitTY0UxVWw0RjdBODhRZGcwa2RtY1RKV3RlYmMwTSttK2p2ckJt?=
 =?utf-8?B?TXVId2Nua1F4MWVFQ1hPUjBGWCs0V3dicG5rcTVpQWI2SlJ0TWVES1JETTVS?=
 =?utf-8?B?NStZcmlFbnJnRmFQZ1A3WVJzaUdFRUlEVDdvcXZxRHFlNVBzTDZ4aWo0bUVW?=
 =?utf-8?B?SUVQTEhmVEtDR3RWWk5COGVvUXVVSHZ6V2pRNDBId0hPeW53N2NCcHM0VDFh?=
 =?utf-8?B?OFJIQnFxTTNwbmxBTE50WGV0RDdJWWV2dllqNXZVWVBkVnU2T0lnL1NrK1ly?=
 =?utf-8?B?bjdTcjFpbzJ4bDJwNjFKMzN4KzByL3RwaXRhbzlJbm9CcUorVCtQTmRJaHZT?=
 =?utf-8?B?V0RjRHdoQTVodlNxeU14SzdsdHU5bFJlcldGVk9OcmFPTHdXTFpqb21CWi9w?=
 =?utf-8?B?SklxblJJcUJOZGFYbll1ajBPTElXMkpjcnJiTnc1TjVpWG9zcGM4enNJYzBG?=
 =?utf-8?Q?5+tygEBvuBHZqSYiecTJnpttLFqGGBigj070VfL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmlRc0xGYXBsM3hmbFUxMHovbG1zOWdQb3R2aXZtN0RvTllXM2JWeTVEVnlN?=
 =?utf-8?B?aUVFaDJaM3FQMUlIV29xci85a3M1MGRYelNTUGl6dmhHZlA0eFBXOEd1MklE?=
 =?utf-8?B?UUJZWVltWWdtdU1hUWwxQTl0MjZ4VkhVU0ZqTktLRkpEZmM4U2IzaEdhRFJR?=
 =?utf-8?B?T05IazFrSmpob0xpQjJ1eEJqNzZuQUpmRmovWnRXMmFvemdEMGxpb3lhV2k1?=
 =?utf-8?B?T0I0c3RqcXU1TWRnUytKWFBpc2hUcFhzcjRCcXFkTm9vWnNWRm5YRHg4RkFQ?=
 =?utf-8?B?eFN6N2ErVkVjVmg2MkVPYkJuNFpBVUNzSGpPRDBGV2FKUDZoZGpGaGpZY3U1?=
 =?utf-8?B?QXE2RTQyTno2TE9GNlVLeEszN29kQ203bkU4T1IxeUJkNDFuSUlKRit5UEkx?=
 =?utf-8?B?UklrMkNWdldYZGRhTCtVZzZuanhaOFJxUHhTak9zNEFnb3hVMXpiMjFhM2xG?=
 =?utf-8?B?ZUJIRjJ5SHVNTWtTcTNnUnhmZ2lrNDEvVWFVNm9CVmo2bWF2ampwMzFPeE5m?=
 =?utf-8?B?MWdJQ0xpT09US2RwRXpuZ1ZVcXpMbUtjVG84UFYzWHZwdEJWayt1OWJDREl5?=
 =?utf-8?B?bG0xL0pURUpsL2ZJdExjdzFVaVNHakVETFB2cGJ0aEFwRm1RVWMyZ0c4UCtj?=
 =?utf-8?B?aGE4TTQ5ZXRuTzFjN0ZIcDBjYkNEd2RXdWgyNEF5RmNCMHhVLzRzKzFlWTRT?=
 =?utf-8?B?NU9PUXdKV1R0UG5FdG1LQ25SbDBJaStDTHdZWmhIU0FacWhhRDdhQnBzNGM3?=
 =?utf-8?B?a05DUEV1RFhCNG1OY3lvYnRmTUpXK1B1SlRxS2pYcFV1U3RmbHc0aHRnYWxj?=
 =?utf-8?B?bUY1ZVZrT3FiMmdRSndUNys0Y0VUejRHQ1BkMjhaWTc1WjMzVU02YXVpT0xC?=
 =?utf-8?B?bURTREhWV0I2MC9Za2MrLzQ1c2JkZGdzUDVSdFA1VDlpRjUwZXpuODJaMXdr?=
 =?utf-8?B?SGxCVnk3dVdvS1grWjJBMm93V3gxVjdFSUdzU202dU0vaHRHRWtxL01YQmFj?=
 =?utf-8?B?WVh5OEs1TFVza2RUZjVzOWNPVGpwRVMzeU9vbXdpYXhYZmtaYWRHSE4yZ29h?=
 =?utf-8?B?NzJkNTNFL2hNaTIra2h6U2FaSjk1bzg4YnlmSWQyeVZOWmJ5TmdwbDlycGhu?=
 =?utf-8?B?SWsvZk9QQnpZVjkra3FPN3I5TTFTcG02TzAxWkl0Y1pKN3hjTkpVVE4zYWhM?=
 =?utf-8?B?bzc5OTFwc1dqRE5BSFdhUU92dE9FZXp2ZzdlL1J5T3cvZGpkOG02TVFLWnZx?=
 =?utf-8?B?Q1ZKT3YramZEeFFmTlY4bEp0NzM1bVZWMTlmY1JFUjVkaUFvYjJUUXFOMDNp?=
 =?utf-8?B?aWVwcUZFYTlZaHpsNjZzSDUyM2NTY1F4d3NHVmx4c2IyT2k0Nm9NS3NLUlNW?=
 =?utf-8?B?SDZDN3ExTEF5dW81bG5NTVQ0ZzhMMk1GREc5bEFmU3kwc2Jyb0RuNTM5TDFZ?=
 =?utf-8?B?OE5EbkxqWG1TZm91ZlJPWUh0bUlMT3hQdm1lZnBNRVdtc0xMcWtPNC9WSVda?=
 =?utf-8?B?Y1NYMVNyT1JCSFJvTUZvNklvN2VlcFNjc1l2cmZLK2ZVRHRJM0treU5sUlBG?=
 =?utf-8?B?NEs2dDVGSXB3cFpwMmphaCtNVThmYlpKYUNEdDR3cC9wdlllaTVTa0hGM2tG?=
 =?utf-8?B?Yk5ES2tJZWpub0NNdmlXc3lYRXNHa0RTQ1NvSldPNlI1WlZ1SGc5dUMySGFO?=
 =?utf-8?B?UHhKQjgwWkc3N3Z6bzJPUk04QjNzcGRDODR0dzRhU0wvWVJUSGRwNk01NUZ0?=
 =?utf-8?B?VFNMZkxHRi8vTmx4eDBDSHpzK0hlNnJJYWNINVZ5ZkJ3UnAvRWxjODdtUmJW?=
 =?utf-8?B?VldJSW0vS0MwN0x2ZkpaRXJhcDdzOUtkWlh1cnhTeHNhRjdiSHZuT3hrSDhm?=
 =?utf-8?B?dzJmUlNaaGtOQ0hFT2IxN0RyYVo3RkJLTGJSME1Od3g3ZWlGQWllRmphZlZy?=
 =?utf-8?B?enk1RjJwdmpKTmRHVTZIbGxrVHd3VVlRODVZSHdxT1Q5bUNYSlNhdGxmY3dW?=
 =?utf-8?B?S01sd0QwRmtQNDNjQTVqTmQwTFA2bTdkUlhITG9nc1U5SDFFZVloNE9rOUFH?=
 =?utf-8?B?d2NnMWZWWnRxWUpJUVZWSE85cGdNRHlSS0hJZ09PdFNXbUU2b0w0Y3dQZHhZ?=
 =?utf-8?Q?Kg+WN12rOA4KEeHnnp5EwKFg3?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7778464-0db4-460f-8955-08dd07a5662d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 07:48:32.3197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOVb94a95r4BFUyFJWdDH7U0dwVbGuZQ26CweIR+bqNFIz8rlXRYbNKxxfcAx7BiiWA7kMHu13U10a8FFppTcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7996

[sorry, missed your reply]

On 01.11.24 18:00, Jorge Ramirez-Ortiz, Gmail wrote:
> On 13/06/24 17:30:51, Jan Kiszka wrote:
>> On 13.06.24 16:16, Philippe Gerum wrote:
>>>
>>> Tobias Schaffner <tobias.schaffner@siemens.com> writes:
>>>
>>>> Stress evl with a load command while running the tests. The load command
>>>> may be set to an empty string to run tests without stressing the system.
>>>>
>>>> To align with xeno-test the -l command line argument was used for the load
>>>> command. Listing of the unittests can now be done with --list and --List.
>>>>
>>>
>>> Nak. Compat with xeno-test is definitely not a requirement if this means
>>> breaking the existing evl command line usage. Besides, --List looks
>>> strange as an option. Let's pick a different option for the load command
>>> instead.
>>>
>>>> The load command is moved to its own process group to allow a clean
>>>> teardown of the load process with all its subprocesses.
>>>>
>>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>>> ---
>>>>  utils/evl-test | 71 +++++++++++++++++++++++++++++++++++++++++++-------
>>>>  1 file changed, 61 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/utils/evl-test b/utils/evl-test
>>>> index 5c1c3da..fb85f69 100644
>>>> --- a/utils/evl-test
>>>> +++ b/utils/evl-test
>>>> @@ -6,33 +6,79 @@ if test \! -d $EVL_TESTDIR; then
>>>>     exit 2
>>>>  fi
>>>>  
>>>> -usage() {
>>>> -   echo >&2 "usage: $(basename $1) [-l][-L][-k][-h][-u] [test-list]"
>>>> -}
>>>> -
>>>>  keep_going=false
>>>>  do_list=false
>>>>  full_path=false
>>>>  unittests_only=false
>>>> +load_cmd="dohell 900"
>>>> +load_cmd_pgid_file="/tmp/evl_test_load_cmd_$$"
>>>> +
>>>> +usage() {
>>>> +   cat >&2 <<EOF
>>>> +evl test -h
>>>> +
>>>> +This help text.
>>>> +
>>>> +evl test [ -l "load command" ] [ -k ] [ -u ] [ --list ] [ --List ]
>>>> +
>>>> +Run a basic test/benchmark of evl on your platform, by first starting a
>>>> +few unit tests, then running the latency test under the load generated by
>>>> +"load-command".
>>>> +
>>>> +By default, the load command is "dohell 900", which will generate load during
>>>> +15 minutes. To generate a more realistic load see dohell help.
>>>> +
>>>> +This script accepts the -k option to tell the unit test loop to keep
>>>> +going upon a failing test. Otherwise evl test stops immediately.
>>>> +
>>>
>>> To be fixed wrt the comment on the previous patch.
>>>
>>>> +Use -u if you want to skip the latency test and only run the unittests.
>>>> +
>>>> +Use --list to output all the tests available. --List will print all the tests
>>>> +with their full path.
>>>> +
>>>> +Example:
>>>> +evl test -l "dohell -s 192.168.0.5 -m /mnt -l /ltp"
>>>> +
>>>> +Will generate load including network load using the server at IP address
>>>> +192.168.0.5, some I/O under the moint point /mnt, and the LTP testsuite
>>>> +installed under the /ltp directory, and use the latency test by measuring the
>>>> +timer irq latency.
>>>
>>> We should use stress-ng or something alike, instead of the obsolete
>>> dohell script.
>>
>> Fact is that dohell does better than stress-ng, at least in the configs
>> of the latter that I've seen before.
> 
> just "dohell -s 192.168.0.5 -m /mnt -l /ltp" ? do you know after how
> long (ie, did it take a few hours or just minutes?)
> 

Yes, I ran what Xenomai 3 also runs, for better comparison. That was for
some hours (don't recall exactly anymore). Not just 10 min but also not
for a day or longer.

My theory on this: With RT Preempt, it's more effective to stress the
common code (and locking) paths like stress-ng is triggering. For the
more decoupled co-kernel architecture with way less common locking, and
that rather short and not nested, cache load is more effective.

Jan

-- 
Siemens AG, Technology
Linux Expert Center
