Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010068.outbound.protection.outlook.com [52.101.69.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73F728DF08
	for <xenomai@lists.linux.dev>; Wed,  9 Jul 2025 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074440; cv=fail; b=WuDX8qWvfoNBsTUZxE6U75C85QTQdXGFa7+1nGf8R8YEXNfYT/CeD2w6MBWMie6V/SpW3shxxJ8GI57yRqmmAQUNcpVyqCLgavwH6izIuP3oMmXGVa6nxx1+RmJKMjyLLdfjYowxxqAesbPawU+oE0SVYaBog0BdMbJIDDbQFPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074440; c=relaxed/simple;
	bh=fpo08H76o7xHw1K1Z+/r/BPh5w9t+tHclWbh7AST4UI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EmqdFD4710n2rhyDSKdqO5dOJmp8Xm/34Ajma5cxdYJ2kA3XArVk0k9w2PXSiw/QLTw5wV/K8pl3xdrPLOysF+ACIuFTrTKv40Bv26JmPexekORkdWHrk3NseIj1k6J8d5umJ4GqXtnoO+//QN5KAeOgza3WqkvY709TXI3ZSEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=AyICF/yv; arc=fail smtp.client-ip=52.101.69.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="AyICF/yv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfUtomBahFgBETCTOL4kTWQyfkhTg0z05C33H5qGfixBMYGo2yib4wStDPq+ZKaR9JDayjeKuaK7f6f7gX0ssoGnKDYrYdkZYbLuJe9EVaU5PgSamY5iaXUawTGh5BSvKXqSHgujgm+9v/gqgWFK5j116S9K0xplEWMLM4NcUo1avR326sl0i8LeQAfWXogYsRQ9GoJumMl0LUPIAyRSOyJDTv3hAZvdgNsQXZlaM4myRvu0uxxVFWQI+SwAElLo24Y+K/VtXSIVi77RZVkHr6E0srxRFXelXDP7iCN3g4dv0039cqOxMopiJJ+BLdP5L9RaN7ygd9FDC3bOR1g+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyAUe6O4yUSfUlsoPbYtifilIV9kB35R5TY3K4Dt7C0=;
 b=JjihnK1fCxHJQjLUN4AoNmj6IFVznQRLKIAwQI++CCD6UaV/c71INiXUwpHwYp3nNBlp0HrG3BpwOe/sKOD7qfbQbj4XWpottQw+T9Og/VnWmlNkeWLhEws6VbbRGBQjCp94NqOBQ17OAmaqDWCs5vv8qRt8ZGBEcpjFR789bV2RZ0LGF2BgwSqYUH4AeDB4RADGWHBJmieZyf8scrFiMnM4pCvAks40IFIsK8OtQZ9ehm24ibvIdE23/glkqQ0P9FFXhSnJT41iKnpipiABACnkRbjdxlK9SiDQjrPlkK+sRVvxqlco9F7wW3TmBX4qgEPALLZIn7KVatIRh+jtUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyAUe6O4yUSfUlsoPbYtifilIV9kB35R5TY3K4Dt7C0=;
 b=AyICF/yvqKG9mNy93xc26JqTMnQT/nClnK1xlIedyAGmZTiHWRmLa227s7eXV8UayF5P6XEZoqa0HINtknLegFdf4iM0mGus1JOQzJ5uPP2VNBgq0Enj20K00jbsBoeZTz6nU5dAQF6LjXJF/eC0P17Exl+B9Sin6m+hws/F5P+9FzYNDbCEhr0vtcvNopFsD01/TBTEUOuiQl95aYYReV9tqfpjkOGoyrUi6Ryz22InEyFrTM1DSBad5+y4AM8nas51yydXYeX6sLNCtk2dkEOxEpud+c/05E43wsFZDObD2m32pwua37g4UKwUFYSbi3RyGGTnka7iQ5xvFkv2vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6790.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Wed, 9 Jul
 2025 15:20:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 15:20:35 +0000
Message-ID: <343ed054-2d25-4e30-92ea-ff355bfc2556@siemens.com>
Date: Wed, 9 Jul 2025 17:20:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Xenomai Meetup at OSS Amsterdam in August
To: Richard Weinberger <richard.weinberger@gmail.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <CAFLxGvy2U_0hfTKfPPZAui8XFBMAFqxLnjgCUcD2-Xw3=79UBA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFLxGvy2U_0hfTKfPPZAui8XFBMAFqxLnjgCUcD2-Xw3=79UBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: c072afa3-91e9-4a76-3488-08ddbefc26f4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djcrQmZDVWNtSWRVN3Z4Ukg2bVF0OWYxSDcvcXlYZmU2SitHa2NJekpYRnhk?=
 =?utf-8?B?bFdJZDJSa3pWcXNOOXlNUXlPYXBuRDh2bEFBNlRqajFjb3BjVTk0Y0cwV2tD?=
 =?utf-8?B?M1EvV1E0bzdhK0MzV3hWRTRSK1FnYlk4YlBxd2JuMTE0eTNWM3MzWW80bW1y?=
 =?utf-8?B?SldRMndmc0RvVUF0TVVhb3p5UURJU2llZlJ3MzcwTlVoZXBlTkVhdUNJZGZs?=
 =?utf-8?B?Z2d3dGwybXg5VmxVWkl6RG03SWJUZUdUNkZoNEtWazRTN0JmVGN5eTJqc1Vt?=
 =?utf-8?B?Z0dzOWZOYXk1UG13TU9KREFlb29lZXB2c2ZYS0dyR2FoeGhFV1hlcFR0YjVS?=
 =?utf-8?B?Uk81VWJBd214MnNEdEVPNHk4NG1tdnNjVkE3OXY3enVaODJHVmJSaHhwSmVW?=
 =?utf-8?B?TS9hSWhVNWEyZ1J3MEVnOEF1MTQ3UUhVaUZrdGlUYzdWejE4ZHRXaVA1Smpw?=
 =?utf-8?B?T0pjT0FHK0ZCbFNMWUR0bmU5YUFENUFBVEFpY3N4TWxLQk81a282ZnpxOWVG?=
 =?utf-8?B?RDZrdkQ5NCtrL0EzRnBBY0N2aDVZbEU5NkppcThrc1F5Z1lFUCtXVUx3YXpH?=
 =?utf-8?B?YVBQWVZtUmhFTW5qMTVsSW8wS2d0TkFka3VKZDFIOXZiNDJzcEswVjZJSlpn?=
 =?utf-8?B?c045Ti9LUERpYUNIVnhIUVlxQmFHaThvRSszTjU2V2RxaXJIajltMzJVWVB6?=
 =?utf-8?B?eHZZMmJXUlVQKzl5ZnMveGNHZURuSkh3MG1WKzh5aEdlcGFvM1FkY3FjN2R3?=
 =?utf-8?B?aVlTcERsUVY0SVl5WFdCV0VzTk12REZ0cjY4MFJlU0NST21ZRU5TVTBNL3o5?=
 =?utf-8?B?cmpVdGZqa052YTB6VXRhNWMwU2Viai9KaDhobnlETWg3TFZWUGhlbmtQdk00?=
 =?utf-8?B?RW1DR2xkZnUzK3UrT1MwL0trN3RkUitwMnpXOXFjVXArbWJKTGxWaU1hckZP?=
 =?utf-8?B?dHdHM0phOEszc2k2WllqREVyVFRpK0tzR05oT2d1NGJwNDZOUmpvTUYzc0gx?=
 =?utf-8?B?WUVZbGpHQ29aZFppWjY0RHpubGZYTzF0LzZmZjdsU0RUTkNYNjBpbGpvYjFi?=
 =?utf-8?B?eUN1TGdITEJTcDVoUmlQNTBMTTNDT0ZYT1ZxODcrVVJJRzlwNUtCbmMwNDBN?=
 =?utf-8?B?alhvRkJ2MHhPVzFtVGYxNmpJaENrNzJhUjRXYkFKRlZDbDRCWllnTlkxRDFj?=
 =?utf-8?B?OFVrVDRMZDJBZTJlQ2xGTjB5bk1uNGxTT3JPbWhJcjZkSjZIUXE1NlVHNlFO?=
 =?utf-8?B?N3IxSGtTQU5iTEVabXlwa1k4R2M1MFFIY2xJQjNtQ2YxMmkxYjgwMVlTN2c0?=
 =?utf-8?B?Mi93ZVdBYVRJT3M3c0lOcHlhYng5TGpzcXVCSnFEdzE5d0FpUVlORlk3TnNS?=
 =?utf-8?B?emhPWDh5eTJEQ2hqMDVoZmMzandLRTZFeEVBVlVZRlNHYXZrRkVLa256dUFJ?=
 =?utf-8?B?Qkg2VEpoYjB6M0JmWGpuV0NkZ3dXY0hBR0tKaTRxcytoYjl5cGRNQ2hNNXFG?=
 =?utf-8?B?VzAwYllNTWo2YlJLYzRwclZxQVJ3RDZISGRoQ3dpWlpiMHlyTjZ4SkNNUElK?=
 =?utf-8?B?ejVpY2FUSXNlRE1SaFBjSEdveUo2Z1BwT3FvRDRDWDRWK1FWRGh2QVRoWStv?=
 =?utf-8?B?UmcvY2N2TWxYNVNPNXpFS003RE5CK0tFU3N5cUsySXhNZk1jYWJvdEs3Zlky?=
 =?utf-8?B?SFNjblJyYzNmUHdFcVVuQ3YwRnVMN25nNjhJTXRaSHh0RDd1ZmpWTXE5SU5x?=
 =?utf-8?B?dVM1OWlKV2RvMktLby9SdzBCMjhuSTVIdkp6Y1g4SWNLMndwcE9SR2pLcGhm?=
 =?utf-8?B?VUxhTEdIWGlZaUovbFdselhSWURxRzhPdVhyWUZSbmxWU3BJTnVROTRDeEw3?=
 =?utf-8?B?MytSaTZXZVgrY2VhNzdnQkNNRUVEOFlad08yRmI1RWQyUzR4ZHZSR2ZXb3Fq?=
 =?utf-8?Q?tAN/2+0U3pg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZU5UMWM4MHpEcWVadzdVV0dJZkxtOVowQm5FbVZ5UzJwYzRVeDk5a1Vzc3FR?=
 =?utf-8?B?RDhFamtEellZTkk0a1JFekIzemRJc3FVUUpDYkNvUDZnRjBrV0RaWWZQQXFj?=
 =?utf-8?B?cHMwRHdPaEFjRGdUd0hidTNKMGhLZktQMkl3YkZoZWVNRkh4WVRzOThMWDZC?=
 =?utf-8?B?RCtGS1AycW9GTUNxVE9kSVAzVTVMMjVUd0VoVytWWkVHbzNmd0VkVnhwZ3BK?=
 =?utf-8?B?R211eVd6c0R2cE1wZ2JYbk9jbTh4OFEwNW45NVBHN0huWlJlY0NXV1hPNWhE?=
 =?utf-8?B?QTY4Qk9TVkRWWTF0MXZORlFFbzFFemJ5N3hPYkFtUnkyZmFyZ0twNXhPMWx0?=
 =?utf-8?B?bXNVTE03bjZaR25aK2RpZVgvcXNaZDR3OGpTOHhNdm9ITUQzTHI3TU9iKzZX?=
 =?utf-8?B?VkxqbnpGUmlmb0k0SWNPZVlzK1IycFNzalhici9CbU1MVUFZZjh2dzhXN01U?=
 =?utf-8?B?bXpWVnRZdjQ4QUhxeWMyUTFma3B6NVkxbEtPZG4vMjlML1hXam1Kb0pLVTFH?=
 =?utf-8?B?dEJzZlNxWmJMQkxiWElFNlRENGNLRktkOUJkNUFmNXZEN2dZNEY3K0luV1Rl?=
 =?utf-8?B?bmYydmtrL3BkSlZONEYvdm9IcnRyV2gvb2dWR3kvckJ0cW1SY2ZhTEhrSjhF?=
 =?utf-8?B?RDdFa0RlQ1BCNFcrQ251cGVLSzNHenhobXNNRXg2bHVhb1V4cVpoc0pHazlQ?=
 =?utf-8?B?MkN3MStJakFZNnR5bmZ2LzRzTFhTS2Q0NkR4cGxIMzNNNlFyVnFFNXViYXpM?=
 =?utf-8?B?alZkMTBNRjQ1MndqQ2lIRU44K2ZFK3FtUVZQUjVnVnhhM0dPa21aNUZwRW9T?=
 =?utf-8?B?NC83d1NNQjdqR3E3Rm83WlVkVzc2NzB1TlIweFp5cVorZE0wQlJ1UndYYnV0?=
 =?utf-8?B?TDBlKy8zYUJHNis2cEpsRGxNN1V2T2g3RFpKTllCRlBIUUNmQ1FIWGVtSVll?=
 =?utf-8?B?b213WitZTUd0QkVFdzFqbGVLbU01dnZhSGFlUjh3SGpWVjBzdjE1bjduRG8y?=
 =?utf-8?B?VGZZS3duVGJFTnRFeGtTVzNjclo4NFROaUtlN0UxdjNheGZ5Q1g0KzhXU2t4?=
 =?utf-8?B?YzBFb3VTR1R4OTJjcFE3OEhMVUY1d0lva0lTZEx0ZkFjdzNlTFp2TGJOUjBu?=
 =?utf-8?B?MDhGS2FlY0pNbzlZdlNPeE5hKzFwOHlSY0RMSnc0VVEyOWwzcS81TFZlQU1R?=
 =?utf-8?B?Rm9QYmdnNCthdndUelkzeXhCN1E1Wm5KN0NpSExLL0JabFJaeU1MeXdYaGox?=
 =?utf-8?B?d2ZCd1k5MW1Bd2tjbVhmWkNMNS8zeE5aU0UwdWJhR2ltRk9DR2Q5ellpSFJt?=
 =?utf-8?B?RHpuZE1rWm1tNXAzd2FUY0h4RmpSVkdFTzM3WmNhbm1QNS8wZVRxOXVQRUN0?=
 =?utf-8?B?NzBmV0M3ZlNSdlJ1TXBPdEJxVjZZTG5qczNFdnJ0dWV3WDhRa0hmbE9mdmRF?=
 =?utf-8?B?aFBKWkczM2VlYllZUDBzbFJ6dDdWcGhRRHVyNVBBMVloWUQ4eC9nS2JSTTJi?=
 =?utf-8?B?VDM0TFFjR0Z3OUZHWWpBMjBxOVdIbkNuVHU3WHBaVzBSeVFwamI3OUh6akZZ?=
 =?utf-8?B?UC9YVEpqRkFQQ0N5NzMxUGIreGVRTkJ4OUFYcmxkQjRxTHQyUXdWcWMzUFpR?=
 =?utf-8?B?WXNoTGVnRTJJY09rVi92M3h3eGNDVHRDY0VhOWozbFo3c0lWQ1JOaXdFb2dp?=
 =?utf-8?B?UUtPemh2OXlqbGNiYlB3K3RBRTJaaUM4Z0cvaHRGUnpPQ2ZEV0poM3F6R2gr?=
 =?utf-8?B?SHNGelFoSkt6T3ZhZUFBNWNmRFlPaEpQZCtWRFR6N01WYUlIcm16bkVtTkFO?=
 =?utf-8?B?azlWaUNTc2YxR0tqaUY2K3FVVmtLRm9ldXd3eENqY2FxWFZrTUpOUHlDWVNh?=
 =?utf-8?B?Wkh5QnAvSkRiTHgrN2tLWVF5WXpYalhZV0xOL2tXQnNKQWdkdHcxQU5Oem9o?=
 =?utf-8?B?eXVFMElaMGV1Q1hYK3JlOFgzWDJaa0VTWGFVdzVpT2RMeXU1cDhqYUdhamZM?=
 =?utf-8?B?SmFGWUk1YjYyakd6WVAzbGhtOUZ2VGVGbmJiVHZqZ2ROS2dmQnh1S3dtTnFI?=
 =?utf-8?B?dHUreWZ5UXlmQkNSZGsza0FPcGpZYVd2OXg4WEtYeDM0dkNVcDVVZFRSOFZi?=
 =?utf-8?B?RUlLcGRSOElJNTIzV1BSa3V2dEdWWXlzMXB3TzgrRUZwaGpybjR3UUthUmFr?=
 =?utf-8?B?L0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c072afa3-91e9-4a76-3488-08ddbefc26f4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 15:20:35.2361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3yr1O+CRaJEkNt3b18oEYzFAsRddZ05ffOid+rBBJ7m5RHbwVuwb3lW+ELsISNkrB93PtwneobOH02dtTwG+qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6790

On 09.07.25 16:55, Richard Weinberger wrote:
> Like last year, I expect that some members of the Xenomai community
> will be attending
> the upcoming Open Source Summit in Amsterdam. If there's enough interest,
> we could arrange an in-person community meeting at a local beer
> garden?
> 

I will be around.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
