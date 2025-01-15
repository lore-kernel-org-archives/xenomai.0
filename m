Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42997080A
	for <xenomai@lists.linux.dev>; Wed, 15 Jan 2025 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736950398; cv=fail; b=kVr4aF7d61YXhpMHjCSQIkj3Wkz6leItzV/G+GzEUkGHKPsWNJLCUNutMbzGib/L/jAOTC9fU1tGtjdDiUYfYfOj7rWU1Hq6vL52FtUskohAfLH/WXo7fTUDPyhpJlthg6WKwE7eqdCbktHmhDp1hiEGIrvi8qqI3VMLiSnJdFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736950398; c=relaxed/simple;
	bh=2iPZtbqWessD2RXZIbaSGAw2e+xTmPPrjXPwR4kJ8GM=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=TxFdOdfTjjYkZHERYzSddmFrHpTvQ0v5ZxJfsJZ586V33EjQC+r87PeJTb5OALn0LnoIe7PPj1BB1N/KrdmIL15yUUKaAwce597ZZwOSRbmC5gDcxjDoQj9fE/fgfW+pBABDtVYywKlzcxnEY0ZFhhw6WTtHCH7g8evYvIpmTMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=S+BFPQiT; arc=fail smtp.client-ip=40.107.20.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="S+BFPQiT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCtqbCx8s076tJnkSoS1bNmXe9xp6uhqeLhUBNO8jD1xnnXmAmxbHHryoL+K107wAsMSXGOatTiKfNgRKE+zKO3s29+qVpt6lEzcpd+xkRX8vM8LzQn3hdFx2jqknxWpFH8v0x3YVkUNIT6VlBmjke8Q16UN8MoCzm4hhGknJ9PiPO1U6QG/CfFrG4SLAnxGA6RsbE6B5AT+WA2n1qf2uWPwnsMQW4mnFyPP6hgq1iabbi3xmAeOfSrfL44U1MfwesZHo1mHBpZOhbSxqDNs1zHqCp1qGZU0Pj2+Fj8FtbVpRw6VphErQ5EGwylavEBuO6k+LxeWZn+JpSfqcb9qrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5e7T+bFnLFMzfVIAb5BBhEo5T9mTbw9zWedDBGMFpE=;
 b=EZVqReOkayxCtmzJFr/hiJW5YkKnBOIuYJLqVh8UvLP0mXrBz20ayxC2sC3t4kS8xab36qZhYYnqdtnLigj/WxrFuAce0x3rNHi/3rJihR7IiQt9a7ZL2MbDO1pcYyi8swSeVaq9zN7LOEYfeQhB04g3PQ0fK1P5mDfoBBaieG5hEbYjdHZWuLJ/mcJ8TfnrcRGRBsSK7rBQOUBZKw9eNhnu4dSDOrlo8/7EL2Prj+WA1q44kmkSSivxoj6ViQk1UqVFMXJJpykevbtjiMOzPftg48Ao8ued5mCZhy9Sr6yzVPk9RB7vapqhZrhoj2GypFrLzQhbQLD0Il4GgwvTUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5e7T+bFnLFMzfVIAb5BBhEo5T9mTbw9zWedDBGMFpE=;
 b=S+BFPQiTHlmZ7mmuU/pStyNMlWQKQ+lRdPtaFeLOHW4oMzUpGDyXPdxju3MXsgCjmmqlTOi2COPIurgxML4bP0TK+4CKEKZyBm8EMF6DWHYORNWwC+cal70rw7Z8J05SSUE1TUpYsL6qC4YAWqdo96j1mn8VI36KBxb0bZYwie5Slf2ceayA6yfGUPmWKRz553oB35k9uOASQWxlaNpLUNUTDwKyq3uNOwcj5fjcn9RhkZZFr/0Gebqx1xI0Kha7tYkya7xzv2kSO8qlburYrmPN0bYDpKCq01wPYOiOYrotNN953t9cvlsx64kkBSNsxLOtr6XMZQ4SG/AR22OOAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7262.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:449::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 14:13:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 14:13:13 +0000
Message-ID: <8a0efc9c-2949-48f4-8408-264e5322c0cf@siemens.com>
Date: Wed, 15 Jan 2025 15:13:13 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] cobalt: select: Move nfds range check to caller of xnselect
Content-Language: en-US
Cc: Florian Ullmann <ullmann.florian@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0015.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7262:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a0179b9-25ea-4a11-4033-08dd356ebfdc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHFubW1WaXFpbVVpa1RHeSt0eE9lL093SDNKY0dZMlRsa3RVaXppM1cxdVBj?=
 =?utf-8?B?N3Z6NDR0dkE2bS9xZXJuV0Z1M2V1RVhCdU5tcStaOG1ZSWZrOGYxVEhDbDd6?=
 =?utf-8?B?OFR2QnRzWTR5MFlwOTRua0hHS05CclV1elBwb01Wc2k3dnh0QjZMeHFJeUI4?=
 =?utf-8?B?VzhtVE5INDg5S1d3V3NvTkRDeHJGTmIvSHEwRHhUeEl6OWhoaFJML2prYWRZ?=
 =?utf-8?B?VVFHQXhuNmVSMEdldFF6ZkU2VXp2OEhpTWl4TDEwSFgyVGVZeTJMQnJFanNm?=
 =?utf-8?B?MTErZDVWVWwyN0REcVd1Z1hOVDFJVHV5T0UzNDBXNXFsMTBpNm90ek1vaThn?=
 =?utf-8?B?SUR5SXpDZlpweEhVeHpGamxhdXg3N2w0QjlUUERJMFVQZHpVN21GSVVYSnho?=
 =?utf-8?B?QWY1WkNScytsUkxVTm1VdjJTanhlaHA4bXVzUFR6TGFFMHcxS0lsS25yMjNa?=
 =?utf-8?B?SUpCand6ZTJFTlFIaFJlUUhmdzJjTmV3SnQrZjJraE9UbVlvOHpYbEhseUcr?=
 =?utf-8?B?QmZyV280L2NBV2xZTmtTQkdWcVl4L1BrTEI0VU82d3VHVnFvOHhCaU5Tanla?=
 =?utf-8?B?dVhaS0xJRFFmSFo5ZldLczJUWi94NkxjWEtnM2dMcmxCRDY1VVI4NDQ3Vmlw?=
 =?utf-8?B?QzlDakZrYmljSnBCaTVaaisybnRxY2NtSUVXOHRVRlo4Y25pZVI4K0UrUzhY?=
 =?utf-8?B?ZFZWbThxcWVBYXNmdEZzQjdZQ2JrMW1ydlF4SmhTOG9GUm5xTXhlWnZncUNr?=
 =?utf-8?B?UXUrZ0Zhd0J6bDVabmFYTEc3SXErMnJJalF3TnQvSjFrV2JSSHNGWGxaUVBV?=
 =?utf-8?B?ZndiazZXUFdSOEorSjhaZnFYYTFSVkRpNWVRV1JXL0dCQ24zZlBEKy9jWW4y?=
 =?utf-8?B?SVZMR3hCM1pYNmsyTWhwUHJaSzZ5MmM3QUlxNW12TlcwVC92cWNLM29YbjlF?=
 =?utf-8?B?b0FWU1N4YTBBMXpuNS9iNGxjUXVOU1Ixc21Bc3dKNmhwcWhrVGs5dkR3Ykpa?=
 =?utf-8?B?andZVnhlUUJ4WkkzWElLUkFidi9DdFVZS1dRVTRGZ21ZS3ZzTUcvbzBXNUF5?=
 =?utf-8?B?ZDhza2tpeHNESkVtU1NzYkgxTjBSQzc4NG5qUWszdEJHbURIYzJSZ2pFTHlT?=
 =?utf-8?B?SUxnQjJ1THk3aWxGMDZiOGdaL2x2QWw2VTV6Mi9NTVNNUUtPY3FKb0pkNGdW?=
 =?utf-8?B?ZkdOcnR4OUl0NlZ3YzMrcEhlbEs3c2JSaGx6aWNTdTRocGtmREdHMWRleWc3?=
 =?utf-8?B?c1lSaEhNSmpPV0Y3QjduSmpTdFV4a2MxdkRvV0VlaThFMVhOdW5PTWNGd1pz?=
 =?utf-8?B?NEU0ODk5YW1NdkdxK1RGMzRpZm5qL3ltYWs4QzdQdVVWLzdEZmFUbzh5NU5X?=
 =?utf-8?B?a3JQQTlJVnA3WkxwcWkxdUR5TGxMSmJqZ2Vsa2VkSVlSb1d4S1pQT2tlanhV?=
 =?utf-8?B?WUVSaVNKcVBDK1NNNHVvelRuaUR2ZG1nVkYyOWY1Q1lIbm9pSVNqdlA5WVJH?=
 =?utf-8?B?eUVpMTU0VzJncW5KUFpmUkpHSnF6SSs0Um91Qms5L0E4cWZySVhaVzZnT3NG?=
 =?utf-8?B?MDUwcUdaMFQrMFdDTXMzVWdOTTZtN0JuSEd2UlBSVXh5T3VFK3VsRWZLVWlr?=
 =?utf-8?B?VGFLSERXdnROSzBlWVMyWmdlTmthcHdXbC8xaGZxQ25MMUgwdXRaWHVMSDVq?=
 =?utf-8?B?dFFNVUMvZnBxVzAvdnA4aTdyOHJwdzZ6RDk1SHF6YXFMM1JndDVNeUhTdWpt?=
 =?utf-8?B?cGptU0hQeEt6TU0yeUUvV3dGR2lTc1FCNFFCM3UrRDN6d08xVUljWjFtcjdZ?=
 =?utf-8?B?KzIrU3FlT3FRdS9lZVpUQWN1SWV3UENsQjZXeXBqeUhFL2JwNXh4VHFrQ1BP?=
 =?utf-8?Q?mrfmmkOU9WqWH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDk2RkpEVm5oUEZVYjRMejhTbDZUekVCYTVZZ1YxTCtHQ2VFTEI1T0xpT0k0?=
 =?utf-8?B?NStKZk5LeUhQS2NOU2JqNVdIL2s3N3NwRm9XZXBkVk1ENTFIcXdIZ3Bndmsx?=
 =?utf-8?B?TXpoejhYbElQNzFIRWRCSVFYbiswVE5NNEYzeFQwdVdNRFFzclNDQWNyQ2ZS?=
 =?utf-8?B?V1VscExVN1JGTndLOVZoQnVDcjBsM0RrU1RSUmV3cWhocHBFdTY1VHJpdWMw?=
 =?utf-8?B?NVlZbEN4RElSQXliREZ0bk1BSzRZQU9iWWgrTGU4TldmanpFaExQV3prYStF?=
 =?utf-8?B?NnRvVFBKM2FIRFlkWFUxYksxQ2hvZGcrNDZVRkRaQk1ER0RjaGYwekhCVitn?=
 =?utf-8?B?ZGZrUk5aVStmQWs3Zzc5bThsczNLZ0E4VGp4LzdJTHlCVGxEa3YxSWRKSjVP?=
 =?utf-8?B?aDdndDFyNzBCdDMrMVcwWld4cFlNNDJBVTl4a1ExclNmU0VmRTh2VE92OFA2?=
 =?utf-8?B?THpRbzdNV0FkRzNDQkhBTlpIOHljTUR6a2s0K2Y5K2poSitmQzNNbFRKM0or?=
 =?utf-8?B?WVpNRzUxQTlMbGlGRFFmMVl5dVUzNFArNEM1S1VjbnZ1dmxQVlI3TFRjWHJq?=
 =?utf-8?B?b2dwNlBaSmFWVkpMaEYrVzN5VWpDS1ZhYmhaa2FXdDc2R1VpZENLUkRqbkpD?=
 =?utf-8?B?ZndIcUxJR3JIUmFZbk8wcUJpZm9rOVZrNm9tdmdvRHROZFdhVlduM3ppKzIr?=
 =?utf-8?B?ZlBNUFRoTEZqTEs4UWEzUmFBL2lkUThWSXJoWlRLRGk2dXFBS1l0SDhBWnM3?=
 =?utf-8?B?TnNPUWM3T3pCNFBHUERXb1U2NTVhN0xaM0Fpc1V5Z1psS1Qwc2RDUERrYnBz?=
 =?utf-8?B?LzNPMVd5MkJneExENittTEJucDczaGVWWGFxKzgzYk10WXZOQ0Zjc21CWUdY?=
 =?utf-8?B?bDFjb0tLOGdEemFuNDRtTk1YbC90YkZLNWVxcmdBamZYQXZ5cHhDZDdiUjFM?=
 =?utf-8?B?U0c2cVFMWFVSelI1cWkvOWp6RjVJTWNJZUpHbUxIUGdDRzRST2dtN0ovOGha?=
 =?utf-8?B?dFJQYkk5djdoVVRzNFdQdWgyVjh1cGVVbis5UlgvSTZyVnJaWHpPUWMwWDNI?=
 =?utf-8?B?VGx6dm42dEQxV0hzQ3N5eW0wRDZmNUtYUHY4RnVPY1FSUEYrdnZSZHh2UW1q?=
 =?utf-8?B?bGpyaDhKK3RiT3JUWjlaMDF5TTVxOWp6QkpteUxuQnR3d2d3cmNBMllvU2Vu?=
 =?utf-8?B?R3pXZm5YTE5wODNFc21Wd2dqTFRHcE9JYlEreTE5dmh4YVowUkRraHBCUFZU?=
 =?utf-8?B?eWlJRk5KMVQzWkRUOXdJWGluZ2FnU2E4SlZROVhFbTViRjNCS244cUFuWDFH?=
 =?utf-8?B?NFBERlF0a3JiNmFVbnBGVUxFUmZWRDBjZGNlVVZIOFJ3RjQxTHp5N1pzTENm?=
 =?utf-8?B?VE5yMHI3S2hRSHB2bGhJeUdOM3FDSmFNclRvRHU5djZWdk5MR0JEOTdRWXpt?=
 =?utf-8?B?eHZycEJWdnYwbnB6bDBtbHZmcWFPZUM3NVFRYkp5NXQ0N09LV08zVjk5emJF?=
 =?utf-8?B?c2RJZ1AzWmlnVXdOdUcxc3FUMW5zRlRiZU5VZXpaQW5vckl6bXFwVmJ0RUxy?=
 =?utf-8?B?QmMzU3BFdFVLbk5NRXNMcWhZa0FFMG92TTNXMHIvQjZSMUtpSVlQZEhIdVdo?=
 =?utf-8?B?Z2RBQS92Tncxekl1eCtIcS96RU1KZUpLbVNVc0IxSjUyWUhIVm8zK0hJVGZs?=
 =?utf-8?B?WDI0M0ltMEhkN3Q3RTE5Qk5mQlpPenM3ZVpFVWdHOGpCRFZ2NWRObzhoY3R4?=
 =?utf-8?B?SFpiWXlSNTdJTExaQTljSVRwU0djV3RpUFRHV3F0UHVUekVYZkFWME1nc0hu?=
 =?utf-8?B?SVF2a3g1OUpXUVM0WDZmb0xtZzlFenVvOGFJNzk2K1VhN0FCVHRZOGNremti?=
 =?utf-8?B?R1B6SndRWUN3RnpPN3F2UWhTdFBBclFBWUREQTJONHBlOERkb3ZBemFTTWVk?=
 =?utf-8?B?UWRUR3RhbjNkQlhtaTR4a0VQS3Bxc2tUajQrSTZVK0ZnZ1c5MHQxMXFKTDhy?=
 =?utf-8?B?cWpqNWphaFJDdzFVNEh2cXdEUkNoU3lzOUJGVnBGVXFrY1dTN1puQ2VkQ1NZ?=
 =?utf-8?B?VjZvR2pLdEMwdEhUOHA5UVp1Zk50YitaQlZmS29CV0dqWlN0eUc5Ymw4WEM0?=
 =?utf-8?B?dmc0OUtWMUJJV24xZnJQblpRWXUwL0tRS0l6dnpTWFJmT2x3YUpzemNJY0Fi?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0179b9-25ea-4a11-4033-08dd356ebfdc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 14:13:13.9349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tl6yN0Mhp/+Y+y19CrdI81omsK9tP6bwgPXhZR43yLz5L2K2j1sQCH2aXGW1rnbYQCE7JVUCMCrHN2BnfcMaCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7262

From: Jan Kiszka <jan.kiszka@siemens.com>

__cobalt_select can stumble over too large nfds values as it copies file
descriptor sets from userspace into a statically sized kernel buffers.
This can lead to kernel crashes or worse things when userspace provided
garbage.

Rather than duplicating the check, move it from xnselect to its only
caller __cobalt_select.

Reported by: Florian Ullmann <ullmann.florian@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/io.c | 3 +++
 kernel/cobalt/select.c   | 4 ----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
index 722f1ce20c..4e20ca19d6 100644
--- a/kernel/cobalt/posix/io.c
+++ b/kernel/cobalt/posix/io.c
@@ -266,6 +266,9 @@ int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
 		mode = XN_ABSOLUTE;
 	}
 
+	if ((unsigned)nfds > __FD_SETSIZE)
+		return -EINVAL;
+
 	fds_size = __FDELT__(nfds + __NFDBITS__ - 1) * sizeof(long);
 
 	for (i = 0; i < XNSELECT_MAX_TYPES; i++)
diff --git a/kernel/cobalt/select.c b/kernel/cobalt/select.c
index bd790affe4..70ae9a07d5 100644
--- a/kernel/cobalt/select.c
+++ b/kernel/cobalt/select.c
@@ -309,7 +309,6 @@ EXPORT_SYMBOL_GPL(xnselector_init);
  * than expected if the sleep is interrupted.
  * @param timeout_mode the mode of @a timeout.
  *
- * @retval -EINVAL if @a nfds is negative;
  * @retval -ECHRNG if some of the descriptors passed in @a in_fds have not yet
  * been registered with xnselect_bind(), @a out_fds contains the set of such
  * descriptors;
@@ -329,9 +328,6 @@ int xnselect(struct xnselector *selector,
 	int info = 0;
 	spl_t s;
 
-	if ((unsigned) nfds > __FD_SETSIZE)
-		return -EINVAL;
-
 	for (i = 0; i < XNSELECT_MAX_TYPES; i++)
 		if (out_fds[i])
 			fd_set_zeropad(out_fds[i], nfds);
-- 
2.43.0
