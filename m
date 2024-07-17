Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B86111A8
	for <xenomai@lists.linux.dev>; Wed, 17 Jul 2024 06:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721197252; cv=fail; b=HQDLORFSzU0brkKWv/edV5UL0sy9USqMFAdh2hxoj68RaIAZ2w1PLaLbbfZG19fKHivNCGbUQU1DQ47YTNvgiivkrWmJI5VhKPSveiHhcQD0MQgDXyDJjhwpCHZjSRP7JyYSkJYJfiayOJvuyvr13SB8nkT+GreJ8uV2I+4m3XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721197252; c=relaxed/simple;
	bh=Etqvwbo0OvTY4fswMgtu/gb/DDGrxc0Z9jZmzAOEDkM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EiGGlIClQCbaXFrhz5bdXnMu5RhP+waQZ/MYPq7irtUIx0GJWcNqBo48JApOAQ7cpMShVct9UIZQw7xIiCUgdVqcRF+SkUaxAdX1bZl88BbtMiVxhcMTnD2EfRUIjH++oOlDqQPuWgsx6czLrPpJ8vsWKIMvD5RlEMqo3uXuPf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ZT40usxA; arc=fail smtp.client-ip=40.107.20.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ZT40usxA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BstLk2Og1h/B2Bxd3eeJL1jYbgbXLzqSnUn4+HQaCl77Pfo//geOF5Jdh4mVH4j4TStilxktMXOv9rbhYq9QkNHM79ZXbpR6q4j5NdBj94yn7uHtHCyOad0+QW4T9eJs20MaMoHWRVbcuYapJX9CvnOtWsCttNKo4icvkDkHXL2bGhB8ASlLmk8EGD7P27NelX/lEnQLdg3qyxGgMZpwmezvpDGhKDtlz/0yRStgm1IlHpASBKy0HWMUknkhr2t8YfUp+U1LOSOZLwxsbjb5Dd9eb4sm/65nvRszYob+Soy8Ft4eJiIN/yfoXc3Nkwoy7HfI7gOv/gBEpqs6GJaZNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InLCBMpgy9IQ5/OLXQQv6reqbqaE/jAT2n1IXDl5YA8=;
 b=WUX/arD4ZaD1SJEL5E741Su4H1P39AoUzA4NmFOGBKWJSChpozcFrD5ZkK7NNBFcD1lZV1f6ukFWkIgLlbIDKpOe1U+Gmc28IKGt2mE0YfwLBJoiHY2tLln0I9Sy9HVc6jsP8MncwWOpEL5EqaBnCg86sNeoZfH3gk2LNmYa2tdB/5G4EOt1ByqqULKrWcvTPS2M1MqbNOaWkWMULpHD6MnVAPE9FwTry5Z6xkdtJpHelk05l1DfQfwHWSqTtxYTJVV8ZKYxOgGUkb0xiGc1z9L5HDGHbCYW3CkEg9rXbIgizZttD24OxpFpaIIMcK7r1MKA9xTmT8WgzL3x4u138A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InLCBMpgy9IQ5/OLXQQv6reqbqaE/jAT2n1IXDl5YA8=;
 b=ZT40usxAR/IsqvuH+YkEMjwA2HQM43uLcKo7oKzzI+nilmuoTKGL0Fu/+cwAGeBkc4jxRH0+kvN8TeiK0qdFQshEJct3rE0klK/YtV5yehMwH4ltlDw/0EMjGxPEYBWNW6rYxM/sME2MNsM3dhRdMlFNVGTKqDzrVTNicGomk7x1MytO9uKfmS4VazrBl28jsZ89mvDzZwLYlzc+VbTnvADDePO4G0fEjM3tOF6Slp06xK7XothHUJzDHOa9X4NPPNtffXz5dTHKc7WEHops08XjxrQ8gWHUndiqVuAqQTmZigs/K2wiG0lIMF411ZP6GQo4gGGo7xHBcjPhNYnJ5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3647.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:140::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 06:20:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 06:20:45 +0000
Message-ID: <c5603537-e108-4cbc-a367-a2b6c45933c9@siemens.com>
Date: Wed, 17 Jul 2024 08:20:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] testsuite: add latency treshold option to latency test
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20240621085547.2088976-1-tobias.schaffner@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240621085547.2088976-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3647:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dcfaab9-5a02-4521-589a-08dca628979a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHZaYUsxd1FQTFBLMjFQdzEyVWNvOUV2cHBIeHpLalhudXlGMFl5MzNhU0RC?=
 =?utf-8?B?dXB1ZlZyWitlbmFkVElpbFl2K1Z3NzR3cXRZRVpITDN4YkZYQkMrMWd6TU16?=
 =?utf-8?B?b0E0K1FJQ0syWDJRTEtVb1l1Ujl6blZ1UTcxdG5nSzVCMDA2d01tZmdqM2lv?=
 =?utf-8?B?ZGg2WVd3N2w5bi9WeEs4V0ViT1NiM3R2aGI1U2JFNUVzbFYvbm5DcFdmZjJp?=
 =?utf-8?B?WDNkeUhXY0xrTFZIUjBZQnBoVVJmREM0WlVJVlQ5aE9vcUM0bnhaclA3WFJG?=
 =?utf-8?B?dlFKTVgxOXA0Smp3dGJSWFR6OHp0TmgrQWJodkkreEFITk9qanFycHp5WFFj?=
 =?utf-8?B?aDBrS2pOU0NLRHdsU2p5UnE4SlBrT3JCaVNwRWNJUXh4YXIzRmZFT2NuRFBY?=
 =?utf-8?B?dFV4aUFBaE42RHJzSlV3ZEl4UjMvMk5ZaFNXOUtVYTZXVmRINzFuRWFOTjFX?=
 =?utf-8?B?V3pjOFBBeU8yYzdLbjBtalpHN2I3MERreGUrWHlBSFJkZS9XcUd4VVFmQ1VL?=
 =?utf-8?B?bnc3ek5LSHJHV1c3NWNGaU9WVU40REwrb01CUmpGeWtLb3ZmY1RiT25DYnVO?=
 =?utf-8?B?SCtwMG03MjVWOEVmZ21NVVJENFVhVi92SVJ0TllPaVZqMWU2MStFWDFISlFF?=
 =?utf-8?B?dHo5UWsyQmlmOVhzYzRqMTV5ZzJHQmYyb1hNQmViZjNNMjBabVBET2pxeEFa?=
 =?utf-8?B?NlNmTHFSVkRkeUt1YVRMVnNqUTVXbDFOc21KQ2FBOFFqS2hxbWQ3OGdCeVpR?=
 =?utf-8?B?d240SVlQRDhpTmg3d0tkSTVKb1poWTBsdVhyQXhyQUpzWjFlM2ZhL0xqSFND?=
 =?utf-8?B?bm9reGE2TlZCSm5HYXR6SjJidnBUSFo0YkR4Y0FMRVR1cWtUQjZYUmVxZUFU?=
 =?utf-8?B?UEkwTGZpWjlSM1Ria2RGMUJBMDh3VGJMclVNTjJBbHRhdWozT2JOV2lSRW9p?=
 =?utf-8?B?RHZ4aGdmZDNKR2V0MWpUdVB1Y0wxa3BrN2hJbUpOVnJmNldROWxrbTFXVnZr?=
 =?utf-8?B?eis0NWdnT2Q5N2FzTWlYNEJReC9mRUNLcHMyRUl2QUdGdFNFZHlKM01tditC?=
 =?utf-8?B?SFpQL0JUQkRYNlU5R29RNndFcVlMZ0hzdGtzYlFmTUgxdjk1RHprTHhYMHZB?=
 =?utf-8?B?Nks1NStLUGVWSnVLVWhDQlRhYzNZdlFHTlVSVnhhME9Za1VaMm9PQ0JFdEJK?=
 =?utf-8?B?RlZQd21RV0FnVUViUWxBdEhqVGV3alBmSkR2ZnY2aW1udGZLcTU1SlJWRjZD?=
 =?utf-8?B?R2R4bENZVVlNS1JaNlBhZEIvTGRPYjdPZU55RDdLR2l2cHE0MXFWdG5JMi9s?=
 =?utf-8?B?YmZCVHNBeHh4UzN0WFFGQU1qT1QzQUZ6Z2lkb3JkclFodHIvZ0pXeFExaXlm?=
 =?utf-8?B?RldGd2M3cVBJV2RRSEUvS1I1ajdwbGowVE9HTTBXc0RyQ08rRHluK2E1R0V6?=
 =?utf-8?B?R1VLbEJDeDFqTkk2MkpxbHV3bTNpNHpsLzBvUGcxZEgxWW01UG50dVVkMysv?=
 =?utf-8?B?QzM2VURUK1dEbDR6a3RFSkRhWkIvN2YvNVhDRHFyYm14bStvQmd5QnZuQlN3?=
 =?utf-8?B?SmE0dWQ0UVNKNkFRRTZ3QTlrRzJWMUs1TUF2QkxWUXpqMWdoQjcwVXZmWjJB?=
 =?utf-8?B?c2NYS2VNZFZOUHZlNlZLUXJIbldiZzVtVFdmTDIxSlJJME9sa29ZWDdOaTdR?=
 =?utf-8?B?TW1iSnZWQTVuOFhETDIrTFV6c3FrTHJueGZMbXB3bVkxbjR5WnNsTkhZWS9j?=
 =?utf-8?B?RVBYSGN1OVdvYUt0TGxGN0w1bnRvdUJ6Ymx4Uy8vVVlMMlBibWRCRDByTi9n?=
 =?utf-8?B?K1lFMWJScm5lNTVqS1hOQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHcrVGZ3RmxDNEhrTDV3dmpjaDFKWVZ0ZXBrRHovQ1JtQzM2ZFJockx0bUJt?=
 =?utf-8?B?UGU4V1hMKzRpeWhuWEdydVpmdU5RUmFFVXkrWSsxd2YrVzEwZHJiZ1AzUFpr?=
 =?utf-8?B?dHFQTTBXcitBZjIwcjB4a2p4MTJ4NFV2dmQyZXZEUFNIQ0xLdldTWHNkSEJq?=
 =?utf-8?B?d21PTjZQbm5yV3dGZEtsdXJueXZJNmhyUm5uRTF6UktMbUVib1BDNC9KaXI2?=
 =?utf-8?B?N1N5bHJPL0ZVdEQ2NVNxM0FFcnNHek52Y1BLTkZwTjJsUitpK1NFWmFuQ09N?=
 =?utf-8?B?UzVFR1NqQVlKbzFEQ0RjdkYvb3VicTFRRmhkYVdKaXBDeUJ4YU9pZm9iU000?=
 =?utf-8?B?bTZxQmIzN0E1cU0vM2xsOThTN21XTGlnc1hrRHpiU1dnSlhGVUdkbVJtYTFK?=
 =?utf-8?B?MHhueU16ZzY1dkduZVZjZC9NMG5qUy8wMkRvWS9ES1BYSjZLMlM5eUVnbEt1?=
 =?utf-8?B?Rm1LNGNOdmdJZnpxWDR4QndyWmxkRERkTmpCQkE3ejhTbGdFcVpzUFREd25i?=
 =?utf-8?B?WVdIcUdsQmZKR1dmUit5UGlLcVUrZ05KTlVlSjBGazZnSEk4cXZkNHFXNVM2?=
 =?utf-8?B?WXJMQ3g3RFp4T0hMeitBUzN0OVFhSFVYL1JKeUJOQUFqRG52UTJxZm9iTU1u?=
 =?utf-8?B?dEkrTDU1WlBGcU1ZQ2x6L2ZKbGFmOERrcEh4NjVRdng5eVYveDE5a3l2OENB?=
 =?utf-8?B?RGs4cjZVd01HYXA4R3dnN3BQYmRWNks2REw4YTdyK0I0ZjhteVRrR1kwL0to?=
 =?utf-8?B?dWFaVTNwUG8vUTBVTTBoTUVLR1k0ZWtZd2taaytDQ0NrMG5QWUxyanRRTzh1?=
 =?utf-8?B?S2xGWFVPd0JrdXErSlZRQUw5b2taQlJtblN6dStwa0VkUmFZWTd4YnJDYmJD?=
 =?utf-8?B?TGwzeXhaOVM3ZVRUUitJc3RqaW1zaWc5ZUVuRzR4UlZPNVgzcG9OTk1ZMEl6?=
 =?utf-8?B?WkduVHNVcFJ0ME90cEV5REJ0NmN1MVJmd0dhL2JySkJRQVU1Z1BFSENIYktV?=
 =?utf-8?B?MEVTOXN5blR3SVpHbk5RVkxqelVnUTlrS2RQUm5YN1R5bzEyNWUrM0gxcmgz?=
 =?utf-8?B?MWhQMGJVVGJSdE5iaDdqTnYrMzVueDVncDc0TjhLdWFXMGp1b2RoOUQySHV3?=
 =?utf-8?B?UUcwTDFrdUc4bjdQN2JxZzZYVVBrWjZzRG8ybkNjd1Z2Rm9lUnI4Ti9yd045?=
 =?utf-8?B?RGcvMGFMNkUwMkxiZVRoMm9laEFxWm84WHREeUtmVTFSdGFPa1RPVjhRN2Fv?=
 =?utf-8?B?aVMyenNGUkZEdjJ6ZlZVY0JqcEJrSzc1Z2FWcGVpTitlY2VLRXlUZW45QnF2?=
 =?utf-8?B?cjEyd3QvTzl2dXF3cFdBVkllQmROdmQ3RFlOV2ZNMlZHbzA4djRlL1BCc2ZN?=
 =?utf-8?B?anVFdGlZbjFqcnJ5aVNHajV0eWtVNGg1K1ExVUMvam51NEZpdW4xK2VsRmFP?=
 =?utf-8?B?RzU4a0lsUnMrdVNJU3FRTGNwcTRKMHRYUE5PTU5EUUkwdm9lS3R0SGRQMHVm?=
 =?utf-8?B?UWdTRWlrSkxYZTVYaUQ5UWRlem9CMjBrYThpWElrdGhyQytzbVlMYmZUdXNN?=
 =?utf-8?B?Qm9SR21wS1IzZXlEOThpM1pUQWJZQXdjZVhqMXY1eVl5RzcxMkxaTmdmMGdW?=
 =?utf-8?B?SWlmL1Q3ZUdLTjVUa3Nkc0QxbUNqaG5mNHRSZk8yTnVzYTEwTWc5UzdycExW?=
 =?utf-8?B?UG1MbEV4MXgrSjFXYkNYdEZ0bVlNUS9QZGllSkJDK2NUb2krZHpDeS9NcHUw?=
 =?utf-8?B?ZWlzOTBnbUYveTMvSXl0V0hPZGhRL1V3bXhPbDZmM2hvUzk3L2N4d2tzTFFJ?=
 =?utf-8?B?R1FmT1Z6ZXlEdzBqTy9lb0NVTWlPblR5a3ZBcmMrYzVXVTV2VVNIWnpPb0pn?=
 =?utf-8?B?aTRkWFp5K1paYVRyWnR5OWpvc0lDQkpFUmJuMU5UcGZYQ3V1cVhQU1cwbEN3?=
 =?utf-8?B?N0VZbGJ4Qm5saGQxMDZtd1FBVlhSR3AwUlZwS0MxZWNBaEMxNXhLc0l1ODlB?=
 =?utf-8?B?ZTNQOE1wTFBWU2NxeHk0SUMwUVpZeEVmUkVSb3FoTFk5a0Q1d2NSdmQyM2Fy?=
 =?utf-8?B?STk1d3ZVY05UMkVLVHV6enlUUTRGTWN2ODVqVVV4VjV2NG5jOGEvZ2xiTzVR?=
 =?utf-8?B?NGZSdDNkM29vck5KS2JFMU53YjVKWFVpWVU5R20zT2w1MGJ4a21CVlFVdVRn?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dcfaab9-5a02-4521-589a-08dca628979a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 06:20:45.3212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Fk30viMnKNmXv38KYj1mL6pk5sIox54r2HiWqmnT6yJr5y6XIAIxP3WymmBkkqhhSfbcV345FOFkm+Gotl/8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3647

On 21.06.24 10:55, Tobias Schaffner wrote:
> Add an -m option that allows to set a maximum latency treshhold to the
> latency test.
> 
> If the option is used, the test will fail if the maximum measured
> latency is larger than the treshold passed in microseconds.
> 
> This is mainly implemented for CI long term latency tests to
> automatically let the pipeline fail if the measured latency is higher
> than expected.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  testsuite/latency/latency.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/testsuite/latency/latency.c b/testsuite/latency/latency.c
> index 7856b48b8..52e315d9d 100644
> --- a/testsuite/latency/latency.c
> +++ b/testsuite/latency/latency.c
> @@ -89,6 +89,7 @@ int32_t *histogram_avg = NULL, *histogram_max = NULL, *histogram_min = NULL;
>  char *do_gnuplot = NULL;
>  int do_histogram = 0, do_stats = 0, finished = 0;
>  int bucketsize = 1000;		/* default = 1000ns, -B <size> to override */
> +int max_latency_treshold = 0;	/* default = 0 (diabled), -m <max> (in us) to override */
>  
>  #define need_histo() (do_histogram || do_stats || do_gnuplot)
>  
> @@ -536,6 +537,12 @@ static void cleanup(void)
>  	if (histogram_min)
>  		free(histogram_min);
>  
> +	if (max_latency_treshold > 0 && (double)gmaxjitter / 1000 > max_latency_treshold) {
> +		printf("\nMaximum latency exceeded: %11.3f > %d\n",
> +		       (double)gmaxjitter / 1000, max_latency_treshold);
> +		exit(1);
> +	}
> +
>  	exit(0);
>  }
>  
> @@ -614,6 +621,7 @@ void application_usage(void)
>  		"-c <cpu>                        pin measuring task down to given CPU\n"
>  		"-P <priority>                   task priority (test mode 0 and 1 only)\n"
>  		"-b                              break upon mode switch\n"
> +		"-m <max>                        fail if the maximum latency is larger than max\n"
>  		);
>  }
>  
> @@ -648,7 +656,7 @@ int main(int argc, char *const *argv)
>  	cpu_set_t cpus;
>  	sigset_t mask;
>  
> -	while ((c = getopt(argc, argv, "g:hp:l:T:qH:B:sD:t:fc:P:b")) != EOF)
> +	while ((c = getopt(argc, argv, "g:hp:l:T:qH:B:sD:t:fc:P:bm:")) != EOF)
>  		switch (c) {
>  		case 'g':
>  			do_gnuplot = strdup(optarg);
> @@ -722,6 +730,10 @@ int main(int argc, char *const *argv)
>  			stop_upon_switch = 1;
>  			break;
>  
> +		case 'm':
> +			max_latency_treshold = atoi(optarg);
> +			break;
> +
>  		default:
>  			xenomai_usage();
>  			exit(2);

Sorry, forgot about this one. Applied now.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

