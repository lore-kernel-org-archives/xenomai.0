Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2062.outbound.protection.outlook.com [40.107.249.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B33C2E9
	for <xenomai@lists.linux.dev>; Sat,  8 Jun 2024 05:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717824683; cv=fail; b=sU/5kmiVvlE3qgpl4u2nCdjC+Zbqif222G0pRgQ3uNdxV7m5bXovOt4vjulSlo3NYDK+C1eGLb1StmFe6bn5YZ1Gb+KRR7KdZmt/P8maE6iPerrgDo3Np1Ma6yxEDocL3T57J7I9fK7K9WzIsI29hmWq0ThYYA/kBGW08C3v/aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717824683; c=relaxed/simple;
	bh=rB9rl8UGw211PEPOC7tygE6Zih+/4ewgalNs3lw5PiA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VPjxuGEI71vyP9eKZ1ozoD4eLhAlZzB3hXEJBP730sr/j5oRbVL4j2A7SdnRtU3Tsz4t37o5uFe4MH3BDkuSrxtX1IRpW5LQqHzhWlD6YVnrrXPlDXPOg0mg8RRVsJXQJF5yWhcta2aKWrA1uOHOrKP9CfGBamyFDjMK/SABo7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=WacfW/ZW; arc=fail smtp.client-ip=40.107.249.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="WacfW/ZW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dM5TpfZZIZPeFi5zU6uKSkCwgLkEBAEKVnJXArt9mTtndkTjBFuqWZVdwzZla2zP2rxaS+r4Yq0oNE/MguQ4kB/Q7ilRBnCYo8fA/ShiJ6h2JzObKHIvIfW0i5kssQrthvYYNyoI7v1weI90ItZnAhGBQuoxZmQxmez7RLySC10d7p+j9jMpxqU1t4bnEO18pGXklcYUJEC+ttUDHEixYsHUX9DKdqIu9C7g4o0Db/dn2avSr52HvvrizB2b0GPjj1gXlJ5aLZVTMxE++ek0bNhcF+Ro/HOqkJkce48OUcP+hSulbGI3p87/hTJjhxDD+/S+uypg/WmDVi1/VaJcKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8R1eHvwxYzWggDRN3L/YLQTdFZaubyPQXce98FEpvo=;
 b=SvQRjUBs7N9GsGYOCTTXWqndH7QUc8fs52hre5ec1PZbznPfgJes52Rmgoy+caPAsNo0c+e9M/4QE9KqkdzkqXhlHMSSuIzn1TZqqDmj4Rbp3JLfqHVtUVB68/0bQCshPo2YfgUlciw6JAjZhtOeEIJUYz5HOWOUZJikHbXVBAc+3FcH7ld2GvuEKbP8k8cg1V883Jk5hoi93kwbUhuwfKjT0oZyLRUlVKmtqkD5b7mrYAszDkKM8USH0dd/c1VJma3oT2aHS8g+ekjNmjK8NgFyrADBZq1IQ6IRQr2dBuRmZdR2cZZJ+ke90pi33rfxVPy3h0xFrUCrEn4IB6fMCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8R1eHvwxYzWggDRN3L/YLQTdFZaubyPQXce98FEpvo=;
 b=WacfW/ZW31wulGh0Qghm/Mc9QkvlfIg/vBeJkabKmindn6CK1b4Smu0EzQqk/Cvw3xQIYpyQKyVvPBucEaT8gF9ShIdUoqeKz/ZIigjQ6nTgBxgdR+3xxn92GJJe3V4br7tCbZ+h2DtcrilS8/Z9QobHoywvVQoCTXLe9NZbwlS97AZFvU06pnMyHebjZznqpVrtl8DE4XdDG2UUlCzshCtNs77OjW9SCDoiCyd1rcdJx4Xb8PZ6kDPq5UlGqNTeCkKxPdKz54xwihACDWnR7QuOPY07ValrKAfYBNWukdHwpp/to1eH02JnljfsbR0jP2+JdOnGAxIkyNP79t2I5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DB9PR10MB5715.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Sat, 8 Jun
 2024 05:31:15 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%4]) with mapi id 15.20.7633.036; Sat, 8 Jun 2024
 05:31:14 +0000
Message-ID: <73b55cbb-0d7d-4552-9102-cc7c16e5834c@siemens.com>
Date: Sat, 8 Jun 2024 07:31:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC dovetail 6.9 v2 2/2] KVM: x86: dovetail: Allow
 kvm_wait() to be called from any context
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
References: <20240531-flo-fix-kvm-guest-for-6-9-v2-0-5534fcae4eb5@siemens.com>
 <20240531-flo-fix-kvm-guest-for-6-9-v2-2-5534fcae4eb5@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240531-flo-fix-kvm-guest-for-6-9-v2-2-5534fcae4eb5@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::10) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DB9PR10MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eefa6ba-c0ff-42c9-bc86-08dc877c366d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXdGMXRQMFBJN0ZGN0c2eVI5T1FycjZBaDErY1VaT3JEUlhobXFVY1J5MzNa?=
 =?utf-8?B?VEU5eVd6cThueWEvcXIwRkxtRXhJQmU2NU9GRHcxWUpXNGptZTlxOWxaVlly?=
 =?utf-8?B?VWtURTFOcUFUQ3AvT3hKSWhQaGV2dExKYWZWTUdGK25nUDlkWTgrRlFiTmhj?=
 =?utf-8?B?WmM3Sm9qQjBhTmZ3TldUaS9QVzhQZnhLeDVDY2ttU3VGVUNnMWVGeVhVbnk4?=
 =?utf-8?B?Mk5qU1ZueEowZnBuRVVhR2tQMkV3clEzTVRpQVo4N0hqanM2Nkd5NytwTmlt?=
 =?utf-8?B?NXdjTWs5OUd2ekVDclk2MEF1RnVySXdyT1Nnckc4NFdjWjdmUkF0aWJHUXA5?=
 =?utf-8?B?TjZ0UlE3ekhDdEh0ZVNSYVc4TXFyRTFYZkw5Y1JhV0p1am9SWWZYUTI1RHNO?=
 =?utf-8?B?bkZaRUlKMnhpczMwNXZURlM3cEdEMSttY2dPKzhPMVhGOXd6cUgzd3JCMXBZ?=
 =?utf-8?B?ejd4NmI4amgrN2IwcDMvVmJXSWllajNMR3dTY1kxeUladFFXQjQ1NkJJNzRr?=
 =?utf-8?B?Uk12RHI5K2swcU81anlGYVpiNW45ZjVSVkNhdGZqODFTRGZ6UkZlTkUvODYx?=
 =?utf-8?B?RGp3c25nTXpWK2ZudGdLQVFrU08yTnZvbCtNOUlRWjVyaCtkbDBZalZsVHo4?=
 =?utf-8?B?eWo4UmhOTm1lQTc4RGZiUTF4bm4zMm1hR3hncy9CYU5JWEhuRm5yK0FyKzUz?=
 =?utf-8?B?TWN3a0JZVmMrS2NlOVA0c2l6T0pJMVNvNWc1L0RPaTl0eEFqaEl3SFlzWmQx?=
 =?utf-8?B?ZTlock8xK2tDMGlQZE9nSitlY2Q3N1plZWdTU29USlU4TmFDR3JVdUNvL3Zv?=
 =?utf-8?B?WFgzTWd4WVAzd2hHTEpUZTRyRzllL0RueCsyRjBIZW43ek5ScXhrNzVVNk9B?=
 =?utf-8?B?TXZTbXZrbGdZYjV0QmJsMzlGRTJXUFRuR2NoZDZrMkxSeS83MG5iQW9FS3F2?=
 =?utf-8?B?ZmtGV2JweFlMcE1SL3JmdzZMMDFCWXlkYjJ2NVdwWjExMmxEd2RzK0drdno5?=
 =?utf-8?B?QzlKbU1TWVJmV3E4UnlmdnNSM3NGWEtvMnY3SFFDeHFJQU5VRlZ3NXJkK0Nh?=
 =?utf-8?B?Zmc0NW1uSUZVWWVKRlZaKzBibkM0dmo1ZklneTdoVU04TVNaN0RYQ1hnVEcy?=
 =?utf-8?B?RkpmcG54VWk3N0ZUMkd4RHVDQURtNVFYaHhBV1ltcUx1VmRvOGdnSlVyRTJM?=
 =?utf-8?B?ckdIckNKZ0JySEYxRVpSTjVEdVZBbHlmWWhxekZNN2pnaTBReHVuWUIzZHp4?=
 =?utf-8?B?dStmbXlTRzFlSmNZSVFPWU9DOGpNOFhBOUJsbFV0NGNXc2FxclpBN0k2ek1E?=
 =?utf-8?B?SXRPOG1jcjdzUS9NclhxczA0N2JKK1VhdUtPd0ZNQXM5SkJ6VThVdzdIcUIr?=
 =?utf-8?B?QjYybzRTelQrWFFWM2dsOHNxd0JiUnBkTDZjN1RraUJocmRtQXBVNlJXYVdK?=
 =?utf-8?B?aXNFcGJReFdsU3FtNCs4MGZlMXFQem1UWGZnM3NHcDByZTFCcFFIUVdtT1hT?=
 =?utf-8?B?U1IyYXFGc1Q0RkpQbXNnZGdtL2IxZy9kN0lFTnZFb3c2ZHp0UkgwUUNKN1NZ?=
 =?utf-8?B?TzZ0RzlQclB6ek03bTk0OVR0V01NMlVIb3V0NGtSVm8xVm1YUDZBSXZwZDFB?=
 =?utf-8?B?aUtLQ2FoMUxEKzBhRXhqbk1mVkc2dk5seGttbDUwUHVibjBuUXVCM2NoOFND?=
 =?utf-8?B?WEV0NURXOFptcENCTTBmdUZWRE5oSkUyTE9SL2w1TCtWckRKVEdweTY4NmFW?=
 =?utf-8?Q?Rt15AoqK0V6ooUrxZQ11G7C3SwlyqF0/oirGgL/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uk1KMzkyaE9YOHRrY0tiWWNBcGdtYUhVaFhkL3BmQml5WFZacXpBaHV2OFZV?=
 =?utf-8?B?NzJIeVBXQVZsbWYxTXNZMlh3U3orV2J3VUxmTzZFMnA1VmlrWUEzUForRGUz?=
 =?utf-8?B?amFHNmR2anJPb2VVSXF1cVZ4UFVWNERMS2FsZHBsV3Y4WTJEamdJSlJWMktX?=
 =?utf-8?B?ZlVsOFZ2VDZSb2x2dXNBc0kyT1J5dHFQMFJZUGJMTjgvRzV6ODdKMmpHN3BS?=
 =?utf-8?B?bzMwNGVkTmV2ZjVmVk9zdWc0bytub1ZoUEFzV2JOYzJuSFlmTkxycHJIY0I5?=
 =?utf-8?B?ZnVLV3N1Ry93ZkN4cjExVnhra1dROWcwZVlFakVCM0k4T3kzME82WlROVnV6?=
 =?utf-8?B?cXdycUZkY0dEbm5qNWhHaG9nMDdDUVFUVUlxQ084bUgrdlQ3UktzTW1XTTJj?=
 =?utf-8?B?MWdzQmVSa0E2YWJhbTR2dERLRWh6Unl5c0Y2aTBxblJnTXQ3QXBiQ2ZnL0Jz?=
 =?utf-8?B?MitON0xXTmdqeUVyNDlIS2YzSHVWRUxiUnkxWDAyV3FKS2VjN1NWczdFTWkv?=
 =?utf-8?B?OWlpQW1LYk1GRXRhMUdXYW9oQ1AyNzZHakxMenZIQWI3MVlUZVM0am5ZTk1F?=
 =?utf-8?B?b3NFQ0JvZnllSUEzYXVaUTAvRHpUWmswQmt5d2t5T2lSOXp0eXM0TThhODJN?=
 =?utf-8?B?ZFloV3p1bGZWZ0JMVEpneWMyZ1c2MmhxVldySmhPRXdmU1liZ3A1NWNOSEFQ?=
 =?utf-8?B?QTB6YkxDZjBQdnE1OGMwampMTllCZ2Z4UmJBQUsrQVE2NjVtY3l1SEVZSGVC?=
 =?utf-8?B?WEVXMkcrRHVaSElvTkpFMVZiWTRkWjlKQmtzYkhNRXRISnhZSjdta3JRSW44?=
 =?utf-8?B?V29HQ3dDNFcrMXluRmxjL1lKOXI1UHVxQmlNMTRWS3pSZ3ZHbXFydE5aZ2Y3?=
 =?utf-8?B?NisyZnBZT3NXbFRwUnV3clZDSkZNVW9BTEovOFV6elBtRUJCV3FqYjF1bXJV?=
 =?utf-8?B?VlBqeGFjMlhROW1RY1RkWXM2clhCWk0yOXQwMSswVzBTMnBKNFFPL1pIVzVG?=
 =?utf-8?B?Rkt5WWpjbTk5T2JJeXZOdmptcFpFVEtpWDlVbkNkYUxIcmJ6elpJYmFIRU82?=
 =?utf-8?B?MEQ4ang0YkhxM2hMWEkybnl5Q3A4ZXd4VzhZenRNVDB1YWpUcW1Tckd5bVBO?=
 =?utf-8?B?TGQ2aytBVk1qNWp1MSsvTVFmdWtNRTNxeTROaW5PSmExRFF2a01tb0VOb3pU?=
 =?utf-8?B?VWdDVWdEdnp0eU1OMFhaRnFIZUttYnlZdjlsTEgyR3RWN0JaQmRQaE5mNzlp?=
 =?utf-8?B?ai93VS9vY3FIaGd5M3FQNVhQd256N1FhZm4wUjdyRkZLZ09IRzFxOTFvdTNo?=
 =?utf-8?B?K2xZSzVucFYrUlhkWUQ3d3VqSWt1Mk5YVm92dzNrRmxMdXhob1IyZzlkaVdv?=
 =?utf-8?B?R2NUaGIxUGNXeTRYcGpmZzJqbHFTUEJuV3B0L0JKclNibGdqMDhXNzRqaERk?=
 =?utf-8?B?RzVBOG5idmpob0huZUpzNlo0emRHcUJRanFjNlkzZEtjdlVYWS9qT1g5Tmw0?=
 =?utf-8?B?TjFRRVVhRnYvdjl6ZnlhT3kxaXBxZk1HS09nOUIxa0dtZCtXZGRMSGx4cjFz?=
 =?utf-8?B?am1tdmpmSDJOOTUrYzExZzJDNUVsN2ZKQW13SngwUlZzbGd3NkNvUjd1anN0?=
 =?utf-8?B?RFZONjZRUTluTXZMVG1DM25CbjdmcEh5ZXJETjhWWlhxNjhIUHp6elk2QXlL?=
 =?utf-8?B?SS9wTzZSV2cwMGpvZVJTc2lIRjIxWVVINzBmc1pIQWhXbmwrZVBKM3pLblJX?=
 =?utf-8?B?VHBMTnhMSjc2NFBYV0FSZkZwT3lZdmQ5R3BqNEQzZzNOdzREMC9WT05mb3BH?=
 =?utf-8?B?aDhqKzFHT2pxaHV0RDdCdXpkQjZBeE5OOVBBTmRjbVUwb3B1b1h6a2IyN2Vo?=
 =?utf-8?B?encrZkQ2ek8zZEFLUlFoUnlodzFQendaZEFSVGdyM2FOUGpFbUJRTTNxOTVr?=
 =?utf-8?B?YktULzF1blpXdFNHVHI2SkRPbUhtdEJTT2hETGdQMjlyOXN2QnBpSU85TTdF?=
 =?utf-8?B?NklBNkJSTmpLS3dNSGhPUEh1cVFzN3FQWjM3a2lWWEUzcEsya20vSlB3ejRV?=
 =?utf-8?B?U3hkOUZqcE5XWlVvQ2xTb1EzM1dla2RzTEttQ1ZxczVwSVdhK1FPa2llVlhY?=
 =?utf-8?B?THl2cnBMMnAxVHpxSTlPOVJRdldoa0ZLTnVtMXdJV2UvTmZtV2pMZ2FpbjRX?=
 =?utf-8?B?Ync9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eefa6ba-c0ff-42c9-bc86-08dc877c366d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2024 05:31:14.0108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3RJFdbdmd7DcnUFWKu/v3UJMC9KJ0enbF2+BuuhhPcDxSZwO6UdePcuCsP69ypcpnT3rq8U2ns44rE0Bbiyhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5715

On 08.06.24 01:04, Florian Bezdeka wrote:
> kvm_wait() unconditionally enabled HW interrupts when called from
> pipeline entry code. That broke the PV (paravirtualized) spinlock
> implementation.
> 
> When running with CONFIG_IRQ_PIPELINE enabled we always call
> safe_halt() to allow HW IRQs to be handled.
> 
> The !CONFIG_IRQ_PIPELINE part is now re-synced with the version of
> Linux.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  arch/x86/kernel/kvm.c | 59 +++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 53 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 655b1cf8c9ab..3180a26cdfe1 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -1059,22 +1059,69 @@ static void kvm_wait(u8 *ptr, u8 val)
>  	 * for irq enabled case to avoid hang when lock info is overwritten
>  	 * in irq spinlock slowpath and no spurious interrupt occur to save us.
>  	 */
> +
> +#ifdef CONFIG_IRQ_PIPELINE
> +	unsigned long flags;
> +
> +	/*
> +	 * We always use safe_halt() to be interruptable by HW IRQs.

Nope, see below.

> +	 *
> +	 * HW IRQs off:

Let's stick with the nomenclature "hard" instead of "hw".

> +	 *
> +	 * Wake up on next HW IRQ or by a vCPU kick triggered by the current
> +	 * lock owner.
> +	 */
> +	if (hard_irqs_disabled()) {
> +		if (READ_ONCE(*ptr) == val) {
> +			safe_halt(); // enables HW IRQs
> +			hard_local_irq_disable();

Just halt() - if we entered this with hard irqs off, we cannot assume
that it is fine to take an IRQ before returning. The kernel doesn't do
that either for Linux IRQs.

> +		}
> +		return;
> +	}
> +
> +	/*
> +	 * HW IRQs on:
> +	 *
> +	 * If inband IRQs are disabled the LOCKDEP state is already correct.
> +	 * We can disable/enable HW IRQs without further bookkeeping.
> +	 * = Linux IRQ context
> +	 *
> +	 * If inband IRQs are enabled we have to inform tracing / LOCKDEP
> +	 * infrastructure about the HW IRQ disable/enable event.
> +	 * = Task context
> +	 */
>  	if (irqs_disabled()) {
> -		hard_local_irq_disable();
> +		flags = hard_local_irq_save();

Why this? We have tested that state above and know it for sure. Just
keep hard_local_irq_disable().

>  
>  		if (READ_ONCE(*ptr) == val)
> -			halt();
> +			safe_halt(); // enables HW IRQs

Yep, this is needed to avoid delaying hard irqs while waiting for the
Linux lock-holder.

>  
> -		hard_local_irq_enable();
> +		hard_local_irq_restore(flags);
>  	} else {
> -		local_irq_disable_full();
> +		local_irq_save_full(flags);

See above.

> +
> +		if (READ_ONCE(*ptr) == val) {
> +			safe_halt(); // enables HW IRQs
> +			hard_local_irq_disable(); // fix HW state for LOCKDEP
> +		}
> +
> +		local_irq_restore_full(flags);

How about this instead?

if (READ_ONCE(*ptr) == val) {
	safe_halt(); /* enables hard irqs */
	local_irq_disable();
} else {
	local_irq_enabled_full();
}


> +	}
> +
> +#else /* !CONFIG_IRQ_PIPELINE */
> +	if (irqs_disabled()) {
> +		if (READ_ONCE(*ptr) == val)
> +			halt();
> +	} else {
> +		local_irq_disable();
>  
>  		/* safe_halt() will enable IRQ */
>  		if (READ_ONCE(*ptr) == val)
>  			safe_halt();
> -
> -		local_irq_enable_full();
> +		else
> +			local_irq_enable();
>  	}
> +#endif

Yeah, we indeed need to preserve the original version for the
!IRQ_PIPELINE case. This was also broken.

Jan

>  }
>  
>  /*
> 

-- 
Siemens AG, Technology
Linux Expert Center

