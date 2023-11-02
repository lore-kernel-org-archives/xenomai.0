Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2044.outbound.protection.outlook.com [40.107.247.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE9D1C280
	for <xenomai@lists.linux.dev>; Thu,  2 Nov 2023 15:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="j4+UllsM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZ5x7h3SmKST9In2NcFbKvaVjRwAQ6xZ5CHtXzAzHeusokraj/ENkdte7VNJM6OVb46+Anr2WUt+9kuyyKiYAlw5ZrJuTlAua0/A+gA9vcgfWcZmVgtTfJuMono8hZKz4NJRmfLqHP2zK5Er6NoZm01IyQ0X9vSMzeHw0SciNybjNURJE3jYKLBjGTA0gPG+P99h83SuAlq0cdpq8GNbtXH9StF55wwxJZUDdYlNR7BCOLqUmOO1IsISAb0rWiddU+gosa/XKWABIHcpx139QwCAg1DkF672caD/lRG9FKfq4RYF+Jo69jQxG6tes7x3HSKS6e1hLX3dixlzPoow7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8Bue6BoXXY262wege0YTDT4xO5lPmCFselogldOLcI=;
 b=LVkK8V8pxu7YkoSevNUf3yowAzq3yhMfMJrYq+ERV1TmLOKNfj+dntLjXH0Nux4NKK9Jo0Uv9qonNMDgx96bH2nISn24/DdrSgEJLm7nH83GbQSnCNPbExlvhymy+yurpPNSbdnPRbEzX0W69qO1wTgbwDwxn09p3WCgIEkP86tAZJIpWs7bRLR+du0Yeui7B9yzp0/uIOZsUwZPsNR3bHsxx4upKa7khCLiO+8RYXtdtQe7sgNc1G7qFlDNhrkzTivSptVvNrnNRe5SRpsBgofo8OrkXKH7xTpLRf5CtMT6LlIKswG1SAfvL3Js+uhx0DxxcVhThn3Vnu+w7g7+fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8Bue6BoXXY262wege0YTDT4xO5lPmCFselogldOLcI=;
 b=j4+UllsM/iW8U9/hVQyydGfA2AFPTAeKdKzXEPzCC6Vl5muvYvfvCdUp3rqJXm4fTQUo19btDIqbYoeKXCf+460l7VmHUWCNKZf+un5gXEJqFpytrDqk7om1cwfgVKoFMkK1ZAsveTtwb2gAqkQYZuXZ16o3fyz9eZI460SjHlXd5nrVk7H2EUxDl/8EfETeLD9CfM2vlvm1Y6bFwFWq2Vx5WTqM4fsLvZv+izNGdSbXGZL1z+lymdzdrrurhG8e4AQKL0S7G9pG40Jh0CCgm+LmI+ZdkB5txNEIf1ptLGJxh4cWnnvJvBVvytgZpKNUZ3IvGsNjyMzPomx6K8VJMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7280.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:614::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Thu, 2 Nov
 2023 15:07:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d%4]) with mapi id 15.20.6954.020; Thu, 2 Nov 2023
 15:07:27 +0000
Message-ID: <981e9737-6f04-4406-9fdf-fd37a37de9e2@siemens.com>
Date: Thu, 2 Nov 2023 16:07:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Minor testsuite cleanups
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20231030-flo-cleanup-testsuite-v1-0-0fb7bbd2d45f@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231030-flo-cleanup-testsuite-v1-0-0fb7bbd2d45f@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0413.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: c6231bda-85f8-43ea-3b08-08dbdbb56d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r9yl88/X8zn+HUpTHEvwABMZo+QufP2nykwlIDPua2FsuMA7ZZxTUDPxk7EBKQtGymv2zEZ2lSk9FMNOnKxhoM3gmsOiShzTc96cr8B+FmS3ABt0SkBKULjRhX5eBvQznfLbcz2AjAQKYWhIxerk2pFoig0HNp72V/SBZTPr3Djzds91WlLNfGP1alKAK2UM8lLqm3ywFXz2YTAMvAxmMTMYtDnDXLdA27mtTV0vMphK9CjcyMRPlMGldPgsIilMwZug6M6NKbmTCBaMtVq7F2g5iAYRs6USB98yM0qBU6O7etWh0IygwQEsCNznnvhJwPE8MFMmuZrW6Op/7JSofa13k8vKbO96ceOpzEW3O+gNNRYb2pGHoyuBbWfYz8nEgSVq1Icvz2FOkqAZnHl8vbUTgmZoW55DKaoGjCL5BkeQGlg7V41LnXE7DWAlva187yOAvpdv2+ebRKNUNoYSzCMmUf08xnBPAoerynfoLeZg7C+H6pcmynOCl8ojwvxr0oVLtgi2YuCgFnnKErPiSU0OjPO15PcwyZ2tx4y5Zo4DpsRMN2f/4ekP1OMFrXvxrC+kW7B3vRD6DjmO5I6UZ60xhZ9XMCZEGM4jqMEDwIcjfPBCySQkPACWz2e0n4B7ZdwuDSVghQ5j5xFgA31BXQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(83380400001)(31696002)(8676002)(2616005)(26005)(44832011)(31686004)(8936002)(38100700002)(5660300002)(6512007)(6486002)(6506007)(53546011)(478600001)(66476007)(316002)(66556008)(66946007)(86362001)(41300700001)(82960400001)(2906002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1BjTzVhKy9MY2ZIbCtzSm1yYks2TTdPVkZYOUJiZUV6KzBVNDN4MnpxTS9U?=
 =?utf-8?B?TWxhdkpHVk1UMGJCLzRORFg2cUJTQ01mblpzUkNOaThrVTQvODRBR0plQTEv?=
 =?utf-8?B?OUh2MEhwaVV0QnRsazlvSkFtV0RwMlVpckRNT3NRc0NFWVJyM2dDL2k4T1dX?=
 =?utf-8?B?elJVY25jOHA1U0VpSUplbFNhUjBJb1kwMHc4a2tBM0VLdU1od0p5YXpFbXJa?=
 =?utf-8?B?MEY4VE82RVVpMDdlVDI4Y2M0ZTRyV1Z5STVQbVNYWHJsendOZnJkeEloamZX?=
 =?utf-8?B?MmU0S2xOZk5RNnlrRW5wTStXUU5XNXlWcWNhNXVDZGJIZ1lhbmE2QU1qRUl0?=
 =?utf-8?B?TDVUTXY0M3lWZFAyeVhsanlROHZIMTJ2YU9aMThHTnlIOFpiY0VBMGZhVUM5?=
 =?utf-8?B?Ynh5ZHIza2lrZHRaWTZVRW9telQrQVVtejBjK2pRbUpEamk3b3VuMEw4UDJ1?=
 =?utf-8?B?NWtyQ1dTczJtYUZaRVdnR0YybktSdCtVMUhSMStNT2xtUTdQelZPUWk2MUdx?=
 =?utf-8?B?ajZoVmNyZTlPb0V0Q29IRUR5RnNyenMxaDMraFZEaEo5RXo3RVpEVkxCd04v?=
 =?utf-8?B?Y1J6TlY1NVhheE5xZmhQK3F4MkZ3ZFQ1b2FoTnFmWHVwcFJ6MXMvakFhTmw4?=
 =?utf-8?B?dVZNNGw4SEpkQ1B2VWF1YU8waldxYnBnaVhaT29ha01ibTczbnZjVWt5Y3Rp?=
 =?utf-8?B?Q2NiSWVpTU44WHRIYzh3WEtIcGZ3MENwZjk5YnpGTksrODMyQ2FDREhIblg0?=
 =?utf-8?B?eEV2MFJWbjBZN2xtNWRBQUhwdmtiUUcxUmNLVGJqU3NzaTAreDZLRWgvRDdD?=
 =?utf-8?B?NzRSSFhLUldaOFVQMDZ5RDZaTGVQUU5XQ1lYWVNrakFUZ1JXaUplRncvdFRT?=
 =?utf-8?B?Rk8zUUs3cGJuY29ROVNDeUVlN0tvWUlWUWdVUERRMUNiVXRKeWtFanhaZk1s?=
 =?utf-8?B?WU0zWGtWeUZMeWZCb2pwVS9SbURrVDBLQWkwZ1luNHRld3JMRWRZQ1lVMTlW?=
 =?utf-8?B?bHdzZzBacmwrTnVjVE12d1ZhR3BmMjhHd0ZqQnhuSXI3ZkloYlB1aWRKeEc5?=
 =?utf-8?B?N0ZpQ1V4cFM1RXhFQlI1NytFSFVtL1lDR2VSK0JncDJKaS9vRkZsdDExVVJG?=
 =?utf-8?B?UnV3U21USWErU0JEbGtDSXgwaFFLTC9pVXZPc20wQlFzc3R6QnRQOWdpZy9X?=
 =?utf-8?B?SDB2ZUZHZGtLYjYzcEFGWW9UdnI2MzJKYWpob055SHFLbFprd1NKSHp6Q1hm?=
 =?utf-8?B?TDcra0lwb1lrWkZMZWl4d0VPMnNsRUVPd1Q1MjZIbVVyM29IYVdxTFpvTUNF?=
 =?utf-8?B?T2tJV20yeVMrQzQvVVFnbk5XdTFCbFZlM3BjY25nNExsSGUxK1A2czdZa0JE?=
 =?utf-8?B?Qm1OTllCejVET3FTM1U2ME1ubU9iMEQraXYxZlJKMEd0eDRqZHczbG1uVnRO?=
 =?utf-8?B?bytZUGRkNWZ4a0wrVGJQSFVRUUtpc25GRXVxTTJ2bzFoWHRXMkwwaDVpSHdQ?=
 =?utf-8?B?N0VRQ2M5ellRZzc5czBmS1N3WGNEQXg1ZEN6dGF5OGl0V1F6NVpVQ1dJQ29p?=
 =?utf-8?B?YTFnNG0yNXpHZ0MrV2pSUFB0TUdaWFJLNjE2d1JIVWkvQjl2ZTdkV1pkaXh2?=
 =?utf-8?B?Y2toTGJHNVFRQmhBUzF1bytMc2V0aE9yMUhaVitVL0JYLzRHRCtycVpvYWZ3?=
 =?utf-8?B?czI4ajJaK29NVGZvd0wrWnIxZG1BWXVZMmZ0R2pxNFNyRmh4UVNTQ1d2dkxG?=
 =?utf-8?B?ODN5NTFWVTlNZnJKVEhTTmhzYjQ3L1UwSXFiTWt1TmxlU2xCdDVMWjZxbWJ5?=
 =?utf-8?B?RzlMS24wN2JsMm5Hbk5aUURuR2dWRndoaHZacHk0S0VSQlJoZHg0M2JqRW1y?=
 =?utf-8?B?RlB4MFIxVyszbUhCc1R0R2N4TjdqdGc2QmFhTXJXUGdZTEE2U1MyYTlzVS94?=
 =?utf-8?B?NGNVT2ZmV2M2bVFJSnVOOWx2ZWF4cjVSTXBna0IvUStVdkNmTTNCR0JJeUpk?=
 =?utf-8?B?M3NPd2pLY2ZrR04xbXN4eEl2TE1sUTRMTUgrYjdWUzJkNnIya0tZZUllTk1r?=
 =?utf-8?B?cVJPQUlhdkF6b0hlNkh1MXFPeU1Ca1NOMEZDVlhlaGVySndiM0pjV1k1K1hR?=
 =?utf-8?B?eWQrTmxIN1J6R21KYWwzSHE0V1Q5cjRJUUU0VDlldFRGcjNQZWJLYTBmN1Iv?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6231bda-85f8-43ea-3b08-08dbdbb56d1e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 15:07:27.1277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JrfdvYIkLk8rcX2ti861lLZMu6/ahJUgdNPakyO8MOGAia3QQEY2irCFKMHsfHBHz98z2HjPq7tDI74m+Qp0ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7280

On 02.11.23 15:41, Florian Bezdeka wrote:
> Hi all, 
> 
> this is the result of the analysis of our recent CI logs. Seems that we
> did not properly report failing tests and continued with test execution,
> hiding some real (but still minor) issues.
> 
> Best regards,
> Florian
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Florian Bezdeka (6):
>       testsuite: vxworkstests: Do not try to call nonexistent binary
>       testsuite: smokey: Refactor smokey_run_extprog()
>       testsuite: smokey/spitest: Fix --keep-going in combination with --verbose
>       testsuite: alchemytests: Skip pipe test if kernel support is missing
>       testsuite: vxworkstests: Skip tests if low resolution clock not enabled
>       testsuite: psostests: Skip tests if low resolution clock not enabled
> 
>  include/smokey/smokey.h                      |   3 +-
>  lib/smokey/helpers.c                         |  14 +++-
>  testsuite/smokey/alchemytests/alchemytests.c |  74 +++++++++---------
>  testsuite/smokey/alchemytests/pipe-1.c       |   8 +-
>  testsuite/smokey/main.c                      |   5 +-
>  testsuite/smokey/psostests/psostests.c       | 109 +++++++++++++--------------
>  testsuite/smokey/vxworkstests/vxworkstests.c |  64 ++++++++--------
>  testsuite/spitest/spitest.c                  |   5 +-
>  8 files changed, 142 insertions(+), 140 deletions(-)
> ---
> base-commit: 14470d7d58dbfe7210cfa93f03e241a38d9fa798
> change-id: 20231030-flo-cleanup-testsuite-bc6ea7f6dc31
> 
> Best regards,

Looks good, pushing it to next. My comments can be addressed on top.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

