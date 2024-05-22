Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2079.outbound.protection.outlook.com [40.107.7.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3123D82C60
	for <xenomai@lists.linux.dev>; Wed, 22 May 2024 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716377639; cv=fail; b=cMMgMCOU3uHDKMVFRKVzMsT6tH0mI2MfW80FyExkptmBAynlWp7jENu4sDElb1mP8gRl/TQhQ4YW4q3bcAxZgQ3BJHI5YBsvMkG05sY//q2NDDDxU4h1NhbyQi6mJErxPNteRM00Cl7Y4RcKmTAqu8XdZJc/cIh7xDYLhABYCZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716377639; c=relaxed/simple;
	bh=JhloVXCyBeooV+d23Un8ALiUeql9maXWNON+D2dp6qs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KQAoM5FEIUW6NLUxfkGeHXarhP1lEfj1eB9pvRhRdQyxq5j4dz/18QSNpXI20b4z0pSTFKg6tC/HDXZLCs7YrCd0EsUcj09BhW4WoojZcYTsCeTNUQeQPTuKEctEZHLvvGbxWF+wo3XIa/gHr0/1W2AbIB0H1dNmh3QoLNVmRPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=jflVUYsp; arc=fail smtp.client-ip=40.107.7.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="jflVUYsp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzMUkxZEwrZ6GcFD9EhUTuCIeAWlyoEoDX7hSri1YlsetpdwWqmxt1knDuHrJyXEeh4hKdwNF5lvKHrCOBhn1EFlq2JrClIHV5Uc9c6uJPVr3B7NP/fXYIrb0SwPxVBYqRO7yxoAvfFtzqF1sUgpiORJXl1NRXItDqQAuXc8G+NrgkagDlJdlTI8/Q0aBrTfb579/yY1BMp235XCXUlUIB/Q3Dz6Lf6Z+HDNU1du7CBWTNEm4pclmf+8ont2oyGbBcT5Lt+ddYTBE/bdt9FHZy4iDw81aV+iK3yeNi3UYgdyzHrfINs8TIZxhUJeX8L9FCdqjSCZuIL+neKv3IhU8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i29bYsXKyJgSIyJM93Qi9ZhKxLC6Iz1vTzcJetX9o7o=;
 b=SXLXzT8V6FN1hUuS3U1u8xkU0A23LBzDfZKItoOPLBL93PbvwslYraVmiV9BNG0a6zxYxhwQ5tlo83UY6mq8rhXEg5W8ytqx6kXoKXXm2HwmDL9YIWrGk7pbLW58BMtjAd/lEDO+8GFDfL4Vz1VaQv0qVMRbJ/tDSJ9j9wVQ3QYSk9k0Pzt3JPwtkiS2pbtExb2pZFJkWtCTPKSudH7dWcVBg1SNUD7YCrMWH6JMl+Go+wBa/UAK9+Z04NT2HNhqioAKxrCa7QvOC1pvOfWJ1cWhoytYtSwKlkNNllSdE+j0KjLoPAM/ml5DYBN44mnCu0AFyxcJN1fMVasKoZl6+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i29bYsXKyJgSIyJM93Qi9ZhKxLC6Iz1vTzcJetX9o7o=;
 b=jflVUYspDmEKtp9i004moox8DQLQy0kl/iOGClZoG/FVAN9Usx6tkZQPQ0Q6vaKsiLd+608Eqh40tCZkNZG5EyN7NmwAsBkYKAsbr3OMF/Tf7+oFDNjx7RkSRM1p65rl2x7AiseVbTn6NT2fItt37leKejt2xgLe9m35hYGRLoaJqaSVWoV5iHOdUI7mmoV950ugMk4bMOxoVqpBoWzyeImN0LhEG7y4zDIkwZfWfzxhQKqbXXoCyfZ9rFBZcx8FHStOOsySyJgOGZ5fzXD/qVmaJTfnokaTJH08zWAKJP5RZJ+5cGqQjn2TDkHKZtgLTlqLYYYbl4P4OjBTCWGPgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6669.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 22 May
 2024 11:33:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 11:33:52 +0000
Message-ID: <770b74df-11fc-482a-9d2b-119b92e7097a@siemens.com>
Date: Wed, 22 May 2024 13:33:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] prepare-kernel.sh: Add reverse mode
To: Richard Weinberger <richard@nod.at>
Cc: xenomai <xenomai@lists.linux.dev>
References: <20240518112703.30713-1-richard@nod.at>
 <ba5e0fc8-e2fa-4495-9cf2-69f0ed2d1621@siemens.com>
 <1792993044.132105.1716360194595.JavaMail.zimbra@nod.at>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <1792993044.132105.1716360194595.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: e020d367-41fb-4a40-5704-08dc7a530e1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YURJQ1dBcmhHMmVwSlVQWWIzRk9RZ1Fma3cwamYyUjE3SWpVRWFYYjIzWTdt?=
 =?utf-8?B?ZWQ5ZFpjakdmaGZBa0t2TTlhS04xaWhoZlNzNWlOWGpSMFl3SUFTK2JSZk4w?=
 =?utf-8?B?Y2xDa3h2QW5ZTkZGOGZ6bHc2WmFvQ00yOW1qektucXJ4MlB1UU5GdnhEWnJ4?=
 =?utf-8?B?UytHZW9TVTloUzlrT0VGTUtvdjdZNEh6aHF4V2tPSXBOMjFTeUMrdms2Zkpi?=
 =?utf-8?B?cVp2OFF4dGhTL0xWZGd6MXY2OXZueVpKeXdPUWV0aGVjb0ErUXozbXVIS0hJ?=
 =?utf-8?B?VUVoaWZaelhZc3NwMTRLWmVDeE0rd3hxSWEzb0gydyt1MmxlZi9ySFpSM3dm?=
 =?utf-8?B?OGJ4YlFIT2tPd2tZM2RneWRCbWtiaWNERTNWMTdKZWQweWhaVjE3UVFuc1k5?=
 =?utf-8?B?RW5hUHJoazFLaU9BbUlMQjdBeXhjZ3pnTGNkL0pKb2VzUDRWTnNMT2RaZ2Fs?=
 =?utf-8?B?Rzh5MXpwSGhNditVd3lOYUxLU2VzWGNiRXJKNXdQQXlUOVNmd2ZXNjV2N25H?=
 =?utf-8?B?cDl6VkxQb001aEdvVEw2WUpLK3J6TFdCY3FTZ3BCT0hQY1FzYVJKRnR3Tlp2?=
 =?utf-8?B?dzVXZkNJOXJjZy9UNzR4NWlSSUo4VnEzUnpuWGlCdjdDbnlaUHcrRGJvbE1Y?=
 =?utf-8?B?VklEK1p1Nmc0R0ptZk1WVTlKajM3VUVsVHVpVWhlUXJZOGVBVWpWOElPRk5D?=
 =?utf-8?B?TjZSbEFIN0p6SlNoRWlwd3pmaGp3dFp1elc1KzZ2Mk1NdHZMSEdMQWYvWWR4?=
 =?utf-8?B?U1haZEJzMkdLbUJRMTR6N1hsOW1hRUNQcm5Ha3F6UWcxR3drN09JemxPYnVr?=
 =?utf-8?B?M0hKS3NVQ1kvU0ExVXB5Q3p6cW45Rlh6ZWFBNFpnaFFpYmc5STNVNWlqM3V6?=
 =?utf-8?B?TFFBRCsrQ290ek40VGFYOGUzdTRXc2hXdVZRZmFoQWhCMUlIeTVvWC94czhN?=
 =?utf-8?B?dEc5QVZtcG5HU3NsZExRTjd2bWxtWjhHZkcxY1JRSVFpLzUrUUp4a3ROa1Jh?=
 =?utf-8?B?MTR3cVpkelM2eXFyS3o3UmhBelZpc29MZ0hVb09ra1p4M05ERVRUMS8zU3ND?=
 =?utf-8?B?czFncEN2TXhrMHpuNWJEQmIyeFl2N096Sm1OMmxmc2RLY1FMMy9VSTc3VVoy?=
 =?utf-8?B?VVUxZFhUbVNORFRjbDVIUDFtT1JBQzFrc205bVNpdmlmVWlCMUh1bFZad2Rx?=
 =?utf-8?B?NnV1MWo4QlRxdU85TStQWFJLaW1ncXRGdkhMb1pxbzRaMFJtSVVYN0FzVURC?=
 =?utf-8?B?NGVFbVZQRUl5d3JpOUZURTZjMFN2cW8rb1hiZkZQUTg2WkNjbSt1ZHBsWGJD?=
 =?utf-8?B?aE5aeDU5QmQxWElRK05DVWc2NmlJNDhsWG1Hb0Z5dGZmY1Z3Y3gzYjIvelFD?=
 =?utf-8?B?L2FhRGZCQkVoL0ZvcStNck5Xb2FVd25pZWN3QjN3bThSeG92TjluUlZLa1gw?=
 =?utf-8?B?NitFMHJOdUc5My9rZWN6NkdOZjh6bFlORk1kdDQvekN1Tk5mM0lRbm9wWHRU?=
 =?utf-8?B?a0tNTVd5YTdCTytjSXdDS1VFaHoxQjBiUUdtTnZUbTNjQWVkVUt0cDBSQ0VC?=
 =?utf-8?B?bmRxdjhZaXVTTlNGaVVaQ3REY25nWnp6djhRcTU4MGI3U0xoNTg4YzIrdnJJ?=
 =?utf-8?Q?uEUdA/nuz4VsgPTYB/8jJhsrL8e+9dLuC9YyQ6ANy/c4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emJIaFN0a1ZDTS9tSkRiTG5ENEhtVVhWRElSdVlQVXB5bC9ZU0Q3NkF3TUJD?=
 =?utf-8?B?ck5xR3ZTd0VRS25USVEzV1d0TllhVWoxMzZXczI2N3JGeithNzNQZ1RvNmho?=
 =?utf-8?B?WlFtZkpJcElhSXFCOTZCWjZwK3h2aytnaTlKZGJhTWxRS0hiUm5jcHlIOWJs?=
 =?utf-8?B?cnhjRGUrNHpHZHFuS2RwNm9oNm9GTmJlK241d3MwOWxZd0d3VE9lUEV0M0pH?=
 =?utf-8?B?dWs3cEQyc09rOXNkMzFQeHNyeGs3MWZjYno4WFBwUXBrdTZoc1BWOFRacFBm?=
 =?utf-8?B?dVluam1OTmhPT0ZMajJoRFN2NEl6RGpDVGRpZmEzdjVmb0xuNGZrWnBvUHJj?=
 =?utf-8?B?S25pR3JoRzFad2N5aTRPZGVsOWc3cDRsUHluSktCbm1DSWhKaHhpY25GOGt4?=
 =?utf-8?B?ZEtNZldVN1RtZHRqemptd3pRVmpiWHN1ZFRESUUvdXV1M0xGTm9VcXIrMHkz?=
 =?utf-8?B?M3Vzb3B1aEQ0TS9iRS80YWhXNmRZL29VSjBDSnNRbnFWbHI3d015SVl4T3g2?=
 =?utf-8?B?Wkp1RkJTQ250Nnd1OGoxOWQ5cklrUEtTcWx6TWRhelpwRXJWRjZQeE8yNEtO?=
 =?utf-8?B?Zi80Z1BzNEVRdEFXWitxV2d6TittemMvY3I0QWVxcVM5L3JMcHU1U1lUeWk3?=
 =?utf-8?B?bVpWVE5KcjFGYldGWE1Fcmt2c1U3N1I5NlV4a1JobmZLVEVaUU5HMEZKdThz?=
 =?utf-8?B?azZkaWRmMXhkaERMcnB4V24wMDJwdVFLUTlscTZQZXJrSlJ3K0hFcVlkOE5H?=
 =?utf-8?B?c0tqY0lLTWZ3ZGtiZ3FodUpVM3ZKMUZIMkN2clVpMVkvczBnaTY1UUFHTU0v?=
 =?utf-8?B?bDN3NC9FZzlIZnJzT2tTVEVhR3lRODNHRUpJNmtTQi85d3l2d0ZTS1ZKSXZN?=
 =?utf-8?B?Q1c3bWNzZkhaQ0Z2NG5xMEF5ZGlzY1pHOTNzcVJrRWFWaHhLR3oxRjZiSmVt?=
 =?utf-8?B?NHd5dGwzdTFkVXRzYmJSVC8zUXg5MXZBdVYwWktTMlFuVzY3cHdVVjFnYW5x?=
 =?utf-8?B?OGplRlNIa3FHU3BpRElDZjRaVHk4cWNaTEVoYnd3aFZ5aC83dTZJZWo2NGRQ?=
 =?utf-8?B?RU93SWhZd2cxejlTdjZTTkhMRzBJUFdlM2xaU001MHpHdmpEak5MeFhuYmxz?=
 =?utf-8?B?eWRsUmYzSTZWRHFCeG5iQjQzY3BqSzJSU2tFd0IwMXRDdTdmdG5YZWVkNDVM?=
 =?utf-8?B?YUc4WmQ1aGFMUTNQTlNtYW5Rd3p4ZmxLdUlTVklveWl3OFAwOFpmL2ptUXps?=
 =?utf-8?B?RGpjbjlkTHlEL1cyWFhuUXdvQ1RoTWJVRVlpV3lZNFg3Tm9uZFpubDBENUlU?=
 =?utf-8?B?dzNTbnpCTGxJSEl6bm5jWGo4bzhxQlduMDlpMGRVbkZ1eDNLN1MvTTNMQzh5?=
 =?utf-8?B?Mk1YaklLTlBkY3JPaldPeWhVVUtxWHVCT1FLR1lYVlpuZWtHL3ZzaitQazcr?=
 =?utf-8?B?Rm1VVFhvKzAxRTNoY0NhT20xaWQ1c1N5RnN2bUdHdjhSa3V6dXlaMjlWRnFJ?=
 =?utf-8?B?bGRNNnp3dVBTYlYxSVFEckViTjhRcFpwejBCVU1tY1gyTUJwNm1WcDQ3RWFF?=
 =?utf-8?B?QXJqRkZkUHVnWDBZQ0VMRlpQMEF4ZzB6UE44TWVKZDNmQnM2SzBrekNHaFVI?=
 =?utf-8?B?Nm1ScXd4RWoxNzJ0M3A4TjcybUNZMTEzZUFEdXRoNTMxNzNxTXRXREJGRXlX?=
 =?utf-8?B?bnFjY29vNWw2cHIrdytzZVZBMUVyY1c1elNwUTFDc2ZmZ2pPMTBmTDU3V21N?=
 =?utf-8?B?eXVPZzBuZktNUVBMMXpZWTN5WWxUWmRLNklSR2ZlcmZDWGVqenZnckZKTlBG?=
 =?utf-8?B?dVlCSDFIbHpJbk9tM2l2d0pDSnd5Z1I4bDYzQ05HQmJHN201TGN0czIvUjN5?=
 =?utf-8?B?TTdBbFdJQW5vN0tRVm04MEdISmNVNUY2TDdZb2Q4V0taTllvMnNBOGtjdm4y?=
 =?utf-8?B?N0FRNzZoa3gvQUVjRVBYdElCQUxpWVJTdURyZk1kdURiOWl5cWMzaDR5YjBz?=
 =?utf-8?B?L21SNnpIdmxUcUhmSDQzK2RTeDNlQy9nd2lubWtUbUNzalhWOGhCT0Eranky?=
 =?utf-8?B?K0dLanRtbndjSTloZjJCZCtLSCtsTUpzZTFIVm5YOXhPVEovZlBNSG9tQmFq?=
 =?utf-8?B?L0ovbFl6T3czc3dHY2NMUWxTd2tLK3ZpUUdIUDFTbG5ON1Z3QzFVWHJlaVdw?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e020d367-41fb-4a40-5704-08dc7a530e1d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 11:33:51.9705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZXLsKxymJCQbrURv+rPwCZ2ekLKrR8WLAgjqBzr2vg8upVtKgKJCxiSLtYJSIC8NWEVmeNqI29spMsUY2dIIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6669

On 22.05.24 08:43, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>> Indention is inconsistent - to the degree the existing one of
>> tabs+spaces in the script is considered consistent.
> 
> Yeah, the whole script is a mess wrt. indention.
> I have prepared a patch which converts the whole thing to tabs.
>>> +if test x$reverse = x1; then
>>> +    if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/Makefile; then
>>
>> Won't linux_arch soon be a list of archs?
> 
> Yes.
> 
> In my WIP branch I have glued everything together.
> https://gitlab.com/Xenomai/xenomai-hacker-space/-/commits/rw/prepare_rework/?ref_type=heads
> 

Just submit both in a single series next time so that it's clear for me
which should be merged first.

>> I like this as it obsoletes my local script :). Just minor notes, and
>> please make sure it goes will with the any-arch patching extension.
> 
> Sure. Beside of other fixes I've managed also to get rid of /bin/bash and
> changed the script to POSIX shell.
> shellcheck is now happy up to warning level.
> Info level still gives tons of suggestions I have to review.
> 
> Beside of that, what's do you think about the --filterkvers, --filterarch, --default and --forcelink
> switches?
> IMHO we can drop them. I don't see much use in them except of adding complexity.

--filterkvers and --filterarch date back to 2006 and this commit:

https://source.denx.de/Xenomai/xenomai/-/commit/b1ef45e37c06a2e62d57cd139b410e02bc486898

Unfortunately, reasoning was not recorded, and we can't ask Gilles
anymore. I tend to agree that this is not needed in practice.

--default seems to have become obsolete for the linux path with
https://source.denx.de/Xenomai/xenomai/-/commit/0886b75af74654682794102d080dfd4a16da1244
- I don't see that linux_tree could become empty anymore (unless you do
"--linux= --default", but that would be strange). Adding your new
default value for --arch (all), that switch could be dropped.

What would be your suggestion for --forcelink? Just drop it and skip
over existing links or make it the new default? Enforcing the update is
probably not as safe as using the new --reverse, followed by clean run
of the script. This is at least what I would do.

> 
> Same for --dovetail, since no release patches are made anymore.

That switch is for integrating Xenomai + separate patch on top of a
vanilla kernel. I would not drop that feature yet, even though we no
longer distribute patches as releases.

> 
> Also, do we really need interactivity?
> Currently the script can ask the user for the paths to Linux and the dovetail patch.
> IMHO everything should be controlled by command line switches, no script chitchat needed.

Where would interactivity still remain after the above cleanups?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

