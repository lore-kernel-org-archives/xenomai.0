Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011049.outbound.protection.outlook.com [52.101.65.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041A4239562
	for <xenomai@lists.linux.dev>; Wed,  3 Sep 2025 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919174; cv=fail; b=JEUX7tr//fVndB8TRC2o4ecAIwGUGAQRZ9e7lS/o+Ezh125CdkfzLsv8+RDqRSUuWzZ11GbVS8kb6JjRwh+0/PRC1orr248py3XTb3oAy8i4SBC73RCM3b0Zgf85/Pw7Ciz32bTuTcYBpyFW9/+5QsbfuDcRb9dsFTwB7rPOR7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919174; c=relaxed/simple;
	bh=OK6l7pV56vGsbL3doO7kXRKc/dxve0HDHh0X52OryMg=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=soET53tQoDtTBT1EZbf5bJavbEgXUc4pZBkFZVLtoHKI/q1/ggC3vMXPe13g1KrdTXR9ObBKhYSSqKNttIP+huwX3SWEJHcLBsWMdb5VhPdtHxUYNbhsv5XcoREv6PsZN1XTbD0n2zj31hQ9OjRfMQlNH2B8PWGhm0RESSDj+Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=SeFNuy5i; arc=fail smtp.client-ip=52.101.65.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="SeFNuy5i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lH5X2UZ3aA69GVSiBt+OOVkI7m+VcyXu3XqNkMMQSBupwLWh8ikjwo55MsYeGmmtsXGuMcD5cVJonEc8+xnxyT5sb48XNJtJ4HSd07HZKJKSDeqDf0zHEEkB7O0aGxsJYVzBjrKeCZ1s9u5UFvNCUYrt7M1A1uSlngv16/e7LcQ4ZRx2lykk8lVtp4W7F5oNl2ADBTHNTY9D5xckJJ2VkOTM7ru5awNNgEU4eqw+u3PejnRLoVimSFU2hhZwAQazMFQ8jaAD4MQJAEPAe1C1TbOWT8ZV+f14BzSlNGJxbzW861d+9aBuX83dAbR2ZFYyl3XN8pPYxvAXLcPLbH7JjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNpc7M+k/y3TGnRFNbatSWtXpKPFd6kzpt7cfgC/wx0=;
 b=DcAAOxl6hAgmcseU063yjy+wqZMgkNIgutSTBN4D0Yefa2VsrluxzGDPf6SQcZSuI+4ArUAKdHHktRZJR/VmZX2H4oAxrjQV447/nfalFonT1kC0io/N1KOqPuB6qoVNBfcVrq9j+V8cU4zWV8rAEzjYSEXM+LDox8EbWSdYuK0bLad+sO0sxX8XUnaoEW+t1y1LzHw+CeKtuUlZ0Y6UdLRjGzNnc5PfqUC5zOJqZY8FVdWNfvQfXl1AJDTwIeSNGacmDLngxmvuJEFoIj3z90EKKdTWAhTARHDndK4JoGFoLMswasN/5BZt59fZOJN5/3tcPV6FfrLViiN1HKd78Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNpc7M+k/y3TGnRFNbatSWtXpKPFd6kzpt7cfgC/wx0=;
 b=SeFNuy5ick4dCJepnP8dikQ4DyqMnDEdyi+gTbDm3Jk7coTmE8dR/f1OQnhO0VDdSJg10sfl2GDkRI+eRTJV0Y1+Cuv6PDl6xVT9i2S0cRhmGYI/tWGSN7W4PoUp/7DEg3f64lz78uwiJEml3Ww/TIMVc0du5Mx8KIBBLn+p6rlkamHPHWQSHqdN8DmppPu5W+juyqE1PUzSYmDVn7gb2CVFm5PyxOafKT9U6VxGbzbpTMrzV2iI9t9j1vOQ9gvZe/8c2VoK7YNaadi0oukdXx2ESzW8lMWKMJtN14Fi6bt7wjnrwBH2/tz4A3rFQByy4JBty88dc+uMfu6mhrJrRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS4PR10MB5574.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 17:06:09 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 17:06:09 +0000
Message-ID: <18efcb06-0440-4b09-a624-0270a29ee416@siemens.com>
Date: Wed, 3 Sep 2025 19:06:05 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] Purge left-over from 3.0.x removal
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::25) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS4PR10MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a1ece8-d99d-4959-db8e-08ddeb0c2d8b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDZYUzdpM0JGRGdXaDVxaUxtWWRaME1ZUm4zZjh0UHFGNTFneGtDY1FPM3k1?=
 =?utf-8?B?aWFLMTlxaG83aFZqcmNWajZGNEFObWlSN3k4RmJrd0gvRmtIVFo4SUlneUtD?=
 =?utf-8?B?d3RqRWdqUTVUZXM2Y01FWlRQa0FZLzNWV01lQXpaSkxUL3k4dmlCakZNcWZ3?=
 =?utf-8?B?Q3ExVFdTWncyQjY2amhUTnRRNTNheGdEeFJsNktxbW8zT0UrMHBYUnN4NllE?=
 =?utf-8?B?L0NOcVcrc3B6TEtKb0xOUVNsY3oxTWFIdFBRbXdaUkk0MzJIb3NQcVRwcTFm?=
 =?utf-8?B?VVJOaDVFaHNIQ1hTTjhtN3l5TEkzUHFRZGtNdythaTBOVnBtc0l4WG9YSlh6?=
 =?utf-8?B?a3lRL09CcEc2RHNCMmZLdVZROE9PZmg0S0tsOTFoeUNEWUFxZmZJbTRMU3Jo?=
 =?utf-8?B?RmhFckpKMW9DSTJ3anNnb1lJNGdjQnlMb2xKSkpuZVluVUtBUnp3aXRFWmU1?=
 =?utf-8?B?WVNILzdaV0krTUZjRkdQaHRjUXpNSHRNVDh1MDQvQXpVbmp6TkFRaUhZbFNu?=
 =?utf-8?B?dXhPeVZMd0Y1TTNKTldUN0tHQUVQaXJ3NnlUN3NxZmxOSkU4OStJNWc0N0VT?=
 =?utf-8?B?U3dSWVROZk82K05uRWJmNWYxVlROb3pUdXJaL0UzTVIxR25rSUhSeWp6YlZy?=
 =?utf-8?B?VmJyV1RQK0lFbkhJb3N6S3k4TzIrd29SOVNQdnBvRG1ZRUt0UXZBcjY2Rmpk?=
 =?utf-8?B?UWxvNkpTeXd2ajZTNWhFUm4rakFjcnNaTC9mc1k1NEl1TmVrbGFVaUh6dnkv?=
 =?utf-8?B?cVk0U0d6RlZ6UVc5dlhkV2ZIUHFMVmJpQ2k3QmJTWHV6Skd6ano3bGxTU2lB?=
 =?utf-8?B?OEZLTDU5d2FGblgzK0RmZHFrYjZvb2Z5WTgrTGxlaTFoNlRGa1VTR1JUblFl?=
 =?utf-8?B?dXEzY1QyemZiNWlmenU0dktKckM0R1ZEc3lWOHFsMUw1QXNndFM4RzEzd1lu?=
 =?utf-8?B?anFINmdGU1ppck9aZ3JpWFg3czEvTVZTamRoYWF0aXFZdm95K1BKcXRYVVYy?=
 =?utf-8?B?b0JKVFlpVytWNG9rTHRxNmx0dHVjZ3grVmFuRjJnTW9qR255MDkrL3pUNDVn?=
 =?utf-8?B?ZWcyUFN1ZWtlMCtnNWRkM3Jjd3RSMUFnWWN0VTRkOXpGM2Qzb3VsR3EvMVV4?=
 =?utf-8?B?S3lFeEhIcTlqV2ZHL1BrMGM1NFE0R0ZOYjdRb2xwVml3c2E0d0ZKb2J0NytV?=
 =?utf-8?B?M01rRGxxTzJJN0tqYTUrTlQrZHBlZVlqa2d6QUgrM3dRRUw5bDNHZ3VrQVNV?=
 =?utf-8?B?UHhzQU9BVG81ZGJCK0F5a21DL2V6N1NROUlvU21vWXhVZjhrUG1TeUFTWEZS?=
 =?utf-8?B?UmF5Rnk2ZVF5R3ZuNjN6THREV3BBUlAra1VSN3JFRUo4R1l3SVYxSG1vMjJi?=
 =?utf-8?B?bllSNC84dTZsSHVaSURMQkE5aFIzV0F0MHoyMGRKbE90a3hoQnhlSjZjZmxx?=
 =?utf-8?B?MHp1VjF0S3VRRXNiYVZkS2RPb00yNXQ1aE9CbStVTGczOGlKUlBlSXNjVzMx?=
 =?utf-8?B?ZTZncmJHdTZGV0lVYnJwZU55ak84NUlSN0cyTGk4VXhKZEtjMDM4TWlFaUl3?=
 =?utf-8?B?c05mTmxNNllZa3JHb3pTWFZkNUduM3AvaFdDSVorby9FVUpFRFF2MGRXNENq?=
 =?utf-8?B?WkMvLzM0N2xmWmhZUjZWM2RvK01QblhtS05tN1lLcmxuc0lpUkM2cU56OG02?=
 =?utf-8?B?MnFJVTdvQll1L2pOU1FYUDQ0MkhuZWRyNWVINTkxa2JtcExWak1BUlFFai92?=
 =?utf-8?B?Qkd5VmpRb295QjJsNFpEWUwyaFdyclZhS1pGMndNS2hPSENkaDFNRS85Mmh4?=
 =?utf-8?B?b01RUytWenV3c25LK0JvZGFNS3Z5KzNaQjlqeE9tSkhGWEhKTHV6QklGLzgx?=
 =?utf-8?B?RGJ0Y1lXYXlaZXZaVnZoRlVmcE5uNFMwL1NpUGpZTy81b2JZcGNOTXhMZTVN?=
 =?utf-8?Q?ADVQlPSJ8PM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3ZNZEthZC9QNVZQNWlnaVh3Nktkb1hVNjlsekNaa1M3aTdTR2hSZ3pDWWdy?=
 =?utf-8?B?eE9BMnVtN2hVMmRqdnVPSGhwMGFNVDZnZ2x6M2FKK0hqRkpzZ0UvaHlkMytT?=
 =?utf-8?B?ZFF6cERzME1EM3hjQi82QUU2cVQ3QkdsaEFQR1BGQVFNeGdGZVM0TFc0dG5O?=
 =?utf-8?B?QWc2K3dlTTY4V0svQUFaNnVVWnpkZ1Q3cVBUUmxFOW1ubFE0TUxsa2orTDBi?=
 =?utf-8?B?citrNXlJSGVuVml3VTlldVZtRFpwZGhERWI5REQ0TFl4OC9qbnA2TnI1Wm5L?=
 =?utf-8?B?cUhhaUU2VnBnUEk3OEkzRVZMbEJlRU5CL1RiWjI3T2tmMnhmc3dZbFVFVFk2?=
 =?utf-8?B?R3djVzdzU251azROWVFhRGZQTVRrSlFJUXc1dG9SMW5uanlLa3dQK3FMSXQy?=
 =?utf-8?B?YTdYT2VHMk12Zmt5OXJqbW0ydTlNUENWcUpkcE9GcHd2QmlyRWg3N25xUG1T?=
 =?utf-8?B?aHlPdVJpODU2L0x1S0xQU053S1gvVnFuR1pzY0RrSWgyY3FrbnpEbmxsYlUy?=
 =?utf-8?B?bUk5RmpYbWZOenRXN3phdjlrRGpETjRmZlJGdEgycGE4VSsxYzBMOTAySzN5?=
 =?utf-8?B?NGJxaWxXa25HL2ZIVHJ0SDdhVXFUdVQzTm1maXVkeWNWZ1krS1pHRnNoeVl5?=
 =?utf-8?B?OHdzczFCak5wVjJyMEg3WXN6Qm5MTnNBN1pHdlRXT05lZ1pGODIrWEJNYkZu?=
 =?utf-8?B?OFV1OXNjSWZnNXI3NzdXTjd1V1EvOGkvTWxrVVJSZVI2ZFVMSXd4UUpZM1dE?=
 =?utf-8?B?aENob0dCekExZTJWTHg5UEZTM28xT1hmTTFlMnozMERxQ2pyRG9VRW9PVm12?=
 =?utf-8?B?dXhHOFFmdzlTem0zTlkrU28rZzE4eW50bml1Y3ZXYUVxbFBvL3FhWThBRFk0?=
 =?utf-8?B?WHM0K2xFdzhmend0SHdZR01FOUs1MGpMc3NPZUR5eVI2S3N3Z0d0cGNFemVp?=
 =?utf-8?B?RVVyVHp4OURUeCtzbjRwSGlkKzVCNkk4Y0U1REV2K04rb083WVZ0YjFBRXJo?=
 =?utf-8?B?MXdjUStiRUpFaTBXQXdNU01TN21lNmVTczFEWnVIdUorRGlnQ3JJK2k5elFr?=
 =?utf-8?B?RWx3eG53TDY1THZWQklTL0pRS0M1bHVQS0pPejVtMGRjaVhLZDBnOVM2YkM1?=
 =?utf-8?B?OUN2MThYT0V1aEc3MGNnVy9TQnlkRE1aTXJheGxnVHJOWkwyYWMvN244SVFV?=
 =?utf-8?B?ckdKbXJQcU1XOTVzTUs4WjUya3NOM25ocHRsVWJxMkkyeG9HbnFyQksvZTJR?=
 =?utf-8?B?WDU4S1lkT21sWitPTWMvMmE1VjNzbG0yUFdOendobTBEYUhiRVB5Kyt6THhj?=
 =?utf-8?B?dDVYdEFwZmxvbDFCa1RyZHlMRVhRcy9hMk1CVmY5b1ZZU2F4RmRpazBSaE9X?=
 =?utf-8?B?cUNZN2RyM203YzJqRGczYktMeGp3UUxUc3Y2S3lUd090dE5EY3R2SUQxVDZI?=
 =?utf-8?B?MnNmVW45N0JPLzBSWTM5R25TQnlRT2dXcG9TVmpjVytleS80anlnUkNsZDg2?=
 =?utf-8?B?a295VmUyTUd3V2pHTmNPVVljOFpPUkVpZUU5SnVzbmZKbG9LSEl2S0hWUEtu?=
 =?utf-8?B?eW9PTUd4RytKcXhjTGljY3dldE91VFJjWnczWmFxWjF1R05sbVM4OUdBNmht?=
 =?utf-8?B?TnFPQlRLQzQyUlhSd25pRE13ZklhbEFMNldvTm1JZkU4dWd4czFKVTJ2VEsr?=
 =?utf-8?B?T0JzajI3MXB1a2VPUEVrZGFXZEh3eFNUZC9FNStUdnp4SXE0MUFlWUpRZ3Q1?=
 =?utf-8?B?UDQ3SzNMNENXT2s1OVEycFhacmx5eGEyNmc2aVJma0sxbnFvbTRxNTZHcnpz?=
 =?utf-8?B?R0VxeU9zTEQxNmdZUUExbThOYldjZWUzYm9ienIzUFUvbXNzRE5XajRpY2Fx?=
 =?utf-8?B?czlQUjBOaGN4cEpTeHdyclRuN3dqM28yTTdEdEhCaWJxV0tHNnM5ZHZtNXEy?=
 =?utf-8?B?Q0JtL2dBN3AvSXJ0ZUxISDBRUjZRS3NBNFFYTTc5WHJQb3VvZllnV01ES21P?=
 =?utf-8?B?R2FvL09nKzVDQ0lLQS81bEk0c2xiaTBCdHRLMzlJTk9GaGY1dThkVWxzNHhh?=
 =?utf-8?B?NVFwOURaSkVpQjhWSVVCMHBzRXZtTVJINFZyNjc3U1dlOEsvWWlaU0hQcjk2?=
 =?utf-8?B?TG1xN2k4NWJUb01sWVZNTVhNVytYM2x0NUkxTURGYncwbEg5K0F6dFkxci9O?=
 =?utf-8?B?VGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a1ece8-d99d-4959-db8e-08ddeb0c2d8b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:06:09.6609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: As2zAXq4lAW8NiY/+WWObcjAjqqk8VDO0sgy3uxf5ZPsN5XOBF3ZRtyq8cVAUf/THMgu8zyLsyAsh2zhDUpaXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5574

From: Jan Kiszka <jan.kiszka@siemens.com>

This was forgotten by 5d996c0ca83b.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../xenomai/xenomai_stable-3.0.x.bb           | 20 -------------------
 1 file changed, 20 deletions(-)
 delete mode 100644 recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb

diff --git a/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb b/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb
deleted file mode 100644
index bca3eb2..0000000
--- a/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb
+++ /dev/null
@@ -1,20 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2018-2022
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-require xenomai.inc
-
-XENOMAI_VERSION = "${@d.getVar('PV').split('-')[1]}"
-CHANGELOG_V = "${XENOMAI_VERSION}-head"
-
-SRC_URI = " \
-    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=stable/v${XENOMAI_VERSION}"
-SRCREV = "${AUTOREV}"
-- 
2.43.0
