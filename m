Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2072.outbound.protection.outlook.com [40.107.7.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081E112E4F
	for <xenomai@lists.linux.dev>; Sun,  7 Jan 2024 11:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Ov0omNR2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fc15lBgoKuR1YCpMV7ntHhRGzE4IvEMs2p6HsK+zb9YXzgVNQJCIcMa2JeOEw3TbfLihsIN06qIsH7aGw0KhhUuK/0yNM8+MDQVp3W8ZBPL8ZN+kKMp1pEmzVoZnn/DHQaCOJyj18ICYcu1Wsff5wgOhPdXuNwhGI3aGZmRejtPgTDq2THD7AivGZnq42MH5jciAxdWL9MvS6I20DtSKAIxvQpNjB3Oc5Amc0KqUHookXGRBtPeTo0aNdXtcyYARFoOuEnEQVsOVvxbtsPSFh4ShXzH92CUgcTsaF2jK6RaDZkBZGGrr/foTGay4thy3c3adXyFbrTc84c4vPLTrRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHz4OoSLEDxf/jbqqpXpMofczm0mSDFvnNdlQbzk26M=;
 b=Lc6u/8ezimxG5zxhzjJhztQPSNoBt/EDTF10ce8KAP8VbA2caQX2JRplP4EMGizrcrxUwgpiM12z4MwqDuo7Mp4Z0Hp818RGTN6r6AzCf5MgEEMwJg6AjnUwdz07VuwvRhkdmAEg8bDKEKBTrbGssx0ve2vQ/6j7Psjcn5u8A+1NfOaHZV0ysucLCNyJrxpxmIkpnD1B7cw4PfAnsXiDv5p94d8oTufSg92FBaX4Nt9WalklZYu9s4Cy4M5zEiEzkLJZQFLwpKoF849qP2b1cR9VSYdHZkTkbprzrVChglSblN4/y5iWjPgQJGsSVW73lH/WDu2k9G9DsHCvPaxEvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHz4OoSLEDxf/jbqqpXpMofczm0mSDFvnNdlQbzk26M=;
 b=Ov0omNR2hXIo+KrItYbQV5gK6u6loIiEZ+I3Jwm7YHBDnh0Egf5SaNzSyfRht7/QGDtT4srxfvbDaCE9OvD5QZFBcZ4KRE3c5SWTR4FKmfNEJli5k4V/NEFQeLjkWJmygv7AhMhOTVOQdvrEX9KH65TaemE4WRk2vKTsUvuRxXE5vw6t1Zaj8L4GSX7OsA3gBDIfOANvwPieCAXnTDzsrFWmgeTy6yrBNa6KNkJtNIMIRs9dOdpna4NPds/fTwwiwkKSnOuNs5+9H0ryaYu9OwA8S6HyqsYpNe64+lpM/YqmFjel190UprllJhMCApx2MygjivqBR5ebFAEKOV6kIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6224.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:561::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.20; Sun, 7 Jan
 2024 11:41:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7159.020; Sun, 7 Jan 2024
 11:41:37 +0000
Message-ID: <9430026a-6e3a-41ec-a168-b71543da6517@siemens.com>
Date: Sun, 7 Jan 2024 12:41:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Inquiry: Xenomai 3 Compatibility with AI64 BeagleBone & TDA4VM
 SOC
Content-Language: en-US
To: Mit Jothiravi <mit@mytra.ai>, xenomai@lists.linux.dev
References: <CALB5FwhdXM=a6H-Rz63Ww4yE7hz1gTfi4MHdpAdKq_f9Ba-RDg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CALB5FwhdXM=a6H-Rz63Ww4yE7hz1gTfi4MHdpAdKq_f9Ba-RDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d8b23b-9c62-41e0-40fc-08dc0f759b83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rnP1qQ8XPjLrDFi8X/7GJwxfrAkJmD3hvDq/fxGd3SYv/p+z2GmwZL5jD5r54YPQi/6ijUPzueYppclq2RY1dh9ZP/mq0ktL45CSewjAaIRHi20fgQBjKYq1004xqUBaMcBcotxuksTczPuXIja1tQOkRLc9Ru9kNpvJs5Uur6+kmt86POqqYualRLbOFT5EmRNnvmJDfIcgaQzy0I4uqj/qcmjubXPLIP3I1wnK/IwdGH0w960CUyY3hJkFoiCi2ZC5iLuuV6KmRX6jMBpsVsmk0Qg2Wu2GDRiJCT32RnCol1Ys+CevlOjk8k3mTLIK7XyvT5c3VuXg3zheo+Jvo46qWstVnhnaFljl6Iy7XHWTsnQz0miyF3F/mmc+zFAslSTQ6VsK285hjK0WKFhoqH9JcV+kTUeLJsgEHHpwhkWg2zrdaBwxsg3RvGP+ucCXb/Q2njznYL1zsyXmWry2hzIjdalJqOlCtVKErOAF+oN4pf2wrZn2ANORZGlZm5y2W4c1IZhrb+JNyYwrqrg4jxGBOupQ2E7/jsFenqamEYGRcFyJuUpMaEi5fFFFnVoTDRIUL06yrVIB+M1JBACJizA+pD+1gTG1ZGW0+Dnj4ux2MHNljrPT/b562iuPhy94cx+hk9kMY7JXNiSf1javgShs3K2LPM36uziHxhOGxUybITHj3EpxrT3ecksXThkv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(3613699003)(26005)(2616005)(6512007)(53546011)(6506007)(83380400001)(44832011)(8676002)(8936002)(316002)(86362001)(966005)(31696002)(478600001)(6486002)(6666004)(66476007)(66946007)(66556008)(82960400001)(38100700002)(31686004)(5660300002)(2906002)(41300700001)(36756003)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bURHNFV1R2prR2VHWHFVRjZKempMLytsMWtwRWp4bVVpbStqVmtmVmJVYjNp?=
 =?utf-8?B?c0pmeVphT3BnNTJxdjhTWGJnUmRlYkVrTUs4b1VNVkV2alhtNk5JVDRpc3lj?=
 =?utf-8?B?U0Z6NkY1NFlZUEFTRjdSWjNWVUxwaWowVGYySFhqenA5NTJNREZlQ2tlRjNx?=
 =?utf-8?B?MXdrdG13NmVxUXFXb1U1VXc3R1NSajUySzRRVm41dVJMRkhYWlpqaS8xdU53?=
 =?utf-8?B?L2dOUHp6MExrS0syVmJmcEIwdEEyUlcrTHJ0RFl0cGhDbHRZa3kvVVVxL2Yz?=
 =?utf-8?B?aW9oNUZJZ3RnbFl3ZTdnOEZ4YVpKT05IVWhmR2o2TFNUWjdPWDA0K0twQ1BQ?=
 =?utf-8?B?T2MzcGFOTEJNNFRwR0UwaW9xbmxHVkQvUXkwdFVhcERqOC9KeFhrVmsreWdi?=
 =?utf-8?B?TUxiN2lHcW02UUw3TGV6V1dmRUE4QnpwWjJNU09RaVpjVEhZY0RXWEpCY3lW?=
 =?utf-8?B?RGg4Y21nblQ0bDNReWdQRk1KN0gySDBPSXdTQmxJQnIwSTdWUXFOUnpjMUk1?=
 =?utf-8?B?V0R3cmZBbVJWYjRqOVFDMFg1ZW1VOG1vUUJ3U085VnVRMDJxaWJhK2g2aFFW?=
 =?utf-8?B?ZUpidlBwSndZK203SFU0RXEvTFJ1OU12L1dCMnMxdWVrQlQ3RnZwVW9EN0xX?=
 =?utf-8?B?MGVnTno1dVdDR2h6MldXREJpSnI3bThMTHpRQWZCS0R5T0lGRVk2d0hLdXRG?=
 =?utf-8?B?eXIxL0hFdFFPS0phL3dEV1FaemtGbE9nMDVaUGdlT05BQ2p1bFMxL3hZYVBC?=
 =?utf-8?B?V01ySHlmSFljNHBsNE5WeUdxVmFMNUJHbXpwRitBRUN4dG5UQXYrWjcxWFNX?=
 =?utf-8?B?aW1CYzdWTWZYNFJPNk1CYkd3NUQ5MWUzMVhGNCs2Q3dYTFovRlAwQmRMdEhZ?=
 =?utf-8?B?NkxidG1iRHljWjJQb1VVcFFTOWMxbno4WEtUK2pINFhXNURPbDBYTDh2ZHFE?=
 =?utf-8?B?WDF6T2UyKzBXb3hpQmtMc3lNUmFCQUxsV3FJQjJPTS8rSlNRdFhicDk0aW4v?=
 =?utf-8?B?ekRzKytNNE9yeEhEY0FTR1QrUEpkN2lQQkszcHd3a2hhTmVlWVV1SE0xSmlm?=
 =?utf-8?B?UE5INnRHYUI0WEpOUncvUWViRmFidWwwc2dEUGtLTXpPRFpnQkZUZ2lmeXNr?=
 =?utf-8?B?RHdIOWN2VVQ4SFllZ1Q5U3plMXhLMkl0U2VQWE1XVUVJMjUvTFAwamxHTW5C?=
 =?utf-8?B?akI0OUlFUEhqQlV3dDV2Q05UdUNCcXAzaGhxYU1jVnFnR1h4OFh3R1ljanM3?=
 =?utf-8?B?TlZJYU5ha3ZJSUZQWnRHdllDcTdiR0pSMDVMMlkvSDlQVThtTTd2aVo2bzNi?=
 =?utf-8?B?by9zQy9PNkJPVVRyYlFQTVdUWkVFcXBEcWRBazlHdjlSNlRrcGhsaWVGYzlQ?=
 =?utf-8?B?MWpyK2Rlb3JnaWg3WTJwRWV0MVdlb0ZBMFR3WVlsUEY1VEN3MU51OXhhOHJ5?=
 =?utf-8?B?REdzRU4weFI0NVBMT0RoWklIckM5dUdFN25NUHl3WjgwRUw5WFhwZDR0TUJE?=
 =?utf-8?B?SUM5N1pDbnc3UU9Uc24ybEpQU2FmREdEYnFBbDNyK0F3ME1GT3gwdlprSEY4?=
 =?utf-8?B?RTZveU82VE96V2d4YzdXQmhyK1IvWk1nTlVubHU2RXJTcmYwMGJtUzlTSDVK?=
 =?utf-8?B?K2dGaG9TVHBxY09KZXhPTnYvcWhUMGtnMlY2UmVtR0J2ME9jdjhXbHJaUGcx?=
 =?utf-8?B?KzZwaXduUUhlSnR5ak1oOE1PVFBpQU5qUDlVc2R1QnNqT3VHaDR0aUUwM1dk?=
 =?utf-8?B?dTQxbTFaamRnU2t5NW1xeTY1bXYxR04zQW1iMkU3Vjhob2o5S2cvWTM5M29W?=
 =?utf-8?B?d29aaHY2dUg0YjlLTTROK0pIdEppK1RRODc3SGdqQzg5ZXd4TnFaaVBuL2g0?=
 =?utf-8?B?WEJHQkpqbHVIMUo0dkVhWSs2My9KRHZGdUtnZUdpQllMS01OdEo5S016NmVl?=
 =?utf-8?B?OCt0VUhVTjJwK0xaMW5HWGh1TldMRW85Z0FNckZyYWJ3bWxRYndNcVByTCtx?=
 =?utf-8?B?YjRxQ1VibWl2NElvR0lZV2VuUGN4WC9iTkFQcUdsTGhSYjBreW5oRmxKNXkv?=
 =?utf-8?B?NWU3NUpEL21kUFdrQ1FtK3FobzkweXo5YU5yeUtsYnRCWmdoV25jRjJ6ek5E?=
 =?utf-8?B?S1BkWWFJQUp6ckx1dDJ5N0NLaXdjSHhRYTNVYzRDMlRCVStzWmtMZmxNMlJx?=
 =?utf-8?B?UUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d8b23b-9c62-41e0-40fc-08dc0f759b83
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2024 11:41:37.8032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JiKsugM9o6jEARFbvkbx/oKHEhl/oUhrtuux8Z6vQKxVqYHcanjlBfjsIGaNT5Mbzg1T0nox5/r6zDSR4MgPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6224

On 06.01.24 23:50, Mit Jothiravi wrote:
> Dear Xenomai Mailing List,
> 
> I hope this message finds you well. I am currently considering
> implementing Xenomai 3 for a project and would appreciate your
> guidance regarding its compatibility.
> 
> Hardware Specifications:
> - Board Type: AI64 BeagleBone
> - SoC: Texas Instruments TDA4VM
> Operating System Specifications:
> - OS: Debian Bullseye
> - Linux Kernel: 5.10.168-ti-arm64-r107

You likely first want to check if the needed features of this board are
mainline by now. It's possible but obviously harder to integrated the
kernel patches of Xenomai with those of such an old BSP kernel. In fact,
the current TI BSP is at 6.1, but I would really recommend trying 6.6 first.

> 
> I have reviewed the supported hardware list and did not find specific
> mention of the Texas Instruments TDA4VM SoC. Could you please provide
> any available information or guidance on the feasibility of setting up
> Xenomai 3 with the aforementioned specifications? Any insights or
> additional resources you could provide would be greatly appreciated.
> 
> Thank you for your time and assistance. I look forward to your response.

The SOC is not directly supported but most of it will likely already
work. I was trying the BeaglePlay e.g. (TI AM62x), and that worked right
away, just the latencies were not yet optimal (still on my todo list to
debug that again).

Maybe some irqchip or clocksource driver is not yet covered for your SOC
and will need adjustments. The porting guide for Xenomai 4 applies here
as well as 5.10+ uses the same kernel patch:
https://v4.xenomai.org/dovetail/porting/

Jan

-- 
Siemens AG, Technology
Linux Expert Center

