Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8730C1D014A
	for <xenomai@lists.linux.dev>; Mon, 14 Oct 2024 22:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728945295; cv=fail; b=NQTmTQPxt/XrRK7Tp2Gsj1/TnluF7Xz4h3QwzplhCqEb+TMZXH3ghos4SnSHmbh4DYx9+ZD48VwWmugg5QfVPdkgcJa/YgoUT48qurQrFk3IaAwy8rmPAZrPkP+nHLm8LWEf71kjmNamXiZfcOvg4QmnKB7xvUZytM7UqUgEDdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728945295; c=relaxed/simple;
	bh=eI8nFOG1+J0JpLUFBbdGMZP5qUB+m7hvxukhzGVotpc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q/2wDA8/kYIBzIlbUFEn8vMVRpiiBFoyTWXFFUFc87DgjdkdBD40zwJ6dChTzXcPaZc+XJSICXS0/saVoOkEij3Cr9ElGv1s0pweAjCWw+l3qR6VTGa4fQdATdfst1/hWYmElZEqmm2tdz63PkbrFb6LoKlkQ+/zLl841cZYSKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QDv0bTzV; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QDv0bTzV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUp/ta+vkpIOaspoFVDL3zi2DuPRAQmPqAxqrITGCnrcOj+cp9TxQjiU73wpqjsz60BQEPrul+xkZo64hmLK4YkMFh0FtBqOE+ch6GOhK4M4ihrx83IcLvCtq9oEmED85U3IouRYUX53XZejj+GqCrYALHMjXn4LH4bJhI5IRjFIlaTk2u5a3IQcrUeU+YnRQItp2CExWkxw0c39lhnGxQbvyrjCLd9Gh30RcdO453K3XcQURi5QdnEIfEEUWPIYQNlcM7zVaDNn69imevqvy6jLnfwRjVYRXH9mb455DMnRN1o10eP63YSpvb+A4od2hpvfN1DORZ8aRejqH6lGZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5XgRvB2kCj+c3FJ12GU38B9hvc90oddv9giV8t7G4s=;
 b=YM7xChuqjih3Vw8B9BbOSmyf5UvyjZPwlS/bAj2mBqeYP80sUgT9LwyfH+2IaDYleeQ3CrY631JGuvXHMTKc7RCSRse2Y1L3K+5jLO6DofVcn69VgchjmZm5BQ1zJsiyQBvFEj2iMmCWit7wikZBOGV15kFivmIgnKjSvl298ydxjvpzo5T9kGNbdMphjqHTYPIdcpn7Mtq+2T/BK1+tcv4jMRQpBWnj71K3vC7/9ooNd3D9uWA9DzNjzVgb295xl45Pfq9HA7ABe27VY4rwYcfQzsZPkS7d3SfBv8RJbcqwW/UgQkM27FAO7LrIH/vpdY5ItpBRAGOgHyYtD82scQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5XgRvB2kCj+c3FJ12GU38B9hvc90oddv9giV8t7G4s=;
 b=QDv0bTzVnj7RKrH63i7n0fH2WTlLuCe1jbrVo21kLOZ4AlneXQiohPz53KwW0/Pf4oKQG5+deHLG18NL85Xoh0dLu3Y9eZas9ml2MG8KKltrgchsLRU2buSjP0+F0cohvF9IkZbe4hEC9Ofel0VHPeQibvpJBNMnXCCq+yv2WrgZ1mBuHH9fwo1pHixKIF6dolukYV+0anaMYC4fNzWuBkM0Bg5NiWrRgorgt5QBnFSayoZycfjJ1bHOX2RInAP/Hk9GGRtx2+ES5v+SLHYvFmAzKZTVyb5cx62RNJVgai77ms+4iYh2b+7Eth/j2UzXwf4BWPmY/r41P2PB4PsrSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5531.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:476::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Mon, 14 Oct
 2024 22:34:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8069.009; Mon, 14 Oct 2024
 22:34:50 +0000
Message-ID: <ec76daa4-d09c-4cac-a488-e59064d8c399@siemens.com>
Date: Tue, 15 Oct 2024 00:34:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] cobalt: sycall API: Remove architecture specific
 implementations
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Clara Kowalsky <clara.kowalsky@siemens.com>
References: <20241012-flo-cleanup-before-release-v1-0-df05bfa0ac80@siemens.com>
 <20241012-flo-cleanup-before-release-v1-5-df05bfa0ac80@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241012-flo-cleanup-before-release-v1-5-df05bfa0ac80@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5531:EE_
X-MS-Office365-Filtering-Correlation-Id: 70417006-767c-4182-510c-08dceca06a53
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2F3aGJRdDcxWXVXVlFYbnpYWVZ5TFI4Tnp3UDBQSnFRUHBVVUlWaE5xcm1W?=
 =?utf-8?B?anhWeTl0eXFkL1RZajdTSm9lczdacCtDdVFKOFZTOW50OW9jbXBVcFY3VEky?=
 =?utf-8?B?WFV6SFVYcUR0L0VGTnBBRkp6dXhlVTd3ZGtSa2tZdDl1S3FnL05pZDNPdllL?=
 =?utf-8?B?TnBvMzdYQW9oekNJdHN5Y09nSzBHNlIreFBaTjRzOUgxQUZPbWMzc3BPRXI2?=
 =?utf-8?B?Q2ZYOTlaNURxcTM0TFNhdWlFUWdzTXhkd1BFSTlOOGlSZU82blEvbVQ0WG16?=
 =?utf-8?B?QnF0bVMzZDdvcGtwclExQXdtRXloNzFmNUZNZTdCa0xHSzFpb0JseDBUSit5?=
 =?utf-8?B?Q0M0aFpxQ3VlMVB3bStKNUpRV013OU9DVU5mQXZ3S0FSU3Y4WVJwWUtGV1ll?=
 =?utf-8?B?NGJYRTF0bmgrR2ZJdm5nb2tWSy83N2VoSUNPVEJOeWdTYkN6UitLZlRncUhy?=
 =?utf-8?B?ZEdtWERIbmg1MkhkR1Jja1kyUU9XVlhJd1hBNDU4NDhNSVFrK01MY1p0NVRJ?=
 =?utf-8?B?VWhFbVp5VjV3OVhhNGNUWENtV25zZS9KQmNQOWkxeHUwU1BJblArNHY5aFl1?=
 =?utf-8?B?WGw2Rjc3TXZnd3NkSlR2K0MrSGYycWRya1FaeHZCaFFQeWd1cUJ5cVo4cCtJ?=
 =?utf-8?B?RzRmVkE0T2NRY05VclEvNTZsZFJoWTg5eW9ZbS9lQWpJYWtpWUxHaklVUVV5?=
 =?utf-8?B?bGdwd3Npb1pYd1o1UXVQUGNRNlhpU2NEd01Fekw5M1U1elF1dUxoeG1rbzZY?=
 =?utf-8?B?TVF3NGNDRVhoZmovN1c3clNGekdlWUhhTWMyaG0xWlh1MDhXeU95S1F6QTBX?=
 =?utf-8?B?clU0dElaSng3TmdHRVJudW5CbXczRW04YXAwd1JzWlFZaVY4MWtFVkpiMUlo?=
 =?utf-8?B?NXZ6TU9tVVR4QXo4RjgzbGNzQmk0cTBlamgyYUJUMVl5bWhVNnJHSHRRUHcy?=
 =?utf-8?B?aEdGZGZURWxPWXZoK20xcHlaYy9nSnlRYkRnUEw2cWg0ODlZZ1lRMFMrOVBq?=
 =?utf-8?B?Q1gxN3QwMjFENVdVaTdJcnBLWVREMkJSV3dDOUpyYnMrMlR6WE9MUTJ6TDNT?=
 =?utf-8?B?RVZPMkxETklOTFZOdERSN0J5cmJtUjgzandaT0ZmNVh1cUFVUVBYc1ZuNDE4?=
 =?utf-8?B?Y2pMS0x0UHNxaFNIWURxb0d6VUxNQ1VKOUZldUxlSjExVjlod05qUGVwTk9V?=
 =?utf-8?B?ZmZFT3RQNkZ1anc1dXd4c0JsdmM0bFYzK2ZCZFhGdEpNeDd4ekYya3hOYklV?=
 =?utf-8?B?NW9JN2RoUkNTTGk0OE1EVmZuV0dyVkZhVHloajhVWWttc2oyMWhOVjVLMHdC?=
 =?utf-8?B?WlVpM2taYkJ3dWtlSVZXM1VDNmdWK2ViZTFkakExMVpMbEhIc3R2ZHRlUHZU?=
 =?utf-8?B?eVozSTd4ZkQ5T0JCT3ZNL3FZUG5UWjV1Q3BLZmRmbGhWSHAwSXJNSE8vbjAx?=
 =?utf-8?B?cDlyRmJLZmxibUJLZmN5c3RNQ0NnR3J1eHJpeEpTY05DK3dmSW40ZDZxU0dG?=
 =?utf-8?B?YWRmMG1rYXgrcnJGTnh0eTNDNi84Ty81d3lsOEZrbU1kb3FieGMyZGZwRWEr?=
 =?utf-8?B?WURkZnhyR0g5VUt3TG1VZll2K0ludXdwdTRMOUpJNCt6VjlOTkRlN0FHYjg0?=
 =?utf-8?B?Q0IzWHh1Q1pCUlVsbkFESHk5YW5Ha3BueU9nNGVOeDcwWkI5cXlBZ2ZqTjlq?=
 =?utf-8?B?bWNWOFFzQlFJdDU0cjR1TVA2OEg5VCtyZExJMDFYWHpWN09RWVdNUzN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTNEOW84V3Y3cFNiTzVYQUZicyt1ZlJTNFlIT0xXK2VoQWplcEUxWXhVdDg1?=
 =?utf-8?B?T1NZNk00RU14S2xWSHpKcHZyTzBVZE4wOTlZdHNEempuV3k4eTV5aVYrN3Qw?=
 =?utf-8?B?dEIxa04wWktWNGV0ajlQeVA2VU14WXVTaERmY0xBVk9rOVB1eVE2MnNKNjdl?=
 =?utf-8?B?dDVoSGxmOGdJQVBzVCtFVS8yeUlQSUxjYUpud0N3T2VvNlUzMFNwTWZ3MUJD?=
 =?utf-8?B?dk9Ob3pRNU0xNFYveWdSaTQwZjdETUp2UmcrU0k1R2lORDBnN3ZTY2htNlJN?=
 =?utf-8?B?WEg2TVl4OGdtVEZSNjhONkpBWmhSQjNZU1M4WGhmVWxUdmltOFJ0MUdPeURu?=
 =?utf-8?B?QzNKRVBjSEkrYkV1M1ZueUQ1SjVuQlpvRm5qYWp5amVndFhLY25tWjBXdk1r?=
 =?utf-8?B?bmgyR2FMY013UGtRZmY2RHZTRnYwVG83SVVCOWZ2d0pKRlN1NHEwL3IwY1Nt?=
 =?utf-8?B?TzZBeTR4ZTVhQTRKWUJiYW13R3FVVDhCRmV4RFNmc2F5MktwUS9KdjZXZm5M?=
 =?utf-8?B?MFVTSmZ2eVplS0JMSVgxUklxeVN3VG52cGg1YklGTkQ2ck1XNmszN1ZyaXNR?=
 =?utf-8?B?UHRQQ2hxZmJESFdpZEdHeHJ6dWErRzY5OUZjSnlaT3VLd0lDRXprc0RFMVow?=
 =?utf-8?B?M2p3cTEvb29heFVPOHY2U3ZZeUZiOGVSb053T2FmajE2TTJUZUttaExBeFIx?=
 =?utf-8?B?VDVhRUV4Mm52REdrUHlmUG85blJCNS9YYnRaTDNyN2ljbEJFNWZzYld4ejBI?=
 =?utf-8?B?UGZsUEJDeUE1TjYrRXgzTzJ4UHJVNlRqRWkvdVd3MWNFNGx1bVliQ1RiVFE3?=
 =?utf-8?B?RUxMenc5U2srZHAzQ29vYnpqUHk4WE5CWXoyZlo1TFR4a3JSeEJDbWRSNGg1?=
 =?utf-8?B?Zlp2S3VDVnlrSTdXQytXOUxkSWluVTFvM0M2d2ZFbFR2N0JWbVlVNkUrM2lN?=
 =?utf-8?B?RnF1Y0FFZWVaS2pzdWtQMnFsakdYTFlodUhXZ0xQSHNneXVVZGNiVGk4ZE9G?=
 =?utf-8?B?dGsyUXl2NDVmUHNlektndGdRZ2l0aGtqZ05BQXZIaVM4Mk50WXh2dWJyQTRM?=
 =?utf-8?B?RitQKzdodG93T0J6U3JsTEY4VmxMODliT3VyeUl5RmFKeVFxSlpBL1ZQc3My?=
 =?utf-8?B?c3RRTUZBbVdob0xxc1RuVjdTbEdHMmFRYUs0cW5yQXlLZ1lZYUU0clVjMXNG?=
 =?utf-8?B?RkFkZUlibFlnNEExbzhBTEorSStoZC9MRUt2c3E3aTFHeThTL2RtSVNYb1R4?=
 =?utf-8?B?Mkdhd1Y2cm55NHljRzZHbzdadWtmZDZWczhMOXNBaW1ocHp6d2JNNWpCU080?=
 =?utf-8?B?MTB1aHRiam9xRkwxdnQ0R05sK1FYWmptZHJRVkw3T2tiYklTbnVUb3A3WHlX?=
 =?utf-8?B?K1o0cTJMQTc3MkFSNjJYYVFvN3dwVlJPU1VYUS9qdDhZMWpYQUttTis4RXJV?=
 =?utf-8?B?NTRKdUo4dXFjVmtIWmIza1daeGdmK08zMXJyR2hWNk5ZNGxDc2lNS1dCaFN2?=
 =?utf-8?B?ZDhBU0haRkxCbUNmOTlOZ1J6V1ppaFZPUGFwbzZHSkJvL0RNKzNTOGdxZFMz?=
 =?utf-8?B?QlNiU2Q3czUreDY0TEpJQkFhYVNjenlGbmtsbGYvbDFyM0xPK20xdDFUNnZx?=
 =?utf-8?B?aklMOVFsYkNCeEo4Lys5d1ExR0xidUdJVHFrN1VPU3JJT3pSVVd1RnlIRUNu?=
 =?utf-8?B?SG4rdFJjV285c05vblFqOVlQRXgydWUyaTRjdFpwQklDRE5DWTdENytwM2NI?=
 =?utf-8?B?cWNreE5Qdnlqd1lkYzlwMXhhR0hnQk9BNFFEd2pRdlBlVzZIVnJnRWlMNFd2?=
 =?utf-8?B?SjBQNUprTUNjbGxwaG1jeGVsZE9wUWxNdlNtRWZQOXFIeUp5R3hwcjZodzR2?=
 =?utf-8?B?Z0FvSHA3ZTdBYjcyVUh6a0RVV0w0ZVJTTWtLMHRBRFRYZWpGRWNpV2FkbVNz?=
 =?utf-8?B?QkhFUE9lSmwzOEZYdXFNZVBKZjg2b1BPbGxqTzNvVXYxZUdKVnRWb3pia0lJ?=
 =?utf-8?B?WlV0QXR6b3VqS1RKVm1tUUY2RVRiRm8wRFBXT3NKZUlSTWt5VldaaElzZ3Jj?=
 =?utf-8?B?UHlxck45NWFjM1I4WFBENHNaMUorOFowSjN4UkJ2TGUyTGxYNkFBaXBReU5k?=
 =?utf-8?Q?7xEbrgwfm8Z0Bml7MZ0Wwc/xA?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70417006-767c-4182-510c-08dceca06a53
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 22:34:50.4103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PwukWCt7JoFtDxlb1U3CIQDxMWd3hlw4f9Q+2wWQSkVq9ob2JGrNrw7jb+NM1pWymAzareFP46l9Sd+27VzCxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5531

On 12.10.24 12:26, Florian Bezdeka wrote:
> Adding compat support for the arm64 architecture had the nice side
> effect that all supported architectures now follow the Linux calling
> convention regarding syscalls.
> 
> That allows us to drop architecture specific code and migrate to
> syscall() provided by libc.
> 
> This is a preparation step for a possible migration to a prctl() based
> syscall API. The migration is getting way simpler as no architecture
> specific code has to be taken into account.

This comes a bit too late for the RC cycle we are in, specfically as I
would like to see benchmarks demonstrating that this change is not
causing any relevant latency regressions. If you disassemble the result
just on x86, you can see that this can prolong the worst-case code path
by some dozen of instruction and also a few stack access.

Jan

-- 
Siemens AG, Technology
Linux Expert Center
