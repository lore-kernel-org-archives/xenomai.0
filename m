Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2079.outbound.protection.outlook.com [40.107.6.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD7E4CE0F
	for <xenomai@lists.linux.dev>; Tue, 28 May 2024 05:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716873732; cv=fail; b=duQqPipm8cjry2lCP7pUFooz9iPp5MmDJFjWEmaBD7QoC5W2H7eciw1dKOvPE5NUypdKL8Y7zYkhvkok/8NKiASem1iMAtYNdzCF+JypoP8YBuiEdjPw7xV+oQ932m3gXaO9r2Ec1neOr8n7+IcurYto9UrsWfi1Zs34foisAGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716873732; c=relaxed/simple;
	bh=3mz8S2F4T7WOoHKyXJaDLDK8pQMb+RLAX0KZFrMR+Oc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fYWC1J+/sbo0aGKnyOTsYbQd3vThn7717rUON28J5eU55MBPINkms5lajl4K7i8q0MuB20XYnOKRbtCAsQz+aaeGksrZnfwCQdRI+QotqgjJJsQuGIJ3t3ZOGVxaaLo2zFJ/e2oG0RvZkoAVWf/9eJFYmw22N9Aet4pp5xxUucc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=vlcupFlp; arc=fail smtp.client-ip=40.107.6.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="vlcupFlp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJUO/Opdqtg+AT6gHzYM4SQTdD9wIU+ePn4zM27njbGV9DncrumqV4zOHALeFMm22bUe8iRGZ3bLGFwcM1zuAdgPmh+vaU60dfGJoyn4KSNb2BC0t0HhgIyKcaqlC1NKW6yqMhBpLBMLvXJ18GM26+4uLVWFXzFLh3voHc45Afg6Ms3x1MP4YPIekMxBj9Av8J/C0DYJ4ipRtHELq9PNt9/7OwVvYFVyQQ2+4UBJWFVGKNrNbYAQ0qiHAL+Lv2MZJsBPTNOU9hDKvz3y2wJruSGy3DG3fwjuPQ1XZAPQuLsSwWpRtB9HUHpVsn4KwBxDdsFa5Mii+yxd7zO4Qe3MeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ys/0owmItn4/+Y2BQ266noiXOYP8BkG+cnPg28AViL4=;
 b=ZaRe1pozQDR1CA9Io4OFuXOMxia12Kt2VZsmgu/BJIEVjPx2N2aACHyw0bMWSb+tTWjeOTo1KNPDi52UuvYeDrQzSm7OBnA24TEnmshhRzZOJ4mguPBWr5f2PEsrK/DlEgKqxrm9eeFg+qsUiMtBY7hU2KznFslEBb/XQfY0N7RdPcxoPXdlTnla0jQccTsd+lxJn7WwDUZ9GwXwijdPwpZNDFwBhKUiC4t6YCfYWM0IzIM8ON7MnMrO/XgUn+t6wGkL9WHQFrWh2IIoSnW2z7BuW/ayJLbbXElVZ6iqYechr3wt0vdBbhBycI/pTpeRtkMfBXonymeCBDj03uTXkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ys/0owmItn4/+Y2BQ266noiXOYP8BkG+cnPg28AViL4=;
 b=vlcupFlpM5bI1Gyt8/ks0nWtSmU8ehWZZBBLQELk3cRrqWup5m2NmNnIcAOHaQEfwCfn/SyefycbXef7d5yp3vHTWh4by7mvgX68YqEHXcMaW1L0KEZJZ0gjA/FlnCdO7o6VHyRm/4UwDlkjg0CmtsKlPtNxO2JAdbz3pBLkQNg8jgvkV2LDIxDVorSN5TklZ2xbxSd+8Hr/aUrCp8ZXLFl5oYedrvLcxHJiJUiq0ywQ0HplseqKI6IYVRx81LSSr3jerTX3hQElWSMEyG0KE4Wt6YVsyWKmpwmr07wuXoQ9f7Pd6xBxFecCo8RjsouKtnaw6G0oVz+4L2bc+gJN9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3803.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 05:22:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 05:22:06 +0000
Message-ID: <5de1a72a-ce0c-492a-b5ba-5bdc659df4a7@siemens.com>
Date: Tue, 28 May 2024 07:22:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: rt_igc fails to bing an i225-V Ethernet device
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 =?UTF-8?B?VGFtw6FzIFBhw6Fs?= <paal.tam@gmail.com>,
 xenomai <xenomai@lists.linux.dev>
References: <CAH0t8y01h5W8Hsa=xvUJCyQM5VeA8CSTftBvLYrzbzQHenv7zw@mail.gmail.com>
 <PH7PR11MB749952ADE786FE1D78EA1A91F2F12@PH7PR11MB7499.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <PH7PR11MB749952ADE786FE1D78EA1A91F2F12@PH7PR11MB7499.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3803:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ebe138-9023-44d4-29f8-08dc7ed61d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjRCdkE4Y1RDcjd1TmZCOXBkMU9YejhXWXNHcFZ6SFAvbm1FVEx2ZTd1R09F?=
 =?utf-8?B?emJqNjNqb1owZlpZbkpRemhEQytzdlYyWDBpR0ZlZnFkVFE2YkVtVVR0dFVC?=
 =?utf-8?B?dXlvMEdGMmNnTWNLeCtOVXFsSk1CY3dJUjgvOU1HdFZaYlkzeVBWMXpwai9B?=
 =?utf-8?B?YTNsa3pZMGJWczQzQXluaVV0Q21PYXdaTm0yR1VkTG5jSkhKMzYyamhzSW5D?=
 =?utf-8?B?MEtISjIvYUtYRThzZFBGYUo1Q3N4bTdLMFRvb3VwK0pMd3pKajJlSUJ2T3pO?=
 =?utf-8?B?M2c0eDcyR2tSN0tYUVExYitSaUJMMTNtb0lNN3NYbEREWGJTYW92YjNocXRx?=
 =?utf-8?B?REpkUDluVzBneTByZjdSQnk0M2RDdXVCUnA4RytiNXNURlZaN0hrUGtnYThq?=
 =?utf-8?B?Y09mZWx0TmNhZzlYT0dnUklhbHB4VVZFa0tzNDlwYTExZ3M5ZkE5cjVCQlRZ?=
 =?utf-8?B?QzhIUERuT2RPSm9PMHBFZE5aMXI3R2JDemtsbk55ZHhieDFXRTM1akhVcEMx?=
 =?utf-8?B?SS9Ja2lWTmNSY1A0ZWZRLzJZWW9pbEZ5WTZpTDI1Z3FwZUxpeVBFWml4NGFY?=
 =?utf-8?B?dUE2UzR1ZnJGTU80eFU3V3hIUXNvbXdvVXZTcmx5UkhrQjFYM29UajVxMjdL?=
 =?utf-8?B?WjFIRDZjRnlBZ09ZVW9LNnpmVko0UmFxdXZiQmZpSDBHSS9GZ2MrZGp3QXBE?=
 =?utf-8?B?K0JxWnhwQ3VMVXd4UHdudFd1YWhOdUZnd1R1K0pHTmJpa3hUdEpwUGRFa1Vx?=
 =?utf-8?B?bEpxRk9ER0tjM2xFYXdGamNOV0YwMVRDb28wQmFqZlFoSmxjY2NueGZsTXFn?=
 =?utf-8?B?bGtmTEpoVEJYb0N6bjFrWHduQS9la2RpMnJDNmI3RWo2eG1JbTg5MDRHN3R1?=
 =?utf-8?B?YUU5ck9xNVBOT2RkUkJEUTZvSUI3VU12TDVHN1BYblk2Sm5sT2RNRHd2UWhq?=
 =?utf-8?B?YlJJTXhRTmRSU2VzZ3krbGZkMEVZdldrejV2eXhHOGtsb1VKWlF1eUVIU0FJ?=
 =?utf-8?B?eDNvNkxudnUrZTJpNnNhZGhwS1pwcmIzQS9YYytKNmJOM3diM3hvWkVjVVk0?=
 =?utf-8?B?QVVvYytZN04wMFVwTEI0a2l0N0RtUzJMZkt3Q0J1VHBPbk5QN3B1UU1oU2s2?=
 =?utf-8?B?Um8vYjdhYitkV0JXQW1QRE9oSnprbHFuWU5CUDNMTDhSSnVDdVJ5ZjYyU3ZT?=
 =?utf-8?B?VTIwZXBJcjdqdEhGYzJ3eDBGS2hPV0RzODQxVGNXeHB5cFIwcXc2aVBQUUxF?=
 =?utf-8?B?N1RzZm40VnYvamx3ZERRbGcrQU1hRUM2Y0xQKzlNWDNvV05LU1M4eThuTWlr?=
 =?utf-8?B?Q3NaNll0R3pyRlIya0paQnBFOGNEdFBvbnAyZlh0cktldVhOcXdKNG44ZCtq?=
 =?utf-8?B?NmtqRXVDdWVGQlBQbzNPVmMwSTVkYkN6Z1F2aXYvZmFyN3MySTJCY0lxamdl?=
 =?utf-8?B?MG1IUXozMStMT3c5YlB1M0xaUHp4aFZrS2IvOEY3dE53cmhrczFUZHRPUFpI?=
 =?utf-8?B?eUhLSnlQL1BPVlkzR0VqK2t5VlhOVjN3eVB4V1hIYUczdFp0emJPWCtUVzlS?=
 =?utf-8?B?bFMxR3JuTmUyMTRoZm1TbnVXdytZWk14RHdBSVJ0VFdCLzMxdUxKY2RlYmFo?=
 =?utf-8?B?VUp5Umpwc09PZVBtbTIzOVVqWDR3Zko4YUJKYnAvYVBaSDBvek9qckdtQUo4?=
 =?utf-8?B?OTQ4T2lqOThHb1NmamYvSFVkWjkrSWttMnlDR0k2R2xTT2tIVThSZzFBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzI5M3AxRlBvRG90Umk1TjJQbkZobzI0U1hkbTBCKzRkQ2hXN3kyOENnblh0?=
 =?utf-8?B?cHJNRkQxOWVmdDZjN0hRb2FsTDQ2YzFtUjVRRWJxd1VTY2tXV2FpTmdEK1dB?=
 =?utf-8?B?bGMvVjZFbFpSUk9waVhMNnRSK1I3cWgwd3dCYm5FOTd4V1Voa09PZTJuMGF3?=
 =?utf-8?B?akFpVXpBdjJsczVqVlA3VWhWREphZzJJd0JNdUs5eTJvakwvd3U2T25SNU1P?=
 =?utf-8?B?Wkg1dFlvQlFQaVgwb3lPNUI3bm1NOTFFbXZObmlwdmNEVjdhUnFiN3F5VlZG?=
 =?utf-8?B?cWRUaitINzY4bWZoeVhBQytkVDBUYjN6TmN3dC9oNFlSWGYxM1gyQ3V6d0lH?=
 =?utf-8?B?M1pva0hIcktXbllTMFIrWEliVzdKWkYwUW5NbHhDd0ZnaHZnc3FmRWx6YmxH?=
 =?utf-8?B?c3ZYQUpyRVV3M1kvV2lCSnd3bEVDWkF2elhQTjdLR0VzU0MrdEZwQ1dMZWs5?=
 =?utf-8?B?dlJUZFB1NzFucU1IVFJMaFQzd0k3SjVWZFVKOFlVLzNJU1grSjZNVmpVMExO?=
 =?utf-8?B?Nml2M3NwdDlxSW1DbmxSOXJyaGQ3S0RYZUNhY1ZjdjVIZUgwMUVwSzRvRkhZ?=
 =?utf-8?B?SFhTWTV3d0RYYUlXODdPTnlNK2pxUlhURnY4NU1ybmJab0lncTd2WVZLSFVO?=
 =?utf-8?B?V1EvY1FPb2ZkN1FjUFJTbk9OeGJXb2tmaVRTVDVoc1RONWhkOTdJcjlRTWZ1?=
 =?utf-8?B?R2tkY3EycE9Dd1VXTnhOcjkzaUg4OVNxd2lzN2dYUE9hcGlDZnlUb3FmVnIw?=
 =?utf-8?B?dHlYbHlaY1B5WGs4RW5ZOGtIZlBMYkFVd2hncWVnM1VNZ0d3dXRQSE1TdlZJ?=
 =?utf-8?B?TjdPU3NnTFdrRmJ4OEczVVhLdjZkUHVHMGYvK3JKRFJiQWJDYVJvMTRsdlNE?=
 =?utf-8?B?cjA1WUZQT0JMQ3JsU1lyYmdWWG05Q3RLc1Z3OWczTVpiMTNTU3p6RDV1ekR2?=
 =?utf-8?B?VGpmSDFvYUxnU2E3N3pVbmNOSkVHUFJnU0RwL3RLbHpnTDBqcjdRYzM2K1Fu?=
 =?utf-8?B?cjJaamRVampQbDhTTmNzSHZqYmg3bEpvL0tFTlJ1OVFPbmw5c3JuTkNtbVl5?=
 =?utf-8?B?eTNiZk9meDJVQUdMZ29ld1lySjhsNUlnWmQyMVpWeDVGTlJ2dktlanMxRjha?=
 =?utf-8?B?NmZoVW1nekZHUEdzTnZxaUpTN3F6Z3JVQ1Q2WEVDazZtVjRFZFlrRGdhNWxG?=
 =?utf-8?B?RHJUZEIzZVhqOFZ1THViclZuYW54VjF1bEFwdit3TEhlamxUa0ZBblgyNXYv?=
 =?utf-8?B?QlZpNDdpWDErd2d6bGpBVERIN3lTVEhYcmxmblJtWFZDWnpVQ0dnNlFQTXVq?=
 =?utf-8?B?ekRqU2RXcEZMclozamZraW01eFB0YlUxaHA4TUluSWh0eDQ2elg2VDVpSndF?=
 =?utf-8?B?UG5XdFQvSUE5VEVXbUpRTHVYeUVhRVBIRDNkeG8vRWFjazhLMEgxUGRYN0E5?=
 =?utf-8?B?YVhoZTJmOFk4c3h5T1NWSEplS25IajhIUzZadUp1NEFPUDBqNjVXSEMwTFVS?=
 =?utf-8?B?ZEZKTG5JenZCaGpWQTVUM1FVd0RFM2FzL0dNYnh1NWxxYXRzRklpb1JRdjdk?=
 =?utf-8?B?Sm5tdzR4WW9sNGxxVFhhTzBWTHZKZmNZcWdNUnp6eXMzTk45RjdHSFVlUXhk?=
 =?utf-8?B?RGY4TFhXN2EwNmYreEpiOE1RWHVnbEhvdTVUYXJERDd5dlJPK20vSXZidkli?=
 =?utf-8?B?cG12dWVGbnM2Wmo2WTE3ZGxMRjJjYjMyOFpTN1hYcm9zWVNpUGlrQmNnZEdQ?=
 =?utf-8?B?Tko2eC9iS1ErVENCalkxRFViUTBOUlN1ZmFYcVRqamVUL2lsc3Zua2dmT0kw?=
 =?utf-8?B?bjkycTBmZ3ExUDhFOXowMnRwSkRGaEhUaENjcDhoaE1KRjkyY0JvUTY5V2Uw?=
 =?utf-8?B?U282bGZITURxWlEwWUlPQmFGU1JVKy9JL0tWR2JpZlFGeGdMM3g0R3lsMlpm?=
 =?utf-8?B?V1JGaVpHZERNM2J2K1hyZFlBSml5ekVYQ2VtdFZZYUF2cmUvSG1LUWVSRCs4?=
 =?utf-8?B?MHRTcEVNWkNnVUY3bnRRbHhDN3MxcFZJdFRvZlBlYzkvL2w2eGJYMTcrS0pC?=
 =?utf-8?B?S29vU3FDTExmamxLVElkcHNXMHpQRnMyRXdZaURJaERaTjhCc1Q3N1J4cVd2?=
 =?utf-8?B?WkM3ZlFTL1NpeVpDblNiNWhiQlpDOGJjekRXTmtOZnpsOTRZUnJaS3VyQVNM?=
 =?utf-8?B?RGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ebe138-9023-44d4-29f8-08dc7ed61d64
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 05:22:06.1602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwZd2XKH/vxOv7xh99eUImvHVbPgdHKU05p/RxWaxoJEgzQVLpALKUHOAXAONICZOUv2vMSBo/5kH4EkzGHSnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3803

On 28.05.24 05:30, Chen, Hongzhan wrote:
> 
> 
>> -----Original Message-----
>> From: Tamás Paál <paal.tam@gmail.com>
>> Sent: Monday, May 27, 2024 9:09 PM
>> To: xenomai <xenomai@lists.linux.dev>
>> Subject: rt_igc fails to bing an i225-V Ethernet device
>>
>> Dear All,
>>
>> I am experimenting an Intel NUC 12 Pro small PC (NUC12WSHi3). It has
>> an Intel i225-V Ethernet controller, that works fine under Linux, but
>> I cannot make it work via Xenomai (Cobalt core).
>>
>> I downloaded the latest Xenomai-master tree, and the
>> v6.8-dovetail-rebase kernel tree. The building procedure went well.
>> Xenomai also working as expected.
>>
>> This is the i225-V device in the system (the result of lspci -v command):
>>
>> 72:00.0 Ethernet controller: Intel Corporation Ethernet Controller
>> I225-V (rev 03)
>> Subsystem: Intel Corporation Ethernet Controller I225-V
>> Flags: fast devsel, IRQ 16, IOMMU group 16
>> Memory at 84200000 (32-bit, non-prefetchable) [size=1M]
>> Memory at 84300000 (32-bit, non-prefetchable) [size=16K]
>> Capabilities: [40] Power Management version 3
>> Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
>> Capabilities: [70] MSI-X: Enable- Count=5 Masked-
>> Capabilities: [a0] Express Endpoint, MSI 00
>> Capabilities: [100] Advanced Error Reporting
>> Capabilities: [140] Device Serial Number 48-21-0b-ff-ff-5f-cf-d2
>> Capabilities: [1c0] Latency Tolerance Reporting
>> Capabilities: [1f0] Precision Time Measurement
>> Capabilities: [1e0] L1 PM Substates
>> Kernel modules: igc, rt_igc
>>
>> This is my init script:
>>
>> #!/bin/bash
>> ifconfig enp114s0 down
>> #remove the device first
>> echo "0000:72:00.0" > /sys/bus/pci/drivers/igc/unbind
>> rmmod igc
>> modprobe rtnet
>> modprobe rtpacket
>> modprobe rt_igc
>> echo "0000:72:00.0" > /sys/bus/pci/drivers/rt_igc/bind
>> sleep 1
>> /usr/xenomai/sbin/rtifconfig rteth0 up
>> /usr/xenomai/sbin/rtifconfig -a
>>
>> This is what I see on the console (line 9 is the echo command for rt_igc) :
>>
>> ./start_rtnet_intel: line 9: echo: write error: No such file or directory
>> ioctl: No such device
>>
>>
>> These two lines appear in dmesg:
>>
>> [   25.325872] igc 0000:72:00.0 enp114s0: PHC removed
>> [   25.389790] rt_igc: probe of 0000:72:00.0 failed with error -2
> 
> According to the error number, if it equal to IGC_ERR_PHY,  there should be something
> wrong with phy init.
> 

Is the rt_igc code base we have sufficiently recent for this NIC generation?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

