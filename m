Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2085.outbound.protection.outlook.com [40.107.104.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D832B7C
	for <xenomai@lists.linux.dev>; Wed, 15 Feb 2023 10:49:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9SZCvymfXO4JrWErpCxlWBtmrEIJK76MHNwuRbHjT61wiXxmdnXbCpO7DlmuK9cXKcR3qAsjFhDAMtDu+sXPPLJFjNsZ3D9UjzigfXU4J8SlZHOpWdc0Rgmda2mpn3w8JqhJeoRspOvP4Zia6YOfspKUPqULkXzUb+pzHH/j5HVLCqPyFQ41kuN2zfiieFQ8iyXDF1IofIVm6/6miqnJAPnwzq7aFdYlt6l4Ey3da3wVI23QA/N4xtYcxE4mtT50RjsO2PW4zIz9su+TR2pn0Xbtcm6f7s08bcIdqjBskltatSTQFAzlv7aB1mBlYd6cFI+sc86bguNXdnZ2DaAKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/i9kCtmep7mzZhr25Jec/V7+5Drd+rxakpTkfSuNfp0=;
 b=F30qAX/J6XqqCcGgN5hqi92dCLp58uZcVIbnMINUZOru/TdgHVTidmhtsRwhQYaaIbJIHBNUmVwDiRbsLVa3ntrJI6MlVEw9mbKbHKUOfSpNYxPH9+GxLz1ujGZmknhy2//GomXpmwXmeNUbCnNJyeiJgQuABDITAZk+DCSo3RxfmEFV75vULbD9JmiEdBJt3AYpEEafTAtbtRr8uukIIbALbIEtn66LehPuXmWKWgpp+SQgQ0t0bQXb6R3zoLbLDQ8yZwt2inW4WZ7PN74KCKZ4+ITsDwSgWds+eTQRQlFPc14ciQZjM4qQX0vNK2aqBgSS03jJMu+9YjGrN0vZjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/i9kCtmep7mzZhr25Jec/V7+5Drd+rxakpTkfSuNfp0=;
 b=aVMgkhfFAettNnxY8hOD7nlclGzRcuBX+hW54R9+PZ/qKLJhKr3WckmZMI8sgIOY80ESgJwmE1QDuWJjlLHlrQjMOY+Xk/dkiFwB+u4W7rp3v4/M/akmmQiM6QWrhjyAradGPcF+DcgK1KY6uxlqk3Kl249iFovSH+dkCB044kL3JHvqnx95VZTxR0+EbYlUr5FTvDual3StWpdZu/aXgNfqHMbXhstz1HWZ5xnrgqLQreAKEv6gNZJHjUL2LEJ8IG6M0TQwlmSr7jRZAmfSn8xVCTW4z/QN+Q+A8kDPJeemX2MgBONgd5gZO2NdPX1B6pckYyT1BP1uYFPLHxxXgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5649.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:478::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 10:49:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 10:49:14 +0000
Message-ID: <f2b91213-82a0-f78f-9948-3c7f9a13888b@siemens.com>
Date: Wed, 15 Feb 2023 11:49:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: about rcu_preempt detected stalls on CPUs/tasks
Content-Language: en-US
To: "Yao,Yongxian" <yxianyao@126.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <502ffef0.6ee4.186548762d8.Coremail.yxianyao@126.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <502ffef0.6ee4.186548762d8.Coremail.yxianyao@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5649:EE_
X-MS-Office365-Filtering-Correlation-Id: 96465a72-a828-4bb7-7651-08db0f42475a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CPFMT2aSjRKjVffDsc6Nmoj6WKOUklfy3uTy8jgfabRPC67Bbs3m7OpAQpISjA24U4/vkzV9QbvJUqhg9pWl540m077AFD66QlsrojK1Tig798iEX4vQi8l/FoE6UqkZmT7cVs6CvMwg+ag1Ugfoa94VneaBtsRXu0RMnbM6mkk3vSv1tI3Bf43rDz2JAUyYZnAZUrgEBm4IQ8ZyAb3BDGiBtmlDLpAJyPliSycX7YY2N+CYqpaajhI9pwRJu0D1KEieLQ0mhLACxp5QdIAhhjq0g63ANtHPWfIcW+z4lFMSEW14kG9t8tHYuofnHmnWZHfTGIPG+u5OqVmQf7OAF83VdjB8JxMMWPRRjbBffjCyYgjJkdFCGzUSpb8CDZgtlY1J7BTuwfTuBelxzgjOAtAa+wkc401eltQoNOvHUe/BGYpijEbekI13MUuBmY7GW55KZsYpJaKgUCD/26n6BfJuGGTDJDuwVFh8bcgEaFl8xU0JI1TLyoxqa6fhUHLg2mfKtFse6AKRjcDnDamlusQhKTYDClTF2wSdQ1iLXV1R0nUdcxTjuAtzaN658LgRvYcs58u4m0QJ/fxqZ7okEjehuEMO8k7hF1JdUJpnm0c5sMNhgA3+iplL5/wC0dOd2HWKwE5DkrdVNRY5xlRt6VrDNvYPjTo0W4b4jdhaDcLBI19UdS+VewhWUhcV+OCMde5ZXfmUs5PfrScj443xi0qrvPk2GT+XmvoQLktimGs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199018)(26005)(186003)(316002)(6512007)(2906002)(478600001)(36756003)(6506007)(6486002)(53546011)(66946007)(66556008)(66476007)(8676002)(82960400001)(2616005)(38100700002)(86362001)(5660300002)(110136005)(83380400001)(44832011)(4744005)(31686004)(8936002)(41300700001)(6666004)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDJ4N3NkdnZQVHpHOHZNVnBhTmwxQ2x6c2p5TEw3UzZXcHUxdXk0WGlPc3Uw?=
 =?utf-8?B?OGxONmpuV05qOWJlaFU4VGYybG53Y05iVnpQemk1OXNRUkdYKzdHdzFtZFVW?=
 =?utf-8?B?NGRJRnN6dFhsVnJ5YlZtWWkvN2VpckxnVDAxWXRmUGxZN0x5NXd1eUp2aERn?=
 =?utf-8?B?M1JERnMzNWJabytpT1dEWFVWR0lhN1FZa1NFRTdoSk95WG5nWEh2M3lzbVdZ?=
 =?utf-8?B?MzZvQldTNG1VcHhwOVgwMGNMaTZuM3ZIY1BIWnJCRTc2QnVlSlZPTGlQTjNk?=
 =?utf-8?B?d1hjSnNnV1dadmJ3aE8yWkt0Rk5UaS9McTZiLy9meE8wRWRDUGwwVTJwdHBt?=
 =?utf-8?B?VWtNYTc1Z1ZmZHZsM1ZVNWNoNXpPRFdlb1Z2OTFPcWFGd0dmZkp6TjhTY2Fr?=
 =?utf-8?B?OXRlUHQ2Yk5vMDBKZTRFdjZEZkpUYzRaZ0ZYNFNSRHlzWFlUUWxXNkdlSHdj?=
 =?utf-8?B?YmVmajFGcDUxTGg1c1cxek9xOXh2bWFCcXE2dExVbXl2RmdsR05LYkNYbHFI?=
 =?utf-8?B?ODRyNzZycTJYckRydVpQeEJhT2J1cWN0ZmJKZkM5Mmxmdk5RYzdVb2lIQlVk?=
 =?utf-8?B?TUN0SmlwYk5CRnBMcHVHbXpiTlJlWGh1Zy9LMTk1ODNFcVJnK3phTFYwZ0xx?=
 =?utf-8?B?MFNNL0dvYnZuM2lFWlpHV1oyWTdtQjJGVjBMT09SWnlRYTV0Uzk2eS9HYXVQ?=
 =?utf-8?B?Ry9qTGdwY0ZpRXBoTERiNFVseFNZTm1JOXU5bjhrc1VOaFd1WWlpYW9jejVx?=
 =?utf-8?B?Ymtsd3lkMFRKRFJKWndSR3JtRTI4WEdnM29WVTJLdU9UNHVrRzlyRkZxUHA4?=
 =?utf-8?B?N2RIUE9Mc3BvR3VZRHFTYnZlNkV6RUl3K2xrRWNyZGZ2UEVSNWYwT0ZYSXBZ?=
 =?utf-8?B?cFNheVF6d2YyTmhnS3ZaV0xKNENOMnJtM2htRDZIWS84OGFYQ0piNDZpdE1H?=
 =?utf-8?B?RndFR2JDajRUaGUyZnMxYVBhdzdQUE9Zb3J0b0N3M1h6bk9USVljVmRkR3RX?=
 =?utf-8?B?ODdDN2JTS3duUEVyQXJqSGtFOVRlaHphOGV4V2FaMm1oY0F0NmRhVXRLNDZ1?=
 =?utf-8?B?aFdhM1FCdGNSekRYYzBsWmc0ZUZtZ09iekhRODh5YTcybzhPYmRKcEd5TEhl?=
 =?utf-8?B?d1lKby9LTnYwZXhvN0RveUwxa3hsc0FPaFpQS2swME9UY1Flc1V6MHB4QUlL?=
 =?utf-8?B?a3QvODV5cVFCVmQxWFZyb2pldkd6TFpJcnFpbGM3bVhQNVlqQ0NkM09Ma0wr?=
 =?utf-8?B?NktURERjaHBaRGU2RjltNWZ3cUlMQjZGdmpWa1NqRVN2Tm9WYm9LSnBHc296?=
 =?utf-8?B?U0pvZUx0amxIbHB6RW9DVVIwb2JQOFF1ZjZNcXFScHlFN3ZLVTIzUGZXek1z?=
 =?utf-8?B?eUJmMlY2RFJCdk5FY1FEVFFTWlNjMU9peWtDcGdxQ2RMSVQ3d09wWHZ1V1Vx?=
 =?utf-8?B?YjU4ZGpUVWF6VmRvRnFCekNsU2QvN3dkbUxOVEtXZXRZZUUwbGgwaU0rRmhB?=
 =?utf-8?B?NGEwRUsydjI1K09UM1pmM1Z2c3ZWdDRGL1VyZldKYTEzRHBsY0NKOUZobXNS?=
 =?utf-8?B?c3Z3dTZib0pFVWE5OU0yQmpYY25WUVZ6RTV6VklqTzgyQ1hLcjd3blczUTRx?=
 =?utf-8?B?VEhsTUMvQjFMak1xUjZ3YTlHOTBLZTNxdFBxUUs1ZlBMS2dmRHhneHF1Ylpj?=
 =?utf-8?B?RS90R1BGWnoweGpYbC94Z0lpZElLbVIzT2JzUnpFYlhVcUg1eG85ZE9jWENy?=
 =?utf-8?B?L3BTWGdPNjVGVWQ3OWlTR2pJbWkzc0RES0tQKzh5ckRUSGJwNVF2cTRzcjZ1?=
 =?utf-8?B?YkhHM3Vuc1ZrVzJ0ZUpCMGZsL0ovZ21HVGhJY2hmSWdyQ1d6YlZ5QWE5QW8v?=
 =?utf-8?B?SFFIOCswdklSZHRxZkFEb05yN2d6enZ4Z081cjZXb1NrMXduendrSzZNVlg1?=
 =?utf-8?B?RUdpbmVzZkNhdVFsdUZkbjkrN05CbGxkdUtwdDRTUlYxZXN0T2VQYXJ6S0Z0?=
 =?utf-8?B?Qzg3Y2hrSTFkb1lHM0JwYm9PSUVqNnZPWDBIazVCTGNHNlpjY1BJdUdidVhk?=
 =?utf-8?B?d1ozVTR3eWFVZEVWVkV4OFdsL1Q1N1FiajhPY0RDSXRlakZtNjk4TEJqakJj?=
 =?utf-8?B?aVJnZVhWU3o3cXRIQWFFSzdQTTBkY1hkbnVmT2xZM3FKTzdYandvVFRIazlS?=
 =?utf-8?B?ZXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96465a72-a828-4bb7-7651-08db0f42475a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 10:49:14.4457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/yxeNGXaR7HurL3NPETF7uL5UBiPDpRQBK2IUM4Ddtp6gqjqjxqidSGIsM3WCws2ITXyOcCRJLEM+ds+1VXjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5649

On 15.02.23 11:03, Yao,Yongxian wrote:
> 
> Hi,
>  
> Following exceptions occur on the Debian10.3 using Linux+xenomai kernel. 
> Please give me some hints. 

Is your Xenomai application dominating a CPU for more than a few dozens
of milliseconds? Do you have the Xenomai watchdog enabled (it would
catch such cases, after some seconds)? If you do have such a workload,
Linux complaining about not having the time to "breath" on such a CPU is
no surprise.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

