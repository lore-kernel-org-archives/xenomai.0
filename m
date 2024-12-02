Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339281FE455
	for <xenomai@lists.linux.dev>; Mon,  2 Dec 2024 11:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140370; cv=fail; b=ZJ74Y1uNAJj/xAlGyOiPEd3ok2DjcoJ5DihOJ1+UG9tD9GjYTOtWZLJrAygI/wAqpuROCBpwgMSf57+a8kHylHS4MlBmCZ+IrU0YYTnBigfwpBYk/HknQd8V/ByobpgYfR9kXpDprnJulVrMy7x4AJaeDnUBX2HDt1IaaphW+jI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140370; c=relaxed/simple;
	bh=1BdP49aKpWf7BuIm43pSFm9qnbAydr+r9a47cdbqXlU=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=UtsetDrF96mEXa6drf+0DTeDKLfk/NC7taOXLKiFpvQarA6bZdYXtQToivCUcHkBVSZyk5/J3SlcfVptX9Y6yh1LPSuoCksKZKY8i/tssgV3nEwWTxkNjsJIWKAL4RvA3hkXxUQAW3UScsbJwqRa4TOwT+Sesx/mYSi/eI9tX4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=DQaOuAve; arc=fail smtp.client-ip=40.107.21.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="DQaOuAve"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpRAPzQjAd7JD9HhGs1AEljCM2j1OzmBqU65G4BEaksSxyKd3sZwbCIASCbva9ibn9CtxBlYf0LG5O1d0k90fLyp3shDMn1cqHuQNTKuK+xDrx6AqIzFxf1Y4VXWta0wFYYKvHjeHdsRKgmJtk7JkbyVCwD+cEUr2hwPcJt+dwRS1QLnK/BvOk1z7X+doijaFQ/XCco81rldx008Off7oaTHX8RefSwmb5JJ9xK/KOKx2DE8yasvUFxeGmVjdgr5oViXNiiZM3j1XOIyKX8p9adTP3C2iLoPl0PM5rXVqW55FFPWXF3QuS5gBtSuaRBxi4p14aG2NsJeZC/kcL7VCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n86FJ+1CV12U05uHM/iyJgLhVEjveION0+8SYnyPKhE=;
 b=YDWIfiWdEo7VAczauJ0nBejk6m0KQXSdmIrdYoDjDnfZNl/5kmW9wpvXoV1qbJ1svpIY4HQr385oAry8KwLf1A4ZzZc9y75TvHnzTedA0JG8LLmVmVrfAAGGhB0dUXzYvk5mZ/E94qRT+goLiilqQrKvHq9evxPiAcezD/l3A4KiChQnOcMuCCniormRCpfFykBKeKyLjXv9bJFLlzzUHfqGeKWLs06w5k7rb/1qT6I8xBjuL5blBn1BAzBzhWqGq6js67gWdyLdNEUbBZA2SNHuThMnTmbXoCi2fVXKm2TTUyCyYjxY04X60MznQ8/g4SpcosyEp9E3V88GW2EOjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n86FJ+1CV12U05uHM/iyJgLhVEjveION0+8SYnyPKhE=;
 b=DQaOuAveAvMhyszVPsLFs9bIs+8b3snZFAP36TjAqkA9HTWlxGw29XZLMOpRIx/Tuk12CYnyQ6THhIdF+/wwLjhqzzlUdIfqjGS+agNfjiqwA9F8MBWlSe7/2jIhLYNa2zgs71i/esFe6Wxu3Nq8goJ3W05d0hBYo0F6IG9npcyFEWvpatAckBqh6ERhNXx9vHowzRFSc/1FsYZUVEq+uZ3ra7LBQ9knkFLNbFzEoJOxKSLzLVEUDOhqycIaDd1zjN4C1Gn4sbmVgGwpW8daajwRuXVxfs/1u1XrpRvBHeph8Pho/LVyFm3KQQZqPqLVlwMlC0L/DEuyxEs1tYDtZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5305.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:339::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.8; Mon, 2 Dec
 2024 11:52:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8207.009; Mon, 2 Dec 2024
 11:52:44 +0000
Message-ID: <1acc402b-681a-4e54-9114-fdadce498e28@siemens.com>
Date: Mon, 2 Dec 2024 12:52:43 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: Dovetail 5.10 switches to CIP kernel
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0064.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::24) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5305:EE_
X-MS-Office365-Filtering-Correlation-Id: 3637b74e-5b9d-41d5-a214-08dd12c7d545
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmU4NytIVGQzUWdFajJrZENYR1RhenVpeTJBd0plbUxvZXgrbzhRemRUUjhK?=
 =?utf-8?B?SFFDcDJvdUlDN3A4WVQ5TVhLanlXYktSQ1dWTlJEWlhPSzh6dE5ZQTEwK3dz?=
 =?utf-8?B?VnJrZ2k2NlIyc2xhNHFSM3ppZ1NwTG9HZ3U0OFhxVHVTN2dDL3VvQzg4N2Ux?=
 =?utf-8?B?QlFnYW9UdHlQajdVd2xSb2R0TC9QQnFhV1JmM2Y0N2ZxbVorcmkwbVB6OCtT?=
 =?utf-8?B?YXdSSUUrdW8wUkZxZE93UFErOTBhalVlb09pMUxXQUtlck1kblBkc29SM2VG?=
 =?utf-8?B?b3VtaWtVY3ZsQXdCci9LbkhmbTRaOWxhOGJ6bkY3eldmeVRUbGVsbHE3REcy?=
 =?utf-8?B?MjgzYWlab2N4NEJYZFlTY1BYa1JqOWJaS3lOdmZKdGw3a3pRbFd2Vld4VW9Q?=
 =?utf-8?B?NGRNUXVkYVlZWkdWdGloV1VDaGM1N2ppZlo4S0FiazJXN2ZUUWlwRExZUzRN?=
 =?utf-8?B?SXZXbkdwcXdiOHZRNmlFa1FhZFJiTktJc3hhQUNON3ZhM1JqTlJSVjA0Z2dm?=
 =?utf-8?B?VFFTalkzQUNlcTRJZVU3NWh4dmxWVzZ2WEd5NTBhWlFObk1VSGpHWUNHV25a?=
 =?utf-8?B?b21VMmZjTXNhUnh5ZUJTWlB4MEZGcFVMeTlKOXdqWDhwNW53T2puTHVYYjFn?=
 =?utf-8?B?NjZyd0x1M0JDei9LSnVtZGtLcEwzeWYvdGxPQ3VJSTRUSmluSVk1Z3pmNEk1?=
 =?utf-8?B?cjc4TUpja2oxOElrUlpwODNQMkRoMlh4blcxNU8wMSs4ckRsWG93VlV0S0p3?=
 =?utf-8?B?cWVtM3FJaUZUSGd5TFVyaTFPVTYyWWtXZ01oLytvbkFpQXlyUk5XRWhBZVVp?=
 =?utf-8?B?bzVGRzdQQjBndTlqcVZHQWNCK1YwaFNUWjJReldKMmZGN0UrSlNVNDdnQU9R?=
 =?utf-8?B?NlQ1TkZDTkdZdWo1RDlQYmxpeFgrTjRTa0FSaGl4cGdSekpzenhTR29ZVXl3?=
 =?utf-8?B?UXN2azNZSlhSbGMrYTFHUTkrS1N3ZDBCTW1NelRqYzFoWHBJUlU1LzFlOWpq?=
 =?utf-8?B?SHBRUWltVko0SjZYWlFTdDFVTS9LblFCQ0dCem1rWUVDWlpJWUZPcGJaUTMv?=
 =?utf-8?B?c2VtTXFjSTIvV09JcnFzNkpHd1NubDZmNjRNN3dubVlaSEREWFJ3Q3pQcmt3?=
 =?utf-8?B?KzZESGszeStWSFhKRVhyTHYvZWRnNXArKytjcCs5R2VRZVlPaEdhaEVrZ0Rl?=
 =?utf-8?B?QStkMXFPOFU3NzlwY0p4ZnNJVytnQUlQUXR0ci9JQkN4ZDg3eS9rcmRqTUov?=
 =?utf-8?B?c2VnMHNpcUNRRURUY0dzTnFGUHczTEdXWnpVbk5ybmxaZmV5RVhQbmlXNE9v?=
 =?utf-8?B?OEkxUWZHL0hqK1BxdmwyTVc3cUhSSlFUc0R1SWtwMll4K05WNzJlenNGUks0?=
 =?utf-8?B?TnJDYnJyREdaTU5WSjhrOFhLamxwS0EzY0wvM1lWTGxVbXc2eDVmRGJHdVk0?=
 =?utf-8?B?S0xvL3VkTWVTbHU5N25rbTJJejdLYW9IQ0RPZzVxMk1zMW0xNktyOFhNOUYw?=
 =?utf-8?B?SFZWcHpQZzNZWE0wOFJseDhFcWhmdkROTmdjMlF0bFB5d2NRdzdqMCsvaUFX?=
 =?utf-8?B?empGQ0FBU2tDYS9jaE1FenVPN0twZlQwc2F0eWlpOHVGVU5WMEJIMm9MKzdI?=
 =?utf-8?B?YVpVdWh1NkxNU2JNcndQeGxmdlloQ3hKZC8zL255QlRDSFR2cUJWZ1V4SWd4?=
 =?utf-8?B?Q2RSbW1hVkRlYzAyRjVjV0RjblRGcldTMHllZnNKOVpEN0xLNzVCWmF6MHBW?=
 =?utf-8?Q?brO1EHd04nb9Vnlq+A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnVBNVRNcEsrZjlxTW9zR0hJMGxjNTlHWCtuZGZGQTJOR3JTdzhtM0pBbkM0?=
 =?utf-8?B?N0h6RTR3REcxUERsSWVySS9ZNkJZTzNmNjdOR1JNT3UxTHQwTDYvcnYrZ1JQ?=
 =?utf-8?B?YVlNemUvSGJMVTF6eklzV3djY2NOUlU1ZjNGbmhhK1drWGxDWEk1K2lPSUVk?=
 =?utf-8?B?TWFGYnN0QWJpZ3o1ek9IV3MrZW02N0dMR1JEb1lwczJmTEp2YS9BWGdkWkFv?=
 =?utf-8?B?bkk0eGFJOU9Pd1VRUFJ4aHRVUVQ4ckREdlFoeEdCNHp5VkpRTUhOYk00WC9q?=
 =?utf-8?B?RVVJc3lGN0F1dnltQWxyUTc0Mkx1VlVWdTkvL0MyNFRaSWZQRFhhQ1pPQWM5?=
 =?utf-8?B?dHYxcXoyWmxMT2RBaWJZM2djcFllVmtjV2VoNFl5TWsydjhXcC8rN3dZODRj?=
 =?utf-8?B?eVhPZkE3RmEreE5Ia256dkNUWCt5Y2UxelJJcWdXUk1rU1F3Z2xtKy9HS2ox?=
 =?utf-8?B?dWlja0lyMGgyRi9KMExNSVhlWTVydlJzRisvS3dlY1BBYUhPaWxUU0puUGxG?=
 =?utf-8?B?RjFIMUVzdHB4V2lFbjVnWWtwZ2hYTEJBYWV0UlRBOFI2TUdaT2FLYUlMalpW?=
 =?utf-8?B?dmJIQVZrbHVnZ3hrajFtb3h2L0JobGxsS2JaNDFMZCtNdGpIMC95cGNVR1Vq?=
 =?utf-8?B?aG42Lzdha0J0WU5IcjdPMmtwNk9EYmNmbVFRYnBXL09vWUltUWlHa1lGbVdk?=
 =?utf-8?B?WWd2NFp1Vzlza0lFNXdyKzBOS1J2NlZoa2xrakR3QkhkZjJYeS9kaU5BUE9E?=
 =?utf-8?B?a3lBc1JSVUtPVVVMNExBNWNZNjFFaGYxaUpDL0gyZDlIaW84anZpdTl3ZEwr?=
 =?utf-8?B?VzFaT2pmK1M0clB2d3hhbFlIdStHY09QZGdIdUw5UWVKRDNYZ1UyT2NJYlQx?=
 =?utf-8?B?M3A3Zld4UVdPSDZPbnpDQjdDRWxJTXZSZE1PaDRHeUtMcFFseCtielkzNTNZ?=
 =?utf-8?B?ZDdsYnA1OUgxUklKeVBuaXBCZ21rU3NrRFo3UlhDb0crK20rOTNtakVQODhS?=
 =?utf-8?B?aE5iY1lvRkJnQ21lYytnV2NRNXp6cFJ6Mlh1UEtrSllpM0dKWDFNSmVzb3ho?=
 =?utf-8?B?SFdhNXdoT3ZlV1hIaHRINmh5N283Tk9ZZncycW16OW1CTkc4RDludnlPK0Jj?=
 =?utf-8?B?QVdVQXY5QmJlSkFlQ3pqZGlBL3RxVkViMjVaYUtTMzRnMGhrVTM1TFZ5R1Ns?=
 =?utf-8?B?bUlsRlBEd29JemZuRzhYRmlwYXk1ZFVqdW1hcm9lRjJMRTVrYUlVZ0pTRzB2?=
 =?utf-8?B?Y0R2cnUwRUxDRGtuR3JXL2RsMUYyTmlTR3NrdHhTUFV5MlFSYnZTcnorcGtB?=
 =?utf-8?B?bFFDbEY0RTRyOE0rZ3diVnpFaG9XUG9kMVE0MEZvQ3RUOHFTd00wQTJXTHJp?=
 =?utf-8?B?NksvZ3JIVTNYUTRudlNEQXZxZldUQXNvOURQNGVUcUV3T0E3ZmFpeEFvZVdJ?=
 =?utf-8?B?d3I4ZVFpd3pQdHNkeFdBQk9ydHNhMlVpNGZ6K3ZBU0tDWlhnRzl4WVdBQzF5?=
 =?utf-8?B?L2hqb09oQlBNUU5qQzQxTVhoOVg4dDJSZU5zYVh5TnZkeC81Q3AwKzN3YnJ5?=
 =?utf-8?B?VXJWN0FuSDJGUUdabjY1MUFRS3JGdTAxcDRiSnpwOE8yUUFsYWVxVnpJczdm?=
 =?utf-8?B?RzY0N3UxNTNITkpYeWxHK2RhQ21qNFlNeDdJNGpMclV0YnRXWGJsMXg0R0c0?=
 =?utf-8?B?alpsbzE4d0NZSUpyNFZyNmU0SmkxVjd6WW9tT2F1TkNBMFNVQ0Y4R1hGL0NS?=
 =?utf-8?B?alBJaktlanBoR29HTkhCVVJoK3U3RDdRaTAxRExYMUQ0UnJCdFVjVGFIRnIz?=
 =?utf-8?B?QlFEK3lCdVE5OXcraG5XNCtzRWJacTFNOFUybEV4c1JreWNrU2p1ajQzSXBi?=
 =?utf-8?B?clBLZmNFeVVIVW5MeFRadWx3MFRYR2xJdktadGI0dWRZSDh5bEFoNEF5eEtW?=
 =?utf-8?B?OG93a1BabzA2dW9CSXpwbHFWZlBkc3VObUpLN3VWSDhKNDV0K0Q4SGZod2Jq?=
 =?utf-8?B?YjFNTmovM1dybXpsQ092bWVFbWZqbzFVVVorRjF6OHlSVVIraFJyaFRxYjlU?=
 =?utf-8?B?VEw1dTVBSTlqb0JicVpOY1JBeW14VXdFdE9nYkFDcDhpb1c1NXZBRWRLYUJp?=
 =?utf-8?B?ZnZmNHh4Ym9RaGVoZmZIU2NNcjQ5emRqdkdIMHZ3M2M3aWhUcXBKZEJPTjgy?=
 =?utf-8?B?Z3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3637b74e-5b9d-41d5-a214-08dd12c7d545
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 11:52:44.4153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCETpuYcE//F/eBBL7e43tzI5S7ShUpw9T1ECTuIsq9s+OshOLFV4O9n/zGvl4YLjkg2uQ9MA4NHIejcSP1fsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5305

Hi all,

this is to let you know that I retired the two branches

v5.10.y-dovetail
v5.10.y-dovetail-rebase

with the releases v5.10.229-dovetail1 and v5.10.229-dovetail1-rebase.
Maintenance will now continue for this series via the CIP kernel because
of its longer maintenance (Jan 2031, instead of Dec 2026).

The new branches are:

v5.10.y-cip-dovetail
v5.10.y-cip-dovetail-rebase

And the first releases are:

v5.10.229-cip54-dovetail1
v5.10.229-cip54-dovetail1-rebase

We already did that move successfully with I-pipe for 4.4 and 4.19.
Philippe will do the same soon for the 6.1 dovetail and evl kernels.

Be reminded that the maintenance of the underlying CIP kernel is not
fully equivalent to regular LTS *after* the latter is discontinued, i.e.
in 2 years. The CIP project focuses on specific kernel configuration
sets for CVE tracking and fix backporting. See [1] for more details.

Jan

[1]
https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipkernelmaintenance

-- 
Siemens AG, Technology
Linux Expert Center

