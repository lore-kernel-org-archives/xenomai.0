Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2080.outbound.protection.outlook.com [40.107.241.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06775172BD0
	for <xenomai@lists.linux.dev>; Fri, 30 Aug 2024 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725025471; cv=fail; b=Lh6BkdSRji3aArDGbMbtfZLdp19/f7js1FPkCvM7yeYx4uPp8C5O/ehAhsnEe+4KSxx6veKrvPYzI2xaC4qVYznTxvK1OUGs4AR6SNhMKU0XousZNA53LsTSj4JeFbHKqtQY9Pcno04FAD3NeApYTbxYLvwCWoX5bWNxRHcd6wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725025471; c=relaxed/simple;
	bh=vS/O80VK+JPhsBezvVDkt72VYkSfy6ouDNU/pwIofSo=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qkgOTtZiMkEy+1UvwD9McDPwv+zVX7VrUP8Bq6tCQHGllrAF72NxcWwqMlKQ9l3Q5jSRsOdOvBWR2iA04+A9RxQ8DNNo/jxztXQZhqmke/9AEzyP1J1iYb3O/LMLWAm389xE2h79Xr95XDxYuSuuMPIoOE1UFQo7Gq5IRwqsTIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=MbF3UEPB; arc=fail smtp.client-ip=40.107.241.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="MbF3UEPB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKM+5wL8S98E5UhbRND96TaAQ/y+rBubDXYePSSzZgFVSThdYdTcM6m9c7g+1/ylDiDauuwmIQjS3pJHQhKWSkMjAmw5ygi5841if4o2WT8WgoHv2Cu9ZIqSuVuWtnunYqYT5cV8CT58HIXPRgTElBXCbxppXZCdeDIsNA54mI/ATI43iHKpHP755DxMiYiYIwOCP9cHDUzzTp828TPdPdvke42YbdFhEkeP1capnblckIe4aFPYBcHExcObm0xVv/8+j7oEJUsSvMUmvtEMRK3z1ljKf+9UA5NyuWiSHQIOU9Fl8gFv/qcifvMMyGYHiu1/GKpvyI/dVehEP5qvXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITMWxkuNjPDMJtgO3w5i9/vqOiS6cpwh+X4zkinXWNk=;
 b=DvNybU/dcqX+4S0dw94j8HCm+9R6YMBe5BRY0FiStEI8dGeG8VGl8q3+K13R6hE+C19epFwjkc1m9YvUfRN9DosRlx8dvniTc5vqjMjQXzrwHUv5XjipMO06gv0pTyfMorcIuVvGfFgh6C6pygT3Td5eU1mJ/jILP+nHA0UsSJz5SvjNdMRsYNCGLjq0AVYNhn6pCX3LWStTI4YNTHt5w0PBTsNJrY+SglkvIA8BENb6JgOW2uAkBB0GvN/AnlZLPLes8CIv3ozOomSBYJ3mb9psE8H9ZpTYuFR918H8W4wyi4/PZuFMUczrpjRvjWylG50wwY0Xl/Df3NTOOfGzng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITMWxkuNjPDMJtgO3w5i9/vqOiS6cpwh+X4zkinXWNk=;
 b=MbF3UEPBhLwCUcB2GrjI4d6VzMpZQk5eghplrPD1un7GWdcTSevsctfsseY2judnel4/QmNWArO0otlIZdeEU2mGcG/sf72UUH+uKHb2Q1qP4wGqMTgnJWaqj2ikykwLhH+R8QjwsiK829bpQ+Nn3hucer1kfUgoMlNywVOVtlMx4frhRGVXoV+ZgLvJQM0P44xWCelf8RqURoFBBQ3EyX7+ESC7+uTdc1bOA6mQgmBtJXSNkcyGu0H/OGfrAKS7y7YcZ8TeTzrHpEMNN9B7qFRdoTypGEEgRA5uzqVCggE7ZPfZCBbgOIZRAewQy/vntwp7JBJEplHiBpb4Bx3bvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8317.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1cf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Fri, 30 Aug
 2024 13:44:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 13:44:25 +0000
Message-ID: <aae26c91-4765-48d1-a02f-3f0e5b4521b6@siemens.com>
Date: Fri, 30 Aug 2024 15:44:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v2] ci: Enable sstate caching
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20240723140801.1247672-1-tobias.schaffner@siemens.com>
 <6239feef-9326-4ba9-a744-db774134b128@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <6239feef-9326-4ba9-a744-db774134b128@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8317:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b7bdbf-1e1a-41f9-e449-08dcc8f9dc72
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmpjMnJ2V0dYeGZIdXZjcWoxbWdIaTlvTUlIZkh3d0FIcmpWSTZja0ZwMEZQ?=
 =?utf-8?B?ZkRSSjBSZlloQjJkOGI3SEpzN3VGSXpQbUdyTWhKbFVUOUtwTUIydDhsRXMy?=
 =?utf-8?B?ZkNVMERMbm9RS0ZHcnNwZnEwUEczZjZqbmxmenpXL21jcmtpaUhCaVlmdzhY?=
 =?utf-8?B?ejdvMS9HZXBmYnA5MFlFREpjUlBnVkpjRWhSTDd1OTFKNTdYdXFxZ0F0UHN2?=
 =?utf-8?B?ZnQ0aVJnMXRIcjdBOW5PWjdCN1haWXA4NHd4Z3ZXMTlubkVBRENJd3RmU3Q0?=
 =?utf-8?B?L2Q3U1dPT21NMHU2UmNadVdPM1BmcTVoRHJ4Y1c5UE83elQ4OWx4cVVaVjBC?=
 =?utf-8?B?QmJYQi9oVjNpRE4zSjA5RU96cmRhRUtGV01aekc3aEpZK3dmdmZNRFBBSWhP?=
 =?utf-8?B?RXJxK3BDaGVSSmRLZGgxN0VwcEFsbWVqeEpKVytlWkVYYVQwTFA4bnlTZlVw?=
 =?utf-8?B?aHhuVmJldTZQMFhyYjgzODZpbnlCR2drTUsxZUdKNzN1dHpBRGwzMVhuWFJF?=
 =?utf-8?B?cnBjMzNnK2JoNUdaWG93bVpmaE9lWVErSjlDekIycVJxU3VUMkFycitRaWxT?=
 =?utf-8?B?NWZ1cFN6WnhPa2Y0Q1VXK3ludUREV3M5S3U1Q21KTDlyMER2UXpiL0E2eXJ6?=
 =?utf-8?B?T0J4OERZS3l6RDRnNnFqRWNUcy91UlA5dFdFYXN4SU10UlAycGtEWkpDNnZN?=
 =?utf-8?B?QXFXSmtpNlVYVEh5YUU4UytEVUVuS051STZzWVZ5U3JFZFduZGh1NFVrWTVI?=
 =?utf-8?B?bnI1TDBLYVJVNFpJUGhuUGNOYUdhc25HQUdiWllJNGdLb2VuSFJGU1VuVDhj?=
 =?utf-8?B?eVB2eXZuWWZycnlpeCtiODcxTDdxNXdFMmh3dTBCbWlQOHAwVlNKQVpLbWpy?=
 =?utf-8?B?VzRMOXNKdk1zZFVKOUh3M3NFaFI5Wk9MclRUbDV3TWwwU3dld3JvdUxjTFdm?=
 =?utf-8?B?cy9FU2RMRkVzNkJ1R0NLWWFWb0JXUXdUb2srblliRExnNEdXOUNRUGNRRlF0?=
 =?utf-8?B?YStHdlBxK3BvcFpDL3c4TVFpalVoSlpSbytCbU1nbjhxRUdNQlAybXA0WlN2?=
 =?utf-8?B?UERLOEhUZEJDZ1VrL3VrV2Fqc0VJcFh2bjV6Z3V3akEyRlpURGlFUUQ1TWtI?=
 =?utf-8?B?SkV1cjdLM1ZMbUNrTUc2RWlxcVZUT3krWjRaTWR2ekZrMnN5am82ZUdsMUcv?=
 =?utf-8?B?eXZ1TVVWVFpmVVBqRW9rRTBmcGtzU21xblVFcnA4T0tPdGY1YjM2OFp1Vjht?=
 =?utf-8?B?ODhkY29vWFpwY1F2bmVZRWpqUTNJRzJrWUowV1hDakwvTjdiUkxVTXBWNFpj?=
 =?utf-8?B?cU1yaXdVNWw0bHpmNjZiWGVaNnVQaUhUTEJMQTJMYTZ0M2Y2UGF3Y3VFM0hZ?=
 =?utf-8?B?YVJtUkF5UDdZSFQzVnFGZjBJWmZvb1p1d21Nc0grcnMyUGJTWnhVZy8yQ3Er?=
 =?utf-8?B?MTl2UmZLMFlzdTNRUFoyWnYyQ3lPUG5TMys4aHFJMGVvVXVTSnlocHJYZTRs?=
 =?utf-8?B?eGliUVJwWWgvcklTcFZTUmxyR1l4RlhwZ2JsSzlaWFBSdTQxdkhMbmVtekd5?=
 =?utf-8?B?WmVyS2FyTExaWUdiL1haeGJ4b2txelBEQTVacmpyTmpDMXNHOUVJRW44RTh0?=
 =?utf-8?B?bTR1NGxhampacGVheEUzQnVSMi9abjhlSzNkQXVRSWRCYTRDS2lMbWd1YU5F?=
 =?utf-8?B?WlNRU1BoR0d5TTZiK2UzZVc1eU5rTDdFVVAwdk9UWVJvRlN5MUhQYlIzbUpB?=
 =?utf-8?Q?P4xUm/KuGjAefRO1ko=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzBnVjVKVTFJbllCYXVIOTZTNUgxeVBDcUsvbGtzRWYzTTQwamJQNXo5Sndi?=
 =?utf-8?B?NTErTFdncGpnL2FYQnIzVzYzSjZmOVROUlpjdlZKdlRPN2FxL09aMGpQRVFz?=
 =?utf-8?B?NTdLZXZLWW1LWlZ5OU8wUzVmTWpFcjVlQlZ3Z01DdGVnUHg3WDlzZXRzR2Vx?=
 =?utf-8?B?L1ExYTBwSFpUcjNhR1NGZ050eHd6N3V1cTZUQ3lvT1huTGNlS1NhNXN5VXhN?=
 =?utf-8?B?bFE4TjlCWlhnYXVMM25xMy9TUldVNmhXL1NkRHRRMS9ZWlkxWTdFN0h5bGdi?=
 =?utf-8?B?N2hISEcrS1VWZnRIcU16a2hIUHNycGZWclN6ZUhuMWJtUHJnSitkT1BHZnN5?=
 =?utf-8?B?cndiWHBKUzVoa0dUU0FCcFVrNVdtMUtNRWZBMkd3WWpaWHFaRWhZT3orM05W?=
 =?utf-8?B?bG9TUUtiNmh2UnFLK1VyRmZIcHE1amJxekphR2VSdi9WUHNuN0VrUk05VE54?=
 =?utf-8?B?RmRreklFUGxuZDJ1Mlc4dk9TQ3BZMjJ5Ri9pSGlFamxuRjZWc1lmdFp5SDFX?=
 =?utf-8?B?b0IvNXZkS0h0bTVQbFhKa093SnhkWXVtZ21KZVVacXRKVUlBbE5VaEhxR0ls?=
 =?utf-8?B?MDJPMTR6d1FZSlZaUmVrcGRhRHZndVpHM1VuL2JLTTZycUhJZnpWK1VWelJq?=
 =?utf-8?B?NW1jRmFtY3N5L1NWVHI2ak1ROGF4dEFQQlFXS1ZmN0hCRkJVVDVPLzdqM3o2?=
 =?utf-8?B?bDQ5WjBNMDluNFVMeC9uVWVDcWxUTzRuWkFPN0NSSkNmVC81RXYrVlhjZE01?=
 =?utf-8?B?YTBGUlcyajQvbGZ0UGo0U3drN0lRaXd2WmtMLzc2MjMwdy82ZGlCMXZZZnds?=
 =?utf-8?B?UDcyY01MNjRSaVFycE9UL0o4emRJR0Y2bmR1akZCMjVWdzhnRE42MkE0WnFY?=
 =?utf-8?B?ZEM0UWFyVHFkQWlFbzFKVXorWE05OFIxMkNEcGJvRW1BRmdlS2NTZUJCODlN?=
 =?utf-8?B?d3BKRTQyRk92VVRmVkdiRC95b1pqMzgzMzA4SGF6a3g2MjI4VkhyUVlDY1Bu?=
 =?utf-8?B?RUduUlVzeU5VTzc3Z3hxUEY2Ylo1cnc5aytOS1RlWE9SU25keFpaV011dWVm?=
 =?utf-8?B?QjRDZm5iQjVFbGNwZVhKVlZwNGZVS1pzbFFMeDBhNGVSdUJ5ak01Y1JiWExl?=
 =?utf-8?B?OVBha0hPMDNwSmI3QTltNng5Kzk5N0VWMXBVaDJ2bjdIU2lmVkVKQ01xRWJt?=
 =?utf-8?B?VUx2cUMvclZLQ1VhT1BmWG9NMDQ3TmVCWWNxZFI1bXJreENXYTJYNnRmZHhB?=
 =?utf-8?B?OVBKMlh2VHhaZUV1dEZTZFhaUk9tRUY1N0JudXpjanF5cWpoQlpqWFVPZVlP?=
 =?utf-8?B?RlhnS0w1eXYzaXl0bmp2RllvbVNZTERKRUpvbE13c0JZejcrVDFlUWQ5SHBF?=
 =?utf-8?B?aVhEakprdlY1bUc3aCtvMk5JUUJjdTBYTUxhcFlVSUtJZ3Z1Q0Z1aS9jNmdQ?=
 =?utf-8?B?eVRnczhLeGl5YXZ3OElUVUJqd2tMZUJ2eEdiM0VaZzdNSWljYXJMc1YxS2ND?=
 =?utf-8?B?MFE3UUp2UmRJaGFXUk1vT1BEazU1MXdGUm45UG16U1hsUEJhL3hXYmNsVUo2?=
 =?utf-8?B?QklGbE9JWEs5b2hJcHZ0emlUVG1BM0EyYzF5c1VwTVZNZHRldGZqa0E0SkZ6?=
 =?utf-8?B?a3B1QTJZVm93V0lGY0NjRC9XNFhicWZKc1owRHZnQUF0azlNdkYyL1B3cWYy?=
 =?utf-8?B?aWE3ZmhaSWhPUTVhanN0TE1jRjJta290TjYwSTMxVTFHeUFiRTN1TmM1Zlo0?=
 =?utf-8?B?bVRQVzQvYVoxZS9iWHBsNERjZU83dHJoYnR3N0NDWGt6RUdSd29vbGoydE95?=
 =?utf-8?B?RTMvRndra1FJMXNhdnoxc3Jjb2FML3JZbUs3RFJCV0laYVp2VWN5dW05L0la?=
 =?utf-8?B?WFBjUUZ2MGZHYTFlLy9MNk9DTTA3TEpNMTFkZVZleEx1cmVqaEozR3VtSUlp?=
 =?utf-8?B?MTRrQ1owQUNJWDQ0dWZCNEoybVZWRGtGVUhrbVR6MlN1OUlRV0VTTGlxUlha?=
 =?utf-8?B?M0d0M2EzK2tMdzdzdUlLNFpBakdYZ3RoTVRzc2UyM2ErRmJWUVZVWU0zREVV?=
 =?utf-8?B?U0FVOThKNldkVTUrOHlNb2djK1gyZGY5bGVSTmhyZE0rSlNEWWgyaWRXWmI1?=
 =?utf-8?B?MnZENGZmaFQ2QlJHMEtkK2lGTFRKL3VvamZYeFBaaUgzRkJ6Y2lRdnRkczZJ?=
 =?utf-8?B?REE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b7bdbf-1e1a-41f9-e449-08dcc8f9dc72
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 13:44:25.1710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvLeBcLzoYea04MOWTRacVofWFRqG6x9WBSKG3Bu37c8WOLoqc7Jz104docO0nLYR9OuT/+qsFg4tYieyPa6oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8317

On 07.08.24 23:52, Jan Kiszka wrote:
> On 23.07.24 16:08, Tobias Schaffner wrote:
>> Enable isar sstate caching to an aws s3 bucket by using the
>> SSTATE_MIRRORS environment variable.
>>
>> The isar-sstate script is used to upload, analyze and clean the remote
>> sstate cache on every build.
>>
>> Cached artifacts will be cleaned every 14 days. This can be overwritten
>> by setting SSTATE_MAX_AGE.
>>
>> Credentials have to be injected using the AWS_ACCESS_KEY_ID and
>> AWS_SECRET_ACCESS_KEY environment variables. This is already done for
>> download caching.
>>
>> Currently the size of the cache is ~20G in size but I expect this to
>> rise to a multiple as soon as this is used in productive environment.
>> Keep an eye on the output of isar-sstate info.
>>
>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> ---
>>  ci/gitlab-ci-base.yml | 47 ++++++++++++++++++++++++++++++++++++-------
>>  opt-ci.yml            |  4 ++++
>>  2 files changed, 44 insertions(+), 7 deletions(-)
>>
>> diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
>> index 1dc05a8..f5009e3 100644
>> --- a/ci/gitlab-ci-base.yml
>> +++ b/ci/gitlab-ci-base.yml
>> @@ -24,12 +24,39 @@ variables:
>>    TEST_RUNTIME_SECONDS: 300
>>    TEST_MAXIMUM_LATENCY: 0
>>    TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS}"
>> +  SSTATE_LOCATION: "s3://xenomai-images-artifacts/sstate"
>> +  SSTATE_MIRRORS: "file://.* ${SSTATE_LOCATION}/PATH;downloadfilename=PATH"
>> +  SSTATE_MAX_AGE: 14d
>>  
>>  default:
>>    image: ghcr.io/siemens/kas/kas-isar:4.4
>>  
>> +.sstate-prepare:
>> +  script:
>> +    - kas checkout kas.yml
>> +    - echo "=== Prepare for sstate at ${SSTATE_LOCATION} ==="
>> +    - ./isar/scripts/isar-sstate clean "${SSTATE_LOCATION}" --max-age "${SSTATE_MAX_AGE}"
>> +    - ./isar/scripts/isar-sstate info -v "${SSTATE_LOCATION}"
>> +
>> +.sstate-analyze:
>> +  script:
>> +    - echo "=== Analyze sstate differences with remote ${SSTATE_LOCATION} ==="
>> +    - ./isar/scripts/isar-sstate analyze "build/sstate-cache" "${SSTATE_LOCATION}"
>> +    - echo "=== Check for cacheability issues in build/sstate-cache ==="
>> +    - ./isar/scripts/isar-sstate lint "build/sstate-cache"
>> +          --sources-dir "${CI_PROJECT_DIR}"
>> +          --build-dir   "${CI_PROJECT_DIR}/build"
>> +          --pedantic
>> +          --exit-code 0
>> +
>> +.sstate-upload:
>> +  script:
>> +    - echo "=== Upload sstate artifacts to ${SSTATE_LOCATION} ==="
>> +    - ./isar/scripts/isar-sstate upload "build/sstate-cache" "${SSTATE_LOCATION}"
>> +    - ./isar/scripts/isar-sstate info -v "${SSTATE_LOCATION}"
>> +
>>  .common-config:
>> -  before_script:
>> +  script:
>>      - if [ -n "$ALT_DNS_SERVER" ]; then
>>            sudo sh -c "echo 'nameserver $ALT_DNS_SERVER' > /etc/resolv.conf";
>>        fi
>> @@ -40,17 +67,22 @@ default:
>>        fi
>>  
>>  .build:
>> -  extends: .common-config
>>    stage: build
>> +  before_script:
>> +    - !reference [.common-config, script]
>> +    - !reference [.sstate-prepare, script]
>>    script:
>>      - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-ci.yml"
>>      - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-ci.yml
>> -    - du -sh build/downloads/deb build/downloads/git build/downloads
>> +    - du -ah -d1 build/downloads
>>      - if [ -n "${USE_S3_BUCKET}" ]; then scripts/deploy_to_aws.sh ${TARGET}; fi
>> +  after_script:
>> +    - !reference [.sstate-analyze, script]
>> +    - !reference [.sstate-upload, script]
>>    cache:
>> -    key: downloads-${CACHE_ARCH}-${CACHE_KERNEL}
>> -    paths:
>> -      - build/downloads
>> +    - key: downloads-${CACHE_ARCH}-${CACHE_KERNEL}
>> +      paths:
>> +        - build/downloads
> 
> Strictly spoken, this chance is not needed because we only have a single
> cache entry. Anyway.
> 
>>  
>>  .build-qemu:
>>    extends: .build
>> @@ -59,8 +91,9 @@ default:
>>      - if: '$ALL_QEMU_JOBS == "true"'
>>  
>>  .test:
>> -  extends: .common-config
>>    stage: test
>> +  before_script:
>> +    - !reference [.common-config, script]
>>    script:
>>      - scripts/install-lavacli.sh
>>      - scripts/run-lava-tests.sh ${TARGET}
>> diff --git a/opt-ci.yml b/opt-ci.yml
>> index 01d5c07..e1466a0 100644
>> --- a/opt-ci.yml
>> +++ b/opt-ci.yml
>> @@ -23,3 +23,7 @@ local_conf_header:
>>      IMAGE_INSTALL:remove = "sshd-regen-keys"
>>      IMAGE_INSTALL:remove = "expand-on-first-boot"
>>      IMAGE_FSTYPES = "${@ 'ext4.gz' if d.getVar('MACHINE', True).startswith('qemu') else 'tar.gz' }"
>> +
>> +env:
>> +  AWS_ACCESS_KEY_ID: ${AWS_ACCESS_KEY_ID}
>> +  AWS_SECRET_ACCESS_KEY: ${AWS_SECRET_ACCESS_KEY}
> 
> Thanks, applied. Let's see how it will behave.
> 
> Jan
> 

Only saw now:

2024-08-30 13:22:20 - INFO     - WARNING: xenomai-stable-3.0.x-r0 do_dpkg_build: Export of 'AWS_ACCESS_KEY_ID=[MASKED]' detected, please migrate to templates
2024-08-30 13:22:20 - INFO     - WARNING: xenomai-stable-3.0.x-r0 do_dpkg_build: Export of 'AWS_SECRET_ACCESS_KEY=[MASKED]' detected, please migrate to templates

(e.g. https://source.denx.de/Xenomai/xenomai-images/-/jobs/894592)

Is that an isar issue (but we are not that old), or are we rather doing 
something wrong here with the export?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

