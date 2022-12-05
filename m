Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2041.outbound.protection.outlook.com [40.107.15.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E216125
	for <xenomai@lists.linux.dev>; Mon,  5 Dec 2022 17:16:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEWIkcU936uac+QZ524663dfC+1xiZSZVQPAt8Dze5rqsEUOUVoqOCcOgje273IpK+uEoa43/NtUE3/awuTd2/3T/d5PTewXyOgqAnXARBqBJbM7ND9Ea/PpdPfola2F+J0lIEqOIzDWhwbhTxVjEtSt/cwwhctc6TAxNW9Z5+DVSmR1nI+8aaInjA+sf6BJDAHAE8Yf3WGeF/OaPYSB/hT7kM2+xtKHEBdtaYKk7SLECgBU3IdvZxvem6LHHbcQjcaXK0yBIH1/m0b1A9mOjvgp8obzWl6d3m9kjPCFIru2RARhnqPFF6zxXnbBR+jl84H1vo2ehtaghAMT7bSqMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGbOjsJb2fxbwxQ6GF+vQtPDpGBmuTtIlP3v5Snnc2g=;
 b=JKojwNuISyx1R76LWP8ujyKXqrhsuNc62cQLGTVzwbay9D+kcFGvOUim7TwM8+mXZwNldSd5e5zDiH/X2Izp3xfAPN/pgIchM3dqjH/fLkP7FwQYou8E9aHKpgoHxv4U/B5OmCxEoyRqQg8sbmjB7h/eqwvg9kl+49PtMFshuMpVN4iIRBrdSfsKwYsfTyfjqoqG+7BgYzVa2nWrA7CQxF+KIN7gzmyCt9pD/qZ/P/MlUcq1o+pntXbG/epWTxQn8LIeDZb2HMmVv/onQKZPBKcs+iagFdYFxjTs30OQSFufZEdiqEAuME3PDjdk19MqAL2yHccrrHKVrcmWhNRRDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGbOjsJb2fxbwxQ6GF+vQtPDpGBmuTtIlP3v5Snnc2g=;
 b=zRjXF0qOZdZk9jPlQ+OTR31pxOUJd3o1ZJWNSKBGaMfsBzHfhS5pTzDAXEvMUV8tJao7jiwhGm3bdqBd8/A+XTtn8JfvuhIrXQ7K+J5UiKMWSjtmA0gI+7iOWG1Sl3Z9Ln9GVnlr6TIHb3C0wWm0s2RixC/MiQB1Cai50vaxP1y6ahC6cC/uermLVCIpRYU6jF29AuR0MAIom662h6ps1HD9m21JPZHZhOprLtwarO1hW2L11gN3vnnvFxbpLBf73YjfiMszpwbTrovWP/KqwMaBryI//JoeBRhNtgzEcUoG+io7FwSbIXUNhfcmvEsb3sxeZxlYYOvnzO1S9W726g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB3PR10MB6785.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:433::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Mon, 5 Dec
 2022 17:16:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5880.013; Mon, 5 Dec 2022
 17:16:10 +0000
Message-ID: <edba58e8-46a5-2d15-1f7d-616517119b1d@siemens.com>
Date: Mon, 5 Dec 2022 18:16:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 0/3] switchtest: test different migration types
Content-Language: en-US
To: "T. Schaffner" <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20221205152104.3555474-1-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221205152104.3555474-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB3PR10MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ffe442a-c722-44fa-9f4b-08dad6e46741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lTCDKT7WB1JU0YumX+QAsb4RwA6nWR0ysX22BFreteaZh9PfnqxwobSHgxAGADawPrzOr4MmUNUuNe9XXknfsonKWgCDdmYYn3tlt4dr9cXd04yoofiSGxOQ3fQGMfVBNwwQUZuAa7QRUYiKHpNYG9sFWZaR3xZbeBErGfBq7AB14RSw2e3Yy41aUIN4+yj2jcbf86YViQmKwhuW6l52z0HG7uUcc2GEZurihiJQhdHEI8VyOi7uqPV7OP/6C6e7eTbUm9ltGIb6JL/ubGBXqHewng0ST25kLXuRYmnTmOpOVuxvQgWrDJoja9gJ8rYTO3LlgtcBhiAnBF3tdXrWuKalgvDO1eV9QjWvJO67dOpxugqUoofiGSbYHTVy6gKTRcj4Befeqt3P8nJRzU0p2VE728zOJrM62GOd9PLgwUC712cX09McUlAIwP+PpH8DYasB0VYLJjX1yKQZHgd41qAd/Dlz0WLylBA/H04Tc+hECzyhlh8p4KoU+0bB914vqLRRY8T3KYxKTLbn+UPV7ck7zTDFJxfU8aqjOuLjffppo7i0JMEvB2/HCnxhpWSIJJGtFsjXujT9QD7Q0jVwiMa2LAjwpcWs1W/EXggwlZ1g2QMTS68Zfr+S9FnJ5rUk7OvQBRMCoqUtr3EZx64MSHsoyG9tE+UpnIZhW487sW2Kf6N/JbDt8W2t5/yVOjyT2xAbTfIjy6rRomyOm18yCOy1vrbxv9wI5G8PAcTkbbNGbzaOhsInZkS194bwcPB8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199015)(36756003)(316002)(6512007)(83380400001)(186003)(6486002)(26005)(53546011)(6666004)(107886003)(6506007)(86362001)(31696002)(2906002)(31686004)(66556008)(8676002)(66476007)(38100700002)(4326008)(66946007)(82960400001)(478600001)(2616005)(44832011)(5660300002)(8936002)(41300700001)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2tQaHFUSDFEYUVSN2VrekxaQnNXb0szV2k3QXB2ZEQ4cHU5KytMNW5qckpp?=
 =?utf-8?B?RjJVeFlaUUxiMkNITzdBdEJNck51ZFZ6cVp4R3lOWTlHUGJHTG5ERjdwVmFk?=
 =?utf-8?B?WlFPbk5ZNW1ibXQ1TE9jWU5FYktLUFlkZUhBdmNZRUZmRnR4a2V1ZGdvdEVi?=
 =?utf-8?B?WnVQNDBoNFZRd1BpeW5lNHo5YndENEZuME03QnZyeG5mOGFkdVMzbjVvUmRB?=
 =?utf-8?B?LzRrQkswY0YwOGFjZ3JzM1puUmVYbmdKNVk3M1BoeFFlVkphRTVvVlJIRXdP?=
 =?utf-8?B?TWV2T2p1UlFJWlUrMjF5a1BqVUxSYUVIa0Q2VkF1WWxqNDdLaHF4T3ZlanlW?=
 =?utf-8?B?ZE5WRmJlalZRUEs2Sy9CMWtxamFCTEZKQU5DczRDbEFyYlZQNDczZytlS1h4?=
 =?utf-8?B?eHNqbzZxb0Q4eGtZbVh6KzQxNC9YbU9lbWFCdEE0ZGRSVythVVhCSVI4Q2lR?=
 =?utf-8?B?elB1OXg2NVArSG9uVnlRT0FOU1BtSk1Gay9ZRjllT0JtRzkxYVhQRDJhdWcw?=
 =?utf-8?B?eVUzaWdKWkt1eVMrakY4Zi9EVGJUV0xaWVVRZWNjNWx3VHZ5SDN5SmVReE04?=
 =?utf-8?B?RmlrRXU0QnV4bFFOZFJoUHBEZmJqaUlwSmhnUlhzd1FRaUk3ZUx4YzJZZFBy?=
 =?utf-8?B?bHNrRzZlaEtGbDZuTTN1ODFJQXV6Vm9IUXAwQWwrMmEvdkx6SENRNEVER29o?=
 =?utf-8?B?TERwN1N4Tjd5cGRoV2dqdUlEV21IMURaWTF3dmVMYkppdEw1MzM3V2N5L1ZH?=
 =?utf-8?B?bUdSODVyc3ZidWZCemE1NjEvb2J4ZStwYjZZd0ZJMTZseVhxNmk1c2gwVFBO?=
 =?utf-8?B?ZFJqVmF1UDRTdk92T1VYZk8zZ1V6b2tqdlRwK3p4QWdVdHhhbGkxU3g0WW04?=
 =?utf-8?B?MSthbEhUZVFmNDdTS1VRZWFCU0drMzBCZ2RMdnVLNk4xWXpocDEyTGdlbUM1?=
 =?utf-8?B?UWEvSkVXMll6VjYyR1h5aEwrc2ppUmlyWTVJYm8vVExkMnNEdWxtVEFlSm1a?=
 =?utf-8?B?ZE1mUWVtZS8wY1pqcGg5UkdoOThoZ1BjZ2RUUzhRNmJ0R3ZlQ05nQ1U5dnZT?=
 =?utf-8?B?REZCM3d6emZMRlJ5bzdiOHZCQlhBYms2Wm5uaVg2OVRrWnBKbGxrTFViS1c2?=
 =?utf-8?B?WXNIR01qbWU3Vk1WSFBTVEZjeHR0aEY1aC9YMHFZU0QraE1LVzVha2JIQ0xP?=
 =?utf-8?B?Yzhka3JtRHpMWUNpMlpSNC9md2w3YU54amFjWCt0WHgyZmwzSzg5T3pBdlFV?=
 =?utf-8?B?U3JIcXFTMXRQNDlhdGYrMHhJRjNsREtmcGluZUFJYUdNVnNJUnlYbys4b1JO?=
 =?utf-8?B?N0haMytCUFBTZWpDYy83Q1Q1UDdtUlVuQWFWbEtMYVJkTTcvdHU4bTNydlQ0?=
 =?utf-8?B?aTBOYk5jaEZYcW9RcFRJRWg4aHJuSDlEM1M4cm04N21VbUp5a2xlNFRYUGZ2?=
 =?utf-8?B?YVJJYlFPdWtqSFJ6dEMvU2YyYmpwNjZKR1BJN3NvMzhUOTVNUmFUWE04dFdv?=
 =?utf-8?B?c2EvclVTNi9CWS9FTzJSVS9KVWRvdURGeHVlc1hiODl5dUR5WVl5ajUySGds?=
 =?utf-8?B?MTUrVHpmYWlWSjZ1ZEJHOHlTbjlIbkxoRE1CSXVSbk92UzlPajNjRGVHS1pC?=
 =?utf-8?B?OW1pWU10MkJHNkNXb0pvOG0yTE1neWgzdGRrdCtpbEZ2MnhqRTRWUnozd3VD?=
 =?utf-8?B?N3FZSHYxblVBNUhIUkxoK25QTTBtV3kyN1BSN2FMVHZNb1VaMld1ZDlxN1ZB?=
 =?utf-8?B?WmxvblVWQk5odjNiZkFlTGRxOHVWdUtFMW5mUE9kZGdwMURDK013Zm1mWXA1?=
 =?utf-8?B?MUNod3JvcnY1NFl0Qi9rMFlUZEltRHdBMDRhN0xLTG1vOFRrbEZHbGwxa2Y2?=
 =?utf-8?B?YWlUT2tNeFVycnQ2T0VRd0pjaUE4SFcyblpiOG9DaXczTnR2TXlOY3F2K1Bz?=
 =?utf-8?B?L0pzNHNIb2h6MWZMODFJU3RNK0NJZVFJRVZtWHkrRi9xWTZVSFhuTk41VWQ3?=
 =?utf-8?B?cGpnNmJsUElrZEwxYlRibWFXVlRZQ0h5Zml5ZldlK25wNGc3QUYwaFlYNVVl?=
 =?utf-8?B?TkFNMkVIOFlWaDkrYnphUlo1Y0FiYlBFczRxT0lVQzZqMTZaa295OWdFbXgx?=
 =?utf-8?Q?7+FMlrhBR62FgfisqslEuSf/9?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffe442a-c722-44fa-9f4b-08dad6e46741
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 17:16:10.2556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFNgj5Ew6z2+ZdTMcHc+HQ0EqiNnGfpgkKTjpvRVA4H0g/Cgpv4V320+NGmtx7YSMTe6ey2MBLWljXrvPPPTHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6785

On 05.12.22 16:21, T. Schaffner wrote:
> From: Tobias Schaffner <tobias.schaffner@siemens.com>
> 
> Switchtest only tested intended switches between primary and secondary
> mode in userland.
> 
> Let the rtuo thread also test fault based migrations and migrations that
> occur while in kernel mode.
> 
> This patch series will also test the bug that was fixed in
> 829d4d33cb7aa3ee485ad56da6ac0c3b0ce5dbe5
> 

Does it trigger over an unpatched version?

Thanks for looking into this!

Jan

> Changes since v1:
> - Squash patches 1 and 2 aswell as 3 and 4
> - Call the correct rtswitch_to_xxx function after mode switch in the
>   switchtest driver
> - Only switch to secondary mode by using a linux syscall or by a call to
>   cobalt_thread_relax()
> 
> Tobias Schaffner (3):
>   switchtest: split the set_mode method
>   switchtest: test multiple secondary switch cases
>   switchtest: test mode switche while in kernel mode
> 
>  include/rtdm/uapi/testing.h         |  10 ++
>  kernel/drivers/testing/switchtest.c |   8 ++
>  testsuite/switchtest/switchtest.c   | 142 +++++++++++++++++++++-------
>  3 files changed, 126 insertions(+), 34 deletions(-)
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux

