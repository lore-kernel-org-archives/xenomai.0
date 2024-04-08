Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2090.outbound.protection.outlook.com [40.107.104.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD75E6F53D
	for <xenomai@lists.linux.dev>; Mon,  8 Apr 2024 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581929; cv=fail; b=WEWqnkCW2sNe2rVJHxcQ83QupX90y5jWU3lVvy2uMagDlfXWcJEEY94GvIiNecbBBuPJ3WUp69UYkLE/zuMOxKXDmZpQD1dFzw4GPC1EfFUprZMmSYMSBZsfDYdhLrelZzBjsQALuYeK68SCGya8SRSO3CveBEHCFLHtHydIyKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581929; c=relaxed/simple;
	bh=wiUJE3xcOwfToP9Fm4/waag/iuMwbfTdXyp24Iw/CD0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pCCDGZDD5zVKQsF249LlY0LxBtbDxvSj6nh1y0y2PojJxa5o17Zmn6KVtcPEAxwlbzug8fZXxFlutMyihApKdv1R326AEsr+2jXFTf8dBvPA1d2dsKeTqGdPb/RGql/2RuCziKFj7mo9Y4Ez3ZdlDOJIbZaA8RQqoETHXwvnibs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=AjVZ5gCK; arc=fail smtp.client-ip=40.107.104.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="AjVZ5gCK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mA7WjzrelNkZK1rFuga9NBO/qqyaSAc4GdzihAhTjFW2Covevxxbgyf4oSFK5Vkap1gEXzHuTK2JctkgDGAXQX6hZpVVcJwTxpp6beH0uLHZuCpT5JTK1ULvtB5asPLUSM8g7ygqIvmWhAdsSRP6UkiCFXLoBogDTBysue20qbnclnH9OeLptWxFlBWd09jI2hzKMPgFgyv675TF31Tx682ooMhSI6iOxITtLigZY21O8VK+ijr/jv5p90ZlXatrdtikDn5koSDIsIN/QPuzkLOPLQk0B+imT8Tz7L73ss4cDb22gw2COAuZWgcQOo+XhcblFKzyItqjEZhuasrSJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNYiyfkQInkvPHk8wOdeBNF9SCWyqo98PGBThBAxqjE=;
 b=VAu5jOXkb+mWYhszZdZyjz93sSRz9lJt53d6hiZRcQEKA41zf9zo4MvuCuvYj6o7vq5S62MoDIv0vX1SEBoWm5aH4n6wM+9f91SvZrEofF/F88qXb43TTYo1IrsA0pV4Vwo6/flOCu1dzLGJSCe31rzXeBn8fumkfu1KpjQkNfRUPq41NEwsF+JBnc1fg9mRow4ljczSafe0Ta7Dn36fqS+h+GgZdb83XppmZqxQThtjUhEwTBuwBbn4CFhKBlLF7fQC7E/svyLEPP01fXv2mSL0WDDBN2xgIpiWAAo1CaucCoWuywfsUF/F+TjpTGVm7mrUBpcAE+2ardSz67gtLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNYiyfkQInkvPHk8wOdeBNF9SCWyqo98PGBThBAxqjE=;
 b=AjVZ5gCKGg7SEjyxmv8doelDZ0Gz1+vBKs01Qq2KT0sD+Opm9DbeCdLv1mi8MewXXTF5Ey/Z5guLcCiUIYEgCi1P+LJi+VL1SyaCt8KIKbL0UdGl16DSQwN1+f3uKs43yakDmURc2Y1vhV4Npcw0ha4n0j+eL13OmO8GjCIAzbs91+oS+/v+FIjQf7v9MVsn5d6FWLQ8iYp3ZXhzX4l8UNToJGKGMfupDMCpkB4+Ioh4sRvuMoa4Pu0crhX4sRnuLbal3ZF13z8MUniaLCz7WhJodMoj1EfTjvgaryYVNCx0gfGzo9cIz1PufDSzsVSHUIPJq7tXFU2vqx3gEmNHaw==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7175.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 13:12:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 13:12:04 +0000
Message-ID: <4518cde8-777f-40fb-8598-8b29400d8f51@siemens.com>
Date: Mon, 8 Apr 2024 15:12:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail 5.15-5.10 0/2] dovetail: x86: Backports for
 recent compat fixes
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev,
 Philippe Gerum <rpm@xenomai.org>
References: <20240304-v5-10-y-dovetail-rebase-v1-0-e8010867dbbe@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240304-v5-10-y-dovetail-rebase-v1-0-e8010867dbbe@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0191.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7175:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HKzZx3dA7BBrvDXiMji7pngw9Nexw8MI5VM/kuIysbURVZo3hLWEekg/Obh+AoFfR/eJc7SIPXqMeyNxJ51dHIN7XYl6PU5aYZXjy15FqaoubZUgeywp8SbgTlNUFbqvxIj2e0vzd+z5F3Wv+jhIdfiPOBaD+byaFCGXcAMjgOJymV5eezVWZc5oKz9fYrT0j58M128cSJ7bPUHgm7j0isR7Dj1JLBdGQ6/66PT53146zCTu2tJ+3ZbMjBf7q4sOIqm0jlFYjdw20FpT1jpUluzam0n8a5l75yqSMeQHqr41C65PW6NA8g/M8zNBcT5P97RTKW9gBDT6LuJSMdPjVjH6QM5/0mKyjXCuKMHFWzpi4zV7ajhsYTeksz4kLko2TGJg8CuTH84u14w3T3tW09+Vbsj07bzuRitF+jTmKA/TfU9N7rdhKziM90NcY361iaGJ6k6GZEqENqhGM7T7HyAXvSlJdbezZydJ+W/h/yoKnfU9hV1pylwrhlfFhzJpDBqg2BoGZP6kXpYRaCvgbKpzWtx1ZK4R2fIiunw99ix2808vnWmPp9bv8i7+iQeeFy1LVX4tPTr5NqHHnlGaxGq1lHZOODfiSyLyOb+dt28=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmY5Z3ErRTN2cXd4UDc5R0NCSENjbTFab2srWmZseGtFU0JvRmNFL3BxM285?=
 =?utf-8?B?a1N6TzI5aXF6WTBmTlFldDNtRVRqNUdsaTZ0YjZqQUs1ckwrdU1rUEZ1eUpY?=
 =?utf-8?B?VjVZRE1kT0c1WGtlQSttakttajVBTEhjVnFuSU5KK1E3TzVyTmZiSzhNaFVw?=
 =?utf-8?B?QmVub1ovUWpuT1NwUE4xd2J2K084NXh1QnBlSzBWV1BiNi9saVhpKzdMUzFT?=
 =?utf-8?B?QXphTGFhTkNUakZhL0Rhc3pGQlJiVkZSa0FwQmR5TElka29uUUlGS1M4MHFD?=
 =?utf-8?B?SDJ5TjQvUElMTTVndUFLb25RamxCRldSWlhtMEJsTnRnZ3FsSFJ3QzE4TG9Y?=
 =?utf-8?B?VERMK1dOUFh5SkZTYlZGQnZHSTZrcEdja3N4VyswK1plNklEWitmekVMQUlV?=
 =?utf-8?B?a09IaXhqUkhiSnplLzcyN05ZeTRRL0h4cWQ1OVIzdnA1WmhOc0MzNW9Lb2R1?=
 =?utf-8?B?NG55enF0bkNjdDBJUjdYME9tRjZSWks3ZmZPR1k2SzZENVp4K3BJeWFrcEpx?=
 =?utf-8?B?UFgxT2thOWd0TzdSR3BUS0ZGbnVUVGYrVjZ3RmJRRnJSY25KaG1keXFndmNj?=
 =?utf-8?B?WEJ3MXdycG9wVFNSeFJUU1AySTNRcVIwdlJuaFRSQVlsZXVLUTNCME9mWFdx?=
 =?utf-8?B?bFFXVnRST3ZUZS9aaGR3ZUd0V3NKdENxWUs0cEFvK04zVTZPN1dsbCsyaTJX?=
 =?utf-8?B?WlNFeityUUtGOGtCaytJZi85R1BReU5xbWlrZlk2S2h2ZDlXL3hoSXR2K3dO?=
 =?utf-8?B?dUE5citZMTNlZGlQWEtMWXVYYzRSdnI4Q0ZndG1CWDV0YmVRS1hubFozZG1U?=
 =?utf-8?B?b2gwLzVUbGJsYm04YjdrQkpCemE5Ky85WjFzZlpOYVpUTDZmY1kyWWt3c0RF?=
 =?utf-8?B?ZnR6aXEyY1FaSWVyVVJOWnpNU0FvSEgyQVU1WVdBcnVleXBFR3Bld2pFakNo?=
 =?utf-8?B?SEpmdkhMRHlia1RxWDRWV24reVczbjdZSWI4MmxQamN5dEVrQ1RZZGl5eGxF?=
 =?utf-8?B?ZlVFM0xvTUhHdFdWbG1ZOTRJL1huZ2UvNW5Jc2N3cU01emVnS1lSaENkVkUw?=
 =?utf-8?B?VUhIT0p0RGkyL0svYkQ3azVxTklHOTZyT3R0RW5wdGlBcW90TXJoZmdiMENi?=
 =?utf-8?B?UEE0eEhWWnIzL2FNSlhjSXNYZHA2R1hkYkdDTTNlVXZjcXlFVjZaYW5sZFFo?=
 =?utf-8?B?WFdJL1NEanIzM2ZtcUVwZ0lUL2JZakZHNGZacnNFNk1JcE9odVlzU1g0UmtM?=
 =?utf-8?B?UFFnQzBiU1k5UTVuTlVxMXBJZTQ2SDBVaGtzOXhETUhVajBYNnBpMUhqTFZM?=
 =?utf-8?B?aVFQdDBlc1VLRUMyR2hidnQvdEo0V1g1N0FidlFqY3F3YUFSTlZtVEFFRS9u?=
 =?utf-8?B?N3JpWVNVc3p1L1BlT3VHNVUraHovYkZOYkNGam0zUW01Y1pyUGRtakxzeDVH?=
 =?utf-8?B?cE05dlNRZ0JQcElhVVkveFk4V3k4V0dObEprSm0vWjV1QnJ0R3dzUlJxbGth?=
 =?utf-8?B?UU84aXU1djV6WGdFMURGNVhZOU9hbmVwcjdrUWZvaDRvcWlPZUltRUdWM3J0?=
 =?utf-8?B?djdqSkw3aWZmQWNMbUtVdVhSL0ROQmxNdHpIdzQwL24vL0dhOEpsN2JhQ0lV?=
 =?utf-8?B?MGp0UkozZEx4TUF3RjFwZ3ZMd3kwZmRHdytSRjgyS2NjcVA5S2kvZ0ttaHNr?=
 =?utf-8?B?bFlwTjRzMHRXL0FnRlovSVhDWmEraWZLV1JLNlZpMys5U0xBQWE4bFlBMENQ?=
 =?utf-8?B?VktLcXVTNUYza2NGWlMvaEZNRElkSGxUdUpJYWNjS3pQdlRKUmdQd3RYSFMw?=
 =?utf-8?B?TW9ZQXV4TmZzaWlqNjFGdnpNcklxbUdqZkM1TVYwclZaK2JGa0VJZ1oyMXN3?=
 =?utf-8?B?UmU4ZHlhdHExRG5hUXVEL3Q3ampldWJDMENUdk9ZQ0RacUREMHRHQzZ2ak5U?=
 =?utf-8?B?b3AvcmMrczlTNXlUWkU0Q2pFK2s3MTZmTWVxTDlwOFFLT3dkZlh0ZFN4N2pW?=
 =?utf-8?B?UUgxby9iN0I4RUl2M3ZEOTllYi9pOUN5TEZjOXNWbTBlT3FzRDBaQzlwYjRv?=
 =?utf-8?B?QzNqdU8ydERIRldMUXhxNCsyRFAzR0krV3I5ZmNzUTdPUGRld1R6K2FmdEhH?=
 =?utf-8?B?eFpzcC91RXp5d3lFaENGbFcvanFXdUVwWGdlT2FGRVdHQ0JBQWhGaExwNjFJ?=
 =?utf-8?B?NHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc8783e-c353-4af9-37de-08dc57cd7be4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 13:12:03.9751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjhhUJ7zbRWX4+esNCV3oUlwjVvG2sak70n5mcVBSCcvIGQXjRVI7jyU2VcQPxi0QZJwjx6ZWXtCZ0DUTsVLYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7175

On 04.03.24 14:00, Florian Bezdeka wrote:
> Hi Philippe, Hi Jan, Hi all,
> 
> here are the backports of recent compat fixes targeting the 5.15 and 5.10 
> branches.
> 
> The original series that made it into recent development branches was
> published here:
> 
> Link: https://lore.kernel.org/xenomai/878r2yfi2j.fsf@xenomai.org/T/
> 
> @Philippe: I think Jan is still waiting for some clarifications about
> maintenance topics. Would be nice if we could sort that out. The
> maintenance state of some branches is currently unclear - at least to
> me.
> 
> CC: Jan Kiszka <jan.kiszka@siemens.com>
> CC: Philippe Gerum <rpm@xenomai.org>
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Florian Bezdeka (2):
>       dovetail: x86: Fix detection of prctl based compat syscalls
>       dovetail: arch: Fix fetching of the first syscall argument from compat tasks
> 
>  arch/arm/include/asm/syscall.h   | 3 ++-
>  arch/arm64/include/asm/syscall.h | 3 ++-
>  arch/x86/include/asm/dovetail.h  | 9 +++++++++
>  arch/x86/include/asm/syscall.h   | 7 ++++++-
>  kernel/dovetail.c                | 5 ++++-
>  5 files changed, 23 insertions(+), 4 deletions(-)
> ---
> base-commit: d7226e2eecda5b73a4c8fea85226ea4444038b00
> change-id: 20240304-v5-10-y-dovetail-rebase-43caf7d6a2e2
> 
> Best regards,

Those reached 5.15 via my last update from newer kernels but didn't make
it into 5.10 yet. Philippe, I would now take over and refresh
v5.10.y-dovetail[-rebase]. Or do you have anything pending for that
version on your side? Please let me know.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

