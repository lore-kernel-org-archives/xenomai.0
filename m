Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013071.outbound.protection.outlook.com [40.107.162.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3E62561AC
	for <xenomai@lists.linux.dev>; Mon, 24 Feb 2025 17:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419281; cv=fail; b=kpqlL6J6rDUH3E8GUGIA8Rj/PPF4q3UuVf2a2WHEQN1eER3BIsjwMq2xoRi4mrfXHsrdv1vCuU+S5/6NTYv4PGpXi+Yn1roPBsYrbosKCvLWnM9hI1lXJircyjhQXDsj8tvoHOmimtPDCZZ5eCx1+J077Ib8Pzr+a9bsgeRJTo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419281; c=relaxed/simple;
	bh=/JnUME/LkH88TQhcKsl+kScRg1G1kAuhJp1f6x2KBqc=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=InrDBZcbdirmWQGmFv9UaNb2TwkIYhEpHd0TX7s4RNnWPa67nktPzcctGpWqdaPlMXt7wwQa6xoaQV7qSNPD9InipLh44xsRn6nJ4PCq9Jg7YG61F3SKc0bxsm23Q5tWPSrCLpRzozHFYBSzGVfkI5itpPRxJFc/krtAzMkhMmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xTBfONPT; arc=fail smtp.client-ip=40.107.162.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xTBfONPT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBMK4yEEVDKOlEOlIwfAr1kJqnxgJyc6pr1NCTRKM9AJfBplr43GrocfWrHoCVFXPzinir90XrTSIYLNn0haYfXSx6TZRaye71ilngGn7bkxE8Yeopg4bd2itE7Pq3NEXWOjxH5jKwNBy5zs+UzrzLY5+kFcAjm/X8mI0bnz7EHjKI0FTaD3MgJn5bthF8ugb/0AxLF/fowdKG2n0RcfhCAGg5wtiPHnOlBfWyRnEqe3jBzpLEVhaf/Z26RcLFAJqYIOlvQ0gdHATigJ+rqwelQAp8iYq8Jb+CIjnfSb6Ecbd+S6ezjv1oGkQTHZU/ITdESzLzrJCYJr7qWT0neeVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ydi0AtFppKYNMp/L4HQ4Yj6MMSVqwLcazet6qlb6Nzc=;
 b=olLWKE+j5a2uQmwgzgtPQvwsjzDL8w+zmmPqhvELXimnkhqIYFOCPn4pl+8deN9QcJEQNX/SMsMOTs26ZFxSG3VaxWoMOvNmSJedSled3//0NcNfqfwnnB6q03yjd0QOrJbj+K+2gCERv5bHgdamwP8u3WCJssYIHFZWRgWV6BK9jsBFbPVwotYe/XS/GzNW4E6hYGUJg4XSVmG0TU56H4z63swif7LQM5rr8Ltrr5N0l8+GlEGQrSX7LsZWjPKAn6VNbRS4MAV/DGTBKWkdelAcbpizKzfhbtamb33pziI/XG7tCquZvkjIB0Zl4pXtsVeARLUJHvh3oAzv7vursg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ydi0AtFppKYNMp/L4HQ4Yj6MMSVqwLcazet6qlb6Nzc=;
 b=xTBfONPTCEp/plqZX1HMNjKq7d6Ds+MoHrkRk0kmSwcWLUvYfgLDKPM535/VXQfAMsFcrwIqnQfFTaxf5nLmEqFdE7jfNT68xdImX0UDMPPgT+qrnlDq+m/ddY6fND0Fy+0McjJy63Cpf+Vq9Fq/K/+LvQp4tchZ+jbyO6pNh8RASMYU2tMrI6zxdk7auUrZwpCCYrr6lTBeslPq3ezZUQe65HnXF8ELrQqd4aq+MYXgG+dQw1sIXPFQ9jsUz7Wbib0YhFO1m34uBRTQ5lkm7JIPYMeAbz7KUrSldBMLH2b2ikDKfUjLNVHDV6/j6XFD4sEBRqSUbKNuTP9So0QIxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6175.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 17:47:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 17:47:54 +0000
Message-ID: <8942212a-561a-4657-a1b4-8b68f84bd98e@siemens.com>
Date: Mon, 24 Feb 2025 18:47:51 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] cobalt/vfile: Plug race while opening
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::27) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6175:EE_
X-MS-Office365-Filtering-Correlation-Id: dd8dfc29-299b-4af6-f148-08dd54fb5dc9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KytUWkRzNEdCWnR5VU9DUEppV1hmMkd3eVp6S0NCQmF6aTdmM0JLMXY5bTBp?=
 =?utf-8?B?b2w1dGg5eWxFMHd4MFhhRUFVaThhVlFUUWlEZDdRTTRXd05OMHJzZU5mVnhT?=
 =?utf-8?B?Z0VTRHk5QTkydHhMNFEzNlZaNDFtZkxSQ1NMdE82Nzk4aW5Vdjdxb2p3R2lj?=
 =?utf-8?B?WGxaYmdaTnhBR2tDMTFrTDlQTzMwU1Qyd25lQXFzUXY1NmUvRktmNmpSU3U4?=
 =?utf-8?B?S2hyWFdYRHZTNzRUSHJucDA4QUpTZFErWjFya1duc3p4aW1pSG1NTDUrRTVH?=
 =?utf-8?B?SXVRYklYU2x0Z2ZSR3pTNDcxamU1Q0MwaTU0dnhRSXY5b3V0MTd0SVdsTTdi?=
 =?utf-8?B?d2pYV240YU5pa2lVN2EyNVlCVWJWZkJzcjV1cGkwWEg4Tmc2eTk5ZUdRTVhj?=
 =?utf-8?B?cDlPNm5ia0czVnUyZmY4YnNmb0NhZmxSbXlVQWtKMWJkRGUrOHd3K3NGbW5Q?=
 =?utf-8?B?RTRueXFCMTFnTWV3RGw0K29LTjVneFdxcDlrNHA3TFdBNC9GL1VZZ0NOa2pQ?=
 =?utf-8?B?VkhZc0dZMENXTjgxZ3MyK2oxQ3JpUnVpcXlzTzhpT29paitxaWpEWVc1Nm9C?=
 =?utf-8?B?VjljaUZmQitLdHZPSkk0ZTNVNzM2YlZtR3l6Z0s2bGluL3JOb2o2UnFwaHA1?=
 =?utf-8?B?bDg0UG9ucUF5MWF0M3VJVXN5S0o4bTJpL2o5Ui9WNVhza1pBMlB4NkthSE03?=
 =?utf-8?B?bnhNN2RuVmNscDkxWjNqY29xUWlRcHE3ajkxR3RXcUNkWS9hc01SMHJMMVhx?=
 =?utf-8?B?dWZYMFJhSTh4THdOaFFBMzZEbFgrTG1BVENZMW5MK1Y3Q0lDVVRCMjE0ZWE1?=
 =?utf-8?B?RHhiSGhwQmVJM1ZUOW9UVUM0bHVXZW1GdWpEdUJmRXd0UUIwWXhsaGVDV1ZK?=
 =?utf-8?B?Y29HbjBGejBEZ1NxVFZ0ekQzTktHczRObFhJQ3dvM0RKbDdHaUp1S1dvNnR6?=
 =?utf-8?B?R1JBRzJWUFE5bDF4djFYcjU1RUd4Ylo3WFRVZUF2ZzVXakFEa0lQbnArc1hy?=
 =?utf-8?B?d2pNWENSc0dpQmdVQld3cGhuRnBRTTFwRTFCRlBoYkNudUEwekdTU05kZlBw?=
 =?utf-8?B?c0FlZjZkdVdSeEt3ZVU0Z2I2cHJLUVZyUTlBTEZxaklzaUFKU1NIN2VndkFR?=
 =?utf-8?B?RGplbVVTeWJLV0M0SllaLzJsUmEzNnB2T3Y2V3BNNkZLTUdoSUtjQys4NjN0?=
 =?utf-8?B?UHJORzJ0Mkc1cjlnK3NXNHNjRWt0N1NoNVBTeTltNGFvSXlTZTlhd2pHMUpk?=
 =?utf-8?B?MllFWjJORGNNQ3JHaUFlaEhaVnd3WVBkYkhISUw4QUM4blBXR1ArTVlQNDFW?=
 =?utf-8?B?c294OHB1aWtRLzNZNFJoZys4K0I1UmFXT0YvOEtuSlJJTXNjUmFvTHFJK21u?=
 =?utf-8?B?WUdpNTc4aGE5clRnZ01XdFN6OWFIL1lBMStGdnl5NUNQditlSUJVbGl0eC9j?=
 =?utf-8?B?d0ZUQWRCVWNGUTN2RFVya3hNdUZoQWNPNkxmVjFJRGp1MlZ3Y2oxZ3N4UXhk?=
 =?utf-8?B?NktLVW1yUEVaQStTZ0psY3R4bTVKdllvWFA2SDVyT1pLZlFPOTR6UWVnWEtU?=
 =?utf-8?B?NUVwbXN4MnVGWVVGTjRJbCs2ZUZBQm5BalRlYzNMdlAwblFsUEFXdS9TVXIv?=
 =?utf-8?B?N0ZoSGRMYXhZK2RoQlp6YmdnMkEweHhDa3hPS3lHamlKdEhYQkR3UGJjMDY3?=
 =?utf-8?B?TVh3Tk02RVJqSnE1MmhCT2djYUIxcDNqNUZCb201aC9aZDJJcWNZQkxwL1g5?=
 =?utf-8?B?b0s4NjhoQjVnZzlVRzl0OUJ3cnNHVEtJMUZDRE1RZzAwWXV2QkRmL0xFN3Ix?=
 =?utf-8?B?VzNCcUs3ckhJdURiUjg4amVTdlFoSkh5eVJETS92ck5vRExjVitpdlpWTHdh?=
 =?utf-8?Q?ArVWxu/72khed?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2tmOGY2LzFYbitHN2Z6YlRWby9nL1BtMktpeXR4QkMrRVJ0Q0xWNEkrbXhR?=
 =?utf-8?B?OGM4UDd1b3djTmJJVmVjVitIZTVPREhaSmNNNjV6TW5pRExzV0ltSnR4Z3dy?=
 =?utf-8?B?eUxMcC90RlJ5bTllbkQxSEFSUXBFWSsvN3BaZWg1WkVvYmwrT0JoUFRCbEpm?=
 =?utf-8?B?VThoRDdXSkd4RndPZlh0d3p1SGdFSzdjUzgxTmNSWnVqZmtnejgrYVBGV3ZG?=
 =?utf-8?B?NlpadUdmbkpZT08xeHJXT2crd21qSVZLdExLdUVRT1ZEaVdzNk0ydzdRa28v?=
 =?utf-8?B?RGdEZjEyeEUyRXgwZ2pseW1VNjZjcEZMKzZ1VmdDZzV5YXpkYm80SzVRVzQ2?=
 =?utf-8?B?RHcrR2dZc1NPSmE5Yzd0bk4rWTByV3pCV1Jhd0NmYmJCSGpzOTRpVjFvZ2tj?=
 =?utf-8?B?UW5ndUR2aXpqeDhmcGZ6OS9IdWRpcDM0U0xFbDdNc1dtODVEUHpEbmYvMHJz?=
 =?utf-8?B?VG5reEdjVHphMGlQckpZa0dFdEQrdWl1cnIvYlNzTVZYQUFLVjdIa21wN1R1?=
 =?utf-8?B?MlFaSTdCM0t2bXMySnpqay9TQWk3WnhRZm1hNnhwcnJTMnhQdGpqSnd3end4?=
 =?utf-8?B?c202QkVwbmFMMVFnVHRvaUVMN3cwMFNldkFnNjZKNTZoN1M3K1RzRGNsWElr?=
 =?utf-8?B?S1JNNWZzMkZoQStLdTJJTjRLYWZYQkhoWlBkeXhjZytsQ1cyS0ZlSEVkSFVF?=
 =?utf-8?B?clRCVU1LUS9lbk5KSTBLdWRLVEh2OXNMRzdLdjZPUmRjS1hCMXZGYmR3Zk5s?=
 =?utf-8?B?dU16Uk1ZU1RNMjh0RktTT2UzNHRrQUtLd3dJdTZYRHNWTW5IUmlOc0w2Tm9N?=
 =?utf-8?B?VzVnSk9hNUtsQ04vVjVGTFJyenVna0RNdGdibmJ6NUplMGVsUVE5R2xoajU1?=
 =?utf-8?B?K20wOVNicVpreVR2REVqRVpNQVRiKzBKM3ArMEtweGVKakV3dTBrVEMrQmh5?=
 =?utf-8?B?RjR4Zi9Jd2hZZHpXYWprMzF0bTJURFlzOWxFTWdkQ0ZvcjNvM0ZCcmo3RG0w?=
 =?utf-8?B?T3h3Q3kveVlYRVRLSS9vUTJJZ3RWZzEvZkJyc01RdCtjbTh1VWtvS1FrYzJ3?=
 =?utf-8?B?WlZLMEZaMjJJSDFDOHZDS25LamJ0QzNIZ3k4S2dkTWE5aDBTVDE1YzF1L3o5?=
 =?utf-8?B?YVNFUWczVXJGZEhralBxbGpKQWhSY1Zvc1Nab2JKUU1WNnoxL05mSnRGWkg4?=
 =?utf-8?B?K1lTaGJMMWhzUU1RYktyOW1VOVpIWlkrSnU4Q0c5VUpuWHFQbFNTNUM0bUJE?=
 =?utf-8?B?dGZhMXROSlV3ZDI3TEVFbjdYajNET1Z3WUE2eHpvdEorR1pJMHJLUDNMYTNN?=
 =?utf-8?B?Zk1qMFpteXUzVWtzZXpMaG5WWmpCUGhtYVIwekdmbUFBN1l6ZDVrN0w4WVdH?=
 =?utf-8?B?VkJlTG1qd2lRYTg4VGJpY2E4cTJoNGRkNUZVVWtwbnpFNEV0NXZ0VVdwSml0?=
 =?utf-8?B?cUljME1qdFMwMlZFMDI0Ym1jVTd0L1JhVnNqOU1OMUY0Si9MZWl5dWxpUnQ1?=
 =?utf-8?B?OXNkaFIzeWVOK3c5T25PcWdGSWl2cWV2TWZEeXNIOExBM2o2Yjl3UVFFRXZk?=
 =?utf-8?B?YWVJQXIzZTVwUTh2Qks2eGsva0VkTGI0T093OWZUTmszVHdncHN4anJyZjVz?=
 =?utf-8?B?UmRvU1RiRDUvaGhsWUloT2tVbEViMXB4b3Vjd0ZGQTMvMTVtMU5QbU9CS0Mr?=
 =?utf-8?B?aGxEVWlnNlMxUUtQMXhhbEpQRFA0RFlBUTBKQ0czaDNBbUtFWWNHV0loWW5p?=
 =?utf-8?B?YWVvOGxzS05ZelhpaEVQZTFQanhzWW4wYTVmS2JOcjY0N0tYQi9aMzFoOUFm?=
 =?utf-8?B?ck9rOTdiUjdJbkJ6QUdqMS9MZHp0bWtoM1hrcXZmRDlKY2RXeFF0eER2d1hE?=
 =?utf-8?B?ZmhZL0Vud2t3N0RDRUMwUThjSUJLYVlVTU0yNzFwTkNFNm53WFJDVFYwbFgz?=
 =?utf-8?B?V1h3bysxbDRoRy85NU5CaWlzMVR2YUllUmQyKzJYTU9VWjJaQzlzbmJ2VkxT?=
 =?utf-8?B?cFNydVdWNEpOa0JrRUMwWUJKbTNTS0VsMldwN3FVQnJTTFo5SHZ3bW41bSs2?=
 =?utf-8?B?R0R1K1lJRjdvOGlXdndPRXBBTGNLVHZiUDJRREpYN1NWb0xhTjg2STlMd05D?=
 =?utf-8?B?RitqdXNlRFRGU1p6UEwzOWFOU2pTTElRSXFWM0NUZStvZWo5VUEyKzBpYVJZ?=
 =?utf-8?B?dFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8dfc29-299b-4af6-f148-08dd54fb5dc9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 17:47:54.5584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMsFLEQKXIomFuHWtC0jqnlt9pDFssltmy+4IdxIInAB9G72fOBRHhjeJ53AY4t2enIKH0e4OIVKeAKnLFQFxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6175

From: Jan Kiszka <jan.kiszka@siemens.com>

The procfs does not ensure atomicity of the open handlers. Therefore, it
is possible that two instances enter successfully because we check for
concurrency early but only mark a vfile as used at the end of the
handler. When we run into that, the refcnt may underflow on cleanup:

 kernel BUG at ../kernel/xenomai/vfile.c:555!

Protect that path via a regular Linux mutex.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/vfile.h |  1 +
 kernel/cobalt/vfile.c         | 61 ++++++++++++++++++++++++-----------
 2 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/include/cobalt/kernel/vfile.h b/include/cobalt/kernel/vfile.h
index a53c237759..b0a5dce7bf 100644
--- a/include/cobalt/kernel/vfile.h
+++ b/include/cobalt/kernel/vfile.h
@@ -39,6 +39,7 @@ struct xnvfile {
 	struct proc_dir_entry *pde;
 	struct file *file;
 	struct xnvfile_lock_ops *lockops;
+	struct mutex mutex;
 	int refcnt;
 	void *private;
 };
diff --git a/kernel/cobalt/vfile.c b/kernel/cobalt/vfile.c
index e2c0f0a965..d762526b63 100644
--- a/kernel/cobalt/vfile.c
+++ b/kernel/cobalt/vfile.c
@@ -167,12 +167,18 @@ static int vfile_snapshot_open(struct inode *inode, struct file *file)
 		return 0;
 	}
 
-	if ((file->f_flags & O_EXCL) != 0 && xnvfile_nref(vfile) > 0)
-		return -EBUSY;
+	mutex_lock(&vfile->entry.mutex);
+
+	if ((file->f_flags & O_EXCL) != 0 && xnvfile_nref(vfile) > 0) {
+		ret = -EBUSY;
+		goto unlock_exit;
+	}
 
 	it = kzalloc(sizeof(*it) + vfile->privsz, GFP_KERNEL);
-	if (it == NULL)
-		return -ENOMEM;
+	if (it == NULL) {
+		ret = -ENOMEM;
+		goto unlock_exit;
+	}
 
 	it->vfile = vfile;
 	xnvfile_file(vfile) = file;
@@ -228,8 +234,8 @@ redo:
 		XENO_BUG_ON(COBALT, ops->end == NULL);
 		data = ops->begin(it);
 		if (data == NULL) {
-			kfree(it);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto fail;
 		}
 		if (data != VFILE_SEQ_EMPTY) {
 			it->databuf = data;
@@ -239,8 +245,8 @@ redo:
 		/* We have a hint for auto-allocation. */
 		data = kmalloc(vfile->datasz * nrdata, GFP_KERNEL);
 		if (data == NULL) {
-			kfree(it);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto fail;
 		}
 		it->databuf = data;
 		it->endfn = vfile_snapshot_free;
@@ -283,14 +289,17 @@ done:
 	seq->private = it;
 	xnvfile_nref(vfile)++;
 
-	return 0;
+unlock_exit:
+	mutex_unlock(&vfile->entry.mutex);
+
+	return ret;
 
 fail:
 	if (it->databuf)
 		it->endfn(it, it->databuf);
 	kfree(it);
 
-	return ret;
+	goto unlock_exit;
 }
 
 static int vfile_snapshot_release(struct inode *inode, struct file *file)
@@ -416,6 +425,7 @@ int xnvfile_init_snapshot(const char *name,
 		return -ENOMEM;
 
 	vfile->entry.pde = pde;
+	mutex_init(&vfile->entry.mutex);
 
 	return 0;
 }
@@ -503,20 +513,29 @@ static int vfile_regular_open(struct inode *inode, struct file *file)
 	struct seq_file *seq;
 	int ret;
 
-	if ((file->f_flags & O_EXCL) != 0 && xnvfile_nref(vfile) > 0)
-		return -EBUSY;
+	mutex_lock(&vfile->entry.mutex);
 
-	if ((file->f_mode & FMODE_WRITE) != 0 && ops->store == NULL)
-		return -EACCES;
+	if ((file->f_flags & O_EXCL) != 0 && xnvfile_nref(vfile) > 0) {
+		ret = -EBUSY;
+		goto unlock_exit;
+	}
+
+	if ((file->f_mode & FMODE_WRITE) != 0 && ops->store == NULL) {
+		ret = -EACCES;
+		goto unlock_exit;
+	}
 
 	if ((file->f_mode & FMODE_READ) == 0) {
 		file->private_data = NULL;
-		return 0;
+		ret = 0;
+		goto unlock_exit;
 	}
 
 	it = kzalloc(sizeof(*it) + vfile->privsz, GFP_KERNEL);
-	if (it == NULL)
-		return -ENOMEM;
+	if (it == NULL) {
+		ret = -ENOMEM;
+		goto unlock_exit;
+	}
 
 	it->vfile = vfile;
 	it->pos = -1;
@@ -527,7 +546,7 @@ static int vfile_regular_open(struct inode *inode, struct file *file)
 		if (ret) {
 		fail:
 			kfree(it);
-			return ret;
+			goto unlock_exit;
 		}
 	}
 
@@ -540,7 +559,10 @@ static int vfile_regular_open(struct inode *inode, struct file *file)
 	seq->private = it;
 	xnvfile_nref(vfile)++;
 
-	return 0;
+unlock_exit:
+	mutex_unlock(&vfile->entry.mutex);
+
+	return ret;
 }
 
 static int vfile_regular_release(struct inode *inode, struct file *file)
@@ -645,6 +667,7 @@ int xnvfile_init_regular(const char *name,
 		return -ENOMEM;
 
 	vfile->entry.pde = pde;
+	mutex_init(&vfile->entry.mutex);
 
 	return 0;
 }
-- 
2.43.0
