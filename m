Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011054.outbound.protection.outlook.com [40.107.130.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA1535972
	for <xenomai@lists.linux.dev>; Sun,  6 Jul 2025 09:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751794456; cv=fail; b=YtEM9VIQ/HNTRBT3ZJ5qzcXFor5me+E2ucR8FPObpx4/Juzia3P8jPQ8LOS4dFsBeMBcRyS07Mmuve42yGAqaJvxeitgSi7dqbxfa/gxsr4PmnngRkfqEh4wwWB5qqGzqS26pkyEvMf1EGkqvgXtLHrpvS7tLS7kFPlrHQNRbfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751794456; c=relaxed/simple;
	bh=aLS22zOKCThtfZG8e4hqA/NvF5bfgz9Bv6fVdaCLCoI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=szkHqgUXUDoQe8uwn1HOik6rL773W36X7ihNp1veAh2EDYJStjtZvKh48S7UDXuiMymEZj0l7WoUIqeFXdaW3MJYBe0ayRhdukIEYvNWbm2E231NBvoifGzwiBMiFtIBlQhtAaJZX9Yi5Uh1Gzz1o+d336VG90i99VFohTq5Brg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=AcqVYWAZ; arc=fail smtp.client-ip=40.107.130.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="AcqVYWAZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LB3NsZYgtwZ9XhywKFDtD7HizbxIEm51xKU1MxFO77Mfp1jDu1JBIcuvaM0mURrbjbbytxIs1RdBXXA0awjqNHUXBRUO/Wa6As4kh2sKpzX5MvjeQuzxXLwb7khNSSAoGlafHGcDNGmN4BX7EHAuyFad4Hv3oFBxwACKcz456emBuzYgIIRRMstQbMtlcO9Z3I4tf4cz470kUJJ9DLlkoh3I9cUkySUovR/p2SJzLsF/N9eSsJYZYGjSVT+98Fu/z/rWFkoEa7u3BBPoQEAXNFbm6QwJHgsf2qLXfzHJtu9cpB4ArQjs5s8Ko6GWh20PZOdZVr4kcRK568sr7eutRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5boUiQXlWOAwijx0+fOfttHJ9JL7jBwPAUjlUt1umrc=;
 b=rNdtjBfI8uxcB7F4Ibwo3HrbnQc2vXH7lJ18w3Bbtg2UPQqLU2ZpMSIEv2q/WEIl5sfOZ6/L6trIU5VJxqOmLIknDAJqO2kbnkKJRY51OY/PW9QR6UwUBqUNjLTMVdGBWunufgrFV07IMKCplOx5pvMPU+8zdnhsI4jyXZjZNwp2TfQORnmd3wMHSVl395agE69zVpZ48+4zo7ElUPLxLO0TvQbKNtCWLKO4qrKLFvPX/VoZwYufW6fLxHBShk+3LOn95sdaQruCDNdmN79T0WgNA1/ztxaDL1vgRo1Dh5/q1Sx6CljHKdUntCO9Z70+oS4WZVUU50OpTw2jxoXFWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5boUiQXlWOAwijx0+fOfttHJ9JL7jBwPAUjlUt1umrc=;
 b=AcqVYWAZ1hwFZ6mBczU+eApgbCUVX8f7z4eBbQX7ud1L4mQ1Fss8awjhOpLw4geqA3QypkHyGwcPAbnQVjZYnSqmKsxr7caL3xFav/OGbcFnHum4fpiav2zjPZOJo1LEbrSSj6naCvW/f+1Qz8gcEsxoaUscs5/HfZVMiRGBBWt0KiCF9W9ORnd6h5ffkWM6IdRl/0G/sMZUzV0sNxfGwdf2GWMwNGc93kYxsnj/yuGq+hMzbBTREpE3GbfwoSPE8ofn0qR7Eb3/kQi6nLcE6ijmjP7ZTIZ/RLprRRWNWOk90auVKp/qazPmgVkEn8OfDxxTnCiGBwFOZol1LW1R+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7585.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:564::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Sun, 6 Jul
 2025 09:34:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.024; Sun, 6 Jul 2025
 09:34:10 +0000
Message-ID: <3de47756-65c5-4eea-8304-dc56f70aa8e0@siemens.com>
Date: Sun, 6 Jul 2025 11:34:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boilerplate: Replace strncpy with snprintf in
 ancillaries.h
To: Haiyang He <aspirestro@163.com>
Cc: xenomai@lists.linux.dev
References: <20250705135610.217774-1-aspirestro@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250705135610.217774-1-aspirestro@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0282.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 359f7cfa-bc28-45b7-c0f5-08ddbc7042ad
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUVVck1xeHNyb2VDYnpIeGV2VXN6MzVlMDdZY1cyKzA4azhpRTJBWUNJTWZ4?=
 =?utf-8?B?dVlkcmY1ZmFSR1lYZ1dheE4vK1JpcFB6d09EZi8vU1Zxa29iSXlXVm1mbktY?=
 =?utf-8?B?MGhDK2RjbENJa0dzeVpMdnZmZ3VJTTVnb2xHL3V6dFVsZStYK1hWS2dtMXRG?=
 =?utf-8?B?ZWdkNmFKS29JbVRaZ08vRFJPNVArLzE2Q0Y0VEpvVG9QVTRkcnlFMVYvOEYy?=
 =?utf-8?B?L25QQ0lyTUptb2t4NEFraTJrM2FkQ1BwMUR3cEYyYitSTjJpWWVrbHdKc2xt?=
 =?utf-8?B?MUhuSjJaWHBrS3lDVUxXc01wdFZ2bDl1aFRkS0JDNXFPUmoraVhaeE52TUZm?=
 =?utf-8?B?ejQ2bWs0L0ptbXhxbS9kRENmcUJWZGRheUZvL3ljd2VsTkJzOFd3QWNxd1Nz?=
 =?utf-8?B?Q21UcFduTzdINkNuZGZZYzhIUGQ3UVB3dzF6SW9wZjBWQ2FMVVJ3MGJod3dS?=
 =?utf-8?B?MWpHcllzMHl2Q0xNdk5MWHBOaHUvL0RCVVFVRjNrT0JjUm5MV0JtOWtyVDFX?=
 =?utf-8?B?UnZVRmtqMVB0ZXJ4czR1QVRMdkM5UHhOeW5WRFVDZ1lqQm9uNXRsUUVjbE5v?=
 =?utf-8?B?a3NudEJINWY5Uy9HbFlBUEd3WDlPKzQ5REdBd0o2TDRWVWwwem1ic0d4TXRq?=
 =?utf-8?B?bm5PSEwwUEtDNzNJeUFZcVN2c2luWjBhbjZIaTNtKzVNdThsdnBRditsK1k4?=
 =?utf-8?B?QzFOUmx2YW5ZQ28wRStOVm1YdGxzWklBVVZmcElsTFQvY0dIUU5zYkI4U2Vs?=
 =?utf-8?B?QnQ5dDBqQkVaQmRlZk9obWxvaGdaSXYrSlg5Q2V1d0I0M3RBb3RSOGlkVGd0?=
 =?utf-8?B?emZqMGxOWlRHZEJMU1hLRHVlZE1ERWkveTQ5aXZKc0xVUTNIVnI1VTFDSk9X?=
 =?utf-8?B?MFpGUHVFaEtwc0ZMamdkTWdHbEZHTFFaSk4wUUxWb2ZZMFhaUGR1d2pwYU1K?=
 =?utf-8?B?cFdmYXl0aG1kc3JNaDFOTkgzQWFVZHpjeU1SMmlEc1krcThtRFNPQ0gvNFM2?=
 =?utf-8?B?azlqdnpJK0RrWHlaU1NtcU9VNTlxbTBrWGxzRGZPZjJRZ21EMGlSZGc4TGI5?=
 =?utf-8?B?a0FjbUxQakdtQ2dRajJubVlrZy9FZEYrMERJUzYwVEdQR2lzSmxveHRIbmJp?=
 =?utf-8?B?ZlBMSUtvWmxWZWhwTG5lYXV1SzhsU2JuVEVRdlQxQlJ2SW9oTS9MeEJ4dkhF?=
 =?utf-8?B?bkxSdHZ6NFR2MTlOOHdicFpRdVhySENDaER2eWZjZE1La1MrUWRHU0dDUTNJ?=
 =?utf-8?B?bUcvUklKQlZwcXF0MERvRWtTVkNaR0VmdkVoK0lFMWFxSFdKSDErOFNvYjlQ?=
 =?utf-8?B?bWxZcDdRdjM1T0V2eklrQjJNdWNrR0VMbDFIUUtTVEFsR2RDYUVzSlRYZTBH?=
 =?utf-8?B?VjRsNkp1UUxKdlRQcHBzZU1HK01HcHQxdFlpejFZdWpNUnpjN1BMZTlTd1hS?=
 =?utf-8?B?VUlZTGROMCt2WlFsYlJNeDY3MGVnQkVHVzNXR0FlTDZyWW5DczlPdGsxMWQ3?=
 =?utf-8?B?Y0JzT1l1cStldTBUZS9YU3ZqZUI5aTI4YU03YWlUMEdKRDZ1OWVhbHRSejBo?=
 =?utf-8?B?dTdBQkhXRm9hOEx3TVN1dnltNmN6NTBrOEI5UktadXc1U0NaVkphbkdHQ0xT?=
 =?utf-8?B?S1FBRUxJS3hpTGNQaVZ5YU9ZeGI5OGlqVXZwdDViNFVJYS9uVFdZWjBuMnRo?=
 =?utf-8?B?MTh3RDVhQVpjUUhLSjljdlUvVnE0MEpXS2M0ZkhBMTJRc3BYNEEyYWpWUXBs?=
 =?utf-8?B?NS9jamo2blFwbHVWTmVqcmpHSVRmc3hjbGEwYmtUN083eUNLb2VzOWdic1Yz?=
 =?utf-8?B?VzQ0VUFCdzFzQjd2ZWorVGJvVnYya3BHVXM0Q2FPSXVRNFFwcGpZcW8rYStM?=
 =?utf-8?B?QUtGVnp5YzIxazgwODFFT3J3elgrV3djajdZOVZ6YzcycVZuWk9WUjdYNWFC?=
 =?utf-8?Q?U4ez4roDx64=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3RhdURDSmlNOVhNc3FBMHV1L0FHckxMZW5uVS9OTnRGNDNRdzFHTE1sQ0tE?=
 =?utf-8?B?NDBJdCt6dFV4NzJRL1BDaVBTbDNaYjBDaHlOci9RODAxc3B0RWZ2Q1dKNDRP?=
 =?utf-8?B?STVyODVmUHlITTVWeHM1TXMySEpQbDJHa3RWWDJIQVl2T2x1VlI1VC9vSjVL?=
 =?utf-8?B?ZWpJbFJGWlRlbzFMQkNJRnZCUnVtMjE4Q2JSUERycUdabEdubWJDZmgwbHpi?=
 =?utf-8?B?cTdFQ2dybE5vRWVtNGRXMlpCZ0N3anVIR2hiYUxGRmVIdllLemVIYll1N2VW?=
 =?utf-8?B?UkF3azU2c3EySGpiSTl0bVI2Vyt5SXhuVW9mMlR2aGh3QnpUM3NRN3pVYzdv?=
 =?utf-8?B?azNRSG9DR0pidmlYOXVLZ3lBcWRyRlNmK0FqcVo2aW9WUElBVDZuV1hRSWtR?=
 =?utf-8?B?NjIzak5tTjRtZjM2bWd5cDRVU0FSd1VJNW1aQWlPQjB6LzBqNkpHNkhYL2JG?=
 =?utf-8?B?N01VUzVUOTRWWnlaUXBDVUtGQzJFZjFCQThBd2ZqQWNyaW5TMkx1Qmp0bU5L?=
 =?utf-8?B?czgrUzVQd2dpM1lPQStId0l5YitPSllhd0ozZUZGNVJVMy9YMDRIUmxSNlVW?=
 =?utf-8?B?N3NVbmZ0cDdUaE5vajZFVVVEWDlLSnUxemJ3VlBXZDYrTGFxZUlvaGNMV2VR?=
 =?utf-8?B?REduV2drb1lLWEtJdjBwZEZGdm11eUdmdXpuUzJLZWdRTE9wS0MrRjVGQW9W?=
 =?utf-8?B?elpYTVZtd25ob1VXWGNSeTdrWk5Ra2hMOXI4OG04djZXbE9wREVhVkY0eEtH?=
 =?utf-8?B?allxRGcweEl2R01COE8zdXdxNEZ0TTBlTnkvTnBGbGVUeHZFSnVncWRMekpm?=
 =?utf-8?B?czNTa2laa0NRSGl1K1Z1SGlLMWE4TmEyYmZvaFFJbVFPTVFLSGY3SU5HMXJu?=
 =?utf-8?B?NldkZnE3QW9DWUg0NkdjYWhWTXpYOFh6RitTdElLTzZDRlBEcWJxRmJ4Uzc3?=
 =?utf-8?B?eUdESlB0V0tlTkhJRDlKS0lnZmNIbDF1WWlkbFRVdk5wbzczcW1CRllSaTND?=
 =?utf-8?B?U1NLcjVpVTd4ZnhIYUVpT2VYdk8vZUorakp2R2JDeWhBM2NRUWlHTng4SndO?=
 =?utf-8?B?ckR3R3lNWHdERmhhRlJpNkpHWHVPbnNjYWx0SDJxbXVFRytjcTNHMGdPNUE0?=
 =?utf-8?B?M2NLMTNOcE5pS09PNXZiZm5WalQyY0pERHl1cXZKSVFJcFMybHU0SW94UXpR?=
 =?utf-8?B?czMwQmZIcHllK2l1R1BPc3g3UXhJNUdoZm02S1RieC9NTGV1NTVLQkhWSllh?=
 =?utf-8?B?ZHR3ZWtGNTY1SDJucFdsQkxXZG9tajl3UjlKdlYzNjNUK0h1RzN4b01aQU5Q?=
 =?utf-8?B?bkxpVzA4QjgySXhlOGxMazRLcDlkc3NjblVGVWpyUDlKdGI3MUR3VVlxU09P?=
 =?utf-8?B?YnJaNVk2R2pFNkpzb252cTlzaExhMXRmeWl5bkxhZEFJUzRDWWJiN1M4d2NU?=
 =?utf-8?B?MUpGS0EvVlRuVXp3dnJONlpDZmswTURnMFdJTVNuK2p2TXMrZG5LeXU3cTQx?=
 =?utf-8?B?ekdMVmdtVXl4MGVxSXV0c2RKWURRMXlJRzlDMzF5RWMxdVJDajQ2RE5zUno3?=
 =?utf-8?B?QVdtVnBLYmYzWFFMalk2NWc2ZTNvdmkvSndGRWlDRURrc3ByOStwR3FORXFz?=
 =?utf-8?B?c3hwajBOZFRrUk4rL2NpOGJhVEU4cDlkUVpMMC9pV2tVSjVyWmFnd1BabHFH?=
 =?utf-8?B?cXdxSjlJTVJGV1dMM3B1Q2M3UWlzUHdqQVh0NjNDeGpnS2NPNlM2M0YyUWdL?=
 =?utf-8?B?R1g3M2twUkM1VTRZaEg5UkxrZFB3RCtadStjOHFWdmd2YUJqbXVMSlVVSDBm?=
 =?utf-8?B?Y25hYURHZUpET0FOdFJ3bDZOVGVabFNIblJrUy9GVFJOaXF6VXNFSmpWcmlI?=
 =?utf-8?B?ckpaMlYzTTNnd3dZNVZrcGZ2STAreEsvdUxMTTRTQUZkSkxPalAybUYzTy9q?=
 =?utf-8?B?VFFhcUIzdFgxSFdqUllxTnBQM0tOQ0doYkZIN20wSGg5ZlFyaFk5Vm54M2tT?=
 =?utf-8?B?azM1VXBVYmFtSVpTQjNsRWI5RTRJRWRTdHF2SU1CcDVEZUlTK2QwbCtpMUJl?=
 =?utf-8?B?ZG9JOVRlK09IN2hTZ0tmbG9aaUJlMExpSHUrT0FPLzJzaVp6bFJEdHk4RURC?=
 =?utf-8?Q?DJ4jAdDZDQ2UmzMvrLx0kMYH4?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 359f7cfa-bc28-45b7-c0f5-08ddbc7042ad
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2025 09:34:10.3953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9+VQFY+Wu9Lo2sFijNODERtvfL7hQB3ddRqXslSYv6hmyiVh6ox6Mvvh8wt2gVTRdtG3AIVyK5esfs6AWzG0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7585

On 05.07.25 15:56, Haiyang He wrote:
> When configure with --enable-registry, it fails to build regd/fs-common.c
> caused by strncpy. Using snprintf instead of strncpy ensures that
> the destination buffer is always null-terminated, preventing potential
> buffer overflow issues and compilation error.

Thanks for reporting the compilation issue. But this is not an overflow
issue, just a confusion of the gcc in Ubuntu 22.04. We are properly
terminating in all cases.

> 
> $ ./configure \
> --host=aarch64-linux-gnu \
> --build=aarch64-linux-gnu \
> --enable-smp \
> --enable-pshared \
> --enable-registry \
> --with-core=cobalt \
> CC=aarch64-linux-gnu-gcc \
> LD=aarch64-linux-gnu-ld \
> CFLAGS="-march=armv8-a" \
> LDFLAGS="-march=armv8-a"
> 
> $ cat /etc/lsb-release
> DISTRIB_ID=Ubuntu
> DISTRIB_RELEASE=22.04
> DISTRIB_CODENAME=jammy
> DISTRIB_DESCRIPTION="Ubuntu 22.04.5 LTS"
> 
> $ aarch64-linux-gnu-gcc --version
> aarch64-linux-gnu-gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
> 
> The output of build error:
> 
> make[3]: Entering directory '/root/xenomai-next/xenomai-next-build/lib/copperplate/regd'
>   CC       regd.o
>   CC       fs-common.o
>   CC       fs-cobalt.o
> In file included from /usr/include/string.h:535,
>                  from /root/xenomai-next/xenomai-next/include/copperplate/heapobj.h:24,
>                  from /root/xenomai-next/xenomai-next/lib/copperplate/regd/fs-common.c:27:
> In function 'strncpy',
>     inlined from 'open_heaps' at /root/xenomai-next/xenomai-next/lib/copperplate/regd/fs-common.c:248:3:
> /usr/include/aarch64-linux-gnu/bits/string_fortified.h:95:10: error: '__builtin_strncpy' output may be truncated copying 31 bytes from a string of length 31 [-Werror=stringop-truncation]
>    95 |   return __builtin___strncpy_chk (__dest, __src, __len,
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    96 |                                   __glibc_objsize (__dest));
>       |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Haiyang He <aspirestro@163.com>
> ---
>  include/boilerplate/ancillaries.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/boilerplate/ancillaries.h b/include/boilerplate/ancillaries.h
> index c8c209deb..8de353ce8 100644
> --- a/include/boilerplate/ancillaries.h
> +++ b/include/boilerplate/ancillaries.h
> @@ -36,8 +36,7 @@ void __namecpy_requires_character_array_as_destination(void);
>  	({								\
>  		if (!__builtin_types_compatible_p(typeof(__dst), char[])) \
>  			__namecpy_requires_character_array_as_destination();	\
> -		strncpy((__dst), __src, sizeof(__dst));			\

What if we do

strncpy((__dst), __src, sizeof(__dst) - 1)

? Is the compiler silent in that case?

BTW, we have way more places where we are using this pattern, also in
userspace (lib/boilerplate/ancillaries.c, lib/cobalt/printf.c).

> -		__dst[sizeof(__dst) - 1] = '\0';			\
> +		snprintf((__dst), sizeof(__dst), "%s", (__src));	\
>  		__dst;							\
>  	 })
>  

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
