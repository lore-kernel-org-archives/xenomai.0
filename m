Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013032.outbound.protection.outlook.com [40.107.162.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA6330B53E
	for <xenomai@lists.linux.dev>; Fri, 23 Jan 2026 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769189354; cv=fail; b=a7PAOrliCoCmmununKixaEIBRvWxFNmEKYSrZkznH1vaYMlyowSa4P7HvKXkRaj2ZoPJVtu89Krz31bq9cA7NeXrWIW7Hi6S4K7FhJUJ0+6r1lFuSCHTcpJzgF9Z6ePyjwCkQT4MGXJmUbz/CaBxykyImHfnO+I0p0+YaS+epfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769189354; c=relaxed/simple;
	bh=ovLnEyrlnNLexyrAdVgaNX+cKuLEgzEWiQ6PARa+sn8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o3v2OOKCoJ64As2SdcwLFjWXHrMw5l8MRMYKWQWafek+MAzM/L9fs5CvU9awCFQmdqcS0H+kTfSUN3vRVhzAzsfu620WvUgR0qsbPQxhQtVtMwSFns77Iwzz4mc+jtzG/alzFxvMqZoe3q8QubfZmpVxYEzQfHaOHelgtSOBYiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Vb6Zo7SW; arc=fail smtp.client-ip=40.107.162.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Vb6Zo7SW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqnFKvlsVEEOFQZ3iBve7nyxjQlzT6734vpT9aosqJOp6CCFDC7J4eeG2JRr8y1038Y+A4FRmJKo6EDbedYUAC6SKEHHMoIg/dYNWYWZPFdhKQuooWfp4FoqiC6FT749Wrd//s2JgOyHyd3PO3nd3VwTDCx4irhrkiQpX4GFpz+VUN8ePb5Wud15QzMA94a3ROeC/Ne2/Oe+LsDGuChMw4UFF4jxlXTTnfMhDWGkQjgN8yoc63yf6f11vRVycq9H9m2j/+uW/WKwBL1i5dFiDZo3x0+myoWBvpeJIw+07dePGvD5SLttib7oWKDT7KVXVib5RiQdcX21BCab4Ld4+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LICRKsFvkLcYH9RdmVrWR8AOKubQpto/TGXEx77tAOU=;
 b=jZE6g4fyhwD+IrHcXJbg8/ohVrz37KQqeL7zay+Kkxo86V+fqRBSoh2AJZrxsOcGboVwAy4c/4pruYwHEO5L+RCFknP+relo2LJJFg+1U/7rlBnnjYnlUXrYZJJ5tX11bTKB6qxn+Q6PK+nYfVyzOd/ZpB4V5G0tCkR2nWO7o+hSucMuGv+2GquiRkFHecom+ZLH6cC2gKTx9uGwbu+Ljjl8pKt16J8Xg3S2ex++fIRYJkLtZcqvBIF7tfJDw46t3XOi+yEpO0BQT/5xYoJblPND4b0srDV1l0WVTnCzWjB6FTUghSbVQmumkHnA+VarkjWXos/m9aD7crW4UwL8Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LICRKsFvkLcYH9RdmVrWR8AOKubQpto/TGXEx77tAOU=;
 b=Vb6Zo7SWnr7yZlPcQrI7fT8x8xZnXW972FoO2sCGj/aFUkRbrOqwXsLXiA+fW0Ng+lmhAbr4g0c+hxuI223FPs3madk6RwirDZOI0I4Z15/w89pXR+y2GqJFxrPEtAupcKTIB7ZrLECqN0QY+yNwIGPX2ZHD5dkM88Wu4C6cssTDjqI0EF5BwI8Skop/faQl9jCb7Yi9Dby7nmoPC6prHZExA+s+u1t5t0NoyXPYiiQI9LMRhibFB8I5En6Rz5YiPYyP3ichLal35ZPbvuukZzK49muF1NpXPqslclploWZeVfmBC10ma/dg2ak9vaP6zdqomtzipZoTj39n2tpqbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6455.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 17:29:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 17:29:01 +0000
Message-ID: <3eece4fe-d485-4336-813d-54bbdc0d7c82@siemens.com>
Date: Fri, 23 Jan 2026 18:29:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] libevl: split libevl into libevl and
 libevl-test
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20260123141501.1871775-1-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260123141501.1871775-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0444.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cce7e6b-f414-46a5-4402-08de5aa4e618
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THNScGQ4UUVwM0k2VGxwM3RkcStKckJodzlPZS94bTR1L2ZrYkZHbHRWYzdi?=
 =?utf-8?B?QWhSQnZPK3VrNDlmS3RZZWZZa250cXlIQnBFUnl6VFNjNmpBaVJBMlZmQ0Jo?=
 =?utf-8?B?aXlCbGp1UFg2REFzVkIzT1V4dG1KSDA4VmNzd2hCcjBUazBOMXZ6eGVJYlRQ?=
 =?utf-8?B?ZDB2K3lyU3kxTDkvcXRLc2pCdXpXelRPRFEyVEF1aWdhd2hzZE15Zi8yZUtn?=
 =?utf-8?B?L2N3blA2ZlVpZjlaRlAxVEpxSVJSNUFXS0NFUW41YmxwU1FTVCtCbDJYK1VD?=
 =?utf-8?B?b041OWZ1U3lHUTN2cklYMlkyNkREbEdMcFNKNkN0UTh3Q2U1OW5NVFlmc3l3?=
 =?utf-8?B?N2RVbU1McFFNNlI0b0FuOXZVNGI5OWZuSThEaWczem9Zb1VLYmZVek5mT05R?=
 =?utf-8?B?UUxrM1B1Rk5SS0RjVEV4V0E4WmVjS0xxbHg0ZG1uRFl5bFRlazMvcE5lMVQ3?=
 =?utf-8?B?dU9uek1BeUJrcVEwbnVKSERtc0RTUEp1dCtZZzZTcTkrK2xmNW9Bd1hna1lj?=
 =?utf-8?B?bExaWEFkTUNwdGdOeGVpRnErS3Q5eUJENWNSQzRWazJUT0g5blFxbDdVSnVi?=
 =?utf-8?B?Q3VocTd5ZWxBV2ZhQ0FiQ2RjN2pjSHJabnNnNitrUFV3b2x5L2YwTm9aMFgx?=
 =?utf-8?B?aTUvdW5jM2hGdFJDVWYxTTdINmNtRC95S3FhTUI0d0QvaExxeS9ibWxzRFZ2?=
 =?utf-8?B?WkVLY2lyNnRJWHUxdElBcUdKUVpqWFdGeVdhUkM4b2FLMmhQVmRoMVExSUFF?=
 =?utf-8?B?TUJnUjNSdGN0YmNkOWpwZzlyWWpTR0NsRlg4dlIwb1hUaG9zMU90ay9Sb040?=
 =?utf-8?B?aUFGRHBNVC9vczI1c0h2S2NxQVJsU21EVVdBdFU5WFlsMGJXUnhnV1BUZFJL?=
 =?utf-8?B?UzQ4ZllhTEx0VHR0K2tEQ0psK0lXa0FPd08xZ2QyeVNQTlI3Y01sK3JJVFdQ?=
 =?utf-8?B?TWFGbmlISjdZWCtFdTg4VGwrR1ZCTmk1M2VLVng5c1FnVld4ZkIyVStRT1Er?=
 =?utf-8?B?bUtpM3N4em4rc1dTc1JjaVM4SXhKSWZQZDNtTWNYZnJieFhINlJsbFV5aVlj?=
 =?utf-8?B?Y2tjMW1yS1liSTh2bloyR0grUGVnYkV3cXF0SDV5cjM0b1Y3UXZwayswN29s?=
 =?utf-8?B?YTFWZ3JPajBNbHF1NFNJZXh2Ykw5Uk1JcUIwZ3ZTdlgrWEVlRzY4cThFVFln?=
 =?utf-8?B?N2h4Q3dhTzJLNWFGeWIzTHNqc0N1N2tGYXF1MTJtdVBVQldRR0lIZnhvY1Nk?=
 =?utf-8?B?YzlNVHR0bTJ2RGxPb2NWcjNxbFdMeWQ4VkpKeFlVVVJvSFBzMllYb1NXVXVS?=
 =?utf-8?B?WGsrM1diSFhPbkt2cWFQeGhjd2NSbXUyaVRPVVovanluYW1NMS9GN1IrUS9u?=
 =?utf-8?B?eGhkMHE5cFNBM3owT0UwSFZhWC95dFQydERIRXVoeU9HVTJreGhvNHNPVlND?=
 =?utf-8?B?ZDBoWDdSQ0xMamtPQ1FTVFljWEtnYjRSOXIzblFRN29PV21Gd3loNFFlU2xB?=
 =?utf-8?B?dzZNSXBZN3lTRXkrNlhvY3NWdktWNjBGZ3VhTkFWZ0JqV1I4Z0FydTMxRmhi?=
 =?utf-8?B?cVYrUW9KdWpZazF0RU5aZGNvMXFralRlT3IzRm1xczZGMVA1cjBrSkN6alpS?=
 =?utf-8?B?eGprUDJIMGtiVjJ3Q2lkSXpTaWFXK05JMkE4MVlqRC9tdTR6d3RQVCtkRkhP?=
 =?utf-8?B?TUZvOW8zeEI5KzB3eE9VcWhCaHh1MlRkcXVFeEMxTDhadml3c0I2OXJ1a2Zi?=
 =?utf-8?B?eXRLZEtjNmtoemcxaEtJSUNQckFHUUZjR21ZZXBUSDBsaW1VVEZSV2hPUG1h?=
 =?utf-8?B?U2tscFVMMG9VREh1Y1ZWK1k5bEpjaTRNaEQ1b1FXRzBydVNzdkFRODlBcDZh?=
 =?utf-8?B?cjhMWTFEU3NQZTJlenBKcGRjU3YrTlpSSDBKUGl0K3R2bk5pcEY4Ti9DSFRR?=
 =?utf-8?B?ZVMyOVROaE5mVVQvcGlNNWpYUGZycDhVTEF4TVBqZFRSQ0ZpQUFyWnU4dzVm?=
 =?utf-8?B?cGNkZjJMKzN6NitYQXl2VnlnVkRiVVljM1lrUVE0aDJ0RXZmcHNFM0ppeDcw?=
 =?utf-8?B?dkhrSDd5eWRISDFSaUgvdmdFaUptVTk4QzgyeEFKRVdQbU9PU1phTWl3cndy?=
 =?utf-8?Q?ZrGk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0tDMlNRMFZsdDFJSHFnUjBvaGZZaUI0Z1piWXlQNEV6RUp3YXFXVEFuWFc3?=
 =?utf-8?B?SmI2ZWxQcTdiZ3ZqUDBrcU1VRmpuYmxhcXQ4WGw0OXdORHFidW5SblJSalY0?=
 =?utf-8?B?UEFuZXVBUElOQWFXZlhJajlwY1NDbllxT0lneUpSdHNEdVR0Q3JaUlBGSU9O?=
 =?utf-8?B?RDRDMVNYTXdkQU84LzQ5R3pZUmEybUluMEova0x2bWg3a25VWldxcjMyOVRv?=
 =?utf-8?B?OEszMzVYNThsbWw5akVBbk5FOUlXZ2oxQmUwaFJxREgvcUY3bGZJc3RXVjBr?=
 =?utf-8?B?bU0zMStVQzVEYm5Fd0kzRVhXTDEvdUpzWVp4N01pWHE2a0Y0WVJ3RHdTR2NO?=
 =?utf-8?B?QVNJQm1wQXM2VHZCaS90elNiazh2NUtMTmI5QUp5WTJvcXpOZXgzSmYzWTVU?=
 =?utf-8?B?TmpKbC85TjhubmUrdlZ4MDNCeDc0bmdMdUl1Ry95SHdHYnZRZ0VyMk9zVHBJ?=
 =?utf-8?B?UXovNzZveFlnd293RGI2YUhqSDM3RlJLZ3NFQ25XWDJBQjBmUUpGbUdRRGZE?=
 =?utf-8?B?cG5ONEVxVlZxcEtyaUltRTM3NDZmQWpYK0grYjNwdDdvdmlPTUlyamxpNjN0?=
 =?utf-8?B?Ym04Vktpakx0anp2WFg4NHAwZ2NTSmhpL1ZFa2dldUExdmZ4aUdjU2tjcW5n?=
 =?utf-8?B?M283MFgrZlZQZXRqNG1RbkpPZ0ZMeU9PS1UxSFRhYytBRlI0M0xNVjNkeGZn?=
 =?utf-8?B?WEQ0bkZzZDlvQUVsRkRhR2paUEw1MW9lbnRsN3JNQmF1ZDRnazlUKzUxaDRG?=
 =?utf-8?B?enRkM2FkcTVmckZaaHh6bnVJR1RVTm5icEg3YitFMGJJaWt4cXdGc3dMTzBO?=
 =?utf-8?B?bnFYMHk4OCsyTmF1MHpBK0pHT0Z4YzhwdkJyVXkxdkE0VjlreEhKRDJSd2Z4?=
 =?utf-8?B?VWc0RzJFcVV0S3k0U3NVamJYcnB1Q0NzeGh1Q3A5L2tsamtpbjV6dGk4bHE3?=
 =?utf-8?B?aHdpaGdnQ1FNYy9xU0hzK1FXdmRaL21qVmNLUS9aU21ZUURpeDVaM0hseFJr?=
 =?utf-8?B?VjRmbExvTC9XSnFZbDRPd1lBQlpWN3R5QXRBZStxMkZkUmw2WGJnV0dPRjJZ?=
 =?utf-8?B?S3RDOUpwa0J5bUxBdkhXNnJLc3NNYUdwa0VsaEhvM0ZTbEgzVUQvTXAwdzNt?=
 =?utf-8?B?QUpUeE54QVdwU2dQVTZhSlZkemVMdTZINjI1T0lsNDJpWjMwbUk4L21OdVRy?=
 =?utf-8?B?ZUZYQkkvTlBKRkdLRDZDeHF4SkxxRitWVzNJc0lzVXJyaGhjdEp0L1RTZy9z?=
 =?utf-8?B?OXhWOGlsbWRRU09YNkF6WGZDU2xmT2VRVURqVXAwUGJFQTZVNmp0WVF4OVYz?=
 =?utf-8?B?Ny8ySkRWbzdXcE42TDZuSjlWcGVqdFN2UmR3QUMxbko3bUtTRUM5Q1MvM0I5?=
 =?utf-8?B?MFFMOXJWQjlYME8zSDV0Q2ZIcWhqdGozUEZ3VERDcmoyN2Y2MHVEL2JDTnIw?=
 =?utf-8?B?S1RocUVRQy9sZzNJQ2RDNnVIcXhqTEJqVC9lQ3BTTDVBaDFKUjVuSnRndnpU?=
 =?utf-8?B?SFVpM1JERVRZc1FQMVJzV0NUZHRISWJyZDhzcGRPMVlWOHpWNjR3VllQMHpr?=
 =?utf-8?B?cmducm5ld3pDS2JQcUIyd1hXOVhJVmFUMzBpbDhXcm9mcUdrVXYvNmlyK1RF?=
 =?utf-8?B?OC9YeUFGbzhGc2EwN2xsTmZLZG9BZ1ZrcEVpeUxKSis0MW90RFFzMHVPWndh?=
 =?utf-8?B?Zlo0ZXZ0OHJMQTB2ZE16cVd5VkpnMTZDaTZaZzI2MkhpWHVGZWZWU0QwMjRU?=
 =?utf-8?B?YXFvaml0a2lVcWJvTjFGUFYvMHU1b1dtcUgrYmJhbWoxcTJ6SGhYUVNsdXBu?=
 =?utf-8?B?enl2UFozNUd3MzlJZGNPVlBmUmpmZGc4K1Uwbi9FRDRPV0h3ZS9BUmJSTWpJ?=
 =?utf-8?B?VkFHU251S0JoYWJaRTdic1dKdThUdStsU3JXUHhnREZsUE5zTVlocmpwQ3NM?=
 =?utf-8?B?MTVQMW9CQUZTaGEwTlhXOTdPK0lnTGpPMTZ0eG5yWnYrODUyUGdXQ1ptVFJQ?=
 =?utf-8?B?WG1hMnhpSnZiZDJTMTNPUTdnU2x2Y2pucnR0K1MzY3ZUUm9XcThVbEJKRGFT?=
 =?utf-8?B?dUpPdHBWSXNLakd5OUxlaUVjVDMvYVBkQ2dsMHpaZlZZQWQzbzdPUURlUGxw?=
 =?utf-8?B?UitqTHNkV0xJWHVlWUNRcFMzVGNSUXBGVWxnNG5KQjJHY0RXNjZCUU5RVzJK?=
 =?utf-8?B?N01vOTR5RmNzbGxxOE9xTG1RMGd2bTUycHJudnNDWEY5S2xRZloyNEZwVXQz?=
 =?utf-8?B?MlNGanFWWk1kMzZyWlVXVkYvK1ZXQXNMZkRXMXNqTlJIZ3VEOW5wanB3a0wx?=
 =?utf-8?B?WVJvMU8rWDVDMTdQNUo0WGhiSFJBUmF4MjhML0lmQjlKUThLYThJQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cce7e6b-f414-46a5-4402-08de5aa4e618
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 17:29:01.5780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFCZuyLaj4wOT3i41Jb1DNeSv8e/uXlvY0j9K2I+GfwwQfCspOuuNq5zDrH9X2ocW7naKScMl9P7F9ZdAHzfKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6455

On 23.01.26 15:15, Tobias Schaffner wrote:
> Split libevl in a pure lib and a testing package to make dependency
> handling easier and to allow soly installing the libs.
> 
> The ptrace-sync test uses gdb to resolve and set breakpoints at some
> named symbols. Add gdb and the libevl-test-dbgsym as dependency of
> libevl-test.
> 
> This is a substitute for "libevl: allow gdb usage for ptrace-sync test"
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  recipes-core/images/demo-image.bb                       | 2 +-
>  recipes-xenomai/libevl/files/debian/changelog           | 0
>  recipes-xenomai/libevl/files/debian/control.tmpl        | 5 +++++
>  recipes-xenomai/libevl/files/debian/libevl-test.install | 3 +++
>  recipes-xenomai/libevl/files/debian/libevl.install      | 9 +++++++++
>  recipes-xenomai/libevl/libevl.inc                       | 2 ++
>  6 files changed, 20 insertions(+), 1 deletion(-)
>  create mode 100644 recipes-xenomai/libevl/files/debian/changelog
>  create mode 100644 recipes-xenomai/libevl/files/debian/libevl-test.install
>  create mode 100644 recipes-xenomai/libevl/files/debian/libevl.install
> 
> diff --git a/recipes-core/images/demo-image.bb b/recipes-core/images/demo-image.bb
> index d0a1f42..7ea4dbe 100644
> --- a/recipes-core/images/demo-image.bb
> +++ b/recipes-core/images/demo-image.bb
> @@ -48,7 +48,7 @@ IMAGE_PREINSTALL += " \
>      lsb-release auditd"
>  
>  IMAGE_INSTALL:append:xenomai3 = " ${@get_package_names(d)}"
> -IMAGE_INSTALL:append:xenomai4 = " libevl"
> +IMAGE_INSTALL:append:xenomai4 = " libevl-test"
>  
>  IMAGE_INSTALL += "customizations sshd-regen-keys expand-on-first-boot"
>  
> diff --git a/recipes-xenomai/libevl/files/debian/changelog b/recipes-xenomai/libevl/files/debian/changelog
> new file mode 100644
> index 0000000..e69de29
> diff --git a/recipes-xenomai/libevl/files/debian/control.tmpl b/recipes-xenomai/libevl/files/debian/control.tmpl
> index 36eb68c..89c871a 100644
> --- a/recipes-xenomai/libevl/files/debian/control.tmpl
> +++ b/recipes-xenomai/libevl/files/debian/control.tmpl
> @@ -9,3 +9,8 @@ Package: libevl
>  Architecture: ${DISTRO_ARCH}
>  Description: ${DESCRIPTION}
>  Depends: ${shlibs:Depends}
> +
> +Package: libevl-test
> +Architecture: ${DISTRO_ARCH}
> +Description: ${DESCRIPTION} - test suite
> +Depends: libevl, libevl-test-dbgsym, gdb, ${shlibs:Depends}
> diff --git a/recipes-xenomai/libevl/files/debian/libevl-test.install b/recipes-xenomai/libevl/files/debian/libevl-test.install
> new file mode 100644
> index 0000000..e4118fd
> --- /dev/null
> +++ b/recipes-xenomai/libevl/files/debian/libevl-test.install
> @@ -0,0 +1,3 @@
> +usr/bin/latmus
> +usr/lib/*/evl/evl-test
> +usr/lib/*/evl/tests/*
> diff --git a/recipes-xenomai/libevl/files/debian/libevl.install b/recipes-xenomai/libevl/files/debian/libevl.install
> new file mode 100644
> index 0000000..7efc9b7
> --- /dev/null
> +++ b/recipes-xenomai/libevl/files/debian/libevl.install
> @@ -0,0 +1,9 @@
> +usr/bin/evl
> +usr/bin/oob-*
> +usr/include/*
> +usr/lib/*/pkgconfig/evl.pc
> +usr/lib/*/libevl.a
> +usr/lib/*/libevl.so*
> +usr/lib/*/evl/evl-[!t]*
> +usr/lib/*/evl/*trace*
> +usr/lib/*/evl/kconf-checklist.evl
> \ No newline at end of file
> diff --git a/recipes-xenomai/libevl/libevl.inc b/recipes-xenomai/libevl/libevl.inc
> index 1783042..4c048e5 100644
> --- a/recipes-xenomai/libevl/libevl.inc
> +++ b/recipes-xenomai/libevl/libevl.inc
> @@ -14,6 +14,8 @@ inherit print-revision
>  
>  DESCRIPTION ?= "libevl libraries and tools"
>  
> +PROVIDES += "libevl-test"
> +
>  SRC_URI += "file://debian"
>  
>  DEPENDS = "linux-xenomai-4"

Thanks, added to next, right before enabling the xenomai-4 tests.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
