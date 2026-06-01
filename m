Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011000.outbound.protection.outlook.com [52.101.65.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14EF363C79
	for <xenomai@lists.linux.dev>; Mon,  1 Jun 2026 11:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780314841; cv=fail; b=fFWHUmKea2ndR6kYjUkFq9pcJajoMqfkYC3V0ZeKlOfyRKgxbJBC2A8yIEamDkODXTJdf0KfXxzdPHf6yVz2womcP/IEXE2iQho2tM2ujuFTA6/KfB988pmwtlkJGB5ANvgBr9yxI7vINGHklVBjvi4gNugVmqnew8Ume67nAKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780314841; c=relaxed/simple;
	bh=9VEnyLw33+WZ9loFnykafUtw2b1i6+tEnvFgIWnSREA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WPrBEeIeuAMHqcSjA4XdmZlVCEcdvikSaAijnb2DWk2QRMsF+u4/doLdOSBPFH0bBdYnKeJVxJcLDLDt3b5uwQN8/u+nDszO9iQgFeAb4oouKmeo+G6lLesoNMoTCh7aL1PaQI+Cmg8wMBiaGR3s0j8iAX6uC0P4bAm+kEx+yn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ouPpRr/o; arc=fail smtp.client-ip=52.101.65.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ouPpRr/o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etHG/HKvL+0nn29YejWV9ZuwTR49fvw83jCKJnkPzn81Tt+3D9xr4XJAUU3ADz3T7fvU2JSuqaz2hvR19zHCogtix22yYqlqbTJaWZuYXmhQMF+kAQVBL5LdLHhboyVCacJQA72syG/gUbObNI7Sz5ZYU8Fjpz8SmTCWIuCQAwuZpdRNaX5E6ZHQ7TKGkTf+ATUhElRL8DynOm5C2DbM088nLaVbSac2CYlDJGuA+/4J6jHUeQxK5z4EkcI52g/biEGNkA5frTBEkQ31Nhkk0FRf1CoENstAjMatlDYOjsYKYEU9w32N4m8Gfx2YNREjAE+/w8ltvrr3ghPbaJf8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkhMGxDW8OCSuo+EKFyvafbylXOzterB2xilhhE0JJ4=;
 b=K21eon9rTfN6dkQofiGpXhIIrGztM29JHMnphK+QVcw1y3Dgmd/U2PE7kfgczD50OZTC1unhxasOHCaBurANNc2smfPlfL6SaYU51qVeqzsqmHN6Z/MJQwHUWz1hh8wv4INVSDFSVsrGucUly0GTEYGTQi0XA5h5T5o3bYFxljc4bReXWHk+0X/q0O37EsgyIV0+HsdmyAvI+kW+ADsdk81lrngiFREz89ohn1tWCNx0cVBASd12bQKVtXul3ceG3qKWux5kxNyFuD0B+YUyqD1zr4WRpt2bfah+Xfk7JRlgehok1EuVkZ676KemX/PgMwOu8xowahs3I1HdfASTuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkhMGxDW8OCSuo+EKFyvafbylXOzterB2xilhhE0JJ4=;
 b=ouPpRr/oFcq1ypZClZXs8e0kgjuV6iu9mDBFxCfkzvM3rkgAeCFC3tb+Xb6aY+tdzjgncIFLDrb5sq5CwrGzXXTjzEw0EmhPXnwLV+NYIXGz8lqVRaywYzK96bpUtkvhRjob1S0XcAzMsH5GF7kiT7G1NxM7ZtOMmf0IDq8V3YM5aitZQCqbozw8l9D98mtqN7hJFkqsDCLgVPGzbjhFB7EF66pgcUYpubZOGJ2RrMefE16KoyKRlz6+e7zVayEWzaiDDLf2NTaCjadrwZl6nWYzRBVAdIkWmmGY6lE09jD4WaV+kE+iDCx9Hw0xgb2u8hxvrkPEGkrhC2MDua+ddw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7033.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 11:53:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 11:53:55 +0000
Message-ID: <572b4724-25a2-4966-a55d-6a7aa3195c86@siemens.com>
Date: Mon, 1 Jun 2026 13:53:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] kas/ci: Fix bitbake variable referencing
 themselves
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev,
 "Schaffner, Tobias (T CED SES-DE)" <tobias.schaffner@siemens.com>
References: <20260601103549.785345-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260601103549.785345-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: 7958bef2-7cb2-4d28-27eb-08debfd47533
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|55112099003|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WRMSAS+pD5haL2X55qoA7NhEGfSRNhSYdKwD/0hOLqmgELyLT+wrk+vQ8+/l1gogeqw3cuQoIMni5LjotvZjkLkY33XNMTknUPjnHHgiR/Y1Cf7wawIkodh59dda5sp95f3ys2hN+4RYz6jqXdaPJxH1iEU7asSntjZc7dfUgMyQr6QyLFgpOsOTgrlMHjBIKwwQ+olZuk8dlqm8xCuj9KSLwe9PASh623w4IcVXuZ+TVZaso3tcSJkn7O/WxWqe4yv8yAhvya4hLLtHbAQgNF3/wIv/c86LPd7qC+AVfVHguSPlS+ZWQNPz429cLTGf8/9NRf3SFPbwjpc72xt3Ap/YDHiAVU/FLIqQ6DnIiFL818aag9ym4dRrv9HvC6nhSpCQjUt00f6L283qPx85FL/dqlsQ6iFssYFK5Gvg4qOK5RJmJxoa+fB+n8aV/vpLpnCYRkz5a+j99I+mj5HKd4EfUz6vMv/PP+XK+AUYmrwzIxDIp1S5o7YK31PsUutpuzNlHfiIO4B93iJYP0xmHe5MJUezklSyZ0457LFL/Ew5WCSie1YUlrjp1iqU1TC56uKSG0pjRwtudzkTce7lYGk01nLYDvRUr0in/bdVdStEu9aLfVYKcK9N8N8U/ux13LK9gG9xnn3CI7qJzqKXsAwgKoX0zePkiC8mDTf9p4XbQsqoVylIJKTcls3OnNnElHBIl6TjHzZa5nBojGSOqQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDlxMTZqeS93b2JUTmFBSTJadDFIWVZNWXQ0Rm40b2F1TjdwSXZxL2VpcjJP?=
 =?utf-8?B?aEtKSFpqZnRObEpDWTNQVk12YVNmaER0alhQMEtBcVdoVEQxL05TZy84NkhZ?=
 =?utf-8?B?ejljaDF2R1dTMnIranBkRW1QMUZHejZWOVoyMFNIK2ljQXBhKzgrbUQ3NjFu?=
 =?utf-8?B?N21VeE1lRG0rQ1krVWEwSGFMdWhya2U2U2JDcS9VWnZBTGx2Y0RIVGRnMmlx?=
 =?utf-8?B?Q3c4bWUyNU41eGEySzFJNUoxK21mL2NaOUJ3K1ZXTEFJcjlzM2JZRmYzMUZB?=
 =?utf-8?B?TFkxMlR2OTEwcXlNR0lNUTFUczNUbi8zQS8yVmFKNDJxVk55SzFFYW1UdHVK?=
 =?utf-8?B?ZXZBYytoUlBRdXkvVHJQOHFRZTBaMTRXcU1OQkdycllKR3g3SHoyMktLNnhH?=
 =?utf-8?B?M1F1L2g1bUN2WjB2NDR1VE81UUZ1V2Z6Q0IrM1J3Z3pKRnRTR2c5UnJLbEFs?=
 =?utf-8?B?ZHJRUUFzQ3FHM1dITkpUY1EvWWZPR2pBbUlrV3IwZk1FZlBKVzhWMTJBOElz?=
 =?utf-8?B?ZjN5YUNmNkkzdFB4QTd0S3FjblJUSU9Ka3poM3pLdE53RlhwemU4RCtsMHNS?=
 =?utf-8?B?U2VDbm1USmZaNElEYnRpMlRQNlFFaDJQUGJHeVlIL0VkKzZuWGU2Smt1aC9W?=
 =?utf-8?B?a2RjbnU3bGp4OTkzdjJpUVVENkNMQU5vK2IxS3hxUzFRc0xJaGNWY1N6eVBK?=
 =?utf-8?B?WXlRZmxQMHdWUXY2V3RKQ1dHaVNpUmh4UnErSTZRRERac1p3REt4QkY0UHdz?=
 =?utf-8?B?bXVSMmY5bmpWZzBhNDQyZStOZE52eUhYNURSTVNoOHM3TjM2bC90K2RTZ3Vl?=
 =?utf-8?B?S2p4WVBHWWFCY2NtbUxUbXl2dmlDSm1FemppalYvcWx4TDhkSHJTNzlPa1Bh?=
 =?utf-8?B?eUoyYW05elFsNG5XLzJyV3NPTkt6M1Ivc3B1UjR6WVNFaHd3R1ErdnYrSUhS?=
 =?utf-8?B?eENuWVBvUE9mdlpwbHplWENwcnd3SjRud2RkWkt5ZnN5WHBOT00xb1NmTEtP?=
 =?utf-8?B?b2pUaEh2bnJoL1JOY0lXTFE1VEdJWTRFUFF5NHR6QTRnZUlodzduYUtaaFRh?=
 =?utf-8?B?WU9nYzBoajFDK3p0TUp3N0hsQTRmTDZHWWFGU2Vwd2VvbVVIeGZaVTcrWXMx?=
 =?utf-8?B?eEJ4OGI2QkdvSkpnc1BWYU5yT1Rrd2lWNUNDbXg2TUJPSExVb3hSaHBLUzRo?=
 =?utf-8?B?R3lvaE1EQmQxVFUvbU9kY2lTb2tLNk9makhZT1FSekpQODFOc1ZBVlI0WWNB?=
 =?utf-8?B?Mm4zK3F2Wi9rSWdCbGZaTWs2N1hQZnlNM2pnVWtOdTVFR1I5dEQ1L1lSdzN0?=
 =?utf-8?B?aTNEc0NiYUxwMEhDWi9JSW94SWJMYVNKdjRwK0NjWnRsTkZQNkZZL2F0Vmh6?=
 =?utf-8?B?ZzlmdDNHSTRXQmZhS0RRbnVCVTA4NkZlTjZWZkg2TDBaVlhqYy9jaWlkbUdG?=
 =?utf-8?B?M3RvWEhNQS9Hb2dSVldFWFJqK21wZGVsNm5LRmFqb0JIeDlVWmwwR256NGYv?=
 =?utf-8?B?dE0yZFpOT2NxdVloaHd1aG52Z0llalNzc1pyYlZCeG4vWFBGZEdYV2dpeC8y?=
 =?utf-8?B?Q24vODZxc2dyVEplUjgvSGN6WlBrMVhNbkpsMW5vQ2pkSEhEVFRnWlpwdWZW?=
 =?utf-8?B?NlBVclYrRFg0SnFRU0tXUjJ3TDFuUXFsUEtVS2tZVUdBa1NPd3BxTVNaUzll?=
 =?utf-8?B?Y2pJeGVENlBISFFWU0o5Snk2cW9WMktURm9TdWNsTW16ekQwOUxyaktLSDAw?=
 =?utf-8?B?eDJoeEF2SVlsSjNnNlZBYzlMQ2FNTGFqci9qdFM3VVBQVXNBZkVRY0JIRTVq?=
 =?utf-8?B?d0EvM3NoQmRmek9IelNZTUc0TnNLUURva2ZOSVJWaHFGTjNJTFpjNWhVWE04?=
 =?utf-8?B?M042eGRlS2Q5dzR4dVBFOXBtclk3L21nL09wNWdiaXlNbGpUdThDN1pnaDVN?=
 =?utf-8?B?OUZqWHplazhuRDhzeldSZzZTYnpjT0VxYk5maHhwRTEwbytYSHp2TGdReUY3?=
 =?utf-8?B?dWIvUVBFWVV2WmhDMzBWN0lLTlUvMWRORE5Ma1p1MVVzeHRqVTRVRFBUWU1I?=
 =?utf-8?B?aTQ5Y29vRDl3bkt5M2hRYWlJTStGbm4yb05KREpJMnBaa1kwMUMwY3lwdjVp?=
 =?utf-8?B?RjRvTmhJODYwMG5aVmpNNDkzd1BVbmlvSUR0K0tKNitHUTVQQlV3RjMwUjBQ?=
 =?utf-8?B?ZW16dVZZWXdzSzBRV0kzRThFU0FJOUtpMWRUODJaZDJBRk9jZzlqdXVvWjl5?=
 =?utf-8?B?RHo2T05xa2I2N3V1WWx5UkZoNmNHQ3pyMEFsSUp2ZzBycEVVSjVlbnNkMTFU?=
 =?utf-8?B?T1VVdFlDcGlKY3kxN1pMUVdSZytzNkYrRHF0VllXTVhIODNueHlCUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7958bef2-7cb2-4d28-27eb-08debfd47533
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:53:55.5026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r689BpJK1RCrRG8ufkK/qt04JN43hcZDPGdfiVp64fAs2LfPFOzgqGKQs5yNCp4YvurATeYuyxQSZq0Ee35/Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7033

On 01.06.26 12:35, Florian Bezdeka wrote:
> When trying to run a local kas build using the kas/opt/ci.yaml option
> file the following bitbake error occurred as the following two bitbake
> variables were referencing themselves:
> 
> Variables:
>   - AWS_ACCESS_KEY_ID
>   - AWS_SECRET_ACCESS_KEY
> 
> Error:
> bb.data_smart.ExpansionError: Failure expanding variable
> AWS_ACCESS_KEY_ID, expression was ${AWS_ACCESS_KEY_ID} which triggered
> exception
> Exception: variable AWS_ACCESS_KEY_ID references itself!
> The variable dependency chain for the failure is: AWS_ACCESS_KEY_ID
> 
> The problem only exists for local builds as the gitlab project
> configuration defines such variables.
> 
> We can avoid the bitbake error by stopping forwaring the variables to
> bitbake. We don't need those variables inside the build environment.
> The only user is located in the deploy_to_aws.sh script, which is
> executed on gitlab CI level.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  kas/opt/ci.yaml | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/kas/opt/ci.yaml b/kas/opt/ci.yaml
> index e1466a0..01d5c07 100644
> --- a/kas/opt/ci.yaml
> +++ b/kas/opt/ci.yaml
> @@ -23,7 +23,3 @@ local_conf_header:
>      IMAGE_INSTALL:remove = "sshd-regen-keys"
>      IMAGE_INSTALL:remove = "expand-on-first-boot"
>      IMAGE_FSTYPES = "${@ 'ext4.gz' if d.getVar('MACHINE', True).startswith('qemu') else 'tar.gz' }"
> -
> -env:
> -  AWS_ACCESS_KEY_ID: ${AWS_ACCESS_KEY_ID}
> -  AWS_SECRET_ACCESS_KEY: ${AWS_SECRET_ACCESS_KEY}

Check the introducing commit 0e027423275a why those two are probably
needed for bitbake as well.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
