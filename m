Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2061.outbound.protection.outlook.com [40.107.105.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B6E1F17B
	for <xenomai@lists.linux.dev>; Wed, 22 May 2024 17:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716397553; cv=fail; b=VNcwW6/okGzrrTrQgX0p0IhK6VoSNpr5yoda/tQ2j+aTqDhnnOb+nZr27qhTH+d+jc84Ce74DFhzsq9oT1pPoHI2iXa7NIaQQ6ADxB5tCK65GPWVRAXjgZ0HW1i05cjHifHcjITcYNFd+aPoqqwwT/R08CJGiPkApaRfPE83lOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716397553; c=relaxed/simple;
	bh=k2hMH/W33EZKvckT7Qr3oP9DaP8GJtvEKKmldWCcw0A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n2/ReEEEoIteCnVj5BFoftv4gPcQNASCJ51xSSTOBcI1ZyjkweurQMlojxnoDDI3cijV/5koW8DYQIzxJcSpfjWVddEgVNA3jQGLuJ//itJkAdnIpXufsE8g5qnrmuGA/d+EN94Shg2DnxU7uBiucB1WyuaszUVRtsjpv4MypWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=TO1EwZXc; arc=fail smtp.client-ip=40.107.105.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="TO1EwZXc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdgdCEsR/5MGlPdQ1+PAznfoqNRzyjP2P4AjGuzkVuLscAbZPbISWaMSrKZP6yVEImLvOXvUabRGKCUN40P5XGWJFozkWn8Jmg32BCw/nzvVZ5qcUN3lHcfvnQjPWCeq84B3laIG9TXLIoD3moApd3f+Y+sKLz/5dUDS9tUhJve2RcXnXcEP1eJ1euTXbw9Gk3R42JFmxbEX88TcB7SwzGpVYZXJS9fJGJVjT4pRRv/t9Y+5l8yxEnpwvK6/AKxYMvOnqY3FcvaTbBz4GqFmHf7FWumC2I18Mb/BmTRgbtbT350i4SFGhy918XKlR1vHLPuDxpKiJeydQP4WbqA6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BbMO/C0uq4F99w6mG3nhK9BoaNw5688y1FeB2jwXkE=;
 b=jLRw4Pny+1bHJljnXYdVZpFQ3Xvgp6V3syVNAjkXVwAAnf/l5aa4k3zzYSjwCBFzmAX0KjTh8yYZbJbDGlJ2u9ssZX5HqkPdhXp6fZzdRxS46YqaLdOi/EGCw+fl4KjoJz5VN4CBQ5uaDpe7IoJp7R6d6v2Yx3+UIJU23Y+s8RydgI4b8UeRCBo8oZF4JFI9bkhcnHkvg33iFDCW/+adounoeghwcI5UvL7InLXU63pGJ7qaqPFPqUcpuNbberduG2L6+44YusyMGLvDkDgwdxmy3uK5/PiNrBiLdnVC5FFkLYpVJAC021F9IXqbiitIeTfL9564kW9RKNsLYWwgTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BbMO/C0uq4F99w6mG3nhK9BoaNw5688y1FeB2jwXkE=;
 b=TO1EwZXcQl5o4CyesXMqx16QBK3gObu520Box35Fhztq7ZMUHbttpNkvKa6a1Yt0cqeScaukC1mEJQEqttOAmJWqZUWBnJPUrPb7n76rQEbsfHh5Eg41zrGpAyOmeKvjemD5XqGNsbQ0axgMAEXTzr5W+JN5352JJ0sLGfdYyBavnLerIoLRAMYiHYkUEnObYy+dx0J8grGOJAMnOHgQyetOy/tZX1yaanA2vnIFf0AJLD3sMxXoEu0XbDplEtK4tE+8AWFmo0aRmwCIAlk94ZShms9VtkQL2REAgmgYrUijpambW0sKO2XVaOjyc9o7yW/5qAv3vRKl6gdpzBvJNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5736.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:24a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 17:05:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 17:05:46 +0000
Message-ID: <3e8c206d-b730-495e-b204-13087853fd46@siemens.com>
Date: Wed, 22 May 2024 19:05:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] prepare-kernel.sh: Add reverse mode
To: Richard Weinberger <richard@nod.at>
Cc: xenomai <xenomai@lists.linux.dev>
References: <20240518112703.30713-1-richard@nod.at>
 <ba5e0fc8-e2fa-4495-9cf2-69f0ed2d1621@siemens.com>
 <1792993044.132105.1716360194595.JavaMail.zimbra@nod.at>
 <770b74df-11fc-482a-9d2b-119b92e7097a@siemens.com>
 <784543910.133534.1716384735664.JavaMail.zimbra@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <784543910.133534.1716384735664.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5736:EE_
X-MS-Office365-Filtering-Correlation-Id: d89600fa-30a1-42ca-3e54-08dc7a816c25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmFQMFZHbzh0VmdwdEhpVVNhOEVSTmJJdDZDWStEVHpQM2hyeGs1L2ZmUkpS?=
 =?utf-8?B?dmNiaUNXajJXWXdDdC9CYlZCZjZ6UTlEdHE4NGFzK251Z3YwSXc1S0gvM01w?=
 =?utf-8?B?eHZ0a25ackdDejZwSnFpYitHOEJ5WU9YSWRWTlFnMFovN0tpKzRTUXZTYVh4?=
 =?utf-8?B?ay9KMytsb3NQUHR5bndZTDJHSHZRVjdOZDZYemVDb3ExQUVrb2tnRk5YNndO?=
 =?utf-8?B?amRONzVnUGhXM0NpcWROb1hZQSttSVA4bjdja3JCUjlDTzFJaW1wSDdrSmRi?=
 =?utf-8?B?dk9LWFhxOERwQWtaRGxuTXR5U2xtU00zcEk0RW9TdDdyYTRFL0prWTNDdGtB?=
 =?utf-8?B?c0J6bWdENm4wdXA4b29TZzNBbnNvOWl0NWxEZktFWlc4NWdUSnZ4VlRNaWxU?=
 =?utf-8?B?R2tyaG9QUTJTV0U3NXhxaTdsWnBTOTV3N2F0VDFrVTA5OHRQRTh6RHdlTFdO?=
 =?utf-8?B?dW5yOVNKaUVzNXpXTkgyM08wb0wyZlBLdVZVOWhhMm5POFBEZTRQQzV3andx?=
 =?utf-8?B?eEVjNlZBaG9WR0NiUDIvczRKdHJjSVYyMGFoYWU3U2hpdXE1cnVGZGFFMnBG?=
 =?utf-8?B?TmhZQVVUY2hQRmVCMG1Nc3hLVUJ2VFlRRUQrUjlFRjROR29uazZtd09iSmtW?=
 =?utf-8?B?MUZwaEVhaXdwcTRrdTV4cEpVMVE4c2lnSGxSUEtlSGcxaHAzVEJ0a2VMaUNu?=
 =?utf-8?B?VnZQd1dDL2NFNmFSVEx2QVRxUUZiM1ZQNUJjR3ZDTWwvZjVUTnRzREU3Q2tP?=
 =?utf-8?B?d1ZpZDJ3dW9mWkRoNEpiWjhocC9mTmxib2JKTlRpeHljelRkNEdyRUFMM0pj?=
 =?utf-8?B?cnZEMkovQmpnNTFWN3h3NkpnZ0hNMXBwdmQwdUJTclViRksxWGxFT2k5SmhF?=
 =?utf-8?B?SVRKdVRudEVXL0oxRHpDMms5dFFpdkluTkh0U3RFYmt5THdlNk5DS3B3MXhN?=
 =?utf-8?B?WjNIQ2MvdWxUdXR6c0lUYXkrLy8vekM1N2FnUm1sVmdZaVd0aHF5ZE85eWtm?=
 =?utf-8?B?YjBvSTc0OHFESWFUcC9CY3FqTmhzdlpKQ3RKLzFLVGwwY2lISFpSQ1BtQzRY?=
 =?utf-8?B?Wk5UQllHRFIwOUdPalp0SjN5cXNLUldxYkFaWFZaNUh4MG9aZTQvK2VLSVA0?=
 =?utf-8?B?SjdQT3lqTnlIVUFwZDJQVHBFdjc1dlVpejR1NXFEUWNYUjhQWkhHUVMxTndC?=
 =?utf-8?B?NFhiS1R5NzVJTm5BUExQeDVTWEpKejgrR2ExUCswL21yN2ttRW8zWWRjaU16?=
 =?utf-8?B?aXdKTVM1ODFZMi9yUHdyRzNEcXpsdUFZdUthSDVXZGFvMWJ4Um5pd1ZMVGFM?=
 =?utf-8?B?MWZNY3pNNWppY2pNOFdqZFhWWU9zU3hNWWUrMzBIQlEyMmJOQmh4NWk3U2Mx?=
 =?utf-8?B?Y3JGZkhpYk5xNGpPa1VESGRYZ2tjZzg5QTF3YUg3OWhPMkJCQ1Z4WDhRZmRZ?=
 =?utf-8?B?WlQ0bUlxdjdTMmJUcS82QzFDbmJhTHdYUUlkdjJ0bXA5cjJTWGdveDFNRW1X?=
 =?utf-8?B?RmQ3Q0VIdGlSQXdZNUxxSmN1RVIzcTU1c0x1NHRSVGIvTk9IM1EwRUJiTng5?=
 =?utf-8?B?TUc4eExUaWM0SFBBc3ZYdnFVVmw4eVNQTGt2eUV2Y1Fkd0E3YmE0MDJpWDcr?=
 =?utf-8?Q?o48dvTYkwwxbGJCfcLqZazn28nsrGmQ8GMw5Nv73JnSg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3BpdnBrR1NhYmtsamlnYTlMOVB2RVQyV3hpSXFJWGRLZ05uZmhsQU5BZ3Fx?=
 =?utf-8?B?OFhGWFZUbmp1VktQMFBFYzgzSGxxdHIwcGgzM1R1SHJGTWpVNUY1ZG05akxE?=
 =?utf-8?B?c0xZRnZqMFJVU2R3SXRsNkM1UExhaXdVQ2RVZkI3NWxtRm1UVjYxUVBxS0JV?=
 =?utf-8?B?Mi9DVE9GejN2QmRaZUwvcWlZVUdvOUVoV1Z6MVZzbEtVWEVlUTgwWUdWZE80?=
 =?utf-8?B?bHl1MmlCeXRrK0VUeUZuRUp3dDFhRjZXWWJGR3hJT1ZEZktyNlhvUWpHNnZ1?=
 =?utf-8?B?UjBJWkh0ZEhyNjJab3JKT1RPS0todFJWcmhNU3J5U3dxT05pOUYxQTZTMmc1?=
 =?utf-8?B?ZHQvVlBHSy9tTndjdlorcm9RKzBUbjdoeHhsME5rV085UktReFVEUk1aaU9n?=
 =?utf-8?B?SGluL0lHb2xHUUNuSnJqSGNBZ1Q2QzkvMzMxSWdHU25mdUdLQXhGdmdzYlU2?=
 =?utf-8?B?ak54MUNCN3hBZFpCVWdEV0Q0amxjSE9nSE9IbDJhbGthN1hhMENEckhUcHBj?=
 =?utf-8?B?Sk1YNzc1UnJmdzR3bGlyN0JJL3J6eWFUQWNoTEMrQ1YzUC9qbWhSTDBjc05I?=
 =?utf-8?B?Y0lsSnZib05xVmd2U0wyS29ydHhvU2Y1TWp2REcyMi9uZ2E0T3FtMitReHZB?=
 =?utf-8?B?czNOb25JYVpVM0ZyaE5acHdudnFzYndmZTk3djZrTTNGbzFVN2Q1Yy9Qcko3?=
 =?utf-8?B?WE9KZm43bHI1cktjUTF3MVEwVE02L0JBcU9VRTNMK3lhVHZoS2RMMTdMNzFH?=
 =?utf-8?B?ZGRSaU52bzk5SzVrL0pONFp4Nndnb3I0dVRsK3hyYXZFSS9yS1BoaDFJVDBN?=
 =?utf-8?B?bk02SWtzaGhuQ3F1RDJscndlT3UvdWFLR0pvZ2krUTVRUUNZcWlKTTRnRGFP?=
 =?utf-8?B?THZpejFLbUxTMnFOTUYyWU1PeG54Nm1XdDU5a281QkRiWUd4aGFmMGNBTkJE?=
 =?utf-8?B?a3RBMGFkOFNiN21ERHhjT3ZzMDdRTlRwNWFMOHIzMWU4akRLTWJNTXRMV2xF?=
 =?utf-8?B?ZXA2Nm1YR0h3VG1PN25pVUxBc1BmYkVucEVhV200M2FNcnhaUTJjSVZJZERq?=
 =?utf-8?B?TnVFL1FZMTJrK0l6Z3NTOGZLOGNldndJNXhRUXdwa21FakNzR0lwSmZENUg1?=
 =?utf-8?B?Sk5laXdBVW9wbm9WalozbjdEUWhPMlN4OEdmMHJnalFIZHhnenQyRGVySFJO?=
 =?utf-8?B?aExqdkNxYllaU0NnQ0RBZER1VmR2cnkwa3RuVFl2dXB5VXVwRmtIdVVES2tE?=
 =?utf-8?B?QkQ0bHRucDhHN2NDWGR2Z2NoNWJBeGFsRzR0QlMrT05XY0VTMkp1QlZOWmhN?=
 =?utf-8?B?SU9tWHcrcGJCOUcxOXJERmFnNER0NGpGUWlzVGlPa0RiS0c0R1hxMFBDWlR2?=
 =?utf-8?B?cWllMlRUc3RteWdYaVo2N3J5VE5NS2FsRldEb1orRG56VjdpbjVMUjMrUENT?=
 =?utf-8?B?RFVmRGovVWZabE05L0lYSWEveTFHbnZTeGxWQUR5dExBNXFybTZHSzZJTStv?=
 =?utf-8?B?alBzaEpkczBSNmV4enNnNlNDN2dldUhuRlhYT3BCQjFJSXVrTWwrdmd1VFh4?=
 =?utf-8?B?OVN3TGE0eitDOGJZdXRDZmt2cjF0TGtSYmFnL09YM1AxQ1drR3U1MVZLQkp1?=
 =?utf-8?B?MU9FSDE0d2J1R3Z0L0VoV2JkOGc1a0IwOXlCU1lBdXprRjgyNkRsVlVxM2Iv?=
 =?utf-8?B?Sy9vYjhqcDhlZlVUSGdodWFvb0F4eXcxandOaUE5d04wUlh5UDU5MFNFK0NQ?=
 =?utf-8?B?dnc3MFkwcnQ5VTVYVisxdHdRNCtZRmxhYXdTMTVNRDRoSEd6QWZvSUcrUTJv?=
 =?utf-8?B?S1pnbkV5azVCV2xHS3FheVFQeXZ0UU8vcS9yK3pZOG5zZkhpdGdqM3VWaWI3?=
 =?utf-8?B?Tyt3MGtQUThkY1FZNjkzVVpiOGJBM2IzMVZLd1RydzE0OFM2NU0vR1RxL3ly?=
 =?utf-8?B?d09lN2s5a0FFYUNOWFZsdHVhWlVSSWJHQmhPS2RjQXVGZkI0bE1jZVpFd0xx?=
 =?utf-8?B?N2srbkp1MUl3YVkvMkVhN1RaYmR0S0pTQ2pHRUdBZUZWdWJGemV0LzdRVnVM?=
 =?utf-8?B?clp1WnV2alRlclJpM2llM0RvYzF6RU9kcC9vKzRjT1k3MjBTTzMwUzVySFBm?=
 =?utf-8?B?dVAxMUtid2dSdThQWGh3dDAxWjJyaHRVb3ZuZzBSZW9rcG1UaWwvTDZaVHY3?=
 =?utf-8?B?Y1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d89600fa-30a1-42ca-3e54-08dc7a816c25
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 17:05:46.4781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6gSgqjENGkkFlYOQjPsz/wbrfPm8A2KrgCZr/sTEK7EpKUEsr+VT9hFm3+2PIunALbfJ+vz1OaoxXugb9XbZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5736

On 22.05.24 15:32, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>>> In my WIP branch I have glued everything together.
>>> https://gitlab.com/Xenomai/xenomai-hacker-space/-/commits/rw/prepare_rework/?ref_type=heads
>>>
>>
>> Just submit both in a single series next time so that it's clear for me
>> which should be merged first.
> 
> I have implement both features independently.
> But now everything resides on the same branch, I'll send it out as patch series.
>  
>>>> I like this as it obsoletes my local script :). Just minor notes, and
>>>> please make sure it goes will with the any-arch patching extension.
>>>
>>> Sure. Beside of other fixes I've managed also to get rid of /bin/bash and
>>> changed the script to POSIX shell.
>>> shellcheck is now happy up to warning level.
>>> Info level still gives tons of suggestions I have to review.
>>>
>>> Beside of that, what's do you think about the --filterkvers, --filterarch,
>>> --default and --forcelink
>>> switches?
>>> IMHO we can drop them. I don't see much use in them except of adding complexity.
>>
>> --filterkvers and --filterarch date back to 2006 and this commit:
>>
>> https://source.denx.de/Xenomai/xenomai/-/commit/b1ef45e37c06a2e62d57cd139b410e02bc486898
>>
>> Unfortunately, reasoning was not recorded, and we can't ask Gilles
>> anymore. I tend to agree that this is not needed in practice.
> 
> Ok!
> 
>> --default seems to have become obsolete for the linux path with
>> https://source.denx.de/Xenomai/xenomai/-/commit/0886b75af74654682794102d080dfd4a16da1244
>> - I don't see that linux_tree could become empty anymore (unless you do
>> "--linux= --default", but that would be strange). Adding your new
>> default value for --arch (all), that switch could be dropped.
> 
> Agreed.
> 
>> What would be your suggestion for --forcelink? Just drop it and skip
>> over existing links or make it the new default? Enforcing the update is
>> probably not as safe as using the new --reverse, followed by clean run
>> of the script. This is at least what I would do.
> 
> TBH, I have a hard time to understand the purpose of --forcelink
> 
> It is used in:
>                 if test x$forcelink = x1 -o \
>                    ! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;
>                 then 
>                     ln -sf $xenomai_root/$target_dir/$f $linux_tree/$link_dir/$f
>                 fi 
> 
> So, a symbolic link is forcefully created if either --forcelink is set or
> source and target files are not the same. "not the same" includes also that
> either of both is not present.
> 
> To put it the other way around, "ln -sf" is not called if --forcelink is not set
> and the link is already installed.
> 
> What's the use case?
> 

The only difference of enforced linking might then be time updates in
the metadata. But don't ask me about the pros and cons...

>>>
>>> Same for --dovetail, since no release patches are made anymore.
>>
>> That switch is for integrating Xenomai + separate patch on top of a
>> vanilla kernel. I would not drop that feature yet, even though we no
>> longer distribute patches as releases.
> 
> Okay. Let's keep it.
>  
>>>
>>> Also, do we really need interactivity?
>>> Currently the script can ask the user for the paths to Linux and the dovetail
>>> patch.
>>> IMHO everything should be controlled by command line switches, no script
>>> chitchat needed.
>>
>> Where would interactivity still remain after the above cleanups?
> 
> If --linux points to a vanilla kernel, but --dovetail is not set,
> it will ask for the path to the patch.

I agree that this should rather bail out with an error then.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

