Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2052.outbound.protection.outlook.com [40.107.104.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F7F13DB88
	for <xenomai@lists.linux.dev>; Fri, 17 May 2024 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715965896; cv=fail; b=Wen+24DaHEj+qC628AJ1QdAMAmcHGcw5W4nPj6TVg+bcdMIC8lg78SSYATpPoAZSrHegIQ5klU6yay47k/lxWU3bRHc/MwxdSA6zEfJPfOrODL+q3/brYzJytqx9IdCCI2wikNhbW3Y2s7VzP4sPET7kTWV7rUvsh6UcD/HlU04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715965896; c=relaxed/simple;
	bh=CpE2c7GU1sgvEBhUB9EBvxAwxnIuz1QGDf6ARB/jgYw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=isP+8b7YusgAO0RVGC0RpTnOXAqeNd/lRwov6RQuMQUBBRPrIk4Cd3Tps/Mu0f51tN4Yyl+DICCO+PQ8FuIHgAn/3w+l9k+keBOS/G+VejePELtZiBjd1XvsF+2+I/3DWdRDr+/v4wucHZ48Y4ubG+75WPZyKRSKUb5m9Mh7z50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xuCtWLA5; arc=fail smtp.client-ip=40.107.104.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xuCtWLA5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDrE510Lq0yE9ZyqQP3xSgBRdV0lcIV/mWwZHNz0OLlBIqZBTw+1YO3Vm4WI9eIInJRqrjTUKkuKsreBti/YmlCa0d2OiocgiF08QzKTm3GmQ3Xeg8Xl7jdkjIbW8Xd7O9bV6KTLMFI6myvk+GNurkJswIpcB9LAa8F6Ga86XkSm42oP3NFNdHjJTLldQBoFO4IHrYkMcg73R0FO3zMzobpultPwQubpD5qbMhXj75QfZJad7Mw8NN+TwcTHgaD1m86TLAAoLc6Wgtdb2nSrL9W+PoCGcPkb6tI+phm/Uw9+hzHnwrVqnQEZvqC5nN/6vP2QTYjYysI4B7M77qPF9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErslBrCYh2JkHtnpHrXsee+zxV6f6GXuQo/2IVpmsNs=;
 b=DojKnMeQ/fu0BmNFyXiIY6lZvJctld+qz7VfNenFnysfmsHsdSaut+JC+4IObLDakixejtTcWqNedM6sL1NAiWtnymSvrkBEU3zODZnibclCUkkrD4EgVqFBI5MqngRdWTIf+0ZpULFOOVqMbNt/R7pYrEVhkYqdoMJzr5x0/gYF7YS2AeD/2pY58LveBih3nZmnQxUUpPSQdavlrB1qeRHi9iBUBohCFLMFLjzhrQ4myWG5mamlXAW4UvQqe5HjWgjVQxj/YYXrADM+Y9q1yf4od2RFWRqofBvnAQ272FMXE4fQ1yg04C5rMzkeM6NrgFJ4oER2d0V7P/gQUEdjZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErslBrCYh2JkHtnpHrXsee+zxV6f6GXuQo/2IVpmsNs=;
 b=xuCtWLA584flOpCwWXpi86yyQGvDuDkgw3zyEBJ5mcEVPgxXUH3gsq9bMxgH48FNofQ369hRVJKfhvGzATSytGgIfsOa+BN1YkLZQyt3b5f+2FdQLnioFcYDV/DNlNdCHWoUHu3OkEmhNW4wIiIDoDp47EoCH0pmmL6hq71yYOE2FOEwXn1rjX7bTZ1O9ox+oYXsF7TfS4v5ZRc6e0rH0ds1SFbYNoYYEPVzjTLFaIiVTVhfteqXm+U+vhV4x43HM+C6RS6lJHp1xbSjp+kxvzAcwmtBL+8xVZHA0YelbQs3Cn6uPzM1tFwlwP2/xNZBUOSXUbqGnGQ2zoYUjgBDKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3574.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:131::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Fri, 17 May
 2024 17:11:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 17:11:30 +0000
Message-ID: <8a950188-ce63-42cf-96e2-ea767fee9c47@siemens.com>
Date: Fri, 17 May 2024 19:11:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] prepare-kernel.sh: Emit architecture agnostic
 changes
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
References: <20240517133603.17554-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240517133603.17554-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:610:b1::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3574:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d785e4-3db7-4e83-31f2-08dc76946532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0IyQ2M4NmI0eXZkbTVxY05DWDJzbmZLRkFZM1lNeWJFTFBub3grUDl4L0c5?=
 =?utf-8?B?TmtRNmlJUFQ3ekZYaUVISkVDd0pkWEF6amwyaEpsWHJQZkNFNzNJS3cwQkEr?=
 =?utf-8?B?UmxoYnZ0cnNVaHo2R3pnMmsyMndLbEZ0eVZvY3VMVVE3c05GZ0ZwSENMUk1J?=
 =?utf-8?B?T2VsdVdvQ3BkTFFmREY0aGZEZ1hMcVVhRjVrY3Zxby9KZmJHRHVsU3hkOEF2?=
 =?utf-8?B?MlRkdGFvZC9kR2dvSFRJRnk0cjM0SFIyd1h5YlVXY0RwMVJBUzVqdFp2M2JI?=
 =?utf-8?B?S1pRZ2RDeXJxeXQxTGk2NG15d0xSRG82Y0pDcmtuaVZYaEM1aU4wRXZQWUpW?=
 =?utf-8?B?WlJ1UkthSlExL0hVNlhMQko2VkRIekJZd2lBMEtxdEdGNHBZWTA2NnU0dHA5?=
 =?utf-8?B?L3pTUmpXNGhRVVNwMms0V1JTUzdsMjRtSWpFcUxsRGVJTU1oRDF2Q2FXL3pD?=
 =?utf-8?B?N0tYOWVkdUw2TGk5YmdobStXUmtMektpaG1uZENWc2dSNDltVUo3cGpyT2Fz?=
 =?utf-8?B?OXZkRmdkZ3pKWWllUitPL3ZQcnQ0ZHdtVXVXQUF6bFZrbmpoSWo1cXhKNlZQ?=
 =?utf-8?B?bUFiTjhNdjdlcFJpUjRyQXlkT3JEcW5ROFhxa05rU3FyNmZmL1NMVEJxSkRW?=
 =?utf-8?B?cGVKM01nWGlSZXNoU3VvQldrMUdXSkhmSkNGS05pcU03RHNNOCt0VTRmMmZy?=
 =?utf-8?B?LzZmdTdjSDRnMUtmWFdkMVgrUjdRQkNqWGtsdnBpenpvQ3V0aWJSQWtVSTc3?=
 =?utf-8?B?Z0NXazR4aUUrZmRmZlpzOUFlK3QwNlBicTBPaEhKQUNlVkl4NmF6WFh0dXZJ?=
 =?utf-8?B?Ykw5a21RRklDZXVEMWE1YVlVbUQvNUFHWUNGdkpub1BnZ2RPb2plbmNjYVAx?=
 =?utf-8?B?N24zVzVIWkMyeVRqSjBoTHJVZDQ5dHVnM3paUy9LaXlQT2dzVjdRQURtRFg4?=
 =?utf-8?B?aGwwWDI2cTVtb2VZMGl6S2VpL1hwdEYrSXYvM0xoMmJobk9DV1Bnd0swVDVa?=
 =?utf-8?B?dHkxaURpZFdlOWs5ZC9oR1dNSXo0Wm5LV1NOYXRFT2UwTEJMa1FzdFNYdE00?=
 =?utf-8?B?VmpxYzlOaDQyeUNiSHExa3VFemRTQjhPMWNNcG1IMmUzTm9sSC9xS2NXS2NY?=
 =?utf-8?B?V3hZZGZGQ0kzbFhabXFHdGRPV3U0T0h0SEVXd1dEYW1xWkx4b3o5L1hVYXJl?=
 =?utf-8?B?ZDlDZ2MrSSs5TExCODBwdk4xZlJ4R2ozYTFXaGw2YWJ2TUFWV2pKL3Q2R211?=
 =?utf-8?B?Z29BRGFOcEp5YXNnOENjVVZaRmxnUStwSlJkNG5NdXFCVjNhTkJvNEYzOU56?=
 =?utf-8?B?ZEkrVm9jRS9TZDNtTENYdmxxVEJkU0lTNmdiRDhxNjdiRkhnTVd2UVI4RkR3?=
 =?utf-8?B?TmhLRy9tQS8zemxGRXJaNjRTdU5zZkgrMkhzWTRaYkllTnl2a2FTNnp3Nm9n?=
 =?utf-8?B?M1AxOURLOFNCU0F5V2ZsOEVVVmU1S1RlKzYyak1jNmgwRjI1Y3lRejhvWFBl?=
 =?utf-8?B?M0lLSDRNMEN2ZjBpZmo4VzEzQkxFMkViVkp0QjlmMCtHVjB2S005dXdLd3J1?=
 =?utf-8?B?UlkzN0xBcDhVNGRhdW5WNWVyR1hxc1lmZlBYT3VQMHRlYTNFRDdLUisxdUgx?=
 =?utf-8?Q?r0JQ2Ra9XOBWojNymJsuJVUyh10FYYN9HkdV6F31ICfM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MC9zRnZidytwL2o2blBEeHRHRC93ZzBhNFN2czRLKzVFNjUwMEZrbU5nRG5G?=
 =?utf-8?B?RjRZcDczbEtqaFNTdWlKa2l3eFk0RzJhc1UyUEh6WjVEaXI4anh0TUtDamZ6?=
 =?utf-8?B?K0U4V1FnRGhvV1VQdEZiREpOR3RzUkxOdkViWTJ0Ujk2NW44LzdXOEZibzU1?=
 =?utf-8?B?dHFrS1pmbTBOUDlhNkxRcngwYkpIaW91aU83WENOWndMUUdmMDFHMXd2QW9o?=
 =?utf-8?B?RDlteWl3S1lyRFpuNmx0a050TnpTc0QvUktrYVQzQzZnYitubkcraWtxdlBu?=
 =?utf-8?B?cGJSSWVZdUpqbXM3ZmNUMklPVkFJM0RST0RCNER2NkIyU2hlYzlHOFRMcTBm?=
 =?utf-8?B?dFdsN0ppZGFEcXNZMjJQVmNUYWQ4QXBqWlpPb2l4WlJtdDRSOWFSU0tjVUhm?=
 =?utf-8?B?dFFEc09YNGpvM2xNOGpFN0RhUWtKbXgzTU0zU2treGxPaWhDY0NjUUxNOWVS?=
 =?utf-8?B?eUVYdHhVenBLbzRxc3JMcXhoZmp3K0pjeHJDcVQyNjJCcG9tL3Izd2ZyS2c5?=
 =?utf-8?B?K2VaWjk0T0dWeVNpT1owLzhsbEJiN3dpNE1udWhrQVFYQTNNK3R2WEdrK1NJ?=
 =?utf-8?B?RXZuRlUrTHZBSWNyRmdWYVV6L1c3R2hxcUhFa1prTTVjTmFxa29ybU9yUVJD?=
 =?utf-8?B?eS9HMHVGZGdKNjA2cUkzZHJqcUQyT2UwV2ZJc0NEL2JCWTdueWxxZldGR0t0?=
 =?utf-8?B?TUMzUTBjaS9HR3p5d0tKZ2RGd01XM0lORk5RUHB0QTB2U0s4eVN0MmU1UTNp?=
 =?utf-8?B?NG56RHc4dGNSRnFVclFJcjdocVZtOEtqMFZ4d2RKQ0xYc2g4dmV5cHBYeTV6?=
 =?utf-8?B?NkRrcERhY0NadlArT1Q5MVNrbGhpRkJEL0o1cnBrandTajZ5RlltYmRLR0hU?=
 =?utf-8?B?dVBQeGhNM0RYOEd1NkJDdDNVdFN6T0FFQ2NQOTV3YW9OQWdoWjdlbkpKVWRa?=
 =?utf-8?B?c1lQZVUrN05OWGJzU0IxcTVybXVpWFZ5TVhPUWhNcUk2ZUttMm9mSlR2Sm1w?=
 =?utf-8?B?NVlFNHFXQmVsak55Ui9ESlg5RFY0dkJZM2s2YjhHRE5hMmc0aDdyY3FaRmN3?=
 =?utf-8?B?V0ZnN1dzeEw3NlVmd3orUXEvTlloaHVZWGhRRGgrZWRmOWlJdktQYWtkZEJH?=
 =?utf-8?B?MTRISUhjelJLWFhxWkJULzREbHA4QXA1ckJMWmkwRUFETU9yekhOcnY5K0Z4?=
 =?utf-8?B?VG1KM3VLMGpnSFhBeUN1RGNxR1pRTWduTWkrelRQQS9iMFA2TDdFODN2ZGxO?=
 =?utf-8?B?RWJFLzhINWlabkFwbzFuaDZadzE2NEVCak9FcnVNUTYvY0czWm1DMzhzVFkv?=
 =?utf-8?B?RjB6akswRTZ6OUNOWDJIdXNreVhBU1NjSXFLUjNQeUNFdjQxSTkvbEtKRE40?=
 =?utf-8?B?SGtIeXV6T1h6ODJZNU5lZFp4MkU3RFF2Uy9vbUUwZlJXdFRvazQ4WXpBcE1V?=
 =?utf-8?B?Nk5tcjVhU1NtK0NUKzVRMEZlQzZ4c28vOGRqMlZXZFdjSjhpbStlcWFBcXF1?=
 =?utf-8?B?QTAxZ0VJd3dTZGZJekpqaGFvdUZyN3k5cjZwdmNoOHp6K3lKM2tGUEZmSHpS?=
 =?utf-8?B?VUVCb2JmTENyaGw5cEVPTXVSZ2xuQnRRb2ovS3JyLyszOVBpTDQrYnhGbFZW?=
 =?utf-8?B?bDRTNVIyRnlNZUdVUXF3MXgvM3p3MlgydGJBMHY0ajdvWWlGeVBDVVRPaG1N?=
 =?utf-8?B?Q25EWlNhR1cvUW4rMTZLTUNsOHIweVlnUXp0cng2UHRrYlhIR0xHelVHVy9Z?=
 =?utf-8?B?UU9ZVng2TDE0Um9VUFJrMlEyN1drMDVxUU5IU3JqR1FGUjlVSDV0Tm1qVDRB?=
 =?utf-8?B?ejZxOHYrNHFIekYybmxqQ0VFY3VZNVgyUUwzcm1KalhyTVF2WFlCb1NHM3hQ?=
 =?utf-8?B?Zi9vRnpZeGtEUExDVjk2dFIyblhyQ3lIUk8yS0hSclBxa1BXNGNUdEtOdmhh?=
 =?utf-8?B?V2dteXVFblYwV1pRa2l5Y3lzUHdOV2VFbmMyWXRMUkt5aEVsb1YzRER0aldO?=
 =?utf-8?B?d3UrYVNIM0REZlFmVnE4ejY5amFWNmpOUzJRaGI0ZzFTelNkMCtLbjU3aFg1?=
 =?utf-8?B?dk0rQkF3VnMzbC8xZmVkQlVJdG5GZWFtUUUzem9GN1o5WHVDOWFTZHpKTjFR?=
 =?utf-8?B?UFlTYVpERi9iZU1kNEowdWtSeTNuMEJmU21wTHF4RmFiR2lVWUlrYlBtMEpI?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d785e4-3db7-4e83-31f2-08dc76946532
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 17:11:30.5490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: teFSrfk2CByP1VUpiQmDW0bLzgSa60D+XNE3yMfqMvA7I43KPM9syzdQSFP4NocmBaWgoJjSY6dQk5++KnsBIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3574

On 17.05.24 15:36, Richard Weinberger wrote:
> If --arch= is not passed, emit changes that work on all architectures
> supported by Xenomai, currently arm, arm64 and x86.
> This is especially useful with --outpatch=, the resulting patch can be
> used for any architecture later and makes maintaining and building
> a Xenomai enabled kernel easier.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  scripts/Kconfig.frag      |  2 +-
>  scripts/prepare-kernel.sh | 56 +++++++++++++++++----------------------
>  2 files changed, 25 insertions(+), 33 deletions(-)
> 
> diff --git a/scripts/Kconfig.frag b/scripts/Kconfig.frag
> index b76d25e53..3c9ad2b9f 100644
> --- a/scripts/Kconfig.frag
> +++ b/scripts/Kconfig.frag
> @@ -16,7 +16,7 @@ menuconfig XENOMAI
>  	  Please visit http://xenomai.org for more information.
>  
>  if XENOMAI
> -source "arch/@SRCARCH@/xenomai/Kconfig"
> +source "arch/$(SRCARCH)/xenomai/Kconfig"

That was likely there for historical reasons. Removing it makes things
only simpler.

>  endif
>  
>  if MIGRATION
> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> index c9aeeb4fa..25f3b4a7c 100755
> --- a/scripts/prepare-kernel.sh
> +++ b/scripts/prepare-kernel.sh
> @@ -249,37 +249,24 @@ if test "x$output_patch" != "x"; then
>  
>  fi
>  
> -# Infer the default architecture if unspecified.
> -
> -if test x$linux_arch = x; then
> -   build_arch=`$xenomai_root/config/config.guess`
> -   default_linux_arch=`echo $build_arch|cut -f1 -d-`
> -fi
> -
>  while : ; do
>     if test x$linux_arch = x; then
> -      if test x$usedefault = x; then
> -         echo -n "Target architecture [default $default_linux_arch]: "
> -         read linux_arch
> -      fi
> -      if test "x$linux_arch" = x; then
> -         linux_arch=$default_linux_arch
> -      fi
> +      target_linux_archs=(x86 arm arm64)

Is there a particular advantage to use a bash array for that, rather
than just a plain space-separated list?

> +      break
>     fi
>     case "$linux_arch" in
>     x86*|i*86|amd*)
> -      linux_arch=x86
> +      target_linux_archs=(x86)
>        ;;
>     arm)
> -      linux_arch=arm
> +      target_linux_archs=(arm)
>        ;;
>     arm64|aarch64)
> -      linux_arch=arm64
> +      target_linux_archs=(arm64)
>        ;;
>     *)
>        echo "$me: unsupported architecture: $linux_arch" >&2
> -      linux_arch=
> -      usedefault=
> +      exit 1
>        ;;
>     esac
>     if test \! x$linux_arch = x; then
> @@ -333,10 +320,12 @@ else
>     cd $curdir
>  fi
>  
> -if test \! -r $linux_tree/arch/$linux_arch/$arch_probe_header; then
> -   echo "$me: $linux_tree has no IRQ pipeline support for $linux_arch" >&2
> -   exit 2
> -fi
> +for a in ${target_linux_archs[@]}; do
> +   if test \! -r $linux_tree/arch/$a/$arch_probe_header; then
> +      echo "$me: $linux_tree has no IRQ pipeline support for $a" >&2
> +      exit 2
> +   fi
> +done
>  
>  if test x$verbose = x1; then
>     echo "IRQ pipeline installed."
> @@ -369,19 +358,20 @@ case $linux_VERSION.$linux_PATCHLEVEL in
>  	    -e "s,@VERSION_MINOR@,$version_minor,g" \
>  	    -e "s,@REVISION_LEVEL@,$revision_level,g" \
>  	    -e "s,@VERSION_STRING@,$version_string,g" \
> -	    -e "s,@SRCARCH@,$linux_arch,g" \
>  	    $xenomai_root/scripts/Kconfig.frag |
>              patch_append init/Kconfig
>      fi
>  
>  test "x$CONFIG_XENO_REVISION_LEVEL" = "x" && CONFIG_XENO_REVISION_LEVEL=0
>  
> -    if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/Makefile; then
> -	p="KBUILD_CFLAGS += -I\$(srctree)/arch/\$(SRCARCH)/xenomai/include -I\$(srctree)/include/xenomai"
> -	(echo; echo $p) | patch_append arch/$linux_arch/Makefile
> -	p="core-\$(CONFIG_XENOMAI)	+= arch/$linux_arch/xenomai/"
> -	echo $p | patch_append arch/$linux_arch/Makefile
> -    fi
> +    for a in ${target_linux_archs[@]}; do
> +        if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$a/Makefile; then
> +	    p="KBUILD_CFLAGS += -I\$(srctree)/arch/\$(SRCARCH)/xenomai/include -I\$(srctree)/include/xenomai"
> +	    (echo; echo $p) | patch_append arch/$a/Makefile
> +	    p="core-\$(CONFIG_XENOMAI)	+= arch/\$(SRCARCH)/xenomai/"
> +	    echo $p | patch_append arch/$a/Makefile
> +        fi
> +    done
>  
>      patch_architecture_specific="n"
>  
> @@ -404,8 +394,10 @@ esac
>  
>  patch_kernelversion_specific="n"
>  patch_architecture_specific="y"
> -patch_link r m kernel/cobalt/arch/$linux_arch arch/$linux_arch/xenomai
> -patch_link n n kernel/cobalt/include/dovetail arch/$linux_arch/include/dovetail
> +for a in ${target_linux_archs[@]}; do
> +    patch_link r m kernel/cobalt/arch/$a arch/$a/xenomai
> +    patch_link n n kernel/cobalt/include/dovetail arch/$a/include/dovetail
> +done
>  patch_architecture_specific="n"
>  patch_link n m kernel/cobalt kernel/xenomai
>  patch_link n cobalt-core.h kernel/cobalt/trace include/trace/events

This indeed looks like a valuable enhancement.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

