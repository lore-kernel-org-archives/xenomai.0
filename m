Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D1E288B5
	for <xenomai@lists.linux.dev>; Thu, 11 Jul 2024 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720724690; cv=fail; b=irD+d+kcPiB8p+sdNAewJLw9uhEH5q62ZhKJGeiDJNOZgSntUKhp+zg2altON2qf4BGVINwqDyW+PcdmxFB1ZU24E+ihu7fWpPToeHNWDSTkcX9WO/HAD8bCWmbhD68eaRRa0go0p1o77oaTU4dgpcaAbSfPuPFKdWUlYlobsYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720724690; c=relaxed/simple;
	bh=3XnQH5TEjk297rmftsid484nmzPGaOHB+4W5ZJBJYr8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F9OB7+xvKUrkzWv75iXULX7jL0prpv8a51rliTQalbrMadlFZHlV7WB3H4zFXWrQN5SoIwtEuBEf9Ukd9py1lzgXAzvsRAOMC73Wx4NO0y3ojpFEr9MFmQqoI11ZU3+J6zSH3MH2DMm3zRc91h9WeVZ5Wq+mSlq3dpMSqoffu9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=uWLu7hRO; arc=fail smtp.client-ip=40.107.21.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="uWLu7hRO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJFuPhZeK4pmJMTflkVYRx7UEevuclmJG9gQlQFXQnWvKI2ktMVh0fg6r6teUJnNbLlA7N3W97XT0Kb3NZRvRtikROX4MNM4axrTwJSizb0/PAwh44rn9fGVjskugJP8gOKAZKyXgGntr++ra/aLtOXpRX+6tm4LxWBBNpMyRiODn9aFEldAUXx9zmxysgtjwFDZVL1G94tcUFnu+wrLLEYAA4Z3jrD4QvpPdBy6hNRubsRXGBQ72CO1iniekleUZlhGF1QHPUWjeccGAg95aSOo7BKmo4sV5taAqff5gydr5v6NBgIEhK4jsif9RBIqWG7KGO0sELBKjhsVhchHrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oa+Vcv1fwb5JGaHSuj8OOTIPf2MBiRIHyztmUWnDmOY=;
 b=v3acEmZE3W6lXF81w4eeiCHJ658dLefR/qo9VKBN8yuys3xp59OjeE3aTVEEHHnX1ls2qpX5VPLOHonxxLjvctN/BtCLlSUmt/XcBEtV6i1jJTBBg2r+TVsD45xq8MoMyioB/scFoWQ0HmsjN32cojKTVstH+9XJwI6Qb7uWWNoLMM0nMbrDywb/G+JwCNftq8l4bx7X3+jMqsXjudU8IoA2d3N+kmb/59Addbj2UXPqR9IUzIboOFOspyHu59Enx7Bcxst1TKQzzppDJVeIff0W96j1VLyFOiQvQ10rpDgBi0EhcVRn3+HD1++q9oL7E5UcJl310TPM7u4lOlQCWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oa+Vcv1fwb5JGaHSuj8OOTIPf2MBiRIHyztmUWnDmOY=;
 b=uWLu7hROUHmskUExMdfeAkrqjw5eh3K0kvrZMKOn3rFq9QCxdHfzgT3M6+TV0MDUA11lnhhmO5AOUqllg1HsslIbL/pneeayd8gSr9NJr/i5lz7iS3D7rv5i5ubCa9U3yoWPoVio0/TocBYEjLDl8YdRAHLXd0NTwYV7nO4QsSflohsWbfFI3kT8zJ9B2mxOpSa0Xu7X69jg1ftGypj220qcS+hTV7TY+xutQgkNB1bZ+NP2YIsKkzg0EVu/TEacjgWQx3u11S7yJqwb8pzV61MwNypNKt1vDAASs4VzfTQQj8UmcplVqlkVPraO6kRfD5raQm02+EDzMOhqx36J3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3348.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Thu, 11 Jul
 2024 19:04:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 19:04:42 +0000
Message-ID: <98e663c9-6e47-489b-9151-b0f6d3eb65de@siemens.com>
Date: Thu, 11 Jul 2024 21:04:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/33] drivers/stack/ipv4: Migrate from rtdm_printk() and
 printk() to pr_*()
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
 <20240702-flo-removal-of-rtdm_printk-v1-27-cc91bffdd063@siemens.com>
 <e04882ea-4d3f-431d-9e7a-6c48dc4c82b6@siemens.com>
 <10b0083c33b9854909c2a68223c24edb52a9c9ad.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <10b0083c33b9854909c2a68223c24edb52a9c9ad.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3348:EE_
X-MS-Office365-Filtering-Correlation-Id: 050c43a5-5f15-48a0-e701-08dca1dc525c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TndMYVhuWC93cjc1WGVMU25qcTdSWkYrRE1ENlpGVWRURGZhOWVFR2Zkb3la?=
 =?utf-8?B?cnVCd296bnp0Y0IzSXJxS1lpYUxZNzJycHc5V3gwUDN0dytqUHBobVM2RzRT?=
 =?utf-8?B?L20vZURKb1J4MWVQVHp3aVFLNWYxZEFHcnY1TUowM2FTUit2eHFEcVJoUXNq?=
 =?utf-8?B?QnR5eEM2eEFTTjhTL1pLTGRuL1FIMHFwbHAydjl5T3VlaHh3bTJYQ3RRZDZj?=
 =?utf-8?B?SERVaEp6UUJnSWhpRjFZSGREK29RWGgvdGVIelo0RTIzT2hYRSs2Wm1QdWlR?=
 =?utf-8?B?V0I1SnFZWHhZTDFpSDBueU1zY0UyMHNKYlRQbnprZmdQSHZSRnZMekhCTXM5?=
 =?utf-8?B?eTFwZGFKUmFVdDdPbFRDcU0xQnBhTlBhMUw1SENFbDliM2JvYVhEYk0rRVNC?=
 =?utf-8?B?RFk4UzdXblh2Q1NDYThEMWl2LzdUNkJlUzh3ZmpjTlM2bWNlekhJcDNUKzBT?=
 =?utf-8?B?RUUwSWJHMXhoUTE0NGU0SDRYaWtBZVNSemJVQmNTZlRtRCtXSWdBZEtjSTRR?=
 =?utf-8?B?TGxRL3pxMlkxM1huWldvN01ONFV1S3BQbUpJK3FrQWcrUjVZSWswSjA2RGJ6?=
 =?utf-8?B?TTRzMlFzUUdOYWhJeWEwYmIzei8yMjh5Y3MwMk5Wa0Y3ek5UckNNanpjenh5?=
 =?utf-8?B?T0g3dU5KbWdyczJvZ0FsV1BwWXV5YjRkc1RjUTBHQkVuR3VxcXJYTVplZ29D?=
 =?utf-8?B?R3pjY25xc3dJcUdjZ2dXdElCMzhRcWNhbUZWdGlQZjBEQ2NxQ1hiTlhLbDJN?=
 =?utf-8?B?SFVhUE9QVUdsS3g5b3NKdWlDZVZNMncxTW04OEV2MlZwWUVRWUZFZEZ2aHVa?=
 =?utf-8?B?SXNUYWczbG05VGlMRkFsbllIcHVlOXlYc1RYcFhPUTZzaTFEZlVMUStjNU5D?=
 =?utf-8?B?UkVhbVMwYkNiQmdZVFhKclRFT0JIM21kVkpTQ29PcllqZjdwTTNhbDBjOUxQ?=
 =?utf-8?B?VUN4ZjNabTlBdnFOY0lqcjY0UU1OMWZiQ25ZWkRraWo5MFhCZkRPQmlJcU1D?=
 =?utf-8?B?aHU0cVQyeTYzVFg5Tk10dEtWOWFpaGIrcFJINHhGT0pmNmV5c09LNkZxR1Na?=
 =?utf-8?B?TXFBN0hyclpWY0xiSmxVS1Vxd3l1MDFNMXlkOXNoTmIyUGdka0hIRUlHd3JS?=
 =?utf-8?B?SEVXeHZqTG9WOXpXeGl3RTJlSHNtZ3RSaW54cXhFY0RlNzJDMk03T28vRWdS?=
 =?utf-8?B?azhRNWQxb3lrNU1NM0I1Z3JyWllRZ3RNZGhxY2lmMFJmdDJUZy85NlAwc2w1?=
 =?utf-8?B?azMwK3JmWHhqdTBqelpuemNsdXJ4dlhDMmRsZThGNkQ5QkdSR0FHTTIrMUI1?=
 =?utf-8?B?NXVkbXF4dVZNMEV0U1RmU29BL3F1T3BlUHo3UFFydXZEZ3YwclFFRGo4RFYy?=
 =?utf-8?B?MVZKd1pqbFg1QWMzc3JxZDBtaldMWXBnSkZZZXU3NTUzNUVFMmpRSFZFeXMz?=
 =?utf-8?B?ak44eHhaQWsrK0VPazZIVmRWbkp1NmtvUHVTVk5sR3RxTE0wL0dHWi8vY3lk?=
 =?utf-8?B?T0VTODVBN0dCUFVMdEF4MDAyTGxKWWZ2SkkwVkU3R1ZVY2phV0tkMzlJZmRi?=
 =?utf-8?B?c04zVFY1SGErWnVWa05wQzIzMGtGZnM5Q2xQM2RaSDQ1RVZjRUd0TERjK2Rm?=
 =?utf-8?B?MStnZVZMNTV3dStoSUMzMzFob3p1NGpKa0RTdTlGRFJVdEhxdHd3ZjRmZ3VD?=
 =?utf-8?B?Y0xIRmpqVXd5anc3TllPbVJ2MStybVU5d2d4aVdHRU51ZFpCZi9tdmtoTVN1?=
 =?utf-8?B?QytGTGVwY3hGYzlKTEx5WkgzQnBRb29DUFFzODI4MmJHc2pBSnd1R3pmWVhW?=
 =?utf-8?B?aGh0ajdYaWtWL2drQXVSZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHV5dXpvSDJIYVNpcHkwODZlRzlXVXpsaGtFVHJ1dGVRZGRWQXRXUmQ1R04y?=
 =?utf-8?B?TVAxQmhqOWpkY28wNDhtV1ZMWXR4clRPTkUvVzBLMzNLNVBwZWl6ckZLZXhC?=
 =?utf-8?B?Ri95SVFJT2tsV2pXM1VJTkhqUkRRYTFqRm01T3NzaDhwRjhqMkkrWllUZG1O?=
 =?utf-8?B?SWk4Y3M5Ykh6Q21veVRncTl4TUs5dXdrU2pLWnVlTUpHUi8vTjQwaUtsdU1P?=
 =?utf-8?B?V3lCL3NCS1pSUDAzSXorNXVUQ3pPM1BaUGxaMmpNTVJHREpGRnpwcXIvNW05?=
 =?utf-8?B?RzJXdUhGZ2ZURTFpNnhvRnoyWjdrQUY3SEtVNTVST3VSalNsS3lYajJqRkVP?=
 =?utf-8?B?QWppQ2VoYkw4d01Ud3JyS2tGQTVyYXVxTFdyWTBmQ214ZTZJd3RzL1lkcFl0?=
 =?utf-8?B?UUduQ1JRdlI2b3VOOEdDZEJXS2I4WHB4NWRDUFNCTTNJUjVYbCtWQlhnVUxI?=
 =?utf-8?B?ZXFJNHhKS1NSOE0raVRZVysyS0x5OTE3RGNSOGF1TUU3RlJLQVZsN2RZeUt4?=
 =?utf-8?B?RW9WNTRXZ3ZEd043S3ZEQnV2alBQa2JWVTl2RW5PWmpUMXlKTTZ4Uk5HZ3lU?=
 =?utf-8?B?dVpOZHhUYVpEYmVMT0pJQXZwYUhyU0VmRHUzYlJpNTJjRUtTVEdYWjdzM1J0?=
 =?utf-8?B?Y2d1MUJoTWIvaFNuU0hPajRKbkJBWk1id2YwY21RV0ZpanQxMlNPS1pPUTN5?=
 =?utf-8?B?b1VCRi9iV1dXQ2xsMDl2YVl6bHVyZS90anErKzZTZ2pBMks0Uk15ZWY5d3Ja?=
 =?utf-8?B?RnBlQXNHU2lMNjg5WXdqVVgxdkhCSk8zLyt4QnNZaXNOVTRLM2FzODUyQ2FF?=
 =?utf-8?B?QXpVODd3dmR1SmZTNVQ3VEhnZ0NQT09MYnJyQ3dpWDdhYlc4K1I1V1YyajN6?=
 =?utf-8?B?SXZVdUdWQnBQTHkzYTlyZWZkRk1iSjc5djVyQStqc3YzUHE5Q3dDVXpNMEdj?=
 =?utf-8?B?SFhSbUkzbWhnbVJ0R0sxakpUZnVCM0dpZWxKdE53R0VWRjJkUFRiWFFYL01O?=
 =?utf-8?B?MGQyYlRFRkRUOTI4eVRHQmlWckt5dTA4bWJhM051c2g0OWVuVkR2KzluYjBz?=
 =?utf-8?B?NnZYeTZtUHdzcCtpS0RUOFAzTjlacUNYSkgxNmxXcUpnWldTbDRySlBFMjJQ?=
 =?utf-8?B?L2dVallNYnNSeS81UFYrUGlxWDZuTDRWbS9XZi9LK0pWeFlMWk0wQUhKSDBZ?=
 =?utf-8?B?V3pRMWdNRWY3Ny80QitnOHphZ2p0TG1JSE9RSFJ0Vks1bk9heURqNGJUZVFU?=
 =?utf-8?B?OGF1TCtvZlkyRXpqNmtvNGNBdXRWYThlcVl4QnY1V2NXUXBnSjhmZ0ZLV3J5?=
 =?utf-8?B?WENReTJZT2tHb2FaVnpXRngwU3Jnb1NaZnZuYWVpM3pLa1JUR2x1Z2RNVDhy?=
 =?utf-8?B?WCtCWk9wMU1VQTVRVXN4NFpMZzhnSFVzbGplNFJwZmQwdEJDWThhOGVOdFNT?=
 =?utf-8?B?ZTZKUktCREtCU2g1SVJVUk5rR3Bxb2tWTDVhSFBjWTNxRE9COUgxZDZsTmxX?=
 =?utf-8?B?Q2d2S0NESHJwR2lDU3NzcHpoSWtqNC9pSVluVXdUS3h2T1BQYklTNi9TNW15?=
 =?utf-8?B?WTdpOVFuVkZGUThjeGFZZHVkNC80R1I4aVhrY3ZXdHlDYm1ZZzBYdXdZSXBQ?=
 =?utf-8?B?N2xZTSsvS09ObnNqR3FxSElDSmVUY2sxWHJUT2lLWGdERGZEaW1LWTBqTVEx?=
 =?utf-8?B?ZWFhMTI4Mk1CNU5Gc05aL3NSSUZZN1hrakFzb25EdUhXcHl4M2pkVFAxTHk0?=
 =?utf-8?B?QVk2UkxLU3RKZDJkKzJCVGRvTFBBNFBjZ2pDMFR0SVphbTRUbjNMaktQWWcv?=
 =?utf-8?B?Mjc4TTlkVHlncTJrZUxrenNKZDFBbHRlMjYxbEs1cENkbnI2d3ovR3lLSlpL?=
 =?utf-8?B?Qk1qZE1TSDlpak90RUVWU3V2ZVpYb0EzTG54K29FK0tMQXNETFV0R1ZPNEJU?=
 =?utf-8?B?ZDVXbUJ4OXB5RC9xRDFwckpGeFQxcjgxWXlJdDBtTGFIb1A2MWxrK0tHcDNy?=
 =?utf-8?B?cU5GS1U4RUFSMG1McWxJWGZ6dnV5cXlxWU9RcW5TbVlMaXlqT1RlTnI2MnV0?=
 =?utf-8?B?SXcvMmhndmhoc0xJOE9XSnp4di9sWGczSENMVHc0MXpvendmNmE2MTF6VUxp?=
 =?utf-8?B?Sm1Jc1dHRFNCa0dyWE8wL2xFZHZHdmRCbXlXcCs5Um9WR2UyN1RNNytWektR?=
 =?utf-8?B?aXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 050c43a5-5f15-48a0-e701-08dca1dc525c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 19:04:42.7329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQv6JpRHx36LvcO/xfQGWjXabDXnK75KErXorWAYV80LRs96tX41q5C1VJ/hVuujXJjVqOMJbjAt09B76IpiEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3348

On 11.07.24 20:15, Florian Bezdeka wrote:
> On Thu, 2024-07-11 at 18:14 +0200, Jan Kiszka wrote:
>> On 03.07.24 15:25, Florian Bezdeka wrote:
>>> Some (rtdm_)printk() calls were missing log level information. The
>>> default log level (= warn) did not fit well for them.
>>>
>>> The missing log level is addressed by migrating to the pr_*() API.
>>>
>>> rtdm_printk() itself is just an alias for printk(). Migrating helps to
>>> remove this function once all drivers were updated.
>>>
>>> No functional change.
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>  kernel/drivers/net/stack/ipv4/icmp.c           | 25 +++++------
>>>  kernel/drivers/net/stack/ipv4/ip_fragment.c    | 17 +++----
>>>  kernel/drivers/net/stack/ipv4/ip_input.c       |  4 +-
>>>  kernel/drivers/net/stack/ipv4/protocol.c       |  4 +-
>>>  kernel/drivers/net/stack/ipv4/route.c          | 21 ++++-----
>>>  kernel/drivers/net/stack/ipv4/tcp/tcp.c        | 62 +++++++++++++-------------
>>>  kernel/drivers/net/stack/ipv4/tcp/timerwheel.c |  9 ++--
>>>  kernel/drivers/net/stack/ipv4/udp/udp.c        |  4 +-
>>>  8 files changed, 73 insertions(+), 73 deletions(-)
>>>
>>> diff --git a/kernel/drivers/net/stack/ipv4/icmp.c b/kernel/drivers/net/stack/ipv4/icmp.c
>>> index c3b80b18d..d96b4fc5d 100644
>>> --- a/kernel/drivers/net/stack/ipv4/icmp.c
>>> +++ b/kernel/drivers/net/stack/ipv4/icmp.c
>>> @@ -24,6 +24,8 @@
>>>   *
>>>   */
>>>  
>>> +#define pr_fmt(fmt) "RTnet: " fmt
>>> +
>>>  #include <linux/types.h>
>>>  #include <linux/socket.h>
>>>  #include <linux/in.h>
>>> @@ -184,8 +186,7 @@ static void rt_icmp_send_reply(struct icmp_bxm *icmp_param, struct rtskb *skb)
>>>  
>>>  	rtdev_dereference(rt.rtdev);
>>>  
>>> -	RTNET_ASSERT(err == 0,
>>> -		     rtdm_printk("RTnet: %s() error in xmit\n", __FUNCTION__););
>>> +	RTNET_ASSERT(err == 0, pr_err("%s() error in xmit\n", __FUNCTION__););
>>>  	(void)err;
>>>  }
>>>  
>>> @@ -254,11 +255,10 @@ static int rt_icmp_glue_request_bits(const void *p, unsigned char *to,
>>>  	unsigned long csum;
>>>  
>>>  	/* TODO: add support for fragmented ICMP packets */
>>> -	RTNET_ASSERT(
>>> -		offset == 0,
>>> -		rtdm_printk("RTnet: %s() does not support fragmentation.\n",
>>> +	RTNET_ASSERT(offset == 0,
>>> +		     pr_err("%s() does not support fragmentation.\n",
>>>  			    __FUNCTION__);
>>> -		return -1;);
>>> +		     return -1;);
>>>  
>>>  	csum = rtnet_csum_copy((void *)&icmp_param->head, to,
>>>  			       icmp_param->head_len,
>>> @@ -435,23 +435,22 @@ static void rt_icmp_rcv(struct rtskb *skb)
>>>  
>>>  	/* check header sanity and don't accept fragmented packets */
>>>  	if ((length < sizeof(struct icmphdr)) || (skb->next != NULL)) {
>>> -		rtdm_printk("RTnet: improper length in icmp packet\n");
>>> +		pr_debug("improper length in icmp packet\n");
>>>  		goto cleanup;
>>>  	}
>>>  
>>>  	if (ip_compute_csum((unsigned char *)icmpHdr, length)) {
>>> -		rtdm_printk("RTnet: invalid checksum in icmp packet %d\n",
>>> -			    length);
>>> +		pr_debug("invalid checksum in icmp packet %d\n", length);
>>>  		goto cleanup;
>>>  	}
>>>  
>>>  	if (!rtskb_pull(skb, sizeof(struct icmphdr))) {
>>> -		rtdm_printk("RTnet: pull failed %p\n", (skb->sk));
>>> +		pr_debug("pull failed %p\n", (skb->sk));
>>>  		goto cleanup;
>>>  	}
>>>  
>>>  	if (icmpHdr->type > NR_ICMP_TYPES) {
>>> -		rtdm_printk("RTnet: invalid icmp type\n");
>>> +		pr_debug("invalid icmp type\n");
>>>  		goto cleanup;
>>>  	}
>>>  
>>> @@ -467,7 +466,7 @@ cleanup:
>>>   */
>>>  static void rt_icmp_rcv_err(struct rtskb *skb)
>>>  {
>>> -	rtdm_printk("RTnet: rt_icmp_rcv err\n");
>>> +	pr_err("rt_icmp_rcv err\n");
>>>  }
>>>  
>>>  /***
>>> @@ -492,7 +491,7 @@ void __init rt_icmp_init(void)
>>>  				   ICMP_REPLY_POOL_SIZE);
>>>  	BUG_ON(skbs < 0);
>>>  	if (skbs < ICMP_REPLY_POOL_SIZE)
>>> -		printk("RTnet: allocated only %d icmp rtskbs\n", skbs);
>>> +		pr_debug("allocated only %d icmp rtskbs\n", skbs);
>>>  
>>>  	icmp_socket->prot.inet.tos = 0;
>>>  	icmp_fd->refs = 1;
>>> diff --git a/kernel/drivers/net/stack/ipv4/ip_fragment.c b/kernel/drivers/net/stack/ipv4/ip_fragment.c
>>> index 113a71238..d20cbf52b 100644
>>> --- a/kernel/drivers/net/stack/ipv4/ip_fragment.c
>>> +++ b/kernel/drivers/net/stack/ipv4/ip_fragment.c
>>> @@ -19,6 +19,8 @@
>>>   * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>>>   */
>>>  
>>> +#define pr_fmt(fmt) "RTnet: " fmt
>>> +
>>>  #include <linux/module.h>
>>>  #include <net/checksum.h>
>>>  #include <net/ip.h>
>>> @@ -96,7 +98,7 @@ static void alloc_collector(struct rtskb *skb, struct rtsocket *sock)
>>>  		rtdm_lock_put_irqrestore(&p_coll->frags.lock, context);
>>>  	}
>>>  
>>> -	rtdm_printk("RTnet: IP fragmentation - no collector available\n");
>>> +	pr_err("IP fragmentation - no collector available\n");
>>>  	kfree_rtskb(skb);
>>>  }
>>>  
>>> @@ -132,10 +134,9 @@ static struct rtskb *add_to_collector(struct rtskb *skb, unsigned int offset,
>>>  							 context);
>>>  
>>>  #ifdef FRAG_DBG
>>> -				rtdm_printk(
>>> -					"RTnet: Compensation pool empty - IP fragments "
>>> -					"dropped (saddr:%x, daddr:%x)\n",
>>> -					iph->saddr, iph->daddr);
>>> +				pr_err("Compensation pool empty - IP fragments "
>>> +				       "dropped (saddr:%x, daddr:%x)\n",
>>> +				       iph->saddr, iph->daddr);
>>>  #endif
>>>  
>>>  				kfree_rtskb(first_skb);
>>> @@ -197,9 +198,9 @@ static struct rtskb *add_to_collector(struct rtskb *skb, unsigned int offset,
>>>  #endif
>>>  
>>>  #ifdef FRAG_DBG
>>> -	rtdm_printk("RTnet: Unordered IP fragment (saddr:%x, daddr:%x)"
>>> -		    " - dropped\n",
>>> -		    iph->saddr, iph->daddr);
>>> +	pr_info("Unordered IP fragment (saddr:%x, daddr:%x)"
>>> +		" - dropped\n",
>>> +		iph->saddr, iph->daddr);
>>>  #endif
>>>  
>>>  	kfree_rtskb(skb);
>>> diff --git a/kernel/drivers/net/stack/ipv4/ip_input.c b/kernel/drivers/net/stack/ipv4/ip_input.c
>>> index 26642ef6f..933e38b56 100644
>>> --- a/kernel/drivers/net/stack/ipv4/ip_input.c
>>> +++ b/kernel/drivers/net/stack/ipv4/ip_input.c
>>> @@ -21,6 +21,8 @@
>>>   *
>>>   */
>>>  
>>> +#define pr_fmt(fmt) "RTnet: " fmt
>>> +
>>>  #include <linux/bitops.h>
>>>  #include <net/checksum.h>
>>>  #include <net/ip.h>
>>> @@ -102,7 +104,7 @@ static inline void rt_ip_local_deliver(struct rtskb *skb)
>>>  #endif /* CONFIG_XENO_DRIVERS_NET_ADDON_PROXY */
>>>  	} else {
>>>  		if (IS_ENABLED(CONFIG_XENO_DRIVERS_NET_RTIPV4_DEBUG))
>>> -			rtdm_printk("RTnet: no protocol found\n");
>>> +			pr_err("no protocol found\n");
>>>  		kfree_rtskb(skb);
>>>  	}
>>>  }
>>> diff --git a/kernel/drivers/net/stack/ipv4/protocol.c b/kernel/drivers/net/stack/ipv4/protocol.c
>>> index f56177da8..bd74b05ba 100644
>>> --- a/kernel/drivers/net/stack/ipv4/protocol.c
>>> +++ b/kernel/drivers/net/stack/ipv4/protocol.c
>>> @@ -23,6 +23,8 @@
>>>   *
>>>   */
>>>  
>>> +#define pr_fmt(fmt) "RTnet: " fmt
>>> +
>>>  #include <linux/socket.h>
>>>  #include <linux/in.h>
>>>  
>>> @@ -80,7 +82,7 @@ int rt_inet_socket(struct rtdm_fd *fd, int protocol)
>>>  	if ((prot != NULL) && (prot->protocol == protocol))
>>>  		return prot->init_socket(fd);
>>>  	else {
>>> -		rtdm_printk("RTnet: protocol with id %d not found\n", protocol);
>>> +		pr_err("protocol with id %d not found\n", protocol);
>>>  
>>>  		return -ENOPROTOOPT;
>>>  	}
>>> diff --git a/kernel/drivers/net/stack/ipv4/route.c b/kernel/drivers/net/stack/ipv4/route.c
>>> index d9a9c8b9b..0863c9d03 100644
>>> --- a/kernel/drivers/net/stack/ipv4/route.c
>>> +++ b/kernel/drivers/net/stack/ipv4/route.c
>>> @@ -22,6 +22,8 @@
>>>   *
>>>   */
>>>  
>>> +#define pr_fmt(fmt) "RTnet: " fmt
>>> +
>>>  #include <linux/moduleparam.h>
>>>  #include <net/ip.h>
>>>  
>>> @@ -479,7 +481,7 @@ err2:
>>>  	xnvfile_destroy_regular(&rtnet_ipv4_route_vfile);
>>>  
>>>  err1:
>>> -	printk("RTnet: unable to initialize /proc entries (route)\n");
>>> +	pr_err("unable to initialize /proc entries (route)\n");
>>>  	return err;
>>>  }
>>>  
>>> @@ -588,8 +590,7 @@ int rt_ip_route_add_host(u32 addr, unsigned char *dev_addr,
>>>  	} else {
>>>  		rtdm_lock_put_irqrestore(&host_table_lock, context);
>>>  
>>> -		/*ERRMSG*/ rtdm_printk(
>>> -			"RTnet: no more host routes available\n");
>>> +		/*ERRMSG*/ pr_err("no more host routes available\n");
>>
>> I think we can get rid of all those archaic /*ERRMSG*/ markers at that
>> time. I don't call why exactly they were left behind, but the fact that
>> these are error messages is now documented via pr_err.
> 
> ACK. Do you want me to do that on top or within this patch?
> 

Within, it's not really a major change.

> I can hopefully ship v2 tomorrow.
> 

TIA,
Jan

-- 
Siemens AG, Technology
Linux Expert Center

