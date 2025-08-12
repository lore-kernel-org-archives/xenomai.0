Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013018.outbound.protection.outlook.com [52.101.72.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D65E286D44
	for <xenomai@lists.linux.dev>; Tue, 12 Aug 2025 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755008418; cv=fail; b=L2FbA79vSpTzMZ7iqIofcnyqHFPtA/AMgAK4Y+B4P8Ag9AgAdKcuatpnx4t/v+x6KyRj2ZMxZwQvOpzEQb5lDenjgJlT+0YSDmAmkMJGjTA1uqgm7zxE3GNcuA3Vjb8wbuzKXXJ4r99wqVUPuJV6izydF2iTNF/D+NARrYrAIyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755008418; c=relaxed/simple;
	bh=D92iDNPdV28jfD/MWANTmA4hG8iGYskezSrQMudzyKM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hZ+CHpk3gSyoMJ6jj4mC2mtxDViFCm8URi0TFmwWMKwCmKMyCjxiCJDwpdbOzAtmRlyHkiyJH4IVEd6188o+K5TwV1Q3N8lOsusTOegPhqubaIwczKVa31kPC9OCY869Ajv+MjM/KK9666BgjyToKXwBgx7hAjJTf9POFvGBQgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Hngrg1kF; arc=fail smtp.client-ip=52.101.72.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Hngrg1kF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfrFmCmNRWsAJE5mcU7yJDH7cdtZVEFVLo+c8vH6s5edIK0JAlhg+vMtMA8uk7g42XOArjvcnxPdS3TjVSwiQ7Vp/kXqhZF8WNFTyeh/sbiv/Wta9vdXhqhYJOuWA0iwd77ceuFcZlDPTtncvUIR6QokNX51ZaEJIYpBWQwPjR2lVlVpbJStC7h58Q6MtQAanT5kYNTjawwAlpbYkJ7YorEiObk8Z8/MSZr22KmtKtkINo2sQP4BVw/5A6FWZqYiokPpgBgC7VW7WcV1z3EUTb1lSYgyL1fwoYWUDTF6Afhpr8TZkhGIVAPawi1joSnf9gi87tnOqc0MyYgEJ/9I1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsLyFaH1+v1WSgbQSSzVWO78228ZQqzz1sUnPAasw4U=;
 b=aIIercpIys8yE0qZnn/+d7Jw5xK3n/O5Ow7dub9S+3x+rTfuUHiFisrWrqELo+wgrX10eVFzuJxzAYM8TNBtGPSad4wLVEy+l+FyTV/pEo6nLzLgutgqBRY6I+vlMngN+Dpv8H6wJyWqgXq/cVcciL43DxzfzEsb9FVlYI8mtCXNyCHgMbkpG6hi5KLnXpY4gIMiXbliApG4K5FXqEHDr6FYa8VNzXHUUj0Mz/XV9q6xNzdBJc1+8maULnICuPUBQ7ATL/Gq0fl+VoigNteIuMbisLwFK4w3iG+B5DYov4H1UHBuhGLRTwVyruUOMhDXhmLl5qpeN6jLX3lbfzf38A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsLyFaH1+v1WSgbQSSzVWO78228ZQqzz1sUnPAasw4U=;
 b=Hngrg1kFz8CXUBj9e2bAsRVU0tSqqlyBuVei75I0Cj1E9qy9Y5wRC0B6rWMudkzZ74AwHCzn8R/UfPTi01Ob8P/dftwX3VRRQDoZwH4pqZo0nETOm7yblBF2eeqq5LHf7GbYmuFJne+AXIyBvn3l96mDwbvcGdLZ/iHAslejgbcpvOCgA5pZaJnoFY6Cin7hrEvhFZ2cpI4u89yyvW5i2jDTg6NhVSrhJ3JuC07m4KPPuiINMN3q3Crn/do2vUilos+Y9I20Ee+gOqmMsoF25EgCbQaONc7lNem/MK7XWdCTB89Y+v9euvySVAQPCXYenSC941r0l9nVkER19DZfsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6382.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:be::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 14:20:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 14:20:03 +0000
Message-ID: <bda4eb89-41d9-4b80-a332-194f1433294c@siemens.com>
Date: Tue, 12 Aug 2025 16:19:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: We are moving to gitlab.com
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Philippe Gerum <rpm@xenomai.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <a1f7db9c-0422-4b1a-a762-d5ad2d9edf99@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <a1f7db9c-0422-4b1a-a762-d5ad2d9edf99@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bb5d416-c99e-45c5-c017-08ddd9ab5425
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmFKQ3RCbnMxOUpjVVcvSE1lMlVnV0NxUnRGaWQ5c0U1SmFQaG1rZVk3U2Z1?=
 =?utf-8?B?SDlrZDRheWlYa2h3cFdtcnBDSlhzbkZKajZtcmZGaDdVUG9MbStEdDluWWRz?=
 =?utf-8?B?WWUvYXduQUZ4TXdPWWhuVFJ5QVhsaWVjTld3Ni9hZkNJRnVrMExFOGhmZm82?=
 =?utf-8?B?Uy9sOTFCYXF1QTNPNE9KOGN1d1JYTmtob3I2dWpETGFqSVdTN0cwOVFaYmpQ?=
 =?utf-8?B?TEJvODJaUERmQ2RiZXl0UjJua0VLb0VNaUJaSXQrSXVNOXYrWlpUelJPOU1Y?=
 =?utf-8?B?dkRpaWY1Vm8xZ0VsYXBmbzYrQjJKN0FlcjljQTlmNWk4ZTdObXptVFNoNVUw?=
 =?utf-8?B?c3pVYmxnd0xiL28xc3JBNjlISE9tblROdVBWeEV2MlFUWExSNzJBRWZzeTNm?=
 =?utf-8?B?OGZ0Y0pyZGxaNVQ0empIMWtERm9GNkJmTDgrZC9NWTBHcnZNeVpKaEFaQUtL?=
 =?utf-8?B?OWdodlR3aG52aHRhUGN5bGFSZWkxU0xRZ0x1NFdqbGJzOGR2eTg5RWZZYUNz?=
 =?utf-8?B?VzdIYlpMazBSVXNSQldIN2F0UTJJUlA3MUhSZGt0dm5FNW5ZUXNYQ2lzeHRj?=
 =?utf-8?B?bzUvTDBrT3RKTlRnRk4yV3ZQeEJvd1RKWmgrdWZhV2N1NENUS1ZoWXFpMDBR?=
 =?utf-8?B?QUM3SjlmN0NPZ3JOVXZVbEYxc0kycXNRaXg2TThUMVVnNWg2bWRCTDFxVnR4?=
 =?utf-8?B?SU0vNDE2S3EramR5K05hSWpQN01vSXkxQlM5NmE5Sml2b2pvZ0toNmk4d1ZO?=
 =?utf-8?B?c0d6aWloNStyZmJGYVg0S3ZyWXpJaXd4cVdqU1Vab3NWWVo3eVk0ako5aHNn?=
 =?utf-8?B?Uk54a1M3cEhrMGwvOGpvK2Q2ckNTUFk0dHdKUnRCQlVwOFJRcXB6bmFZODhK?=
 =?utf-8?B?RDJaMDYzZHhibHlVS041N0liazZjYUxCSWlMSE1CU1pBNkREOE5uM0cySEJB?=
 =?utf-8?B?SmF5U0kzWjZOSU5XMDNtY1F2cnlKaHF4MGxTaDJxQ3pGYTN6MWZQN3FkL2E3?=
 =?utf-8?B?aWpZREIyT3Ryb1lwVWZQL0djWXR2S1FxMlAwMDBqa1QwT1pEdXAvQit3RENI?=
 =?utf-8?B?cW54aHpudkd0NVFhUG52RkZPTDlDb2c4cFR2eWtPVnJxMXc4NFFKMWxIYStE?=
 =?utf-8?B?em1oOG5kTFB2MzZ5WXpnRjlrdkNhM0t6emMxa0tzQ1phZ1RoMk5ROFVMcGQ2?=
 =?utf-8?B?d0Q5Qkt4Vkw1WjkxaUtlZEpjRTlFREloZ1ZSa2hTTTJZUWlKT3doMDk0ZE9Y?=
 =?utf-8?B?YUtsMVdXRWdMQzlTMzdRbW1ydjdVSWwrMkN1eWRmQTBCVXpPS1ZLREdWYXZX?=
 =?utf-8?B?ZitXZ1g1dmN5Rk8wZnhWWWRuY2hwdCtvZEQ2NzZTTGtWTXVjN3RPSHdkZWxm?=
 =?utf-8?B?Q3VrR01sK0VmcWl1M3ZIUmh2eXlWYVhiYmxDVEpIcjlKVEgrOE50UHR4d0Vv?=
 =?utf-8?B?dUtJbTVuZk9XVjk2NDdnSGZlUmo4dTVtMHBLVmtOZ2N3YWhsMDBOOGpCNWRQ?=
 =?utf-8?B?NktWdzA3OVJ1NUNMOWxkOWZVY0dCQ2t5Y1Y3YXhiRlZ1WE8vNzM3V1FvY29x?=
 =?utf-8?B?MGlaQjJiNEVwWEpVNlRlQU43UjgzSWV5UDNlYlZmeFpPc0luSTBxZUk0RzdX?=
 =?utf-8?B?dGxCRndYOW92c3BZNWV1dXBLNjZNR1BmZlJmTStrd0ZnWDNEbVNaTkpEMFFh?=
 =?utf-8?B?SmEzREtTa3JKcU5JRXRoSHFJMmVZamdPSnlaRWJkdFQ4TkdNY3pVNkwxVHRl?=
 =?utf-8?B?cmxzQ3pIckY0a0ljSFcrTXF6MldNcmF4c2lWZ0x6MG5hSGVGeW83Z0Y4alZO?=
 =?utf-8?Q?qOnBmbKydIMiAgQHhdW9a08OFCbtkgVYhbXeI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHp1ZU9URjc5UDVjeFlXb1E1RVlRdWtUbGpoZTdUZ0JVWndDYVpQS0ZQZGZ6?=
 =?utf-8?B?Slp0ZjVlQ3ZiTEhXOWhkWWpmeGV0T1ZvMzhjMmwyd0dWTi9QaWhDRklpcFJW?=
 =?utf-8?B?R2RyRW9tREM5RjIwMzZwUDZVNWw4L1ZJL3ZCSTliSFhReUNnL0RLTWUyUVRR?=
 =?utf-8?B?QTUzYkdTZ0taR25teXEzNE9RS3hxWlNjYXNWTEt0THV6YUhORm8xMjFialE0?=
 =?utf-8?B?VDhmTWNlcC9oQ2ZvQ3RjaTRSdExNUGxwSHVwS2VOZldKd0MvWmQrSWRZb21w?=
 =?utf-8?B?QmFielFDYnM2Z1k2SDF4OFdvK3g2cHM1RklYdmF2eDR3SkQ1bHVJZGY3VGs2?=
 =?utf-8?B?MnhoYWZFSDdGSXpQOVpNb1ZkVk9TL1BmRUxNRG9EK29VU25WY1FPbTgrbUdv?=
 =?utf-8?B?R3NnR3ZsbEswUDdCS2RSQnkwUUVlWHhET0x0Nm93bDI4TStObXNXNlF5VlZi?=
 =?utf-8?B?OG1xanFyZm9zd25DZW9DeWdxTDVmNFdtQWFGY3FjRERXaDIvRUNvY0JBc0lv?=
 =?utf-8?B?ZEw4ZHc3WUhwNlFIcmJKVUtFMS91QjNwYTdZNmVLdjVPb3d6NGJvUVF4bEZa?=
 =?utf-8?B?UVpVQStjUmV3TVBtNTc5MFA2OFVOQ2xBTW1tbjgrT0xmdGFqK1lINXhyaURx?=
 =?utf-8?B?Nk8yemlsQUxDYnpESmhUVmlydEExRUlEaXdKSURSdkVsWHdzdWVzSndEUW13?=
 =?utf-8?B?NmZOWmVtalladERBbSthN0oyZ21vYkVZczUvVFBpbHhjaStMM0ZFUHdQclVz?=
 =?utf-8?B?Y1I2aGpkdjdzWWJ5dGx6WFo4WU01cytLdXdEM1BMbHBmSXBhWWlZNG53OFQx?=
 =?utf-8?B?U3NBS2lwTkRaY3EyUjlUakI1aFp5NE1haWVHanhzdTM1bjErcE1VR0pBS0tT?=
 =?utf-8?B?NEh2S3c3aU5ITVZPV0M1eG9hVDlxQTdjSVVHaXJHOTNxT2QreEMxb3FPRkdt?=
 =?utf-8?B?ZDhkbmYvWk0wUzNyVzlQUHYvdmlCY0dUb2tVN0duQ1R5WmdyanlHWk5NSklK?=
 =?utf-8?B?WkMzT1Bpa29sV0VBbkNYcERGb2VTa1hPV2VabzJ0RjRPeGNNUmhISk1Zc1ZY?=
 =?utf-8?B?a1J6K29pZW81MVFLR3hLemhyZWJXQ2djcCtPbEF2TWVXYXpleTQ5Qkk0b3VO?=
 =?utf-8?B?Szc3a3hXQTk1L0phQ05uS25OYWJwSzAydzBEWkM3ZzJISGpOWDFKdTJ3N2d1?=
 =?utf-8?B?c3lqTUZJWmltbEtFcVRZZG1CM01PTkFUTTFxSkZqR29LZi8wSlRYYmlFeVFN?=
 =?utf-8?B?TDRGSHhlMEVVVHFCU0pWc1hnK214VVdIVHkzUkIzdGpZc2R1S3RXRG5IMEZy?=
 =?utf-8?B?bElrUkY2czBIS0NqeXdGWmVhMXJVY1BqVE5CaDd5YUVZZG9xRzVNaHo2N3pv?=
 =?utf-8?B?aHFHK2dBWU9DY1ZZNmFySFh3UU54TWFkdFFWMzRGc09TZ1ZTVFlxY2NpUUUz?=
 =?utf-8?B?Nm9oeU9sZGxaUnNERU8xQjFyLzJzZi82Z2E3ZGdqY0FMTmdocGxSZytLdmgy?=
 =?utf-8?B?ZUJUS0V6aTBld1pNSGVCRlVSUWt1VGNEbDVMSjF5VUM3Q1Z3SnNDVjZzOXFp?=
 =?utf-8?B?Myt5VGlMV1U2RXM4Qi9EdHhYdnlrcC8yKzV1alNoQUYyWVl3aW1hdk9kSkxx?=
 =?utf-8?B?aGlPODN0RW1BOElRWnZWVk1HejFQMjVzK09uaFBKM3ArSUhiT0RzbWZuU1Vl?=
 =?utf-8?B?b1Vzbmo4dmR3WVVVcEhBaHk0Z2NtcmpJb3JrbVlRcko3UEV0bUN3UVg5YUNj?=
 =?utf-8?B?YXIxMEN3UWNtelRaaFd4WXc2cjh1Qmx3aVJPV1J4VUp6RGdDd3BKazhuRlpO?=
 =?utf-8?B?a0ZyYXE0SVVKRzR5eFhNTVNqc0ttcFR3ejh6RFEyeGQzY2E2RnpCWVhnaXhk?=
 =?utf-8?B?R2RkdHI4UjhPZG5FcGsyVXFTK1pQVGVlQjBGdUU0aHlVdlV2YmJVK3JXZEsr?=
 =?utf-8?B?RGtXUGtGRXRnZEVtdGxBN1ZvRGtNaUxmMXZnVUFpclpFbGZCQmpzVi9hY20z?=
 =?utf-8?B?bTRGM01jczlFWkJrdkZtajdlY3hkODlncWRNOWxIekVWVWJYYU9iajRrdXh4?=
 =?utf-8?B?cVpiaExtL08xUi9YYm53elNabDFycjVzdDRrM2oxRGNzZEg0UGl0MGJQd2ly?=
 =?utf-8?B?VXo2V0dDTm15cno2NjliSDBqK3U5TDFoYWUrUGxncGI3cFM4MkVEMlIwcVpz?=
 =?utf-8?B?ZGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb5d416-c99e-45c5-c017-08ddd9ab5425
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 14:20:03.6018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMk/B+7L0ETq5yhVmcwvot2j8ZJdHURcNiYrNtUqwVPlL5PANjAVL/iJkk+B1+FkW4UU+L0I1elO+ML6aDlCVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6382

On 07.08.25 11:04, Jan Kiszka wrote:
> Hi all,
> 
> we have been informed that source.denx.de will eventually be shut down.
> There is no exact timeline yet but we better act earlier than later. In
> fact, there were already signs that this resource is at risk. Therefore,
> Philippe and I were considering options before and came to the
> conclusion that gitlab.com is the most straightforward path.
> 
> So I started to build up mirrors for all relevant repos under our
> pre-existing group at https://gitlab.com/Xenomai. At this stage,
> source.denx.de is pushing all changes also to the corresponding repos on
> gitlab.com. CI and websites are still on source.denx.de but we will
> likely change that next week. Once those services are running fine,
> repos on source.denx.de will become read-only, will stop mirroring, and
> all development will start to take place on gitlab.com. We will let you
> know.
> 
> Still, we would already recommend to update your git URLs, which is
> basically s/source.denx.de/gitlab.com/. If you find any glitches, please
> let us know ASAP! We specifically interested if Xenomai user in China
> face additional access issues now. We already have some mirrors in
> gitee, but their quotas do not allow to push complete kernels there.
> 
> 
> Another change along this: We currently have so-called hacker spaces on
> gitlab.com [1][2] which were created to allow any gitlab.com user to
> create issues there or actively pick up todos from them. Some frequent
> contributors also used those repos for pushing ongoing work. We also
> planned to grant access to the projects CI and test labs, though this
> wasn't realized so far.
> 
> However, with the main project moving to gitlab.com as well, there is at
> least no longer the need for separate issue tracking. I therefore moved
> all issues from [1] to new main repo at [3] and disabled issue tracking
> in both hacker spaces. Please continue the creation of and contributions
> to Xenomai issues on the main repo [3] from now on!
> 
> And if you are using the hacker space so far for pushing branches,
> please speak up so that we can discuss how to handle those use cases
> best from now on. It would be possible to grant developer access to the
> relevant main repos, but it would obviously be possible as to push to
> personal forks.
> 
> Note that this move does not change our patch workflow which remains
> mailing list based. No one raised the topic recently if we should
> consider a merge-request workflow, and as long no one does, we stick
> with our tradition. :)
> 
> Jan
> 
> [1] https://gitlab.com/Xenomai/xenomai-hacker-space
> [2] https://gitlab.com/Xenomai/dovetail-hacker-space
> [3] https://gitlab.com/Xenomai/xenomai/-/issues
> 

Quick update on the migration:

 - gitlab-based websites have been moved to gitlab.com, sources.denx.de
   pages were decommissioned. Please report any broken links if you find
   some!
 - we will switch the primary repos tomorrow morning (CEST), but there
   will still be mirroring afterwards, just the other way around. Still,
   please update your git URLs!
 - ftp.denx.de will be shut down as well, and we are still considering
   what to do with the historic bits under ftp.denx.de/pub/xenomai

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
