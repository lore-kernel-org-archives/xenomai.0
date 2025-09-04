Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011013.outbound.protection.outlook.com [52.101.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7ED2F90EB
	for <xenomai@lists.linux.dev>; Thu,  4 Sep 2025 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756981025; cv=fail; b=CFpQNBMO7+3qzdSNRpLiq6tYNqZLC7f7pDNEqvi5IV4IJ+LeZpQG33r5iRHj7kMLz+m8CG9CFhTPJBkox3tLQbgqxEzqiI8bHudTEwX0xVG9ZYD3+Z/FfqFSSkl94e2DXGnq1Sq5IbdfXpwBwrTfTIBtfjNpMCmxKrbsjrcWmYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756981025; c=relaxed/simple;
	bh=2F8f1yVTpiJyuK151NsHxiEdVcnGga0ECVuSpSMvwo8=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=RVcaa7pi16n0isaLoicRpbQqC1Tw3UhUuqiVfH9G4b7Ot4rknYhVCAips4FBXlX953FXr3fJUFyIOYyPI95Q/8H71q069f7AabLhaxaj52Rttwpr1HIjWwlKnZfxJfWeSGxlIWgjXV7FrKINvlhCLMY26BxGYC5/xQe5ARz/GNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=FtRQyUaO; arc=fail smtp.client-ip=52.101.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="FtRQyUaO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2g592p/J9SEbbHqd/o/tlKKYzDfMc0mCQxTLLHx7yoTEDU4X8BVAi2jQb27+dHuZC2ToXknsWCe9vvvZXED7JpqLbAm7rYpkrSuuDGcQcGjBV+8s6cqQnopZmIVOE08p0g929NbzRo2WZAs2jdI5FGIEE3iv+9hfCJ8lFiw2Pj2xqzXFQhpnGISkIb2Hx7bHKai1uEK8c2/CBloOmmn9D5D/bU45iw3QqIRE0lTdLjgRk30S9nEKa8eBs+xgBSxEdAk8EbZKqByxpgwD2D4/RIuMDQPHkly5+tTuaBGFtOpBdBZAs7ZrKjjgIM4BpHjI1nlD8rTHHVY4ks0cYG+9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odKtfbrWN2zPe3gIRPteyT+AFy0jL/wyHCv8+o0j/cA=;
 b=htVBU8eFYUrPaCAwcyjmizCi9nHng+bES7x7UKtooaVX9Pu2zBwDGtFoJIJPzC4A+pPQ6S+rc4CTtQlCjLHQae7Ix6bNfoISG0XhwTRZSYN+CR/uMdD08jYVnQN50ugpb0dW5dWP1mCN5OxtPfj4ByWz9gPD4k9W7l5B8iErHUnbrWB/GsoxiyLVSfdjMBJrZfOvr3G+iqGbw76y08E8aF898IKyw0kx66Zm16ztgVJKlYKjUM6XyxWqIAW55H3eadqg+WmB0RaOHse4fy/3gVIUhmfWxxB4F8s2Uu48cGEhm25PSSRtdZGgm6U3rFJh6QIJLYraFgtWQXJNRiyxuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odKtfbrWN2zPe3gIRPteyT+AFy0jL/wyHCv8+o0j/cA=;
 b=FtRQyUaOX8/m2IUktPzSmpP/OYrqAnGEKitxdkT3K5f4Inyk4afNUa6k8Vz4dB89IVa4rs2ykbNCxhQr8y+eEK6+aP0FxrVd59BDVnVjv+U3QdFCDLf3gn0njLOJvat7TEQHZ/mNdiId6CgNSmhxDMKjWm8mvVI9YK5BGhGTg0hZK78KyOKjnl+QIMCj9DZhSWf2REQzgjFvlvwcZiCMHY6cuXdWTprxqtOzW5I96L/kDkZCQAiG8nRwxEbH7e844hJ0krHHDoS6Sp1RlCBW8APyOdZkC48fvB1Z42rHmt5FIBMJRiF3UEx7YgTl3Gze36Is06JvpEhDwNJWzMw7iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS4PR10MB5646.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 10:16:57 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 10:16:55 +0000
Message-ID: <2505ed10-0e7b-467d-9df9-8f264b8ac7b7@siemens.com>
Date: Thu, 4 Sep 2025 12:16:49 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] ci: Address shellcheck findings in
 run-lava-tests.sh
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS4PR10MB5646:EE_
X-MS-Office365-Filtering-Correlation-Id: cf1e99f4-e444-4445-7cae-08ddeb9c2caa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDlZa3p4cXNzMU5za0kzcnV1S1ZtY3FiUURLWTF3T0hwRWF2OHRHUXAvQlhK?=
 =?utf-8?B?YzIvK0h5ejhNQXovWFp3RkpWNjNGblNoOXVYajNJRnRCcWQzZkFDWkE0emlj?=
 =?utf-8?B?TWJOZ0Y3MEtsM2JwUG5pTTdYSGpjeVh6ZzhKVk9lb1gyQUF4eDJqdWdpZUpT?=
 =?utf-8?B?RVdsdkJuakY2bWpkZDY2bmo1cWxwY24yYjhsWjBSd3BhTDM5eTJHb0pucHlW?=
 =?utf-8?B?dWlHVGEzZ0VNcnJCckdKT0YzUkNXSVVwZ2RFOUVtb0RteHZINGJKdnZaQ1VN?=
 =?utf-8?B?OWF1NlRhWE9yZWNsRjhseVVUSWtQNS9VY0o1RW1wK0dUV0Vmc1J6NlJOMk1w?=
 =?utf-8?B?RC9OUGszVkpDNi9NMTNUVjF2L3hGK0hpMDI2bytBLytRT3hrYmxUTkx4clJu?=
 =?utf-8?B?R2JpYVlhaTRsL1Rvak52ZnNQK1JVKzJMRGYvSkN5M0RmMXBDcUt3eUJlVWdN?=
 =?utf-8?B?SUdvTWU4U203TXgvOWRmQ2pkcHFBd29kajVneUlCb05iV2NFYVhZNmFtTzJs?=
 =?utf-8?B?ZE1PSjc2VFkrbzZGTGYwdWc3cHJDaERrUmliVjFaYjhNVFpocldMSnQvNVEr?=
 =?utf-8?B?WitlTGdoeUJxVVJQU3Y4UTRySkVON1ZjZTdIWjFub2xyV0tqaUJyL1FSMmdo?=
 =?utf-8?B?VXRidVRsTkY3eWN5M3NtRDFwOFlqS3VtaS9TMW05T2JhTzRJVXR3YkJuZlkx?=
 =?utf-8?B?UHRSUUZBbnZXMzJPR0M4TmRpZG1LSWtvWGJYUFgzOXZ0K3VQVFNCckdPMHI4?=
 =?utf-8?B?VUsxWXlHS3pkdE5uMGdCMGlPYkRyZEVYY2FaUDkrWlUrWmFRZmZJYWZKZHQ4?=
 =?utf-8?B?dE1qZFhDS0x0K01EUk5LMHdPdUFTRWJBTldXdSt0RU1ZeGJvNUtQYVM3NjNo?=
 =?utf-8?B?cFg4eDA5VHptMkRzdFFEeWU0d3BMcXo3WGszdlkxS09ZRStJRmZ2TEtERVhV?=
 =?utf-8?B?QmZ3NElqMXBrUXVKOVlmOGtQQTcxeXczVmF6M3BEY0xhM3ZKSzBMT1pBaUNG?=
 =?utf-8?B?QmY4dTVBbzJUdUJsUnByMDN1M2NzQlQ3VjVaZWZWb2ZLb2NFV3VIV3EzUWhj?=
 =?utf-8?B?Q25LU215ZStpRUN3ckN6MVRpMTJZN2ZwVTRKOW9hZ0c2cnZNZ2F0aEltMGpU?=
 =?utf-8?B?YWdhcmYyOFNGZlEvUXo1ZGk0Q01QcWlTMzI0YVFHaHZnRHNJTUlaT0h1blZy?=
 =?utf-8?B?Ykc2YlJPVHZRL3BXcDBLb0NTKzg2UDVMc1lPdC9EN0wrOG4rZFNlNlZFSmNU?=
 =?utf-8?B?SXcraU5VRmRPT1UvcksyTVR1VjVKakZsUkJWNm54REZJL2hxQjROMUFRandH?=
 =?utf-8?B?S1FzWVZzNU90RmpZVWExZFNHRHdHRGJVd0VnWUxWVkVhcCtTSnZOd1lYd2E2?=
 =?utf-8?B?RmFhV0hxbjN3akJ1UmExRER4WVZCM25UMGNNUm5Id2IyWmY3aW5uelp4Mnly?=
 =?utf-8?B?SFlXa2JiaUlXM1NpclY1Zk5aMTRBQlJZWlNJOHpjMVhZSmJoZWZQOElQTmNu?=
 =?utf-8?B?eWtSSW54Nk5UV0R2SnRjRERvWUNJYWlOTTFkdGpuRUFQYzVQMnE0aHZnY240?=
 =?utf-8?B?aW1WUnBCK2MzeWtpcVhBSjVQRkU4angrWlA0SUtQZUEvNi92cm5EblIyeTA4?=
 =?utf-8?B?V01aSVpVUTc4RVJHS216UGhrcTBwR3gzekJoTlRBNnoxQkpwaFpiLysrMXJh?=
 =?utf-8?B?VjFsbGU3V3F2Z2dYN1kwV3hTSnZKUUxxbmZiTTdMZnYzTUNlTzlZMUtkY2JJ?=
 =?utf-8?B?ZnRZdEJRVk9POFlmRmRobkdHb1ZmSXVvOXFwSkV2VHREM0doQ0JpRUpEbGY5?=
 =?utf-8?B?cUgxb1pFekFSY2NiVHd6WDVuNEhhRlFnZ3IwYUpacXVMTE9DdmZzRzdVbTBZ?=
 =?utf-8?B?MWxnT28vU2FEZFRMQ0NtaWlGUU9udUpVVVdGSHdRd0g4Q1ZDMG9PZ2Y2RFJQ?=
 =?utf-8?Q?kw9cY3HWTPs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NS83d05ONTFmVHZMUmVnb0F2cldka2xhMW53K0hBWGlLUDZUZ2JhbnYvdW0w?=
 =?utf-8?B?bzB2b1RXa3JiWUp2d2J6VHBGTWZPR3JVZSt5SzQvVmVnMDhnbnd0UjlJckJq?=
 =?utf-8?B?Z05CTkc3Q1RjVWZGZUNCVTQwZUg3ZnZTS1c5bDRMSEJON09tR1lTZkdVTE40?=
 =?utf-8?B?bUFIbnlRcXNWMkxJejBSMkdEMm1CZGY1Q3A4aTlFUUV4N0JydDh1SGVPSjBp?=
 =?utf-8?B?MUQxUlI1RzB1YkIxVDRUWCtsNHJSMkNWOU1Nb0JKZVprMFh0eHlmT21jWjBm?=
 =?utf-8?B?MzB6WlhKb0lraEhUdy9weVpLVkNQek5CMmNyQm1WbFZOdXRNSDVzRkM3aUdB?=
 =?utf-8?B?RGg2K2xtVHo2eTYyRzdJYTZXeldZWWFhTS9iMVN2WUNOYzN2eTZjNGZQWFhE?=
 =?utf-8?B?c0FmajRqVWJkbURPR211Zm5LaTFReGhkdEZTN1c2YngvTVFwbm0wQVNRVWY2?=
 =?utf-8?B?K0Fxa0lzazNOVk9WTWpmT09JcXNvLzhWYkJPSlZWekt2bkwreWE5MllXRUtt?=
 =?utf-8?B?MzBNY3Y5ZEIrSTVOdmhXTTVaNjBKaWJOOHE3T3pITzZtWXFzVVhIS09GMHVO?=
 =?utf-8?B?dmNTcUYwVlFkaUVlNlpEQ2NzdWN1TXdFWXo5bFh5SFhwRkpXOVorVlZCMlRT?=
 =?utf-8?B?Z2trRmZ6aEorVGJudDRrN2VaMmxOSXdlMjdDVUsrSStuS1JQTHJ1SnBSMFR1?=
 =?utf-8?B?dVgrMmJkN1JoMTEwb2RJbHZ4NjZYWUhUZVJMV1Z5Um82dVFKMjlXakkrR2s3?=
 =?utf-8?B?b2hJbTJmaWk4TDh1d1czSUk2NThXdVpKd1AxZ2RPeit0R295WHJjSmVHa0ZS?=
 =?utf-8?B?elZlZXEzei95K0wvK1FYdUo5ZlNGVEI3R1BnMTUxR0hyOUFNa2duYzNGMlNk?=
 =?utf-8?B?TGZGZ2syQzJteGwzMFQvcmM2S3VvTGlWWkIvQUsxNEF2d3M5RmZsL0NkMGNv?=
 =?utf-8?B?SEQ1dlU2RGhsb0J0eGsxcUY0YlY2MUE1MkNRZmFodnkzeG9CQmtqd1RoenUr?=
 =?utf-8?B?Rlp5amlhMXBvc1hUd3BXcjlva3MwSDRnMmg1SU1zUGJOUzVBcmRkR01mUkpC?=
 =?utf-8?B?ZmF5SGdzeHlHRzVxUWpibGhlN25YbzhQSTJQWWtHZkwrMTgxTFN3TDF0a2lr?=
 =?utf-8?B?ZUh4WXZnVWIrVlg3ZVM3OFpVREVaMTBZVUtlU0h3QzR3dWZlRTZoU0YzYVdP?=
 =?utf-8?B?YjFNK3dHdElqTTdmMjhMOE5tcjljTUo3RFBxTkxDYW1wU3JLVVhxSUEydDUr?=
 =?utf-8?B?dGU1bnZlUC8vdmNrRGwrdmFGcy9BTWNKdmtRTC9TU2h5TzJTaGhrQk9rWlY4?=
 =?utf-8?B?OUZZejdJZnk5Uy9KZjZ5ZzMwc0M1TWxhY2ZmVVROVWl0Y1ZHOGk5ZFg2aVVD?=
 =?utf-8?B?eWhCd0taZm9Cbmo2aUpyWWpBcitsRmJ2SlJmNVdSYnIwQ0pqMWFjc2MwYVhG?=
 =?utf-8?B?SDBuYUc0VVN5NUxHY0gvU0ZhQUo1a25md0dZQTh4UTNqdTdlQUlyUTJ5S2JJ?=
 =?utf-8?B?ZjBXVVBvSk5OQURDMHRWVHVla0tMQytXbk1OUmU0dHI0ZkxibHJ1QWtJaERa?=
 =?utf-8?B?RXpmR09SQ1FyRjNLdFd2cWwzQjFvcTBUTGU4SnNHZGx6UmQyeWVTKzI5L3E0?=
 =?utf-8?B?em9aVWNjaXllMmZpNjdiWEd4bDNuWkdDdi9Fd0VvS2ZPNHFya2pVc013Wkpu?=
 =?utf-8?B?UVZ6QXBTV3lHQjJwOWFPdHRYekp0ckZCcHhhRUhpa0pXOGFIa3FXMlFxemti?=
 =?utf-8?B?d1NCTG1IRVJWUmZlN3hWVXVNNWtHUjFob1ViMkNxRDhpVy94ZmtZYUxNUjZV?=
 =?utf-8?B?U0JHVWlPRDhONVd1bjVDZkZFZUFVcEliWURKMGZCRjlLR25EV0RnQ1hsYksv?=
 =?utf-8?B?TkQ4S1VsRjcwNU1aUFYzYjdlSjNabUFHUzJOWDBzNzAyMnpPdEJ0SDZUcElI?=
 =?utf-8?B?dnBDY1pzSURCZFdFMXdNdzhWR3FuaVdCNm94em1BMWZvRXpaMzJ5VjV2TWlw?=
 =?utf-8?B?N2tySGJYWnVVdlZ1VXNvYzFxam9ZRzh3bzJGZUkwcmM2OFI1MEZXd2UzNkN3?=
 =?utf-8?B?SlBBeWpGQk1XVmtYdzd5NTdicFZKWU5GU0lLMVdCQ0hUTnpPeHFlOHZmOURB?=
 =?utf-8?B?VkxVdG1zcGZFcnNmU2gzNVlrVzRldm1leFI0M0JnV3U1aUxMN2tTRVN3UXJF?=
 =?utf-8?B?Wnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1e99f4-e444-4445-7cae-08ddeb9c2caa
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 10:16:55.7683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mfzZN3sZKHajWn5akoA9LMlLNoJRQ7SbwKWK12ZBJHxZ8+1jTKcC5lefdK3CQvGHwtpo9pTFd1ZS8yizU7fsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5646

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/run-lava-tests.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index 2293872..2fc19e5 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -2,7 +2,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019-2023
+# Copyright (c) Siemens AG, 2019-2025
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -21,7 +21,7 @@ get_first_xml_attr_value()
 	file=${1}
 	tag=${2}
 
-	grep -m 1 -o "${tag}=\".*\"" ${file} | cut -d\" -f2
+	grep -m 1 -o "${tag}=\".*\"" "${file}" | cut -d\" -f2
 }
 
 get_device_state()
@@ -61,7 +61,7 @@ test_definition="tests/jobs/xenomai-${TARGET}.yml"
 tmp_dir=$(mktemp -d)
 template="${tmp_dir}/job_${TARGET}_${CI_PIPELINE_ID}.yml"
 
-cat "$test_definition" | envsubst > "$template"
+envsubst < "$test_definition" > "$template"
 
 echo "check for device"
 time_elapsed=0
-- 
2.43.0
