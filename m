Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2082.outbound.protection.outlook.com [40.107.247.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E1A20F0
	for <xenomai@lists.linux.dev>; Sun, 30 Apr 2023 09:22:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfOsuDOhQEErmh3qdyA2JKrlfVLHRtl4mWKXgnohZUNKM3IOtI6UgCZyHKqV1WrmdZcCKsORTEF5X83APN6rdeOxRMUFvAyy9G8zNPAX4bIm16H/nqetQETtNvcDs/78OisQhZccISny1FljwgsKnf45BqVtldW/Ude/fyE3vTpiz1dzOWkBLZ8nN5EoK+fItQ0HUzrfZs44XYGZkRW8sDpc5XO65PCR4RIPYpmG21ECOetOh63xRWiEVc0E+63M9H/jOrA7NthyMcnPtvkgT8w8TqMBqAyDH33m8GqoJp62NBussaSyXwWcJ5nBEnBjR5g7A1BJFPpv8C5BYvuNsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkH/72EEcO8/EMIGDDDxyN1cXk6n2JKswIXcituKATs=;
 b=d4q5QndWSdnu9GBvPd+sFiRPBPUjkMtj5X6IFGDdYfUbDozsxUz+rKPc11HCaUYGHOzhhUT4kU7N9PAjjl7/5FntKw7v8MldGAGTHg/6ML/4+xeUL3jMwHf3XKEMM2FUBs94trDnsZCK/K+fOsOJgT6Vmm6gdf2se3pRVx64QYIhWUu3bCIhTUdon+4IB6k0LDyEQQjzzd+q0QYi5MRDZLIbR/WLuUnPB5KW4Tri4Lc9i3D79HurFTICCBqCKoYYPbo4B9O9rvPanBW0L9n6iqDXacJgZ0Zxzs6LK3My4awJYDTM6oHSFZTlfplYEf3l3qS9vVyP/T5HB7ei6RRFJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkH/72EEcO8/EMIGDDDxyN1cXk6n2JKswIXcituKATs=;
 b=IFmcK0KqBwn3TIVVk7SKDYGcw62JZinOGD4hhXwIZ2qXT6fjqfVSX1N8kFZdNI/4Lgv82PEls4C5XMCJlyPP4eUa5Owa4B5rHHGMv8uf+Tsc3CBeufdLsl0aIgalDsiyyxTAZUdpKZNNJt87yhfC588GXLNRgQ0HvJSgpYvKXy0Zh8zkvNlSZrySsxcq2/3U6t6UFqYHmHlK1MjRXNQTALAOEnu13/tFeiXoMSoT0253+fzlNTjvmbiFZE8usPmpYyD6fyzVLO0yADG3Oq7ztiG7vIwuWp2evK1KoyNNd3cyvHPUkEiT1JD2QNUaVyBq+ej5zRYbKWmwmCLQesy8CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5603.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.28; Sun, 30 Apr
 2023 09:22:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%4]) with mapi id 15.20.6340.025; Sun, 30 Apr 2023
 09:22:25 +0000
Message-ID: <6b6aa7c7-147a-9e95-ed91-5b0448b17ff6@siemens.com>
Date: Sun, 30 Apr 2023 11:22:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH xenomai-images 0/2] Update demo-image to deal with the new
 testsuite package
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230426-flo-testsuite-extraction-v1-0-6f026bba9c39@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230426-flo-testsuite-extraction-v1-0-6f026bba9c39@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0051.eurprd03.prod.outlook.com (2603:10a6:208::28)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f54a7b4-26b9-422a-45ab-08db495c68ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BJGwoVg0eeuOYBvsqOqCRH24MQmQZibTpAp2TSPdGrfYvBGzjVRNhkHdR+BlHgZr4nfXYo5W7834fH7fl7/Avf5QfDAVKL7EjFrXLCbe41nFfpKaWQxhZy2yeCD+s+cL3+ThFoNeYi5FQv88wf7ZfySsxx9cWSgV8U2LKgi0IsNs8lzC6faa85VGsWJgkGsAymQUMm/9uJewOvuhN32lm20Nui4l1XXAkdsybJiRaUeLHv2mXP4IJL7j+UYnsnn+BHK+EYS27VNTyyYfhh9MjroQpF1NyM1/fnUTt+6OvWWfSL9oRA5Dwz4jRSvYIgWoc3hnSfCL81/UkveIdpSBonH6kCASc9LfUdlpuaRIqVYpiL6wHgrgy886UaQsL2C3MuruTxweGK1OELLwva0ylzma5uLN3SZczSlT3NSvgpdRaFT9/aEuxp3sA6BktRGhwfqMija5e3L7g14ML1iHcHMTk7q2/VXmiXD1lU3pE2YYz8weh1yY5kOy9Rb0A4penj/R43CMdkZOWSuhGHnvbVMYy2zhACtVLBuVSmd7Jja4rTa/L2hHdpZ4XgGJNl1ooBDKcthnm3q2PghFTn/h8lsSH2L3uBK5SyVGifj72y4K0Z3Dso7lEh1iN0Rvze9Ah3SUyo4fXA7wsbzf8O81Yw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(4744005)(2906002)(478600001)(186003)(2616005)(36756003)(44832011)(6666004)(6486002)(41300700001)(316002)(82960400001)(6506007)(6512007)(53546011)(38100700002)(26005)(31686004)(83380400001)(66556008)(66946007)(66476007)(31696002)(5660300002)(86362001)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OExYYklJV2ZpbGphRksxZkViNVNPQ0JENmh4QU93QW5Zd3BjMkhtemlaOUh4?=
 =?utf-8?B?TW9mdCsyTjJKSWZNaklpRkFMS2ZVVTNWRnRWRkVsQml6eDgrM0kzRStCa1VR?=
 =?utf-8?B?Y0JhWXhPWVMzNFdiM3dsQjRaWU1pTGRXelFIRVB0VG0vcG1NVXpTNExVanVP?=
 =?utf-8?B?UUI5dUoveGltSzE0TGViZ1BBTjJjY3gxYlc3RlBIektxOFk0WVU4TXV3bEY3?=
 =?utf-8?B?aE1sakQzMkJLRXlRdjdMOEsyZW5PcEpGMjg2NlVCbHlvRU1zeEo5WWpmWGJZ?=
 =?utf-8?B?TS9DRytRQlUyRS92S2Y5b3E2RDZ5QWRjT2FsejMzV21hckVMdDAzYnBydVZC?=
 =?utf-8?B?SU0rY1lJaSszMGh1dkkzTHhiS1lESnFMNDNhekptQ1R2eXpydXk2VDUzaGt3?=
 =?utf-8?B?enR6Mzl4eTlrcjRkL1l5YklNdTdsSEVmNDVGTDczdDBYRmRqNTVTODQzOTc0?=
 =?utf-8?B?VUhlMnduRGlRbjFBZnFDQUhNSERqR3pZWHltQWxHM0dLT1h5WlQ2ZCtTT09q?=
 =?utf-8?B?Z2pOL0pITTc1azFRZUxJSlZLU05pWENpWXp5MXgwd0orUEFIcTcxQjlsMDhl?=
 =?utf-8?B?VXNyaVZVRklUL0RyRnVIbjNHekNiUStWS0VMNTU0WGNseEkyT0ZRWEM0N0dE?=
 =?utf-8?B?eEtITzFHNEwyOEIvNDJMWkJOZFVnNUY3Y2ZQL0Q2c3VISFI3bGJnOVR4b3NJ?=
 =?utf-8?B?SzlpNDhxS1JjdkdJVWFUZnlMcHFKSWI1cE8wZlFUSVQ1b1p6RkI2ekhWU1R3?=
 =?utf-8?B?NWVHcTV5MEZxZUdmTDg0NExOeUxHc2xnSHl4c3RURldIaGNDOC81NVVvKzdP?=
 =?utf-8?B?MC91MHE0SkxhM1pVRUFrcnorZS9xOGk2SDJHM3NjRVVnMmxHR2NGQ0g1citx?=
 =?utf-8?B?VXFrT2tsMFhQMzNyTmk2eWcreFBCaXV5QmtXYW5tdU9keXk5TFk1QVZIazh6?=
 =?utf-8?B?QXRPM3dRM2lDSmhlYTNrYXpCNmRONFVZa3dTVjVpeVM0eFU4czk3WDhKc1g4?=
 =?utf-8?B?VlJSMytNMHZ5QjcydVBFa0s0TFVaZEQ4UXRLS1ozZ2ZoblZObUcrZkQ5ZXYx?=
 =?utf-8?B?c3A1UXVmeTVWZTBtY2RKOFIvRlI1Y2w5TVNSRk9WMUprTVZaS2ozYVNvZDJ1?=
 =?utf-8?B?U2VtRWk3YzdScnM2cGIzV2JvL2pLQmZyeTk4QnRPdGdGcU1RZWd6YVEwVXVq?=
 =?utf-8?B?aXNmYnlHNUdRRUN6eFdlTC9uWDdMY01LcjY2U2RwMmZqcjJOMWpxaHM1Mk9w?=
 =?utf-8?B?WSs5VmVBdW9LSzFIWE5jT0Jwd1BUQllzcGxWUWo4cWR3WmtHYXY1aDBwZnpC?=
 =?utf-8?B?c0M3aDh0Sno3SllKcTg1K2RjaWMvSjdUTE1uMGhUaDl6eGxwdUdKVElONWRh?=
 =?utf-8?B?Q1p1anZDSU95OVloRTFNWUZvKzFXbVVkNW1WZDg1bVI1d0R0RWt3eXRMdVR4?=
 =?utf-8?B?L3pDaWRiem9DVzF0ZDVBeWpTMHV1d1I5c0hEZzRkQ1NhbS9abVhCWDY5UDk4?=
 =?utf-8?B?M0RZSGtOaDR1eUtCQWRDS3pyMU1jdWlZNEdaQnY1RWx6UE93ZHFtZk01QXRS?=
 =?utf-8?B?MEpTVEpwSHdCWHZieEFqOHgzZE5UWnB6ZUtGYWxFYVY0MDNHQlU2cEpoRk43?=
 =?utf-8?B?QlQvVzZDWlp4OHhOdGNYS3RGQ1IwZUpWRndaQWs1bjFWem5RRjBkK2lSQVZ0?=
 =?utf-8?B?aGZCbHJhMEJ3Ynlxc2thUWZuUTlqa3pkbHdtZDdIZGNDQmVDUkZlZTRDNXJa?=
 =?utf-8?B?QnpncjJYMEVFL2hNdFZoNDh2N1VjMnovSmdaVTZOc2pSOGkrcnZVU0Yvc0NU?=
 =?utf-8?B?ZnhrVHhvKzlFQ1VYaTJWUVJDYjFNd1UwbTBqTlV2ckR4V0VqbCtNb1VaZ0tG?=
 =?utf-8?B?dzFNV25FL3h6UlA3M0IrVmtZT1NoMUc4NGQ5NHlRZkFQWC93SzBBY2p6a0JQ?=
 =?utf-8?B?ZFJSc0hsSC8rZnNmVEVWeGFMRysxM0FCa0N2MWp5VzcyZUtqTU1FanVWZ1Y5?=
 =?utf-8?B?QW1DVmFTUlB0bHowZjY1c2w4clQvMFNsbXpQODBlelpYQTYwajdkMEN6ZFJO?=
 =?utf-8?B?bzVQVG9UUWdSR0tnU2lEK1lFT3p3Z1pVQ3hlbllBa0RZZ3R2d1lwWE1SRXE3?=
 =?utf-8?Q?8MXDUe5IyEJRMB7Kbxw4+KPgQ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f54a7b4-26b9-422a-45ab-08db495c68ff
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2023 09:22:25.1556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPa09RKh1nbVb24tHwVt6C4Vx+DNcFzK7sdx6xtzXQDnp/UTllCKYlmYiTKXWRK5pYuPHBSfxNyq46kQg7WbBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5603

On 27.04.23 13:56, Florian Bezdeka wrote:
> This series depends on the previously posted xenomai debianization
> patches. Both series should be applied in lockstep.
> 
> A full CI run was triggered internally to test both series. The run was
> successful, all tests passed.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Florian Bezdeka (2):
>       recipes-xenomai/xenomai.inc: Split up PROVIDES
>       xenomai: Install xenomai-testsuite in addition to xenomai-runtime
> 
>  recipes-core/images/demo-image.bb   | 27 +++++++++++++++++++++++++--
>  recipes-xenomai/xenomai/xenomai.inc |  9 ++++++++-
>  2 files changed, 33 insertions(+), 3 deletions(-)
> ---
> base-commit: 61317a5eb9b02c09f3400b7b60c8333219a772cc
> change-id: 20230426-flo-testsuite-extraction-37d51e4213c2
> 
> Best regards,

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

