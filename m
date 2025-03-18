Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BC81DE4D4
	for <xenomai@lists.linux.dev>; Tue, 18 Mar 2025 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306590; cv=fail; b=ZbNarPnPZu/VuFIFrHi3p/uASlIQaIAiGRJH6ctDA50U5QtlJeRqvlWtrMltKnr2xioNdz0P5T8rI0YWNlPHJpMSo4zt6RJ6aQ5JR9yGq/ZzCQfvi6ejnK2qp4S1oJ5tYbs6pny1q1TbJVQPGDSebQF+YlXw+ie+WQKTFTrO5HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306590; c=relaxed/simple;
	bh=UBjmjv0lM9KlWODriB1n2pXU36ic8Uy+WZdAuLFp4w0=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=jpgcAIJDk7yul+UBFXM3tPOBfa/RSsgVfLbaznunU5buPa/qSmeV6wdpNMzmZOccWTRZxRcHpRFdxV/f51c/0AKHk17+QmIRARba6NLwgVwa1guq5f5SCR036yC5TUHSWEK5+CR9w/NqP0pRhJtXRWTEagc94S2ZRs7Erx/AtWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ImCm3O2y; arc=fail smtp.client-ip=40.107.21.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ImCm3O2y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVcUXEz5vMjfLVChhVecHnGbIyDH/zUvzj1TPdkTDUa1jKfo9Zn9dRrQUVQc++YUpVLCD1KQSex1lwgv4c/GM1epC8B5V6kc9UoPUjhKmsck1hbAIlRxJbP0L6L4JWvRDoXOmxxGJWiHcRE/wd2hk4OdKj45ea13UzeXi8+b7s/Uhk2DLowJZyHflKMGGTNFBkBZaIydGs0vTGtpY0xvqzkshNBbhsJMzn4hVIZUb2J8vfcartTyYSATRpLrui5+QgAUcFy4xZ4h5WGzzYfxUXb/gerrNZHUo+Em76LvKr+Lo0pEx2Ft2EGhCEoCxQhlsz8Pn+mcqXjNx5loyEv1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSR+UKWgbR/LZFBF5c0DcckYjh7TnP1A8h5F7JF9lX4=;
 b=BukcM7cT0SzjMde3+NbkFIO4ZSgtQFh/FLQNXZ23zOfnh4p/UfN8rhJF0CFGe0vjZOcyrnzg5rhF+cksmehpvLJ+TImyHMu9uexGFPZEB5p6eZ2F7ZePh5kecSKGgzahIPu7CG72lw/ph2YU2fn5mx0mqlUoSp8e/iTLuy4Qsj7Bb0szfSAZGtxZfBxKHxnT8+4x9vyD9GoHRfbxS5ghSqRYRNmU0GbYcNrtabIOTuEVkgR40C1yfiudS0Gmr2Hf83YKGllriu7kBePOm89V7r9jFK+Yb2c8VkkF6U0fskD0SmG6qjB7uVKiky+zk2/yneWwfV30tuDSitJCtWvueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSR+UKWgbR/LZFBF5c0DcckYjh7TnP1A8h5F7JF9lX4=;
 b=ImCm3O2ydyaJwz9RH4/Eb/0a5p839Pd08gA57XFWHPsD+ugYryfpVAtKtl0McD+WuIV22u8lwaGxL8J585RZXgpdR1aFID95Yd6h6o1R6y3zth/aaHA1ggjUPddkuDcTeom307tL2OQ+1mIFwBEbjYnxd2nxXPaEBkT1GHhGSNFcNBgrgV3eaV87WngFRv5ujN+BA1EXXbJT3tZgUccnkSY5yAbCamye6oTrzMOQgQrEeTlc7mdzt2acvqLn2AtT9bpAGmDuIFAcY9pdny7iuCL43RhTeOYUnNPQ6JR6bycsI47BXdZdica6kLnuGoY+I6rkwG5Q3+4LpVNN89JoBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8607.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 14:03:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 14:03:01 +0000
Message-ID: <3d62edf9-8d55-4e30-bcb9-7af6b9a2ac14@siemens.com>
Date: Tue, 18 Mar 2025 15:02:45 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 6.1.y] x86: dovetail: Harden __send_ipi_mask[_ex] for KVM and
 Hyper-V guests
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c29ce62-f2ff-458d-06dd-08dd66259849
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UE9HNnBic29KQS9vM3FjRm9LS2VNeWVHSk15b2ZnNFd1NXd2VlAxaTgvaVU1?=
 =?utf-8?B?bWlRdm9iWDZQaUFlRXFOL3MrTVhWZ1orT1h4b3ZObFB1Y3l0b3hMWjVoMzgw?=
 =?utf-8?B?N3hLNHFSd3drWDg1SEx5dGhIa0xQbnd2TFlZQlA4ejRVWGt1OW5nczZZQXpI?=
 =?utf-8?B?NkZ1d0wvSVFOUmdXbDFjd0c5Wk5rNU5iU1NFV0hkTmJ3bGg4dUtOaVNNcDlu?=
 =?utf-8?B?ZTB4T1FLd2I0UGQvTmwwbzRDUzBqMGxPZ0p3aUtUWjhFRFR3ZUxiVWdqNGIy?=
 =?utf-8?B?ZnNXQzBORDFMeXoyRDVtZy9aejZRVHdpSmU3L0JVaU1GR2IzQTdRYk1lUHZi?=
 =?utf-8?B?c2doNkFNKzFqSG1SdFhWTUVnRDV4NnQrWW8wbU94ekQ5L2h6emhUVFo3YWpC?=
 =?utf-8?B?TlJHZ0dRbE1mdjN1ak5pNjRPOGovK09LanlsUFRobUpJN1BmRlNtcUEvTDF6?=
 =?utf-8?B?TG9Qc2Fpa0VBVXJMVGxXSUdDMm5IeGhkVmJ4WkdwaGJqYVp6OEkyb2d2Rk1O?=
 =?utf-8?B?Z2lPZVBzTGJnWmdpUFlibkdXa3FVQmxWdkdrU3FLK2hMYy9yQTBWTkI5RzBK?=
 =?utf-8?B?VTM1WFFoUlYrdTY4QmJyZlh0SWJ3UHY1UUVDcVJyUlNuUmhERXBSdFJLaVkx?=
 =?utf-8?B?M2pkQzVXYTJVZ2Y4NDUzN2UwOFRwUzRWVlE2TjE4UERQYm9RcUNLaWp3K0ZU?=
 =?utf-8?B?My9FOGtVS09WNnR4cFd4SXgvYzdqbDc4OEh2N2hCanRaSmxtdy9XdC9OVzNR?=
 =?utf-8?B?ZDFvYnJGREFGdXBxS3VkVEpmOFlIS2oxYjd3MElaYnFlM3ZZajdqN1BzL0Zl?=
 =?utf-8?B?TXdxVGZLQzZueW54K25hcmlFYmFrcTZjdVNsWjVQdG5HV2psd2VuN1M3Q3Mx?=
 =?utf-8?B?NW1pdUpyMXJwcnBYVGdtaFRpZ1IrbFBiazQweGJOYVRtcFU3bFBmSENkZ3U2?=
 =?utf-8?B?S3dxTmZBMFRCbE9EQkNYWUQ1RzBOQ0xuZDlCeUl0bVl4NUZWOHk1ZTJxbjZ5?=
 =?utf-8?B?TmdNUmpHVHdTYWt2dmNuZmw4QnZMZzU2b3QvRTZmVkFCektienpaYlhXQ09Z?=
 =?utf-8?B?b3ZxWkViWEYwTzhzWXpud2tjcE95YXJIK0RhdmliZDZ3aFhtbGpBRnlwV0t5?=
 =?utf-8?B?SHRjdDQvZkczMUVCSE1ETXBod1hXY3ROZk9mR0pSTzNKRWhvNlJka3U1eWsr?=
 =?utf-8?B?SlVzVTlRdU5nRGhVYTBONWZLSHJ4YnQzeTdML1ZNRlF5REtKOFlyeHhSMVF0?=
 =?utf-8?B?cU1FS2ZjUVErb2FwQ0xROG1LUjhaL0tFT0pBNndnNFZwWDNMd3lrWVFtRnNo?=
 =?utf-8?B?UTF2WnJUcm5sT0Q1WW1GOWpyRDIzWnFacTFOYU41QXRqMGhkWmVMUGpBdTdD?=
 =?utf-8?B?TG92S1pTclF4YW1NTWQvSVVjTTA3ZkFZaHg0c3FBbEptMU9YeXZHTVZZdUYz?=
 =?utf-8?B?Qm9ibHZCZ3ltRGRPR01YblArVEVJQUozMTBWSENlWnZhaTJMRjhvY1NCRXcw?=
 =?utf-8?B?N2dhTFl4ZWI1OUt3Tk5URjlIT255bHV5NHJDK2VkdHE0TWFkbHdTdllJNzhI?=
 =?utf-8?B?RzJJMUdiaXFScmh3UDFrTDJtVmZjSUsvMW1Mb1ZhZXgxRWsxdkRJZEdqQkZZ?=
 =?utf-8?B?ZWZhUHllWTlHb3c4ZkpSN2xRRENBd3JZbGhoUG0wUWV5bWJZWndTbmlEWWEz?=
 =?utf-8?B?bEFITnVLTGRvV0p4WjVrd3VJZDlYRjZ5aFh3OHgzK3d4QTNRdGphOU9GN2d0?=
 =?utf-8?B?UWg4bjhqekowSnQ3RVBTV3BJM2tSZk9yU2FRRWJvUnBXdEwxcFR4ODhEL0tY?=
 =?utf-8?B?ZzdBVVBmaTVoYzEwUzd4by94ZzNtK2h2UjFhZkFVQkhUd2toVlpMTnZGbEtu?=
 =?utf-8?Q?8zR0QnaBG/U2t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WURKeEJiTUJPaW9qNjUyTkpvRzBndXRmNDY5eTJIRkJwbUFZL1hNWW1zOC8z?=
 =?utf-8?B?d01kaGZ6YUpkMVpBZTc3TCt6VU5ISTg0a1FDa2MxN1BMNVJ0QlBNUEorUjd3?=
 =?utf-8?B?WjZCdUVkYzhWYzh6S3hPM1RlRjAwNFB2d3paUHk2ZHBtZjE5NytvejdMQXoz?=
 =?utf-8?B?TW13dDArL0FJcjBQUnJMKzJXbVdYM1hUaEp2ek5DUFBzWm5oRjdaQWV2b2ov?=
 =?utf-8?B?MVVRd29YeDM3TWVmeDNHcUczMk1ualJmSEcrL1A1VU1SbjFjMUpaTFJHUkJs?=
 =?utf-8?B?U1I1UGNpOW5JMXQ1MEt0QnI3bkE1Q1J4LytJN3RVMTJmRUpKbWJvQU5OWGRp?=
 =?utf-8?B?OVZDeXlCVkg2bTg5dHY4UW9rNzJaWGo4UXgyWjJZMG5Md3o3R3QzWSt0cHhW?=
 =?utf-8?B?Wm9wWE9GQVB3Y1d3RUx0VU9QR1hpVVN2RFdiRDZhWkZOUGdtY2ZIZ0RpNk1i?=
 =?utf-8?B?bWNRSGEybjhMRUhZdUJrV2NnZjdvUU85ZW9zUUF6SWNuRWttdm8rN2ZscHJy?=
 =?utf-8?B?cDhwb3VyTU1na1h5Z0ZCMUc0cUpFZzB3RWJXS3JUa3M0Y2pZYnkwblIxOHZv?=
 =?utf-8?B?RmxadW40R0JRMEtTN25rQVV6RVFYM1h6WlFQL0x5NjY2RnVBVXpqdExLTFFF?=
 =?utf-8?B?MFRoR3kwY0dXZFJTMHgxRDdxYU1rb3gwcWJYcDFSaGxiOS9Fa1pZZTBwTHV0?=
 =?utf-8?B?cXkzUFlOcTBab2JSbUNRUnh6MlNDQkp4TjJZNGJRVW10Vjk4RDRMVm5TcG5Q?=
 =?utf-8?B?MkgveUtsZnlOajQyMWR0dllJNWg1UFY0cDA3R2RldzdDSXRDaEx2LzRDM3pJ?=
 =?utf-8?B?cTRQdEtKRk4rRUFDR3MxdUl5V3pyVkVyOWlCNTlWSk8vb1lVcmYyNmEvZ1JW?=
 =?utf-8?B?TllObC9SeEVHSnpIK1RjQnF3aUp6OGNnejBvYVJmVHJwVFBNdG9mZDlmeldO?=
 =?utf-8?B?Uy9SYjltUjAxeEliMy9vOWc0RTc0bTlFWXBpWnd3SXZZeGRWaWppVm04V3JR?=
 =?utf-8?B?VC9NcG9EcitVSmVVR2Z3Y05sYTBVUkd6eGdrZUZvOUkvVXVMVVFDREF4VU4y?=
 =?utf-8?B?TTF0TllWYSs0b1hQMG41ckk1VnIrc1BHb3ZUWEhodUxqV3ozT2dVa3pjYzRZ?=
 =?utf-8?B?WTYzVkhlbjBtdWladjBNRStpTGd3eDhmaUdRUWllaXNvVTJhM0pUZ1pmL2ZO?=
 =?utf-8?B?MFVJNlR0a1VjMzlvYlEzUnJubXVzMzVqazJrVXNaS1N2U1I0WjdmYkhZc0dN?=
 =?utf-8?B?N3dLWUE1V2E5TmI4bjFSQnp2eURCN2NWczByQWpTd3VxSG04U0s4aklBTmIx?=
 =?utf-8?B?aCtPYWkvT3RONTMvVWJNNzQvQzBqeDFBek85dlNEamNOdXBSb1U0RG4wbjc1?=
 =?utf-8?B?am1Kc2c0aUtRWHQxcWJaUkRSTmpybGxMakxnQURaZHVFMVYrUXB1TTZUT0ww?=
 =?utf-8?B?a25SOG5IZVdLcGk5T0lOYkp6cUxDamVuWmVoclQwbXVtWHZiSTRhQXhxSHA0?=
 =?utf-8?B?ZnFtaVJEcXVpSldjUkhyUDZSVFkxQW1RTGZoTTJBV0o5N1E5ZnhWRTdubUV2?=
 =?utf-8?B?MDNFMS84VTU0VDdHV2g4Yy82aVB6WlVhWFVMYWYwVWxHMWpKR1FQRWRLVGhw?=
 =?utf-8?B?ZE9CQVlEUENvWEM4STZyMHV5SlhsSnVCYkYrTFh4UGNuQmw0bmh4N2NwRkN4?=
 =?utf-8?B?TjR6RWRpQ2oxUmNKT3p5V1kvbUczUTFvNEpLb1p2WHNnNTc2YmxTNTE0d0Ns?=
 =?utf-8?B?ZDNSVlRvTXZES3BjbndsTldJRVlaVHdoQXVTNEhxblIwMHBWUVY3eTFleUtu?=
 =?utf-8?B?NUxiejNXSHpicGwyMnlLeXJSY2NpcC90WEwyQUFvbmhCQ0lkU0RDTmtQQ0xF?=
 =?utf-8?B?cXlvSXlTN3RhTDhSRVpPcTZScSs0ajJTWHpsT1kxVG5hbmlKTkZneUNvNkZE?=
 =?utf-8?B?NGc3enk5RDNrRHFjNm9xaHBVZGg3c09IRVRtZjJXNlRtRWxsTjNLcjNrejFG?=
 =?utf-8?B?a2N6WnBWaHdUN2VVRDZHZFNmUStmR1IwT2ZCUmVHZXh1QmlZaUUxemNDZzJB?=
 =?utf-8?B?QkZOdS9TSE5tUDh0cmY4K2owMys4VGlyMys0YzZBSnVsZVBtRE9XSmFzUjFz?=
 =?utf-8?B?UFFTbm5uNnlwTEw2NFBab1lUWlU3ejJqSU81RzJ6NDZKZjkyYnRSSkFTMkow?=
 =?utf-8?B?M1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c29ce62-f2ff-458d-06dd-08dd66259849
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 14:03:01.2434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukNOkCjBMD4iqUvbpUpRsw3oc7/Mq9YSWcugIL0qrlzvC6jgOO1QanCCzdLFEHialPHNVDizijMxEB9/kcdjIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8607

From: Jan Kiszka <jan.kiszka@siemens.com>

These functions are called in case paravirtual IPIs are used.
Just like for hard submission handlers, we need to harden the path to
avoid splashes like these:

 IRQ pipeline: some code running in oob context 'Xenomai'
               called an in-band only routine
 CPU: 0 PID: 410 Comm: (udev-worker) Not tainted 5.10.229-cip54+ #265
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
 IRQ stage: Xenomai
 Call Trace:
  dump_stack+0x84/0x9c
  inband_irq_save+0xa/0x30
  __send_ipi_mask+0x81/0x260
  ? preempt_count_sub+0x96/0xe0
  ? _raw_spin_unlock_irq+0x33/0x50
  ? xnsched_pick_next+0xe0/0xe0
  ? ___xnsched_run+0x491/0x5b0
  ? ktime_get_mono_fast_ns+0x50/0xb0
  ___xnsched_run+0x491/0x5b0
  run_oob_call+0x97/0x170
  xnthread_start+0x23f/0x330
  ? rt_stack_deliver+0x340/0x340 [rtnet]
  rtdm_task_init.part.14+0x7e/0xc0

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/x86/hyperv/hv_apic.c | 4 ++--
 arch/x86/kernel/kvm.c     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index fb8b2c088681a..2fa4267a1b96d 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -111,7 +111,7 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
 	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
 		return false;
 
-	local_irq_save(flags);
+	flags = hard_local_irq_save();
 	arg = (struct hv_send_ipi_ex **)this_cpu_ptr(hyperv_pcpu_input_arg);
 
 	ipi_arg = *arg;
@@ -148,7 +148,7 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
 			      ipi_arg, NULL);
 
 ipi_mask_ex_done:
-	local_irq_restore(flags);
+	hard_local_irq_restore(flags);
 	return hv_result_success(status);
 }
 
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 6af49d30816cb..94c6a46c70515 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -522,7 +522,7 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
 	if (cpumask_empty(mask))
 		return;
 
-	local_irq_save(flags);
+	flags = hard_local_irq_save();
 
 	switch (vector) {
 	default:
@@ -560,7 +560,7 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
 			  ret);
 	}
 
-	local_irq_restore(flags);
+	hard_local_irq_restore(flags);
 }
 
 static void kvm_send_ipi_mask(const struct cpumask *mask, int vector)
-- 
2.43.0
