Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2058.outbound.protection.outlook.com [40.107.241.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99013F9C6
	for <xenomai@lists.linux.dev>; Mon,  3 Jul 2023 13:26:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcRDysfMaCju+BafIkk4K3RDa2Tu6/k5uCb9GPagOWskSH8XCF9kkmBlTMmvKyiXdsDDlQI3MxZn2N+Om/fhFkJ7LAL9OizlzVEXVghew54AS0nTMX4IY9XFeGGIQbSm8sZLajCJTiGprZowXNQFIfGajL1y+wi14iXnYx14EilycRBfImm7WOhTgDkimXLcUdSB8nLuc/awK5+BadKepU0ZCbK9xb/rNDUhxwdq43jF5osEgCwIRUo72IFm/zklNamHJNZCfuyDPCNWIggHjM/1TF6bg7x9FPQnu6tYk/xqrD/NadpwDMncswF0HLQ7FzyQJyMBw5klpYmc21npCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2j+rusDyj4g8r60YMA/pw1j8kZ7MtDCVJiL1R4J6cMw=;
 b=T/vWLe3THlGbIqqe0rzYkjkVoU25DPBG4SApmeH2jenyHnPhjkatibOYM+awknSjY0nYhI8sFt9HtAp4MvhdF7iaom8tZHNBTZsSo6Bh9Mvqk8IKvQdVxGVCFI4CGVud0y5zrp2n8SClqG57i3A58cFYuA8E+a9CST5fb8a5XHQpZrrXE7TKGmhcB9zB959gH1dzZRAq/sQ4eu8DmVLTNy2RngSUN8aSHvcbPJKbic8JjDsjnPJY43g427lrCsCe7xgM8iUlbZxkXblKwuAurRGnGWIk0XpdyRSYYDO8MJ6+8MjL16aZPA5Polx0pVhHttfpVVcMr5Z2FyoEucJOzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2j+rusDyj4g8r60YMA/pw1j8kZ7MtDCVJiL1R4J6cMw=;
 b=x5m3o4vHYFD1lo0yZ4KaSvfvdAECzUcqgRgtQxs4xA4fpCWX83hZySpOI28XlSLoqJt0VTXcY8UeLibcQ+AYhFGyQ0aooFDrMF4hKL8hE18Pc+16apjkuATln7MmWsEZpC0zQXUvaXiY3bf6UuPCZDQK0IjCLlIRHDzWn63Q4VJ3ZzFWrsXqTB1zmoYy27jJORc+7Pwms3oj8pDN//3ZEJ2k8733OB0f2kI1cSoTExlJFFU5M+nFwepuZeamGOJOZ11JoSLvDOrEGgAwRjwfnIvms8mJNCiSyQt4M4vlivLbc6CCUHTj9/RgnG4dVxYH9muNbee0zFXkhfzKheCHRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB7572.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:3d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 13:26:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 13:26:37 +0000
Message-ID: <071348e1-520e-0202-38b0-fec90b56ae84@siemens.com>
Date: Mon, 3 Jul 2023 15:26:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Difference in dovetail 6.1 branches
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev
References: <5114f4c407bf3013afda322692bb3be6111bf17c.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <5114f4c407bf3013afda322692bb3be6111bf17c.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: c9fc97a4-e7c4-4dcd-72bc-08db7bc92107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3o+6roO1+Hu/U0/bEXJesEe7pFjHpzxERdsJv2x7OCzKDhxR7kFeydCu2ZtPSNApKKr05tbqAhRFRCzBQxHESCgRgGs5iC93e/QLLVvts1ePHtWVyY1av8vv1Q8widDZvvd57X1qjxKnAw+C1BuKZZdHt7pNVwvu8JCaccSgupDziL6eeXUk7hB4cymOSb1I1E/PG9p9GeHU/z+Ojcy3qOFNSL9R9zQOsoc0ghMvnGzaSFle6eDIDBrUSJqY2djO06SO86Iuz2EfEu9RmYMvxDJN90w1fGlVOjr6s22uHpsKM121C23teX2QGmffCx0IGOzp+1XYFMzvlKiMvk8ZF/ofq9Fc5OCZISN/oQzaAthv0iDrd+f2t1K66uvhY4M88W83n5IvbjiTLv92SVrQvFnbJ0+/E4BJ5twhiT7N/zYuJEaxQ47oPTvD6bdCyYsr1xY5IbREBaleaUchZgitqyYJ2NnwoWS1IXR6PSxvo16pZxLZYeTnI0j2g4G7s3t5eSixicUCd4HzMxDpGkYF4jdz72DGb2o37VG0T+g6WFuVb4Xmc/KG1hoCiplRGy7RmSiIBNMqhsiLo4NZXFfn/N9Ld4ovdKYWdt2sZ4rMJTtnzF/9Bx46KI8DnUuGt9+8s83/L4cWcNmvZ0VUKskT0g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199021)(44832011)(31686004)(4326008)(66476007)(66946007)(66556008)(316002)(2906002)(478600001)(36756003)(8936002)(8676002)(6636002)(6862004)(5660300002)(41300700001)(31696002)(6512007)(37006003)(86362001)(6666004)(6486002)(4744005)(38100700002)(53546011)(6506007)(26005)(186003)(82960400001)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFQ5MEZHd2JWbnUxQXduaDhZZDg5NHFYZVdHYnFrL0VEcWQ1b1hnYi9MdjRu?=
 =?utf-8?B?Wi9FZndBaVJUL0R0S1JRYW0xam4rOTNDT3dFTll4NmNnWjNYWEt1YTFsalA4?=
 =?utf-8?B?Mml4WU9SRnhWTE5jNVdSMmZJS3JQNytEMlhYV2l5Vm9GMWNXWkJoaG1Dak9Q?=
 =?utf-8?B?VnlKTFM5MzhFUnVUd1Z0M21GNjhOSmgzWE9zM2dBT3I5SGpWZ3BtZEh1eTZT?=
 =?utf-8?B?a1ppUDJscG4vUnBHS2dXUGJrZ3NuYys0N2tiWmoxbHQxdjBYdzRlSHJnTUJV?=
 =?utf-8?B?K29uR1g0OFJhMGEvU29pSTdWRWZacTlkSS85bG1saEs3SlZHT2dPMFFBUU5m?=
 =?utf-8?B?dFNXRys4aGpzS3RyR3RzSUc2VDZLTUowUDdaUGZjQ3hjMFhUTE1QTEtqZ2M4?=
 =?utf-8?B?R2xVUk9HK0VneVJqaWVoSHkyTStyRVh0MnBoYTdJMXpUbDBKZFVRU2tRZ2VE?=
 =?utf-8?B?N3Nld1Bla2M4STRUN0pVRStPTkUybU1rR1Brc1hxMDhlaFJLblZrbVBIeUtE?=
 =?utf-8?B?SEcwL3dLWlkxREFKL3dLY3Yxd2o5MGRJWHpBTHpuMGVwN0pTclY5THBUWVQr?=
 =?utf-8?B?MlBHVUlCa1kweUtOUVV6eC9RUmQ5VlRERVlNSC9haFNPeWlqWFZMVDFxT2Nx?=
 =?utf-8?B?RGE5Q3lLbWpSYU5zZzZ1MjdtRDV4OG5qd1JFMXB6cWNuSk9LTTlkdTNzYWd0?=
 =?utf-8?B?K3Z0cjdOeXRjZVprN0M4YUpWeElqYUFvaklkTnNzWU1UOGhJdlpXVFMxcWxS?=
 =?utf-8?B?Q3N1SDllM0VwaUl0Z1lTdUtwOUhjMG1wYTYwNWt5K2w2cHBZbWozWXJSTDVJ?=
 =?utf-8?B?UWd4Nk9nT0h2dUQwRjdpRUFsOVJLYU1GOGlXUllGRVhuSW10dEgvUEZSTUxn?=
 =?utf-8?B?ZGpuK2xZcWJqeUFuVyt0VmsvaFBDV0JubTQxSFFKRFhsRlU1NE5yelBpYXdh?=
 =?utf-8?B?UFJwWnZ6bnM2RkxpejkyRGZUVTlQZUVsN0xBOHVTS0daeThRMWpldmh1bTRR?=
 =?utf-8?B?WkJNR0c3cXNtaEFuY3REZjgzQUlWUnZwL3R2aWk1bmp1YVdRMzhsc0ltMDhr?=
 =?utf-8?B?WEJTZjhRczJGZkFHUWI1TzJnYWdORDRydnpTanU2azVoVm01K2dIeE1rdjc0?=
 =?utf-8?B?eGFMZ052OWdFa2FJTFVNbWhGVC8vNWtDeVJ0eElZYXhMc1BOcDdQVGNWZUxl?=
 =?utf-8?B?a1RGMzhNMDBuQmlOalo1bUlTUVoxSTFoeU4wVjBMUjlNZ2JnREFsQzNYMis0?=
 =?utf-8?B?aHFxRWF5Y0RUOHROWjVGSFQ5T2lvQURwaFhJc2JIbHYvZUUySWJmL00xaWF6?=
 =?utf-8?B?VC9KcXg3Q2JPVVBHRkpQSWt5eDZ3ZEFJcTIyejliTmRwZlpkcHowak5WU2p0?=
 =?utf-8?B?SUZFVGJtVG5DRDM1MUhYbHphWndWNW9jRnRDc3dnYUhpWnF0RTBiaitmTU1I?=
 =?utf-8?B?SVFJdURubitZRUNJYkdnTDg2QXdrVmZ4dFhvbzRwZnIzTWpNbTJ6aGF0MEVr?=
 =?utf-8?B?VURlN0xTYWtONGI0MHY1cmZuckpXdjR5dkJpb2RJSmlEMU95Q3k4ZlVuRVUw?=
 =?utf-8?B?MzBrMU5STEZFa05rdkYxT0lnM090NVFmOTlSKzJ2cWM3T1IxYzdoQStGRjhD?=
 =?utf-8?B?dW9nSCtGbmRObFRaTTR6ZVgxbFBpVEtjcEJqZUhQendITWlBazlsT3VaSVYw?=
 =?utf-8?B?ZmVScDR2cEFHdkhnRXNBczRlS21Wd2lpbzNLTTdhUlYyVkdwaDkwbmpST2hw?=
 =?utf-8?B?WDlkOHpBeTl5VVFDbmtFeVYveHdxSnlVNzkzZDhic0orWUZDdVhyb0JHaXJI?=
 =?utf-8?B?b3NKYnp4UEVtSWU4eTZ5RGptVmZyb2FISjFodGQwMzFKb2o3OThSN2FERi9u?=
 =?utf-8?B?dGRiNVpWKzB2ODVaUkFNR0dveUdRRWx4YlVHTWVZUTN6MWdCblZGWjdMZ09p?=
 =?utf-8?B?ZnBMbXpCKzRaYkx6U0RBd2RlaFM3M1BFYUJuZkNWSzdRdHRWTzVkNlRyckZW?=
 =?utf-8?B?YlJieFdVdnRLUmxITW9qamIrR1llUkhSU0ppL3ZpemVuMWxYQTNSR0xpS2pM?=
 =?utf-8?B?bVp5OURlWTRicEtxYzlKOExMc2FwS1Iyd3FsN0VMUi9MekdiR3F3aXVMKzE4?=
 =?utf-8?B?TGpjQUd2NUhoTzRvbDJvT0dsLzBxWmsxTmxEZ3VMcnJNaWNJMjlLTVNLSnZV?=
 =?utf-8?B?Umc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9fc97a4-e7c4-4dcd-72bc-08db7bc92107
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 13:26:37.7283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0X5s5GuGCZbroM7Mh+LN/l5QNcdlmVYsNzcICP2WbSIUF6dxhCXrYeEy53HYBYRitc4iXBliGVgcfM7oVUJgjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB7572

On 03.07.23 14:05, Florian Bezdeka wrote:
> Hi Jan,
> 
> the upstream dovetail branches are currently based on different
> versions:
> 
> v6.1.y-dovetail is on 6.1.26
> 
> while
> 
> v6.1.y-dovetail-rebase is on 6.1.34.
> 
> Is there a reason behind? Is the transition to 6.1.34 currently
> blocked? I couldn't find a related and failed CI job.

Nope, /me just needs to do it.

> 
> I'm asking because an internal Debian based customer is asking for an
> up to date Linux and Debian already ships 6.1.27. I would prefer .34 in
> the "merge" branch. Any release planned?

Done, for 5.10 and 5.15 as well.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

