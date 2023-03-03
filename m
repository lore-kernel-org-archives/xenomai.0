Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B631363
	for <xenomai@lists.linux.dev>; Fri,  3 Mar 2023 08:47:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdsmYDTNlWtHSmzYOIDj7Yvi5Yc49vUoPbXdbJfOgwuxbXEoIdHNML8vzflc0JE744QaMU37NjqfQ2OqnLip4+ulUmue5f8rY6uWKEzAy7btvjNvtFAwabGa6KBIa9RxT+kPjLHoj9XrjUcXt/vtBwqGH0XBX9tseOA8zswAOUNv3TVYLx5B/r3FRPxYmXBCOddUPIcgQ1ds0QMkvDiScpofXEd9N8ft5A5c96NbYicvqu0Zs+XoLqFb3egw5LfaGdRmIGQLjEpTJqD4A1hontmdFcBgW2J4g3xGLEtCO7FP+5wJxvBRs6pRGLnIFCuCLBL0lK7+iE2CqLFvlnstBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tNN/CfJ65BkYag3ita/feeWXT7OFP3nHWo1Rkn8dtI=;
 b=ja+TaYepAZsCpdmeMWTFNWTf4NaVgUnGHyWjEOTGq5NMZuldTf+8RLq1xwDgV/DZimYg/Hkp2UKWZAdi/7S51lWpZ05QcoXZYtTrD9MgedFqWZ/lM3xXBDwj+GpVJibtRmZxryskIJQ8XRIK8J8l30iLLWYsJzMGRRFxXodE5Fv52nRQUuEhi6l/zwU7iM11GOI7mBFCS1twZIiz0XRP49VXmqtUcH6pEkm8CMfmij+SPpPICky2qHS9cMJIfEt4Vw4SusjFiSVM/U8yqCMBkQiXQQ0iRz8kL9en4KhqgCqizL6eGXVcYs8NVjauWoLAgnian8t8B/JIOqQ3ufkzng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tNN/CfJ65BkYag3ita/feeWXT7OFP3nHWo1Rkn8dtI=;
 b=CH+fEeqlZuUmEJzeZwMJhfkjp2CmZoVANKU2WVkACsKNkIT5tHeVbLaG49sntjr+DUe6r98KPwQmzlQjlj0uf9MSvFqDGQ7G7AhrA6EpReIQ7NXsQ+EAs1vGyxIXXopm5jkjVC/JjrT5cewUAvH1EvcQ/Oye8C/5obLiGnn5P2AEfuZcoSI8GKm6Nb8j8CNABVRlP21Rky8S8AGEcLDUUH8yjXzcwdHzBjzSp8LonX3w5YlsB91Aooke1x5sWuoCX9j+pyZfXp4VxdeiwcfRIYJbI+yVxvyw0MmiKW0Q2BlF/lQxiVczEM8YdetJlnzErJ9K0e4sltsF9967LZ3yEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:617::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Fri, 3 Mar
 2023 08:47:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%6]) with mapi id 15.20.6178.007; Fri, 3 Mar 2023
 08:47:48 +0000
Message-ID: <83433ef2-f430-cdb1-7e13-511b135bad8d@siemens.com>
Date: Fri, 3 Mar 2023 09:47:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] config: Bump version number
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230303083805.3211325-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230303083805.3211325-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 30291942-4db9-4f4d-a20f-08db1bc3f6ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y4OdSuI/cEnoR5kiBQB5qYbtEHZxHhPJvwsuCLbvfTIqphLtlaRpGQau72k9mEhdQbv7A23K6CtwrOF4qg2YPHXPiUzZn9mjWEQPQSVEOeOPkF7GqjClJgHYpWiPddh8R1SHSq7APZafjs/4xo4dHDTd6lKRQ+/yLrmX+DSc0mOJ5Lcr0KXVvH1+lPNgn9No2rc9ZzqmCmNOTIKkU0fdaNtXiYCNZoJtKZKwD14Wm0nlaR0VS15+FqXZv+/HindMhgWFhzb0aZB2ffW3XG2m6SGNABB4EqR3GglIuw0Sdn263bYnWMeoTCSVU3OzqbaaROlhUajpgNBrHfnSoo4q2i+WakKFeVsIgh3isHc8DpHnoMQ26UJFBAkD/TvwNaKnEvzuFqXD0rLt9qgIBarYas0PtIHeV2A475jWldnDWq0PIJpgniQo1V5/dGyiPd3W1l6VE8MwsTgOQbHdFmn3+aKxdQASnrkqJ25J74PV98XimWCwD6puWmGc4WjkBvzjIVSyQfVKXq/lTsTqCXZEXQnQHUsPJxxDoGX1tTcSoNMgp9O/mdVsmowbUsD/dlS/QInvTf4i57qW5fWgXSwvEjWPdIkssdmf5h1fhajRg1QGVSJ4i9vSbr9zJ4dB1vx9oiPDVUioAoj03MpElc2j4o/FmxWb3hYrn/jM7UijN+MfBmIQED9eq7ZAIl2k3gPuNaNd6Ps2dw4Po7vw1YOb8GR8ooy3gp7obJhNrFd8djA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199018)(6486002)(36756003)(31696002)(86362001)(66556008)(8936002)(5660300002)(41300700001)(66476007)(66946007)(4744005)(2906002)(8676002)(82960400001)(38100700002)(31686004)(478600001)(316002)(44832011)(83380400001)(6506007)(2616005)(53546011)(186003)(6512007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVllV0hCU2FoL0I2L2ZpR1FtVWpGUW54U3pSY0g4MldZc05penVOd2FoZ1FW?=
 =?utf-8?B?VG9aNGRqS2hqTXNROTU0MHkzUFJUc0QwZjI5S3I0WlpTbmVSV3E5SjZEbWpu?=
 =?utf-8?B?blZ4UnVoWDJtbnk5WGIydjAwaS95amRNcGxkZEN2dmpOeURQMk1sYWN0Vm9E?=
 =?utf-8?B?M2prTEloSVdzR01rVWJIQkJnWUoySzlFc0xrUlNkS2h6Y3B1d1B4TEE0UEpn?=
 =?utf-8?B?cGY2Tk1ic0lFbHN0bFEyRDh2RlVFWERoWnNRMWtVRklNSHAyeFhXUDA4a2hu?=
 =?utf-8?B?Z0FrY1B4cllLVksrNFN1UHhpNFBVaTVRMEV5S0x1ZkdqUnQ0TWZzU1YrYUVW?=
 =?utf-8?B?Q1hZYnlNVDgwdTNVWUQvYlBBR0tPamFSWlhHQ3dJVHloUzVUSFFjZWZOY29X?=
 =?utf-8?B?MTBiWWQ0N0JaL3kzK2hZZWxZWXRKd2NEQzI4U1BaeXNkWmQ3aFhMN3lqNFIz?=
 =?utf-8?B?WmFBWHl5blRLbm5mejk0dkZQQit5dStOSmMycUxIS2l4QldhZDRxQ3Z0Umg3?=
 =?utf-8?B?b2hxQlQ4ODZVRzRlNlBXL01sNWFpdTg3V3MwbkhybVFBS1k2T1RPQXR4OWdZ?=
 =?utf-8?B?OFl0cWIyUjJQKzZ0YU93azFYeXRZNG9FMmt5UndJbUhHTWdnSUhkckJrQWV0?=
 =?utf-8?B?Y2FieHdqWENZL3h0eHZJZzZ6SVc5R3d5UWhXdUpKMksyenk0RktEN3pGMitt?=
 =?utf-8?B?OHdnMW4rOGFTTFZZR1hYOGhxaGQ2bjY1NkRkMU9lUDFxVVNyWGJ4V2xONS9u?=
 =?utf-8?B?ZUVYL1hHeEJtWm5XWkozM0Y4cU4wYkVtVFp2MFkvNDZrWVc0dExYQmpBQmZh?=
 =?utf-8?B?U2JtVlBYSjB4UGwvenJROUk0WWpmUnhOQVNlL1E4bmhqZ2t0NFlKRU42UFZ6?=
 =?utf-8?B?Nm1aVGhYYUVDRmxseFVmREdhL24zek04VGtDZktZdE10eFl3MGJuQ1NPOEU1?=
 =?utf-8?B?emcyU3FIdjlCVXlaRmxXV2wyRUdZYTdRTm9XNHdlMFFzNGsrTk5EUnNEQXl0?=
 =?utf-8?B?NGtqTnRKQ2NveWhiWG1XTG0xK3BGZ2RHVHdqcTZ2TjAxdG9LNndDT3dwVC9z?=
 =?utf-8?B?aG55L2NzREtLUjFqN044dWhqUDQ1aW9sWDRuWTFYTmp4Q1lSUVJmTnpnczhi?=
 =?utf-8?B?cmtOZjQyTzRTN1RJNDM2MnlkZUFJOFhhUjNkSWxLRWdGMmh2QWxxMWhKMkJq?=
 =?utf-8?B?cGlINHU1UUdQc0dzRERUM05mc2dWem5RN3hMQjhKdDVWOTA2LzI1N0dnak8z?=
 =?utf-8?B?eGZHWnl0UmVqb3pSLzVMeDJzZWYzQVlLekJyTEk2c3NZWDk3U3Rha3dTRk5x?=
 =?utf-8?B?eGhvR0dRQ04zQ05lNlhBK0JCRitSM21FSUlmSEUyRTlCVjJ4cUhCUlM1dTF0?=
 =?utf-8?B?S1VwaDBjeTFkZ01pcks2ckhxY08vTWN0VzBSMVpxYVV3QVRvSC9SNUdvSW4x?=
 =?utf-8?B?NVFUSjN5bWpJN2VacDVSN3hwcVR0MzRtTVRPQ1NydmsycDc0REJnNld5eSth?=
 =?utf-8?B?cDFjRWtTWFNhei9IYWU0c3g3Z2F6SDZvOVkyRFFheHJ5MnlXVmphdU9nODZp?=
 =?utf-8?B?NW8vcUxNdHErSlhLMFFPQjgxOWxmQzNGSzU2Z09nRkh2L2VvWUpROU5icnRF?=
 =?utf-8?B?MDRFYUY2Y1J4N2IrWUYzV0lCN3RxM1Jxcko4Q1M2RVcxM1R6SzI1QzRpM0Jo?=
 =?utf-8?B?QTN3UEVHUmlDN29HbEZ6bXFnUUl2YnFyS2VwU1oxRytzd2FLZXZ4Nm9CS3Rl?=
 =?utf-8?B?Q0NBR3JobjVrdTN0cTlaUDRSM0VhN1FYZS9pSmRCUzhXK1lEVUFWek44bzRk?=
 =?utf-8?B?MTYxOFVoeE9LcjdIMzcrUUZlTERYVmRzcWxiclRKYU1ydHJjZ0hJanIwMWlC?=
 =?utf-8?B?UjQ5RmtOVnhzNklQbXZCaytzdVR4NXpXbHl6QndIT04wUmoza2FZcUdtS2Zp?=
 =?utf-8?B?TjFJdk5WVEZvYUx6N1JGUzB3OVU4K0tnUTdhQkJMeEZ5SzFVb3VBUm5DbGdu?=
 =?utf-8?B?L1FVU1I5MmErYTRRVDZiTG84YUVxK1lrOHVtU3VwSHR6aGhOem9WaVVCZ29N?=
 =?utf-8?B?cDVZRGF0OU9EbU5wWlZIS3VodjlqVW9Ud0krclVGS2R0amZxaWI0czM1MnIz?=
 =?utf-8?B?VTZkWGtoQ0JsT0VYbTBRZHl4MTNJcTNLQjE1a2pkVmNuYmRmNm16MEhDR1Vp?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30291942-4db9-4f4d-a20f-08db1bc3f6ff
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 08:47:48.0515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6S40wyusQFkWUE+FrnUIqFoAn6MTecxt57C/rxqIDZTF8+L6RriSos6AVLJw6hqH/ORuLnno5rPNsq/oBShUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7349

On 03.03.23 09:38, Florian Bezdeka wrote:
> The compiled-in version number for master/next branch was invalid.
> That caused some confusion after updating from one of the stable
> branches to master/next.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  config/version-code  | 2 +-
>  config/version-label | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/config/version-code b/config/version-code
> index e4604e3af..172b71c92 100644
> --- a/config/version-code
> +++ b/config/version-code
> @@ -1 +1 @@
> -3.2.1
> +3.3-dev
> diff --git a/config/version-label b/config/version-label
> index e4604e3af..172b71c92 100644
> --- a/config/version-label
> +++ b/config/version-label
> @@ -1 +1 @@
> -3.2.1
> +3.3-dev

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

