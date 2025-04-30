Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011018.outbound.protection.outlook.com [52.101.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5560C25D1E2
	for <xenomai@lists.linux.dev>; Wed, 30 Apr 2025 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746022504; cv=fail; b=NKIN3qcDxY/JfVBSpZricU7sYNOhooBAZZdT7NiNpII8z0fJXn3hnGsG3OkrisE8jW1Nt8NLZYJA5xlqhWlKB9cCvJ3PAsl/00r1Jhd0hc/MmIPYxEkU8ohlES0kzjLWP0IddWQaT7Oe5BynwVVdAGLGExxR6V9qzKtqtbbpJh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746022504; c=relaxed/simple;
	bh=esOROs6pH/U1YCEGn24PfZ3+fjgo9hkq+MWw3xIl0ys=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f5vn4nS9AypkmRmYPdSYyqY+oT6GExyw2+0PXa3I2UzdWvpkKbjta/wS/ggLR9G7TqREYeocm3LCOyY2Yi8XAA3x3987jpon51xoSIOdmZkBRqe8MQueufqaVSsS+qiy94d3mXjr2q+Mv0P0kBu1/AGX2dx+OxY7ANBE5eORRU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=mN3zKMHx; arc=fail smtp.client-ip=52.101.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="mN3zKMHx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1x8UXYZempNpmrT9mvpJ072jLWRUv439HCvgS+5e0cvNX0uvofkHVLG7n0AHqTKzPoPMPJptAyQFm3HZeOIFFKdJkP5Eu1B8FSkrbDtMk0Ex94DadaApzXoEe3fXeuUBX+nvYgcK4dkTe8P9MvMvJ8c718vlv8C65wA+DzAWg1o5J8BgEDdxH8gciC8QtTkpd2cl/FKRUDZvjQH07/ldzQr0Ddlu4N6OfKy/3pfDQO1E1kOh6NNxd2VpHhrIBbgWWIfTpj/5dN1EvVZty9hmRlqukgG6jua8eVvRT0Kx2vXcNy8bv1kvQOb5M2wRZfy0GbMlsHgf7lPaIhM7vSa6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQrqTzEeMOBapHDATfjDRJ+8I+POCZTrAMF8Tq0O2W0=;
 b=HaMa5DkG8BM+QvzbipLTlXU8jQTDc0oM8/RFUIB99OO6BkbvKRFGBOz/iUJL8QNUbUt38ItF5HXqFGm35LlM/Nje3St0E2EX7iIkRKpvl78+XT0hCuHJad8EYB1KNUj6wzHPMurePJ1i5KR+RdRbXPFaJUPS8jJwJaLS0fdbiSdkwT2ys/cY+7snpKhQSIk7iUugMQk98/MpsdzQdsg/+1B/pBTJ5MXCVg3GcHKom4tPrjiHTkO91U0U7+5zyBtgt/QvD4iCnzSKKh01vGDsk3viCERrCa9zjiY56je2vVP89irb/S/4W5s/bFPvIMhWeBWXlftGqXAetgvOdCZH5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQrqTzEeMOBapHDATfjDRJ+8I+POCZTrAMF8Tq0O2W0=;
 b=mN3zKMHxtMoAEMUlb5Pw21fexSwEFQPBIKOaVvtdSl5z0V5+a9TUd+pnf+E92yLo+fEiMPgFMNEXSHnOTkolSsuKLIEppTkAmp9xm379Z/eGp3fsZSazJe5bvUX4RRgaVpcE8Lx/ymHw9TPGXekQJblnMaFIB9tJ7aC6+6RLgwlK7wzdLADTKDv2L7O1eaOSjb4Lxt6gGCbuJjuMkZNvriW40LrNivzpGPRi2TRejddefnCRToIV1VJqKxevWGAKAVkm3zjX0DiqH8KlQrwwrB1KVlyLyfatgvEuza32yrISETrLyUj8aXuV5vEUZ0fF+hU5596fS+ykQnoyy5LWjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5339.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 14:14:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 14:14:59 +0000
Message-ID: <645bc7bc-9c4d-475c-9596-2f5813e23689@siemens.com>
Date: Wed, 30 Apr 2025 16:14:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][Dovetail] fix IRQ forwarding to the in-band stage
To: Philippe Gerum <rpm@xenomai.org>, xenomai@lists.linux.dev,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <87plgtg3r9.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87plgtg3r9.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0341.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5339:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d432a24-13d7-48f0-c005-08dd87f163f7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekxFaTZDVlFmTkY1ZHpBeUtNa3NRK0w0OHZKLzM0N3A0U0hqb25WVVltMTFy?=
 =?utf-8?B?OXhBLzFLeFliaURYMUJpNG0vQjA5dndUUjZSNlZSbFo5YzdVU3IvSFlPVjhy?=
 =?utf-8?B?aytBSlRoeDd3cVFCNHhWTmt0bXE4SE45NkNMRWxkZzRIdnZ1aG1Xd0k1RkRS?=
 =?utf-8?B?bk5YQTlnejZHVzEva0w5U3hTY2tWS0JpVHpXN1JQVjZDUG9URjZFSzFjVlll?=
 =?utf-8?B?WDZJUDdKZnBuWmpyeDhsdUNpS241Z1lvOEFZaThYZmYybDRmMHlZMTdMeEpt?=
 =?utf-8?B?cWJZeE95UzdmZUFDN04vc3RiWkZEYWRocSs4bG1VVWhOVC9QWVA5YmVlWFFX?=
 =?utf-8?B?R2hObXJSdkFNLzk4TDV3dGE0aEhKN21Md0d1VEVFRm9WdkpOdmJRZmI3Q2V5?=
 =?utf-8?B?N2hhNGZaYmhRUjAwc1gycXRsNmNqYmwrY1NuaDlHSXNFUTBSUStYMmwwdnpT?=
 =?utf-8?B?Sml1SEJoWm1uS3VuREQ3TlVxVmcxTUlkNE1sM2V3K3FuOVlIZ0JBeHpZVnJx?=
 =?utf-8?B?TnlOOU5NWTV3eFJaMFZuYkhrYnhpQ2dtcnAvRzZhdG11UnVHdEx0SjBLNW4r?=
 =?utf-8?B?ZzJZWHFiYkZ5U3BYVkhTWW44cWJTelprNHNXMTRxRlFtdnlycW96Z1o4U0g4?=
 =?utf-8?B?SllQdXQ2UCtxSWNFM2VlQnFYUFpickt3a2NMbTFLcDNXM3JkelVwczF2V2ZT?=
 =?utf-8?B?cXdvMHdYeXJ2QWRaVXBQREUvWkhKbVhpTnVQdld1bUR1MGRJZlZ2Wk5GYkhi?=
 =?utf-8?B?YkxxcFM4OW9nRHl1NlFqQ2dMVlBZVmc3alN5SUdXcS9sdzl4SDRIQmk3eUZu?=
 =?utf-8?B?ZmlSeXMzbytEamlYbklFTjViSW1PcW04QmpPa3dnNnRFSG10c0ZoZVB2NkpD?=
 =?utf-8?B?R1BlQXB6V05xNG9KMC9ITjVtSUJSU2d6OGZtRG1EVG9UQTFRWWNWWWw0dndl?=
 =?utf-8?B?Ums2elVmYzRyUkpha0FNZUoyNUJKeGtpdmduazd2RjdrZW1aQmQ2WitSUjdV?=
 =?utf-8?B?aHNKQllhdEdTYWVvZUF2dDRjTXliZ1lMZzJHcHB5SThUM3lkeEpsQ2l4WHla?=
 =?utf-8?B?R0tKaXFKYlUzVGE3akhVSFpNZ0lqeVVKOXYwUjJpS0x6VDJsQ0hJUDBJaVVh?=
 =?utf-8?B?ZVZBQS9tSEtlWm1pVitXY3F0ajU1RTJ4L1dQME1EQ21XTHByM3ArcTJhY2JI?=
 =?utf-8?B?aFpUUjMrNW1FdEl4MG1lM0g1cGg5SEkvTnBtdVhsN3d6OFBick5YblQwcEk1?=
 =?utf-8?B?WThzU0UrdExWK0svbG1PTmV4NGVmQmMxTG1xdk03RDJPdnFad2RuK3hBbUR0?=
 =?utf-8?B?YUVrZFR1MVM4WDdub2Y4ZWU3dzV4amJidXJpMWNhcjF3WkNHakJnZit1Q2kw?=
 =?utf-8?B?QVI4Wmx5ZitBWEoyT2hkQVpuYmhWVFdGKytNWmJYT09ZbVNBdDlzN2w2cEJJ?=
 =?utf-8?B?VWxnSnp0aVZCa0xMS09JbFE4TUZuRk55OEFoV3VwRmhKVU9Qb2pzSDBnVHcz?=
 =?utf-8?B?Z0ExZHhwdDNCdjROenBhNFV4bmlocDFwUVZ3b2MzR1lDY2hEeW1YYkthWGxS?=
 =?utf-8?B?TXZLaldMaFA0ZnliM1pYRW1VZWxpVk80UHoyQ2t3UGVYdTRrZUhqZVpTdTNO?=
 =?utf-8?B?VDkxOFZlemlrOXd3WnZUUWVYY0oxYmpuOEVJbU1ENjQwOUI2d2M2cDVaUy80?=
 =?utf-8?B?YVRIZXVXVXUwN3loUXhQRTk2bGwzck83VTZVaktORWxpOHgzWlFFV1gxWnVJ?=
 =?utf-8?B?NjdHMEFEZUNzb28yVDF2Mm1veStadTdVZUpZN2NTd0p4QlBJRThsUExEMlBW?=
 =?utf-8?Q?bVxm3UJDMRcZ3nzSFlEuHRQ8YzPJquYVuPRmI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVZSaWt2anNLVnNxVkZ0QitTd3JwekhNUEM4dW9sa2ZwaDN0elRWTEt1L1Fj?=
 =?utf-8?B?b2lVM3BLYTdkdDRXbmhYU2FsaVp3UEwrdGdCRlkrYXVzd1hRSG9JQlJtZzlW?=
 =?utf-8?B?bks3dU5RcCtvZjI0bmVwMlB0S0NNT0JZUld0cGcvMnUyNHFsazM4QkdwWW1n?=
 =?utf-8?B?WHRvU3IycDlSeDl4akVjcGFOM2FCT0ZTclBsTGhqSG9wcjZ0ZTZ0QThJRmVm?=
 =?utf-8?B?Rnc3UDNjaUpoaGswVW9PcnA1YWFpRnNvaCtZcHFWbXBDMEROdXJWU0ZZdFBv?=
 =?utf-8?B?dFI5VDlpUlpVYlVkbURtU24vK1Q2Sk5KaGVZQjJiRS9YSnNnT2tHRytUSFFG?=
 =?utf-8?B?Z1E1MUtnS1o2c3JnZEQ0a2lCNlVHTkxMMnFvUmt1a0g4WE5LOUlGMEFwNkdV?=
 =?utf-8?B?R1lkbXp6S2V3NWN1bk45Q0lZYUZKTDdJQXBwUWE5NmtHVWtBQlZZMHdBeVFa?=
 =?utf-8?B?WEN4QlZiRXBTNVFwNXNkWVdzalJsRHdXcVJKRlhOaVBnd0EvWkZLSnU0THhG?=
 =?utf-8?B?eGtpSVlUeGhnUVc1OEsvVUtNRUdIZklNU3RIRlJVUHYzSmpLbVoxQVFoandl?=
 =?utf-8?B?WjFuQzZYbC9Mbzc5a2VWWEdGNDc1S25hN3lWTU5OWG5QWTlWbzFHbzBhYmQw?=
 =?utf-8?B?TDZHdWVDeEhRZjZ6cTRkSmlVSUhIYlcyM3kwNHJCakhoMzZxRXc5RTFva2lv?=
 =?utf-8?B?Q2hpQ0Jia3BWZzRFK0xsR1lkbkNzM3BkdzZ6SnBFaGYxYnNNMHRoLzlLTFEw?=
 =?utf-8?B?NkhueGtRMU0rZDZ2MFo3bFFUSGZpb0ZqcWVwOXgrRXQ1bEVCNmlwN1E3S0d0?=
 =?utf-8?B?UnJZNEZlQXRLKzNzM3cvYlJ4MFFEdjloTGNZcnlpejNneENaaEJWNGQ3anNm?=
 =?utf-8?B?dVJjTFZCaTMraE1IWWs3aG5tOWo2NFJybzhZUWJiZ3FXaXZjbmhOMHF4WUNL?=
 =?utf-8?B?MFhHcnNrc3BPYkwrbmJCL2srWGNDVHIwUkxNUDYxODgrdG5hUTlNRXhCNnJR?=
 =?utf-8?B?Uzg4eklxVDNhV0pINHE1SUlxVUp5NWNnMHhoL0Jkbmh3WTA4ZDVLcDBNK3p6?=
 =?utf-8?B?S001MDhnVi91MUFPN29nMHZwR3ozcEVmTUpXUlJlSFQvajdlVkFOc3dOMStX?=
 =?utf-8?B?MVhFaFM3OXRmSVFyY3FKZ0ZnQ3JWRS9IYldMTGlKamVtMnBwYWRlaVJpV1d1?=
 =?utf-8?B?V1h2V1JiaFAxMURzb00ra0FPQUJvV2FTNnhrYlI0Znl6OHVEMEtnc3lPQ3Zt?=
 =?utf-8?B?VkdOa0xTV0R4QUYzVEg0eEhGQlRMaXZOYUFCSFpHTUhUQkZQYTdITjBjd3cy?=
 =?utf-8?B?SHRMRnk2Q2MyTzB6a3V2WURvSC9ldjBmOXBtR3NDY0ZiTHh2dk9PdGRKdURp?=
 =?utf-8?B?QXdIbW15OXJaNXJacDIwTjhOVTBBRmU4dHFOUDJ0ZlU5Q2Q3RVJLTERpMlpx?=
 =?utf-8?B?QllNcUtXT2FMR2VCQy8zdkRuMXNHc2U5YmFYRklvamorNE1NQngzZTRnREFJ?=
 =?utf-8?B?eDFDSml3eWRHTVdoNzFBT3A1SmhKdHZxOE81cFlJWVZEQjh1VXpNeThuelZQ?=
 =?utf-8?B?d0dDek04RzlLcFRjMmtYWDYycXJOTHRyMGtCTlNKTzBjamNZYzE0MmtUd3dn?=
 =?utf-8?B?ZDNXdjN6SlBQbDFwVVovOUVXeVp2RTBMdXBZYlBNT1FNK3daNVkvQ1E2Wk9C?=
 =?utf-8?B?S2ZKeUFvbVR3TURDR1RFWUI0ZEJMOEVmV3RoOUtPTExaL2FYeGk2VkZSNk9I?=
 =?utf-8?B?WkxodzNFTVpFdDVzaFhSc0xma1M0dGFkV0ZJYTJPVWgwVTY5NkZuYTl6VlNx?=
 =?utf-8?B?dEdTUGhCbVFlOEJVRTNhZk9WQUhJMC9JK1V4bmFGeEk4aHVXM0o2VTkzam9p?=
 =?utf-8?B?S2FNdVlHWHY1UnJIVE9qVWdvVHVpNHJUL05QNnpGVlFRYTU5Y1pVNWRSeUEz?=
 =?utf-8?B?ejZCTnFwWGYrbjMxTzI0QmJmVml6Y0ZwcnhUTVYyYU9ZVi92b2hmN0wzdGNa?=
 =?utf-8?B?N1BpeU93WkVpUGF3cGZnb3BJZnc0OE9zcTh1L3k4VFhhVUlzQ0ExQmwyQ0NL?=
 =?utf-8?B?eEFyOXlGdUpWa1REQnB6RlNCTUxCZ2tnZ2FTZWt2T0U3SE5LbDIxQmtmQXNm?=
 =?utf-8?B?aGY4NEc3UXZ0eFZtdzZRaTFXdUJtRUFPM0dNV1AvRFpWM2VoVEZRNjlwOWUv?=
 =?utf-8?B?N0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d432a24-13d7-48f0-c005-08dd87f163f7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 14:14:59.1598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fouk+sPMhda/h+mWGC0ztScjkY8PXTH252VKr2TEkSo6C/1pkrs7kdB5C6qP9jE+GjlDNC24VzL2WAYt5DqRaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5339

On 30.04.25 15:47, Philippe Gerum wrote:
> 
> Could some (preferably several) people check the patch below for
> non-regression specifically on x86 with stacked irqchips? I ran into
> an issue with interrupt forwarding while working on the xenomai4
> netstack which that patch addresses. So far, so good here, but we need
> more eyeballs and tests for this patch on a tricky and critical piece of
> code.
> 
> This patch is against the Dovetail tree for 6.1.y-cip, also available
> from [1].

Does it apply to more trees than 6.1? We could push that through
smoke-testing CI, but I suppose we also need "real" workload.

Jan

> 
> TIA,
> 
> [1] https://source.denx.de/Xenomai/linux-dovetail/-/tree/urgent/v6.1.y-cip-dovetail?ref_type=heads
> 
> --
> 
> commit 1b67dc87eaeb0da8d719d1619735b0bba4a06da7 (HEAD -> urgent/v6.1.y-cip-dovetail, linux-dovetail/urgent/v6.1.y-cip-dovetail)
> Author: Philippe Gerum <philippe.gerum@exail.com>
> 
>     genirq: irq_pipeline: fix IRQ forwarding to the in-band stage
>     
>     A forwarded interrupt event might trigger again before the in-band
>     handler had a chance to run, this confuses get_flow_step() when
>     determining the current flow state, leading to invalid calls to
>     handle_oob_irq() from the in-band stage.
>     
>     Fix get_flow_step() by considering the pipeline entry condition
>     (in_pipeline()) as a clear hint that we must be handling an event
>     delivered by the hardware, not the forwarding code (in do_oob_irq()).
>     
>     In the same move, disambiguate between forwarded IRQs and replayed
>     ones for multiple non-oob events from the same source which don't need
>     masking on receipt (e.g. edge IRQs). In this rare case, the condition
>     bit (IRQS_DEFERRED) might be cleared by the in-band handling code on
>     the first occurrence, leaving no information to handle the second one
>     appropriately.  We can figure out that a replay condition is pending
>     (instead of a forwarding) by checking the oob capability for the
>     interrupt: oob handled IRQs are never deferred (IRQS_DEFERRED), they
>     can only be forwarded (IRQS_FORWARDED).
>     
>     At this chance, drop IRQ_FLOW_PILEUP which adds no additional
>     information to the IRQ_FLOW_START state, and was therefore handled
>     exactly the same way.
>     
>     Signed-off-by: Philippe Gerum <philippe.gerum@exail.com>
> 
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 94ac7a5b264eb..82c67b49ef282 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -510,7 +510,6 @@ static bool irq_check_poll(struct irq_desc *desc)
>  
>  enum {
>  	IRQ_FLOW_START,
> -	IRQ_FLOW_PILEUP,
>  	IRQ_FLOW_REPLAY,
>  	IRQ_FLOW_FORWARD,
>  };
> @@ -581,7 +580,10 @@ irqreturn_t forward_irq_event(struct irq_desc *desc)
>   *   issue a forwarding request of the incoming event to the in-band
>   *   stage once done. In this case, the same IRQ action handler is
>   *   called twice, first from the oob stage then from the in-band
> - *   stage.
> + *   stage. The IRQ handling code should account for the fact that
> + *   multiple incoming events may be received on the oob stage from a
> + *   given source before the forwarding handler is eventually called
> + *   in-band only once by the pipeline core to cover all of them.
>   *
>   * When IRQ forwarding is requested by an oob action handler
>   * (IRQS_FORWARDED is set in the per-descriptor state), acknowledge
> @@ -593,44 +595,60 @@ irqreturn_t forward_irq_event(struct irq_desc *desc)
>   * stage as well. The internal per-descriptor IRQS_DEFERRED flag
>   * disambiguates between the latter context and events being replayed
>   * after deferral to the in-band stage, so that we do ack the hardware
> - * for cascaded events as expected.
> + * for cascaded events as expected. We might also receive an event
> + * while a previous one is still pending replay or forwarding.
>   *
> - * We might also receive a subsequent unmasked edge event on the same
> - * line while a deferred one is still pending replay from the in-band
> - * stage (hard irqs are on for replay). The flow state enumeration
> - * disambiguates all cases as follows:
> + * The flow state enumeration below disambiguates all cases:
>   *
>   * - IRQ_FLOW_START: we are running oob on behalf of the low-level irq
> - *   entry code, no deferred event is pending replay for the same
> - *   line, we need to send ack to the hardware.
> - *
> - * - IRQ_FLOW_PILEUP: we are running in-band for synchronizing the irq
> - *   log, one or more deferred events are already pending replay for
> - *   the same line, we need to ack the subsequent event to the
> - *   hardware too.
> + *   entry code, we need to send ack to the hardware. This includes
> + *   the case when we receive a new event on any stage while an event
> + *   of the same type is already pending replay or forwarding.
>   *
>   * - IRQ_FLOW_REPLAY: we are (re)playing a deferred event from the
>   *   in-band stage, as a result of synchronizing the irq log. A
>   *   deferred event was NOT handled from the oob stage by definition.
>   *
> - * - IRQ_FLOW_FORWARD: we are running in-band for passing a forwarded
> - *   event already handled from the oob stage to the action
> - *   handler. This mode allows for two-step subsequent handling of an
> - *   IRQ event over both stages by the same action
> + * - IRQ_FLOW_FORWARD: an event already handled from the oob stage by
> + *   an action handler is forwarded to the same handler for execution
> + *   on the in-band stage.  This mode allows for two-step handling of
> + *   an IRQ event over both stages by the same action
>   *   handler. IRQ_FLOW_FORWARD is mutually exclusive with
>   *   IRQ_FLOW_REPLAY since only the oob handler may request
>   *   forwarding.
>   */
>  static inline unsigned int get_flow_step(struct irq_desc *desc)
>  {
> -	if (!irqs_pipelined())
> +	if (likely(!irqs_pipelined() || in_pipeline()))
>  		return IRQ_FLOW_START;
>  
> -	if (!(desc->istate & IRQS_DEFERRED))
> -		return desc->istate & IRQS_FORWARDED ?
> -			IRQ_FLOW_FORWARD : IRQ_FLOW_START;
> +	/*
> +	 * We must be running in-band, synchronizing the interrupt log
> +	 * on the current CPU. Determine whether we are handling a
> +	 * deferred or forwarded interrupt.
> +	 */
> +	WARN_ON(irq_pipeline_debug() && running_oob());
> +
> +	if (desc->istate & IRQS_FORWARDED)
> +		return IRQ_FLOW_FORWARD;
> +
> +	if (desc->istate & IRQS_DEFERRED)
> +		return IRQ_FLOW_REPLAY;
>  
> -	return in_pipeline() ? IRQ_FLOW_PILEUP : IRQ_FLOW_REPLAY;
> +	/*
> +	 * Rare case: disambiguate between forwarded IRQs and replayed
> +	 * ones for multiple non-oob events from the same source which
> +	 * don't need masking on receipt (e.g. edge IRQs), causing the
> +	 * replay condition bit to be cleared by
> +	 * should_feed_pipeline() on the first occurrence, leaving no
> +	 * information to handle the second one appropriately.  We can
> +	 * still figure out that a replay condition is pending
> +	 * nevertheless (instead of a forwarding) by checking the oob
> +	 * capability for the interrupt: oob handled IRQs visible to
> +	 * the in-band stage are never deferred (IRQS_DEFERRED), they
> +	 * can only be forwarded (IRQS_FORWARDED).
> +	 */
> +	return irq_settings_is_oob(desc) ? IRQ_FLOW_FORWARD : IRQ_FLOW_REPLAY;
>  }
>  
>  /*
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
