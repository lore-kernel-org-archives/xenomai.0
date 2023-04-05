Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787897C
	for <xenomai@lists.linux.dev>; Wed,  5 Apr 2023 06:39:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6yEFGP1uB0rPKq2wG3qkchPX6H9KLs3i65DqBW6faHdIZ9v4/ylv4d1WDhi8JQjkz6OZVg96NgXpJb87QapJ8Haukq0deITp64OTpK0NTtiJ5S3s5wlgHumDZxmVCiqaVniMQFmhxI368Dvoxr4NE/v3E2NGk0VIYK/3XSm1sLkeK49ag0o5eM6UhC16CZib3Dqu1C0OIGRjcZL0mtvFX+SUtdbx9aE+1AfRcAoY4dqaMXzpcVKUSjrvSbASIJtiNCgNuMkz+ivX3tMMpDcTG6rJNviuELnnibL9Y0pAXYwbYfh4ixSkCSJQUWoPLOWxBh1VZc8oJoHf2nABxBKwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYoG1HHeqA8wH4lbJp6Ehkey5OQ4J6G+QK1oj8cBlrk=;
 b=hTPW3m3p7fhGh1xDiFt6ZGKeztUcUI27ad1o0aWOAEEePsxcfG+ELVkRMw2D691LmvQuwAVUtxRz0xKSkoThBbK8IvE4T/7KVMv6w1VQrTXVUVizMPVuy9RVLuBKkwu/lr/ePWGGG+cyvicMYN24mggo4Atv3i8UJH2qxJcUBFohRoBOvfRGR1iL1NH3Z68TU3+RisNvMQITWYsRao7VCLjnQJMU+YBXvN70gmQPELZwWjVxwliDYcHWo8Xo8aVsELZyk3JODE45c8L9wkHl+qaHFznVGVU8JrmCqvfbY9NxZ0QxOlOsRKTMajFLU3WvuFNH8rotTHfiDntcihPC7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYoG1HHeqA8wH4lbJp6Ehkey5OQ4J6G+QK1oj8cBlrk=;
 b=BbajpPXTqbiKC4BC02uqCjd+CQQ065J6CB9/oF829Sr1EF9Hx+Su023chB7UdI30TVbukD/3QkGWPWkB3GXv4o2dlNAMeVEMNjfkHYzNaXZ34FyrebAmQ+uyGVWHYosZ9OP2+rJxvDVpKVuMPfERZ7qFgb1U7mjuiEA8PoXhI0WzAtnk4YYoIFgbcpa8SyW6Uczxj9YcA0/pxdlUEoGZNJDshhSoHjfgpzvq6lDNUfs65uL6+RoLu35gebxlmtuxODkICeK6QqiBVGSX08VjWSNoBhpN0WUxH9phEAdl0RkTw3XbNVe9fDaLO6OYIbP/vYehd4NX4X+GE/Kj8rKrTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7404.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.26; Wed, 5 Apr
 2023 06:39:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6277.012; Wed, 5 Apr 2023
 06:39:32 +0000
Message-ID: <14cb8861-4a81-0288-27ba-61cf4427bc28@siemens.com>
Date: Wed, 5 Apr 2023 08:39:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Reminder: Xenomai community call on Wednesday, Apr 5, 2023, UTC
 7:00 AM
Content-Language: en-US
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <MN2PR11MB4285644B9A79E1354871C918F2909@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <MN2PR11MB4285644B9A79E1354871C918F2909@MN2PR11MB4285.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0221.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7404:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b175a5d-3cbd-4956-08d8-08db35a0835e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	egyaJTQMU5TowPlHZOC7HoYvGknjcYkQe66NpsnPOqchLPDrshAR0diqPTCFF6u6Pb3OMaVXlMt4kh7fuy4Q/xuBecbQrezJmqVkIlQO9caH+qbQye9ajUvkuX69tlKtEr6G3Kzufb9WGMAupwsfXiIz08yedbKPja7a6eyVsBFQFdaRAOq6LeKGbk3vCL9lH2ZW1rjvw18505HHW8BWrGrvc94QZb3fRu2px6PglnKDuBNnl1EkYQw4qN3Fru5vR1sFnS1o33JPsRpa0M8+1CiyOOuSYRewYl7ifkaC3QgJ9uVChGEfRD8Uly09k6ZFjA4nBm1cA6pjg2SzTJpwavDq8DVjkNvzLWL+ovD7/PUC6mwQKgTM0rOUFtKa1pxsSGMWXWUyaQ8aGN55cX69q/r0tV3uY8BWXWSEP8FLs5cpJPBqPQ87AMF8ulbtN1+MvvFuO47l2aZx4fcfYDm2Q9i3W5RzNvrXGV4Horr+fLMJ9xYz+bfQ/kcIqZLlOS0oG1d2BvSCd67zYzixz8+9kghN00LS2gzbhkpJRzZPre6gK03xVDcX+7hERf1zpVrQpCdhjnm5u/uPhdsvDO5lbLEiRtjXYsre6eNnWN5VaDL99xA7Rk8ffiV2IfxYnADbchQ6yq36F1DtOL6agfBsDw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199021)(86362001)(31696002)(66476007)(66946007)(316002)(41300700001)(66556008)(110136005)(6666004)(6486002)(36756003)(8676002)(44832011)(8936002)(5660300002)(4744005)(2906002)(38100700002)(82960400001)(6512007)(186003)(53546011)(478600001)(26005)(83380400001)(6506007)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3ErbTZZcnhGT2dNTisvS091UmtiOXYxaWpXZVFNcEZGZXd0VjFyVGIyZ2hq?=
 =?utf-8?B?ZFhMdU9hdjVyakRtZmtEdmg0K2ZLSDRERlc2NWprOTArbUEwcGovRFdZRVl0?=
 =?utf-8?B?czVJNjJFeUsxUldsaGJqaEZKL0V6WEpHZlNBRzFtSDhJaThtZFh3ODcxTlhh?=
 =?utf-8?B?Wmg3czcxS1RjQVF0cTIxcVR0YmlpNDZLVW43V1Rza2VicEhUaXRhMndoeGIr?=
 =?utf-8?B?QjdTUGM5Zk1ZRkpvelFrYlMzdGJoWVZ4UzJLM0hlWXNrSGFJcjQ0MzF4a3Jm?=
 =?utf-8?B?L09vdUdUd1ZmL1B3SXBGbEZhcCt2STNsVGtWVWFHY05HZGRBNDVtZllTenlO?=
 =?utf-8?B?c2oyeCtDY0JoZ3QwN085cCtNQjMwVFhZd0NMR3VTZ1dEaTZpcWk4NVpYVXpp?=
 =?utf-8?B?OC8rbExlSmJ4ZGRhb3l5NUUvYnV6VVB3bEhtT1JNSlBQTnhIU0xhMlFTdDBE?=
 =?utf-8?B?VkVJYUk2ZVBLaDJMaElNY1VQRVUvRTMwbUpWUFJQYUc2V3RNRXV4SVNHWGVz?=
 =?utf-8?B?NWU1NkFuZzZMSW1laVFFWnJQYncwSFZsMmQxOGdncGpLMVdORWlnS3UxNFA5?=
 =?utf-8?B?TWVUVFN1YlBwRXFTOTRNK1Zoa3JyUENtZHV4R0EraktPWjRLbXpLQm9TTjh4?=
 =?utf-8?B?YUVnVlQxMklHdmFHUUNDdU14QkZMWmpCVDhodzFHV1JhY2xLUzVuMTBzdkZR?=
 =?utf-8?B?dEdETVhUSTB3QnJmQWY0K0YvTEtvK0JLU0hFemxJSVA4SkFtSndKSW9ORFpl?=
 =?utf-8?B?bEdnTHpQbXJzTERWVFJsMTdCRE5nYndvYTN1VmtSaUNKY1d2Ukl1cHdlV1N5?=
 =?utf-8?B?R1hSNU8rYzBCbXlsSmVydXhuVENGcHI2aXcxZ3ZSYUZiNmcxOU1TTkxEOXpz?=
 =?utf-8?B?MnE1Mjh6OEl3aEpETzJJL0k3VWJRaVRNcS81ajZZMG02a2FwSm8yM0FHaS9F?=
 =?utf-8?B?T0lQQVBuVnJ4RXJQUmovUGlJM2F2WHl4bHFIR0RwUTFWOXNIWjBGOTNueUJE?=
 =?utf-8?B?QkNtbUVUNUlFS1lkeEpxamVwVHhxa0hPSS8rMlViQmpYR0dZZDQ3bkdZNjFZ?=
 =?utf-8?B?RU1xWnRDa1ByS2lSNHBNOGEwUTFaZFRHVWFYSDRtNXB6NytkL2R4cCtaR0hL?=
 =?utf-8?B?RGtTZk0vRTVsY1orUi9kZ3FDTlJNRmp0NTNYSStJaDdiL2ZObkk0VXovKzhV?=
 =?utf-8?B?TTdHLy9ZWlFpZG9EVkxYWUUwUlBDZG01NU1NRUFaNnpmVFMzY0hiZHhjVkJo?=
 =?utf-8?B?MGwrY0xEWHFqUGxQaFJlSXI3bTRIRUdwbGtTbVNWSUFMU3Y3TnNxYjAxejVJ?=
 =?utf-8?B?NUNDeUtNSXNYNVlJc2pxZThuT0E1WUNwTHRHcENPUXNnSHBpbGN5UlRJdVRn?=
 =?utf-8?B?d2N0ZVNWUHNIUXNrT3JON0xsN25XazRQK0h2YXlSb3dWTmhNZ1VLV1F1Z2dR?=
 =?utf-8?B?Vi9oaEtoblZDMmRLVWwyQlFUVHN4Um9IaDBIMzdKVGRiN0ZseWF3U0g2Mi9n?=
 =?utf-8?B?aElVWDN1TnVJMVlpWHJwNVhmNkZKaUFwRTdKMXR3RXUrdnhVQjhMdHhaU1Ex?=
 =?utf-8?B?Z3hLTU1NWEp2OW55YkJKdEQxaGVDelozV29XZmowclFtMllDM0xuMWY1S3hV?=
 =?utf-8?B?R2lEYXFJMnhMcUpEZThjNzdNckk0MjhmeXd5bEQxYWlGZ2ptSTZzZURLcTVF?=
 =?utf-8?B?UTd5aG1PQk1Fa3MyaXNtamFNaGlMTVlNbmpVNU4zY2hGWCtKTi94aWZycE5Z?=
 =?utf-8?B?TzhxZnlsSTd3eWhvUm9CczlzWjI2c2ZxRUR6UEVSUmtLaDUxODNzWlp6UUx1?=
 =?utf-8?B?TnBRdEU3ejU4Y3FLbitUSWEzY3R5cGtyaXh0WXgzVWN1WU5YZlBaZm9GbEFx?=
 =?utf-8?B?UCs0L1ZrWHVCdkMvekZhZy9PVGNNSndVeWh6MDZvM2NlU290QjB1bzZRcWZv?=
 =?utf-8?B?VkFPQjhrYlA4K2NZbml5dTAweWxCbzVjNnUyMG55QmhLNUROaGJqcGF5YXd6?=
 =?utf-8?B?cjVwV29GZUlKYUpPWVVTUmdhQ3h2aHAvaWozTVFpbVIzd3FhUnUrTGNZZFQ1?=
 =?utf-8?B?ekhmRTQrNm9XdmpaV2xrVkhVMSs1dWpVOGhpY3pSK3lSbkpNUmF6YTc2UmxO?=
 =?utf-8?B?TjAxUlY4aFh5M3V0UnNsMFdQVGpkQSsxaWhpUERmV0VMd21hanp5VGtHaVAr?=
 =?utf-8?B?bXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b175a5d-3cbd-4956-08d8-08db35a0835e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 06:39:31.9923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DVnlE+/ub7AQ7ryiVslYQFQeuGe3gP8IaYo2iEhH/D/J3wi5+T3wiEWxkVeIkxFpes5VX5ZKD96RMjjkxHn3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7404

On 05.04.23 04:53, Chen, Hongzhan wrote:
> We have the Xenomai community call today.
> 
> Topics may include but are not limited to upstream/downstream project 
> plans, status updates, and technical discussions. It's an open online 
> meeting that anyone can join and ask questions.
> 
> Time:
> Wednesday, Apr 5, 2023, UTC 7:00 AM
> Paris, France CEST 9:00 AM
> China CST 3:00 PM
> 

FYI: I might be late by 5 minutes today.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

