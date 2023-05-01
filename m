Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2075.outbound.protection.outlook.com [40.107.8.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1BB20E2
	for <xenomai@lists.linux.dev>; Mon,  1 May 2023 12:03:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8eaj+ncgHXkmyF15VsUyr5eLW+5LpZpPD/e0FWPw3OeCpJuf5vO5raJNe2S5zLqEO434+LMpJuBWQt98bLef/fUVo57e4JR1giwrBKgCbaIBlZCU+9gcSs7z3cMPKY4NDEio5M/Idntzi/wBaM7RiuX7AxiCzV04knVt40p9gH4U/OVuuQhkosaHhX+1Co7TPZZFCF7xhRONQY08kzDjVPPxao88x/oCQ33uWwqwcA2B182VEn8RZKtWeG0FAg2IqhMH4GHlv6uh0ZCSwOT7qk8FK7ThadOkMRL+fws1NTHOad0v3HJPqwu4aYb8XPDNIIS4yhiQX1atkdWzaLIWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEDeS2QwVLRzoSEI8PEK/Kpa/uCKLkGtVWhmx34sih4=;
 b=lr+IpcGRjeyzhS4zw+5Qpq5wmQkEUvGE5W6H8EoAIcjJObz9jC9UqTYCq+rNHJHygEI86N9GnJTjAkG4U4lCzJ6B2UHzibUL5KNzXeekIn1A6Fj1yxO2iwY1sq9WlKcwgjwrO0VdMkvigWn9QIxCaBq00FfzgIqSRcTsV2TJ+rT/UVqSHT/IUaMlMJTunyONjAgIfd6Y1wWgkHGm8HXUnPxPAHObvOhXc3/ARVfCRgbZe05fJqsYnvXokOFv44AbebI7zgWP8zBqhnbnSYqeobdnS+f6cqV+K3pKZ5eGHtOLzjYF4htWPFQBvTfJw68ufdXAHhtyoC/udxr3Y00pTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEDeS2QwVLRzoSEI8PEK/Kpa/uCKLkGtVWhmx34sih4=;
 b=IxOsSe7iqEjUHj0cKXPBTB64NJCDIg1LyQhp9sfsFz8ACzIcvNxXoOz8lLeXUjLUoLWa9TbYDC+rdn5apvO/+Vyt1yaceH6yKuZdcxOykJTo6kVcfPfeWLnDnvSp1P3itqBhC3vkXIRhGYXHIMxbcWl7dzxNToev9eduo5EG4+cGuOKQrOZKe30+dVOjEeBMAuDPWQFyPRFkEONKQVDHOx0GjpWGJnsa0bjh9zbSRMEx41taOMT/DXJVl+ttTenbdhJYJjed3wQ18kUOc2EkZJk8xvS8ZrhmQqRh8ViIJEJCUOjVDbLlA/0ziojXHMeM87V6S5rs+6i+Hr2Z/6kYig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6195.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:94::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.26; Mon, 1 May
 2023 12:03:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%4]) with mapi id 15.20.6340.029; Mon, 1 May 2023
 12:03:31 +0000
Message-ID: <6a6d05df-44e8-b217-0a6c-04cb0aa63c1c@siemens.com>
Date: Mon, 1 May 2023 14:03:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai 3.1.4 released
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P191CA0004.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb6f076-9cdb-40c7-a38b-08db4a3c14c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vOBnhJEJbOn9iVUEv0kYmX3mH4Pn1JYdWDi1j8IIJMAZWyP+nMU6wgD4rnOqgTiLCFqVAUzRBEhoQ18IKbFArorzc/CxG0ZKmCHeQoS0gtw0bv/q9repdxLbuV3nNh5n7Cw6B9qMNma4DjWs23PdUW1QHdeYmbLQgQvAn4IhO/gr4hNC7s7Fu9NDg1XiU1gpLyTLty3YCwCoWFnujaLs58fAvYfi6Petl6IJQg7eyW6zGnbt6Szm9nB8zfCj2KY8OI30LdgitvDmf/vaC580WESLamXCD063uCenARWpOKJjJih2RBrBfAxiVdBc2kJFCmbgTcHKl+2u6g2DgTdV7VYR3gGnUz0zncqVNKl7quqh5Igs1rHBoyO8+RlIsEAQEC/w/arM9BbuhA0c2JAWRTfIFonkespTQ7WFZwYjijabC8a0QgiN0+oiFTqwEp4ZSyk2s+YKpn4/B0G/3vcS1i+OMBeQEXshVPTHc3D0ePik4MCJquq7W7nZhAgJyLqR2gDnQbDcVRMpbcMnDTRdnCNxG3ySZZF3xVlC8oZpicWMBYfzeWKHfbBx6UxVbhM5Nk5VXDAmAP0VDSMrUAifc1/cIiQR6dz/005tvpBAykipaxSEKiLCGwNcW9istpEU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199021)(6512007)(82960400001)(6506007)(26005)(31686004)(38100700002)(6486002)(316002)(41300700001)(5660300002)(31696002)(8936002)(86362001)(8676002)(6916009)(66946007)(66476007)(83380400001)(66556008)(966005)(478600001)(2616005)(186003)(4744005)(2906002)(6666004)(36756003)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnJIS2QwbFZvMVBMZk1jNzV6VW9pRDV4Z1NnSXBraHZsMFhwZjlWSDFYdU1m?=
 =?utf-8?B?ZmNFa1VzVk5nZlArL3MxdTlFYWF3bWRlaE9PSUtpZEYvOFJJSnBod2xvbGpV?=
 =?utf-8?B?eGpDdXZ3Tm5ndm5WTmtveFZESzl3KzUzOUpTb0RqRmhmbnhnZUhlWWt6ZXJs?=
 =?utf-8?B?RjZ5N21QWDNwa2Jwa2lDR0NQSWk4STRhcnA4TlMrVytEbE1FSU1mcVM3T3J3?=
 =?utf-8?B?KzZYVE5qdjhHbGdhSFlDNXhrbERLUFpuNXZQRlNzR29MZXdEWm9jRE9Samkv?=
 =?utf-8?B?OXp2WU0xaXpPbXhNamY2VXY0VXZGNmgxUVRadGVUejBQdFdneGIwR3hYTTJp?=
 =?utf-8?B?L1M3d3BPV0g4eDE2TzF6RGphbkhKMjR0VkVOd0lKRURYRHZFWkVwOVNVdE00?=
 =?utf-8?B?NFY4RE15OVdrUDFnams1UUFhb010ektPTnRnazgvdW1La3RTaDFHMXQwMnpl?=
 =?utf-8?B?bTB0dWFUVUsxNTBXRE1SZVZWOWxHSHR4SjIxSU1sSXhzTEJYMll4cW9hWDJN?=
 =?utf-8?B?RDNMTktBNTRBdkI2WUhnM3RkK3ptMkhmYmhjVVh2aGNNZ3J4VlcveDRvcnJS?=
 =?utf-8?B?TFBLNCt0K2FkLzZhLzhkWjVTL2M1YVhZNkJYVjBYQjR2UVhlUk5LUW40MEhG?=
 =?utf-8?B?WTl1WGFoRUkwNzY0RG1Vbm9mazBqQmVnTmdiWjFrWS9XMmwwWFBJYnc4NGRr?=
 =?utf-8?B?MHVCUVVEOWNRcWxYR2hPR0g2aDUvVFVsNTRSam1lSE9sQ0tsOEpwaUw5WHJZ?=
 =?utf-8?B?dWt3TUxUZUo5TlZuUUJVWXV0U2U2M3Bnb3psc2lza09zWFNFUDN0azlmV2Zu?=
 =?utf-8?B?dDQvZGNWSjRYMUhra01kTWgzQ3kwWDhpdUJ4ZnRsc0RLVkpXRzAzSVRkY2pi?=
 =?utf-8?B?Y2dPM0VmMlNDSnNRdVpTalVFdHdBZGNNQVNGeU4zUzhrZnNMdVBZRitGNFcw?=
 =?utf-8?B?eXNUREZ6U3lyS3NjdU5kcUQ4L3hDU1g0cHhkZUFHdzNhU3FEdzE5OFNDdndX?=
 =?utf-8?B?NkJLV21sUUhOTWs5OElSdjFzZUM0Ri82OVNCaVFvQnBGSGhhVjBRM3g5ck02?=
 =?utf-8?B?TU92Q1NTTTJ5N0N3RXJFdDhMdlJrSEhvRnFFOGg5dFZHSjJqbVVobWpNRSt2?=
 =?utf-8?B?Z3lUWGtmMGh5ZU5mSXFxZHRhc0tUNUJwU2Q5ZEdOSHI4UjFDVjlnaXMxWDVs?=
 =?utf-8?B?WGFOZEsyeld3SXdmZ1dvcGtjUFBRenhNOElOd1czM0NHcU51bkhWTzJDVUxB?=
 =?utf-8?B?NWI4TnY1OWJxWlVTMlZDMVNyY3hLZlNSdkhDTm4vSVQ4eDd6d3JtTm1uRnFa?=
 =?utf-8?B?aDVYM1hyMHM0M3lRdFMrdGJrK3YycXMwQlVJdGhxN29rdEZubVdsbE9DWCtZ?=
 =?utf-8?B?d09BeWFXVVMxSExsSVRvVHl2bWhMNThXMU50ZUpMTThyak1MYTI1UENiYUln?=
 =?utf-8?B?ZjF0Y0JNeHE0d1B6VE45RndSNnBTNng1blByQmJ0UUdXemUyMlFFNXV3Z01w?=
 =?utf-8?B?QkwxQzRmNUI3RzVYTFUxaDEzUTFBSm5oMGpGaHNlRnRNRHBjejdOdjkwSnNq?=
 =?utf-8?B?bitVeUwrTjRCMGxKM21NeHdrN1l6SnRRSHhvaXFwQnppVDYxRDJoWEkrcmh0?=
 =?utf-8?B?RUpVeXlRVnkvSlNNdXNub05USTRtRU40NVRHaXpjQnpoNW1mNHVGRWpLVHRH?=
 =?utf-8?B?aHVBTHhiejk5NllnK0JlUW9XQU5IemVUSlRnVFJ5SnNxazEzRlVIM3g4OEYv?=
 =?utf-8?B?Q1N6Q1VINUIyVDdybmZjSERIcHY3eS9vTFl3TFdYWWxxNUFUNXk1UFRGRTdH?=
 =?utf-8?B?Qm9vVVM3a2IvRkI1cFFCUkNZbXZPeWpCeFhFN3VsN0M4TDB2eWhuNmtienVz?=
 =?utf-8?B?RzJYOUpWaUdKZmc4ZGtlUFp2RkZZTi9HYkJSckExcCtxV3ZRaEhoR0ZwS3ox?=
 =?utf-8?B?eGRMYlFvZVFJSmFKSVkwaUpvRFVLQWNDUGpGTHNuQTNrTmRHQWZnUFVId2pZ?=
 =?utf-8?B?ZTdHUi9DUEVUT0d4U3JwdXcwMWJxdVl6MlpRTzhPYS9QY2xPYnBzQVZGdDZO?=
 =?utf-8?B?Qk50aWFTY0dzOHYycGxRc1pPOUV0eTJhc3hGM2F5MnBKa1pETjhEdEhzSGhO?=
 =?utf-8?Q?zTiPKfOTEAJikpGXAJhpvvMTq?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb6f076-9cdb-40c7-a38b-08db4a3c14c9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 12:03:31.2608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EaDGlbcNpx+V3j0w2pm/AJio8MXV4k/dMkPgru8i4eVNbts+o1SHn7ubAulrkXJScGud+jFNNX3++Ano1UvZ7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6195

Download: https://source.denx.de/Xenomai/xenomai/-/archive/v3.1.4/xenomai-v3.1.4.tar.bz2

Changes since 3.1.3:

Florian Bezdeka (1):
      lib/cobalt: Fix possible fd leak in __map_umm

Jan Kiszka (9):
      cobalt/x86: Fix FPU switch during thread hardening
      ci: Switch to native trigger
      Fix several sign-conversion warnings in interface headers
      lib/copperplate: Release main threadobj on exit
      lib/copperplate: Also deregister main thread from registry sysgroup
      automake: Avoid usage of user variables CPPFLAGS and LDFLAGS
      testsuite/smokey/gdb: Skip test if gdb is not available
      lib/copperplate: Add libfuse if building with registry support
      config: Bump version number

Norbert Lange (1):
      fix build with clang

Richard Weinberger (1):
      alchemy: Correctly translate return value from pthread_mutex_init

Thanks to all contributors!

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
