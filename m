Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5508018B46A
	for <xenomai@lists.linux.dev>; Thu, 24 Oct 2024 10:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765812; cv=fail; b=kqxf3nbrisAU/2kpFs5AQu6mhfgehM3Bt8Mz+Vtmd71skzd+8Il3WSOEJqhwGg0IEAUvntcnS2dMaChbjCK9SOSnKtDeeEAzQEcdq/PlSmc9XmdV4uqXVAJ74zcLnPRCv6pvuf2G7HDs8IKl/7kuKGGS/VSDMFhWrWt80RTvjmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765812; c=relaxed/simple;
	bh=YVoxEdpI3dvfyjwU4FT80rj7O9VWK44/+HtiO5beX3M=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TGt0PkBn6xkQNUgF48BpbsUx6haiFWzFMXA+4s8faPAuOqYV6/Ofwc8v2jnsu+YSG1Bvm7v3BaAaxGouXi4lcGmKdaDHy5eBhnHyzH3HMXYg8GjzZnU6SEknzbPB661DiRD8+CH4i3IFIZxyKMClbflcpEG3uGWJ3cLcaU3ykww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=PSz5z+iL; arc=fail smtp.client-ip=40.107.20.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="PSz5z+iL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dN5zHSwWmZS/gJ3hn3GJrULIAbuXkI5CZ6E7lpnDuuuhGgVvRyL1v5Z8MA0twpMnSuNnwigEBlpZ7YsTAVXYxrIsKMZGNrfa303h46LaGFwHyh9GeWXGqpUbBhD7SvDJRRlXQVy+0WYthaWpEQ7bExLBzpfCz8TH7VmRxKjDa9lyR1Qk7m7uHfDRwWnwhEoPBO4+HlgCo7MWR8TKBrerryIYG6khPt67uJOsZE47iNxSYcGvveyNwCKJc8yxT93VJ8EYhEsbu4fotvROjR3fKXGzr9Y8KzfmTGTQSwFlfSrIIhU81jSiUyQfDTkHPMDjzx2xAXJU/6VLvFPbR34WyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Li+NBANsFRuj7OkxwesP0qrFl+9Ik/cnmksutbllhSs=;
 b=jLdBHuYlsG1XJNIwG1W/F8hVrCvVy/MmU7E4NN1CvOx/SDfmEkWdG2OT6F8jHItxpoqd/jbGohhzEuCn4h9id1+nxdZ35N492ijSks2aGL2wUklZuwiyzWGmjN7MNaUwj5z6nwGLvKF0BWDUyWCrGMc2OBGHR4TndK5czVK8LwPbgWvrWvqKpFbgYVRKrWjHSVm+QOR+cYUC1yH4NBivIZF3ACaB5yDJBxTqCi5lczAHrmEByI2GRHFnSuM6hTsCBokpKy/Xse9hFgsgXo6+WlAIn70xXwhUqvKNyNStzqsBNEU1SxRer+CqbTdFvyVbeOIKuFa5bDILZ37Qei9Q7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Li+NBANsFRuj7OkxwesP0qrFl+9Ik/cnmksutbllhSs=;
 b=PSz5z+iLht5alI8JFIAvuJ2nwQHPv1zR4peoM/bL63bGYjYbpIv/SwdyjzIb7NUWkfpGmkSM05AL056+WO/6Jc5RPwLvUtCh4EXaL4pzKKYdQOtuHKvTLMYvWRhf5cygSIgak+sApisWCH6mRfwMJSA+LtYCIlcvCWQcFN4z8XfDPcmX/jLafEJ7V1RcZhbRxv5ImJYjCc6KxVQM9Nos4lnEhDV49nqdkHTyqBVgQVp28wkcPGWDmJYHD8kX4+qKILT0Uuiv1OhrpZxqb409dnghEXOvUfD/o6ZJO7jii/P3tChXirSBFgi7judtDzQ5JkRAXuYdUiH04M0Zc96Tew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6014.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15; Thu, 24 Oct
 2024 10:30:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 10:30:07 +0000
Message-ID: <dcfe813f-0186-45da-acb3-76fdd9ba9b9b@siemens.com>
Date: Thu, 24 Oct 2024 12:30:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] y2038: lib/cobalt: Fix __STD() macro usage for some
 services
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20241024072656.179803-1-florian.bezdeka@siemens.com>
 <7d1df6ce-21bf-4a1c-b8cc-ff2c449c6575@siemens.com>
 <2bca1fdbb9ff21c91cd13a583deaace3157baedc.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <2bca1fdbb9ff21c91cd13a583deaace3157baedc.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: a3c2df85-d05f-4da1-3f71-08dcf416d47e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1RnTlErSEZqMnJXdDA5c1pmTlJDOEhSaDIvM29veDZrSjFyTmd1akpQemVK?=
 =?utf-8?B?dHZwdGlKRG53amVlclgzWVJwbjBNMEYyTzMzRjJqMXFreHRZMHVoMjJtWlBP?=
 =?utf-8?B?dmUzUDJlTzdxSElOMHkzbDcvdTYwZWlBL0ljeS9OQVdwbkpPWlJoMzJtUXUv?=
 =?utf-8?B?RHE0QmRXQkdrWXpOVDdITDVoS1cvRG1NSFhKV3dOSEFyYzJZMnZ2N0tVUlg2?=
 =?utf-8?B?akVJQnRTV04wTjIxdHR5UHVUVGJONHZ0YXpVd3pHbCtncVdIVGJWSEJiTTA2?=
 =?utf-8?B?bkN4YzY0aEUyRmJHSjk2NjBURlFFRWNpRjBkZmFNSDBqZTRxUHd6YWxpT0lj?=
 =?utf-8?B?amRpbkw5YVA0SVp6bVY3ZjdzZ2thOVY5amNQWk41Z3RwMHNVdU5RSVh6d2VF?=
 =?utf-8?B?MExhZDNNa00yd3NGNHQ2czJuZWhSa0ZsYS8yTUs0ZHc2UXF6WU9uTjVTZDhY?=
 =?utf-8?B?U3M2NmUvMGd5YmdSVnRNQWhYN2toWGxaaVQwOVBWVFF5YWErMXhUaVcwZHds?=
 =?utf-8?B?N3dGRlFxS2xiell0STg4dGx6anlQOFVvTDhIQW93RzNjSlBlanc3bGZrMXhs?=
 =?utf-8?B?Q0Rwb1VVbUFmblhWOUViODFhdUV0SXUrMEs1cm94bVUrTE9IZmlqUCtza3M3?=
 =?utf-8?B?YTJwelBKMjBhNjMxRHB6Y0hMemhIWjNYbzIxekI5a1NTUVFEUkF1V21ERHND?=
 =?utf-8?B?MUNjdms3VUZzeWtOMVFYcEVhTUo5aDUwOXVacmV1WmtoQ0I1YkxZQ01IZXA5?=
 =?utf-8?B?N2lKbnRmbFRBbmxxblJNQ1R0UExjK2EwVEhUTmZuVVR2Tjdna2ZiT3l6NnRy?=
 =?utf-8?B?bHl5WUVNRkg0L0dST3FUSGZrQjA0TGtlV0IvS093cFNaazVZZGljWW1yeTZ2?=
 =?utf-8?B?dDNXMHNMNTVJZGFtaGYxVndLYzdEWE1RSmx3eUJjVHErZXFId2k5clZEYTA4?=
 =?utf-8?B?akhSVWpFc25HUjIwVEVpdzNQd3BpWlMwdUUyVDNiM0lnQ084ZjBsd0l4SGR6?=
 =?utf-8?B?c1kwSVFxVTBycWFwYTJhOGFLcUl6MjFHYzR2YUd4K2JORVRkczBhNURkYXlv?=
 =?utf-8?B?OEY2Z3hCa0UvQWVQYWxQUnFiWVY2Q3RWdnZVdy91SnBEQ0F6Wk9LcjdQSDJ5?=
 =?utf-8?B?dkZ5b3VaNHZlRlhwZ1NpQjVqekZIK2IycGkvSm1RSUVUTWt2N1BpTzduMUxy?=
 =?utf-8?B?bEFIanBZZFlZd3BibHI5VGoxdnpBOXY4VVRUSkVGSm9TTThLQnZOWlVOSmRq?=
 =?utf-8?B?c1VSWDgwYVcrNm9LOGZoNkNrR3c4NmFTNG41QkVPcnBWK0VGSGpwQmllUFgw?=
 =?utf-8?B?cTNHbHJYMGFWVmJmdFQzZWFQZ3JVdEtCaS93SFBWdDNwWGVnelZ3NGxyREk0?=
 =?utf-8?B?TGRlOHRsb25CclpudHZ3UHFibTcwb21TM3N3TjVBWXNlOTJHWEx2cFFJR0JP?=
 =?utf-8?B?b2JwTS90ODRpQlV5Wmw2YlhoOTFocU92SWJvOWxzOWZJZlI2N1dFaTVocXh6?=
 =?utf-8?B?bHNQL2NJenhVZGQ3dUgzMmREVUV5U1g2MnZFYjUwYy9VZlo4MC8wMUQ4WkNE?=
 =?utf-8?B?dFF5VTMyNktrOG5TTm5MVGl2VGJWZktUL2xicGFEZ1FPbTU4QStNNjE1NUV5?=
 =?utf-8?B?V3hBamNpNnR4UVE3dFJBNzdHTWEzK1A2TzgxNjVBVHMrVDV3dnNVWEc5bmhL?=
 =?utf-8?B?TnZ2Z01IQnhxVXpVQTUxSFd3R2gvSkg4dS92bzN4eVRjVnBnSjdKV2UzOGFq?=
 =?utf-8?Q?quZX2ldDlhohib8STQ3YmybtehI6ePZX3XuPwHr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFBieTJQQTB2NWZNN3BSUjRpcHdhMHcxVkU0dmVMOUZsc1J6cG1NVVY5UU5U?=
 =?utf-8?B?OXkxcWtTaFk4S2pwcHg5c0dxZ2NvVjRLcmFiMTVBZnlHd0pJTC9sMDJTdDFH?=
 =?utf-8?B?Y0NBZk5wRnlJelF4UjQ1NWpLd2FTNFZINjlubFRDREJrTUVaT2g0Z1FlQ0ly?=
 =?utf-8?B?L2ZQcUhya3N4RFhIbjNtU0krSWFsb3Y0YmVVcHBNZkNGb205b2RHQlBwWWJ5?=
 =?utf-8?B?Q0ZaVmNEUHEvUUwwZmxLM25hditSUU9uNW9KcDRwbksxRU1meXVMejJiVmtT?=
 =?utf-8?B?S1hDWm53bU05MXdSWUVjT1k2bFFzQ0VWbFpVTDlVZDhaaUVEeStPVlFpSHBL?=
 =?utf-8?B?SHplanZHMWdCc2pNMEphVVZqK1dDaEJKMGhtWksrQnIxeEVpa2JLN2s0cFlM?=
 =?utf-8?B?dWdmSis4YmNrUW42TU1LK1YyUStIVVI4NkxqeUZoZlVPWFc1SXVUZHZHTGFX?=
 =?utf-8?B?VEQ5bUJHUHNRT0hscFkxVGw2RHBxSzVPQ2RHclZnUjZLbVpGdzNPZ0J4K3I4?=
 =?utf-8?B?dS91SExPK21jMzNFYjhwUlBrMTRWcm50ZWlTSC9jcGQ2ODVFNHpRb2Fneko4?=
 =?utf-8?B?YlZ0cGZCSXVod1VFZjlJazJwaWhQaFNDT2xIb1VzMGl1bXZISEdOWXVvenl6?=
 =?utf-8?B?QzBPVUk5dDM4dkRxU0JPYmJSdkhzM21EQWRsL1JITElldUhBMDFtMHBZdDF4?=
 =?utf-8?B?SWp2aldyb2dWMS9tQ2NOYXN3NFYyeTVLQXBRNWpHTGpMTXBlemhINE5nek56?=
 =?utf-8?B?L04xV0pqWjBPc1hHS3lBQlp4TER4SHVwYTlpdzZGNWwvMGU4OEtrc3FZM2hz?=
 =?utf-8?B?Ujl6aGVkNEhQU25MWmEySEh3RFI1TndZRW5sNVdEdFFUanV5alJzSDA2VjVU?=
 =?utf-8?B?OVlTUUo3dE1rR0NLTmFLdS80Q2txb1hoUWZKUXIwOUN0T0hZUTNsYU1xYWRM?=
 =?utf-8?B?dmtRdTVGVVZyb0x1a3laanMzUE5ML3VUMUZ4M1QzVHFGaEEyR1Z5ZWVYSnRa?=
 =?utf-8?B?RTNLY2l2N0s5YVNrMmloaTlKREYxVXJxU0ZyOGZLMG1kUHIwQlNScDFBQzZK?=
 =?utf-8?B?cHJQbE1ZeXdpS2xRbXBOR1d2R3FrSmhRU1Zva1ZmeDN4c0tEVHNjVHVndDdy?=
 =?utf-8?B?dWZNa1dNS2J5MUFGQkE1OXowRW9pTXFaSVF2Y0ZOQUNyeFhlYnhqdGFYL05t?=
 =?utf-8?B?VjlSUEpERVYxckdxTUNxZ3l6OWJIU3BMcmVxK2oxSkxJdTF4eWpqQVVkS0RO?=
 =?utf-8?B?czg2N1ZOVWJheWh4VVQ2dW9TS1ZucG54YVV0VnpMdEIzNFdOQVhrKzJuckwr?=
 =?utf-8?B?Mk0ycWZRdy81VytRR2ZlVXYxRXk5TkdOTFFNUVZvTTZPUFJjOVZoTldaK2lO?=
 =?utf-8?B?QmMxM1gzV3ozTHV2ZGxxckk5SHFmRzF1SVhGMVdRRUJEZ05DTVpQL3NjZ3Bt?=
 =?utf-8?B?aEZXbGZnQXZDUkFxenhCWEkyM1J2K0NuRHI4RjBZdXNBTjZGTEZFaUx0RDh5?=
 =?utf-8?B?cC83d3ZEMkRBMDVYMUxpdHI5K2w2YlFhanNiTmRGUVk1MU5scXJDL2oxV2VT?=
 =?utf-8?B?K1l4MmQ5QVQyUExraTkwTTBSUDV5NjkvVWg2RHVkZlR4MjFHcHkyOTBpMzc5?=
 =?utf-8?B?bzZyNFIvMEMrd243R0gwZ290aUo5RG5pUDRySDVYQ2V1NlNKSDI2bjFrMjVj?=
 =?utf-8?B?Y21LTm9mOWJ0LzJDUUppZC8zV2NEUGlNTndSdVVERk1MUGU4Zng1U3VUOU02?=
 =?utf-8?B?V09XM0RCR1J2aXJxRTI5bjlQSXUxQ1JUODZnWTAxODVTY0hML0V6N1Uza3g3?=
 =?utf-8?B?dVNIR3AwNGovTVBzUS8zRXlPTXZ1a2JMZlJza1BUalBQeHdPYjhkbjNXMnhV?=
 =?utf-8?B?dEp0VVpnMWkxZitpd2dPMWVYb2JUdzBlcTR5LytxZFRYRzJQTFBpS3F1dlJK?=
 =?utf-8?B?K1JNVEpLS3ZiTXBzQzdnRGd6ck9WckxPVXVpSVNnRFltdFdkR0NwVWthRjFW?=
 =?utf-8?B?ck5EODViOGR6NThwZzVramZocllvRzhDTnlwSXhQMEVRc3dEOTdMdnV5YnNa?=
 =?utf-8?B?NmYrQ3ZrbkI5b1dhVG9ZbzdkbFgySWtUYW1EN3NoemhKSURvajRXelp3NUlv?=
 =?utf-8?B?L3hIa0NUdE5CT3RKWmhOcTFsbHF6ekZScE4vRVl0K0hVNXRsNmV5WWsvb0s0?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c2df85-d05f-4da1-3f71-08dcf416d47e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 10:30:07.2678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8H+X9lTH1sWHx+vL14GZpxs//CU1c2xBSNx4IRPqikwLDZA8RVoQa1okYraiq5376wrje/UCCB//dW7ROHusrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6014

On 24.10.24 10:07, Florian Bezdeka wrote:
> On Thu, 2024-10-24 at 09:59 +0200, Jan Kiszka wrote:
>> On 24.10.24 09:26, Florian Bezdeka wrote:
>>> The macro usage was broken for the following services:
>>>   - recvmmsg
>>>   - mq_timedsend
>>>   - mq_timedreceive
>>>
>>> The message queue services were forwarded to wrong libc functions,
>>> the recvmmsg was missing the correct routing.
>>>
>>> Detected while trying to remove the function wrapping at all.
>>>
>>
>> Can you elaborate a bit on the visible impact for users? And it affects
>> 3.3 only?
> 
> Yes, this is 3.3 only.
> 
> Something like __STD(recvmmsg()) had not the desired effect on compat
> applications with y2038 support enabled - which is the default for
> compat applications now.
> 
> Rare use case but still relevant I would say.
> 

So, I wrote "The __STD macro usage was broken..." in the commit message
while merging.

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center
