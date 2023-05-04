Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDEB4C62
	for <xenomai@lists.linux.dev>; Thu,  4 May 2023 08:19:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Krrh/5xQTj6516btVWhy9VjRreRTIQUqLTjGiJaix9L2J4VZnD743D4KmtHwB1ZrHJo6i/4MyFZTsc4ke9+VjjuRt95E8ygFjkYdUFt7NtRikiS5GkU0wvpCRbhnm4iT9C3JHcXByOf4uvwUJlIGME/hGGcNnGFb9Q0Kb9lpne7eE+mnfJtHa4JvDc77YKjZg72E3xgL0Ao4aOg1GEUiJtDQzNriXI9ERt3a7D1z2jF0wCDaUjmqr4aVMC+EjNfdG6gTVC7fAn3UBKPqvDUUFQP72h9l86LsBG17PBOhI3yif3WGYcP7JTXkmyB46aA92F3949nciQpbPYcozwqdOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4ULNTnIis/8+cOmb8mcglhst43P66dW97EKOIUfves=;
 b=A3bGmvM2g7vPfbgYJuEiC8/NqVBBUnd23mIS392Bq0lw5B5I3v0NvOIv9DxFlFHsXdeHBtQ1aX9LcT5ArOtWMdQv1VNhoR1Rt7IYKoXxLNpoEcJJb2B4CSEcxuWszCnTb6HPHCRNFKK5hBixuLk+2g7Xt3mtZtw1HcDJgqQLyIQK59OcfEbat30Y/sYiV+kUwhg9NjuR1GCV01YX8Vsn7Iju3JW3bFryYZ2RSz8VBUDS5F0dd4pIgNAxuaZf3RYeJBHpWtykpa/iql4Og/bfEUvdl4TFwaDujj4ZqhE+RVu2dVpM8JRvU8+GtkNCcVJkWrGF1jiAI87PqyjQf+zTkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4ULNTnIis/8+cOmb8mcglhst43P66dW97EKOIUfves=;
 b=oR1FJZhl4sSdnJOQUpG9giA3ZlkdFJYHP9Mcd7nZdlUncdXbdjItYMGh5cXyZELqMLTXhLe8gzolhgaglrQHkELJN0MnHGysWY8FLeYZC6H3xwVkiEm3H9klydB96GxM+VE/UAn702c0u0qzfrDoED5Mg9K0E1OLI2K0RIftnaG+Dx4bfRbZAtJbo7gfQL/TGKjhPrZu1Wu7Pt3q3sa6mDVusJ9lp566XmlGDYRhZ1VsP6vAa7Y9jUnYNQrW7EChdFl9kD/OzU03bguHKftc3+7WAoKH1An3a456Oux79HmiPGthrDX+gS45jb/E+PkzCIIGixNfP4I6rLslbWhpTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3632.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.21; Thu, 4 May
 2023 08:19:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%4]) with mapi id 15.20.6340.036; Thu, 4 May 2023
 08:19:30 +0000
Message-ID: <7f60f322-1ef0-66d6-fc8a-9a75aecc13db@siemens.com>
Date: Thu, 4 May 2023 10:19:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH xenomai-images v2 0/4] Lift the base distribution to
 Debian bookworm
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230503-flo-debian-bookworm-update-v2-0-f859df1417e6@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230503-flo-debian-bookworm-update-v2-0-f859df1417e6@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0017.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3632:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a56d2e6-ae15-41ee-d9c8-08db4c7848fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EQQ+kUafszx9zelqMl2F2k7vW8K5BBsyCK5VswpEDj75pxURq0/YTfssi1UDltvFjcnHCY0KUY30XqkA4zEwEUPWYKF7FxsxmpA3f9ZpNQgxZ+4kyPEMkQIthTny5z9mjwknQaNiaW8GOC4WgOYewPXvTsRxX4ZQRwuIRXJasJmSHl7MApOodZQXEO9WBJvORvHMPBaBskrFwWyU1FBPwyNUnzE6YNEcKLQce3iiWkqNfEUBBsYOz7QmFBOMA4lJNpUzmQuHXZRoVvrDE7dpLT4HdVjyGqTUzkbxhyA6RkxAcO1lZUlgsK2YFjRjCWa+g61/+HoMZ5Bn8DBUEbrm8cQx3nXWZZOqrLP/PTzSEA12FVcfU93eqwq69AD0BEIS51jIQhoHKyJRb3DhWLpZcIjnMc1Lb4YF/zKKbENR6+Z9Buyjp6sLoZq37TEkwTzu6kWsyq6HQ83ww/KgBC1P0CT8WVw9JJeYZQl78vqa9ok4wZ3/a0jfHOnXGmoH1cuQQZHDNcGA3bTvyereW54SPFTPZzz5gpK7ud/AxKsYoAjjWpuXpowrvn85DfsAMmszVlIROoHDHugUgcV/mcGr1oytn9c0zJtOsvs2pSw4qgzdX1p/6mlb7F3eyyyOFoOlBVf1isNvru/YAGgTShJ7MyBwJLWePX8a/zOjfXgvqd175w8JQcFwXLkNUbB+x7FN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199021)(5660300002)(36756003)(478600001)(316002)(41300700001)(8676002)(44832011)(8936002)(31696002)(38100700002)(31686004)(82960400001)(86362001)(66556008)(2616005)(6666004)(6512007)(186003)(26005)(2906002)(53546011)(6486002)(6506007)(66476007)(66946007)(83380400001)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2hCQ29paWtJMzZOajAvSTRsaklaY3Z6TXkwTlAzeDBCMWhYUmpWb2oxaG0x?=
 =?utf-8?B?ekxyQjhBTS9NemRhaVZJYWZRT0l1NzVZbjZIYlZYMEdsL0tPR3VEN3cvZnBR?=
 =?utf-8?B?UkRncS81Q2wrcjdwNHdEN0dSS0tHbnJnNjlhRXExTTZrUzZ5Z0pCMERFRjVM?=
 =?utf-8?B?M1RHVDNRYkQ1em1Qam9WUlBjdjdzVXJrRm9WOG9FcWpjR2plcHBRZGFjd3pK?=
 =?utf-8?B?aGZmbzdpMmhqSTdiSUh3bXBtRHg5cDdNUzN0NmJMSVhWSFFLdHVQTytvdkVr?=
 =?utf-8?B?aEo0dG9zV0hPRm1GOWo2enRHUFFxRGUxd0YxYzFUVGFFU3ZNc3RnemtRckE3?=
 =?utf-8?B?dXdzc2FnOTlTUEwvUkNoQlNCUlRlaWZGTllmNUx4ZHVVbDAvVUZSS21sWkxL?=
 =?utf-8?B?V2cyOWsxOUtDelA4aTB3OXBBMFNDdldJNnlkNEg3S3RodUJZa0dhWEhWaXMz?=
 =?utf-8?B?R0lXU3NDa3FIaEdGRWhVcXBEZ0pHNXhjcDYrdGR4amk0b3UwK1g2bHVQV1o1?=
 =?utf-8?B?UURGOCtnVllUVFF4bGFBUW9UNzBYZ2d0dTRtc01iU2dmNkw5WHBPYVdqL1NL?=
 =?utf-8?B?VzNncGFCZmVvbXRXM0VBYXk3anM1bGcwang2ajhSYVB6RjcxZ2xwZ3U4czBh?=
 =?utf-8?B?RzUyR1ZwWmZybXpkVUU2WXNZd0pYSC9KbzM3RElSSXFTMWUreStjZk14S1Z4?=
 =?utf-8?B?Q0NKbS9JNGZxTzVGLzloWUUxWkFZOWp6S2NNZUhFQVJ5L0ZUUis4QVJqclA1?=
 =?utf-8?B?RlZMeUN5S1B6RFV3VjdMWkhHSE5CMXJmTEh6dkpGSm4wN0g3cys1VEFXVXhq?=
 =?utf-8?B?eDRBQzhBTzVGQ1BJUElmdmsxSXFwOGYvTTNjNHVlVTBhSkROeHR5SW1TTmJM?=
 =?utf-8?B?SmN5L24xSjdMeTFxbjk4YXlWZStydlQrRitKb0VwbS9VYllubVNueTh2NGFT?=
 =?utf-8?B?aW01U3RWNWNESXVWSE9Rd1kvdVdFby8rcEdTQ2QvVHp4NmlCRmdEWVBPMWt2?=
 =?utf-8?B?ZWpvU0dUWi8wY1NJdU5wa2NDWHJQSDJzeFFSUXRjNTRHUllHNjMxUWlmcGNw?=
 =?utf-8?B?OXJYUlpXTUVjMUFXN1B5cGtvdmkxalhKbFNld0ViTmFoeTZ6ektlN1BKajFU?=
 =?utf-8?B?a3B4WFVyZ0VCdzlDTmdwUG94WXVDWjQwc3d4UHVjb0ZUNm5VWjdveEZxSW5Y?=
 =?utf-8?B?RStTbW9ITXVsaGUyVXFPYitObGo4eXl2RHNjazZvZU1QNmJ4ZU9sQnlFeStF?=
 =?utf-8?B?VkVVZVlrV3lZSnJ5L3ZPTDcwVGJCSWNtWkhlZ05DWk5BWGY0U3hiTm12WWFm?=
 =?utf-8?B?Vng3dHpCZytQbHJYd0txZUNXMSszc3RyZEhCZld2RjQ1U1hWM0I3Ry9BNTRJ?=
 =?utf-8?B?bE5MWXlUYmFkbzVLT0ZKbmVHT1cya0lkaUJYSC9NWUZmb0RCVlpGY3ByN3Nn?=
 =?utf-8?B?VzZST0ZlUWRwZy8wcHdqZlZLa3ptcmVEWkVUTE1oMmovbWxQelpGUXB1bkV3?=
 =?utf-8?B?LzRYcVlZVkVRMGl2bTBCb3AwdEEwZ0tKV1YrejduYXh5ZHZ5ZEl3SEc3djdC?=
 =?utf-8?B?N1dPNkJwQklSVGE1MXYvK2g3L0Q5ZC94QnJwUUVCSU51WGd0OHUxbUVhbXZu?=
 =?utf-8?B?UjkrZVdPem9ZamRHcmx1U1pabm5PUDlLUXZ4S0IyYmJDamc1Si9mbXBYRjJw?=
 =?utf-8?B?UHNsVzRsWHo1REZpYzJUUlZIOS96VnNYMG9JVjcrSzQxZHd2cTZ6K01qU0Rr?=
 =?utf-8?B?WTczOEtkdm9kUGhvUWs3VVA2RElzUm9jR3JmdWt3K1VybENOUWJabmNndFBQ?=
 =?utf-8?B?QVkzaWcwMVNlWmdodENMZWFzOFJydXF5Um1BWEh4dEh4MkFnMlFjc1lxdjVV?=
 =?utf-8?B?TmxZOExkcGkrNVJsQjNKRGgwNU9hS2pkZGQzMktTdFZvMUJ6cHFycnBNdjhM?=
 =?utf-8?B?NXRlVSs0WWlNR1IwdTc2d0VaY0hTc0ZUUWZLb3loNmtTN1RvTEhOdEhGaXhK?=
 =?utf-8?B?aVpNRExkZTZnYk16aEZiMW1udEF5VWpCWDlpMUpmRHpSNFZDSk93OFN1cEE1?=
 =?utf-8?B?RjJjSWxPNW4wMjdGK1F4MHlVZW9La2VQcjI2VUJmemVLSnRyaFFzSFNraVg4?=
 =?utf-8?Q?7bzuy1As2XXrJsDTlwv6dsl5+?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a56d2e6-ae15-41ee-d9c8-08db4c7848fd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 08:19:30.8732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUKTZqF5lIMRd4aJpnKW/ySdpebjv262JY+fo73Jd0Kkzyjo4u7XJX91HUuEhboX0HkTjGzG//8qWg/7wzITnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3632

On 04.05.23 09:58, Florian Bezdeka wrote:
> Debian 12, code name Bookworm, will be released on June 10th 2023. 
> See [1] for the official announcement.
> 
> I tested xenomai-images on bookworm for several months now. The main
> reason was a recent glibc in bookworm which allows me to enable y2038
> support in applications. This is a pre-condition for testing and
> enabling y2038 support for Xenomai itself.
> 
> The remaining y2038 stuff is currently waiting in [2]. With this series
> applied we have reached another mile stone: Prepare the test environment
> (xenomai-images) for y2038 enablement.
> 
> [1] https://lists.debian.org/debian-devel-announce/2023/04/msg00007.html
> [2] https://gitlab.com/Xenomai/xenomai-hacker-space/-/tree/florian/y2038
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Changes in v2:
> - Flipped order of patches 2 and 3
> - Link to v1: https://lore.kernel.org/r/20230503-flo-debian-bookworm-update-v1-0-6a4aa9e4d95f@siemens.com
> 
> ---
> Florian Bezdeka (4):
>       ci: Update kas to 3.2.3
>       customizations: Mask systemd-network-generator service
>       xenomai-demo: Switch base distribution to Debian bookworm
>       customizations: Migrate from ifup to systemd-networkd
> 
>  README.md                                         |  2 +-
>  ci/gitlab-ci-base.yml                             |  4 ++--
>  conf/distro/xenomai-demo.conf                     |  6 +++---
>  recipes-core/customizations/customizations.bb     |  8 ++++----
>  recipes-core/customizations/files/ethernet        | 19 -------------------
>  recipes-core/customizations/files/postinst        |  2 ++
>  recipes-core/customizations/files/primary.network |  5 +++++
>  7 files changed, 17 insertions(+), 29 deletions(-)
> ---
> base-commit: f20791525153c50c16b598127e7fc9d577c8e679
> change-id: 20230503-flo-debian-bookworm-update-42686a56ec66
> 
> Best regards,

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

