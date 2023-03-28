Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2077.outbound.protection.outlook.com [40.107.249.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B5F33C5
	for <xenomai@lists.linux.dev>; Tue, 28 Mar 2023 14:33:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6Liuw6EXKQnSFSMFKPpBomVOQkkzDkhlDLqrPP5LvQM2o6V61+khd7WMrdgKaLbV6NSwlrPNYWnBpNgq8E9DLQusCusRiEDGQi8WqWZOmPR8TuewXICSpljzRLsKznjA/ksZHdMRdHMBMSrMUOuJr3w+6IgBhWv1WWEShZZrLUqeJSpdoUNYFVnXgBL4Ms3YGxbIPBEK8QFNYLkuilj7bqxmfL6/R11Y4INh9vbbirr8Tvibpve86Yzzzzm9ZNixp9GFRhrPjuEpAwoSUFnXZBjolMSTGE2MMzlZLviHacX/uuajXnLEmMlYefQ6CFVekfgeabb1cexs38Iyeg1GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exO3W+iuBTouxmXPCYXinhpNx6i5AHv76otaPSoOaWs=;
 b=l53Nq8XXs7tNL/TXMzd7R5i82QU3Aqs8QXRcX9IpxSiMyUp/jZ1eoXPH10fDIN25ljVLVxoLbC4qbvE3eDT+2vp997ExQwtUoNY3FXqALc2OUsQwHCS4L1R6pfD+dbGoQPbdI8vFAlPIl+cdX827aNf1G9ZXyepWoJQdaMA8tUHKx8cT8AtaeOV00MEfvAhEiebnRkb/vfxlE7otXOGr5/t0wps2XSKOhv59CRt0Cfs2vbI9Cq1PrsX4QJnzVot9CVvQcCM//W79rX5p6ERNbHosCEyBuo0/n8OThFKzfNGAQnh9kNGwo0kdMd1TyG6sKS/jDrqlQn6erJEcA52HWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exO3W+iuBTouxmXPCYXinhpNx6i5AHv76otaPSoOaWs=;
 b=Cars1sVH+kz5EULH8b6JoKfbPCIdSNt/uhrxJN2EE1vMqb6ZrJLRED4M41Yzigxr4zQTWzr2qfMJ77MK/0VsrQzcgFLmJoOCtoIEp/7Y4yXag4E+a/9BPrEpUJ9jPdIwyP+Y0k/6LhjqNLU4CB1//boWivyzxL5u7vrtKJNXSO6ozgk9PiDIT7nfu33uVmLUCeXjY55sVso7d9Zbs8/oGIgvCQZqWysyjxB96hJm2Wmz6TdB8GHQxKx+Qp1YMTst0lCBkgOo5CwXoSOV+zQmTzSJ+I8aTPZdQpvrJNkQ1EaZgmz5fzY4nEO0aSNQWN5v/XsZZouNSV3yrHt20nQPfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DU0PR10MB7025.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.18; Tue, 28 Mar
 2023 14:33:30 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::70fa:c4d2:5d95:aa96]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::70fa:c4d2:5d95:aa96%9]) with mapi id 15.20.6254.018; Tue, 28 Mar 2023
 14:33:30 +0000
Message-ID: <54f04d62-9f13-b8c1-f69d-f42f5f394272@siemens.com>
Date: Tue, 28 Mar 2023 16:33:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] debian/control: Fix missing dependency to gdb
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@web.de>, xenomai@lists.linux.dev
References: <20230327105542.1320510-1-florian.bezdeka@siemens.com>
 <aeb950f3-558a-f704-dcf0-7e6ffc1c7283@web.de>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
In-Reply-To: <aeb950f3-558a-f704-dcf0-7e6ffc1c7283@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::10) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|DU0PR10MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: 667170eb-b379-42b5-57c5-08db2f99666b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WGbD+uLDXS6oMS78z9Bw7NXJ9RbfM5IR66SLsXI48u4CU3/R5PGjgejpwlT3CnLkrKKcmbiJXhH0gMLCNxxsLaiKIobfhkvKJZF1w/mUSsLKeCupWCl0WbW3EsALqQTH5KfpSMOYnusJ5DHWKXYyt6KYSybfE6dRgbf46y22qwbM3Zq1FFDzOM9XRuY4PSfnZKJDHQooLdDFPD4t6CtAvMOjWmqf7QYq08qrWwdMvz8eZtbdQLgF1sG6lqgzRORRCq7vIZY9vQzqj+IY3IJrY+EvGNGMSIGXSuOX+RlHjhuhJjGfQNXY82tCCm91de5qC4lwgsQzVo13PGiJ1Xh6ZWRMQTnP0v5RNfm7D7G/6rebFhU92afUaUCxTvbVu1hQwF1JnwU3RiHahaah5a7EfzIpE8wuGFPb54u8OGW3uQgWnamdxqmUk/mYzkToQmbcHHVrYeWU0da7j37oWKYj/2M0yQsRxaSCPQBqemzvKXpJlzlrdrh8atLOduGkuHJruAq5kXj1Znr+pdDQmCA5efkJBhlIXqC4yld0YegJWt94Yt4/bYV5V/eacTQmJCzaPeSEGYgIRX2c+kQqA6R4YUybz8iZn8ZDezyX0XkW9Pum0tozA4CbnabDEyREcPT45wvDXbawAt/00hbvSfLNiw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199021)(2616005)(966005)(6486002)(6506007)(53546011)(36756003)(186003)(6512007)(31696002)(6666004)(86362001)(41300700001)(82960400001)(66946007)(44832011)(8676002)(66556008)(66476007)(8936002)(316002)(5660300002)(38100700002)(478600001)(31686004)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVNuV0h2NmwrU1o5ZjFuRlZuamlXNS92Rk5xWlpUOHdXZGxHa2hXVlIxRlNZ?=
 =?utf-8?B?dFozdEtLZU83VllDSURVSVVDQXZoQmI3cXNubmEvdE5GTytra2pNb3hLY1N0?=
 =?utf-8?B?bnhpUzFOR2xnN3BTQ25KblZucnRGU1JBWERzQ3IvMnowWDZUeFg2ZUxQemJW?=
 =?utf-8?B?RmJvbTNodXc0VVBvRHBaMDFyMXdzem8vb096VnBBZDZKRm9qSGh3QndDZE5h?=
 =?utf-8?B?RUxjS0FZMEIycHhGVlNSeUVUSmFWUFlxQWlUTW94NFU5RlFaWXJtOEMzeUpI?=
 =?utf-8?B?ZlZxaGsvUzB0UkFONERyZDJZcXgyU2NXaytDL3QwdGs4OW91NU9Ialo1STZR?=
 =?utf-8?B?eVo0MGQ2TFpUVzZTVzVHVnhzM3pNR0d0Z2tNdjlDY2FRTjg0dzFTa3ZCVDhj?=
 =?utf-8?B?SGt4bStXYm8rb0h5RHdzY3N0c0dqcjZBWkxOUjJ0b0ltSTd0RFB2cWlnTDBS?=
 =?utf-8?B?YVhSZVVKOHNzbC9oYWg1RXBhSE9pRmx5VnRoYlpWUHZwMU1ReU9UK1dZU1JL?=
 =?utf-8?B?SVNSWVFSai9WRnZ4NzhkdUdMV0ZNQlJiZmlvQUh0a3VqcG5BWDJsWmNBVGp4?=
 =?utf-8?B?OFhxY0dLakN6RWR5dFZVekxvWUk4QjI1VSt1cDRKMFA0R1RmZ1FFM2dIL0to?=
 =?utf-8?B?dXdBbGw0bDB3SDlMQlROa1VncTNFZkc3cUc1bjJXRDNmbzZZZjh3azRZemFy?=
 =?utf-8?B?Y1dOemZ1NGZzM05jK0hPd3RwUVNOU3pINCtaNUlYOUtQamI2VWxzazVWWEQ4?=
 =?utf-8?B?UmRjMVVtb1AyblBhVEVBWWRJalpTVHpKaFpjMkhpbkRlS1lJSnR0cG51U0Nl?=
 =?utf-8?B?VDhzcWFmTnBLTlhNTzdqZVJrNlk1ajRLWFNqSTNZNlI3T2duWi9BOTRBaVIw?=
 =?utf-8?B?bEZWaDRyU2k0Uk9zVkwxTUpUdVIwa2xKQzArVGVmRWpIcVY1TXpEMFpNWENj?=
 =?utf-8?B?Y1lkWEpmdXgzTzFVbElEV2t4VHp4UmFJbG9QMzFRUy9BNi9QbFVKWFl3QmYx?=
 =?utf-8?B?UXVRZ0hRWXdLTkFrdkxrOGkwWHRkU05yNWNoM3BtdGV5S0VNbkhZd2FkbXB6?=
 =?utf-8?B?WFJtUk5YMXBrQUNCUzI2a0RXQk1xSk95ajV0WTRycWhPUG9TMnVPMTk5VldP?=
 =?utf-8?B?RUNFRjZpZ2FUQXNpYnhZYXM1MWVRd3l2bVRacUY0ekxmcUtDWjIrcUN4Z2lK?=
 =?utf-8?B?WmloR1I4QzE0NlJIOGJXSkszRitWM2lEbGhaWkxtRzhVVWNMaXlBV1ZGZm9p?=
 =?utf-8?B?NUJvMUt6Y1lyeDZ5R011aUh3U0g2TVUvYWgwOXAvQWV4UkVkRXhjSFBQT0g1?=
 =?utf-8?B?elptRGF1WGsrYlluQ2M3b3JSMUxYSVVQTjBEYXUrTjhOTEkwSjh2T0RQbUlV?=
 =?utf-8?B?WUtyTFRiS3RXcU01M3hNSFpOanIxZDdJNTJJVDErbnk3VXRQZDFVT0tBK2FU?=
 =?utf-8?B?YTU2K0FKMHJnRW5jSm0vWXY3Snh4SWpBUk4wWjZGdHRCMGlsR1RGbjJQNWcx?=
 =?utf-8?B?dzhyRENnRVA3YUtEc0R6MCtYMjNkQ0xmTGFJOEhLQTlJR0JWTndMOGp3OHlG?=
 =?utf-8?B?bktHaVplZmkrOGJHZVg3dHFSV054YjJGaGpDZXVtekNtdDhzeHNnMThsVWh1?=
 =?utf-8?B?b3NXMEdBUnVNNVg2STVNNDlEbnhkVUxneFZhVG05R2I2UWxBQzIzdnVXYmVk?=
 =?utf-8?B?eFplZGtzYzZhODR0c0ZheStWNnl0YjNHOWx4c1hGRHF4OWpzL3RYUkxPWWhI?=
 =?utf-8?B?dE9zV3RkaDhzUkk5OUNDc01kUnNaYmpIcUhCV1Vpd1pQZ1F4WTBNRERVUC9V?=
 =?utf-8?B?a1RNbngxT1BlbStOSjEybFNsQ0pZRnpNSzlKcDEvS21qbU5EUmtvanUwZHlx?=
 =?utf-8?B?RkNrYUgzbmJ6Sy9FUmxSWlNzTlZNS1ZacHZoVTBZY1JjSk40MmttQUNpMURy?=
 =?utf-8?B?QWFVTTEwM01DblhDeW5rZzE2K2pzUWc4TG9xTER0Z25iQ2tyTzZ6R0lhWW1O?=
 =?utf-8?B?Y0lkb1V4emtkY2NycHR3d1pJR2ZjR0N6eURISWE4b0ZtL1A3TVBBakp2NERt?=
 =?utf-8?B?anJqaFVxZ25XVXd3NDRkSzZ2VmdCR1JKRHloZExHbDdpdTMxc1ViNWJnSXB4?=
 =?utf-8?B?Y2hrSWxPM24yOG9wdW1JdFo1MXVwaHZOLy9qRUx0WVZ4ek84UVVuQUZVdnJm?=
 =?utf-8?B?L0RqYUhXYkR4QVRVYUFQc2xPUXN6cmNxcWpQa1hMRW9Fcmh6MHA1d3FtbVZP?=
 =?utf-8?B?ZGFET2YwNDJxRFFRZ1JieGFtNi93PT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 667170eb-b379-42b5-57c5-08db2f99666b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 14:33:29.9848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URWYIbU293iKMcQn81wR2IaV6idX7X+2i43s4KlCHVS5NylUG1WZskP5of/22gs+fDedCM0KQ99OU9YW7TY7Yo1lfX/0SLuHap0s4dd9Wjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7025

On 28.03.23 00:55, Jan Kiszka wrote:
> On 27.03.23 12:55, Florian Bezdeka wrote:
>> The xenomai testusite - part of the xenomai-runtime package - needs the
>> gdb binary for testing the gdb support. The dependency was missing so
>> running the testsuite on a fresh Debian system failed.
>>
>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> ---
>>
>> Backports to all the stable branches will follow.
>>
>>
>>  debian/control | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/debian/control b/debian/control
>> index 857d8ff8f..aba59949c 100644
>> --- a/debian/control
>> +++ b/debian/control
>> @@ -9,7 +9,7 @@ Homepage: http://www.xenomai.org/
>>  Package: xenomai-runtime
>>  Section: devel
>>  Architecture: amd64 arm armeb armel armhf arm64 i386
>> -Depends: ${shlibs:Depends}, ${misc:Depends}, psmisc, netcat
>> +Depends: ${shlibs:Depends}, ${misc:Depends}, psmisc, netcat, gdb
>>  Suggests: xenomai-kernel-source
>>  Replaces: xenomai
>>  Conflicts: xenomai
> 
> Looks like xenomai-images installed that "manually". Can be dropped once
> this fix is in all stable releases.
> 
> Eventually, we should split off a testsuite package to allow installing
> tools without pulling all those deps of the former...

Yes, might be the right follow up. I guess the situation is different
for stable branches, so such branches might stay as they are now, right?

> 
> Jan

