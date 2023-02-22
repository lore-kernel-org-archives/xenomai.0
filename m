Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4F28F59
	for <xenomai@lists.linux.dev>; Wed, 22 Feb 2023 17:56:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcY1JQyYLx65Bi2OWpGKm56Y4f633C1gWB3xJ0Cr4bVIpZ6gQ4qUphm4p8jdXz4bltKRoiXj5c8o41LU1Iw4bYDeBoQLOQET+Qb1aK/HTjGYUmuUQRPLLkBBIRzuaS6ZCnIti20tZk6SNa2oBck1fVXdN11ikcVj2OQ1uuuAc3Kn8n1T+hh+zKtHgxTifYVjb8SpmwBjLZkUhisHwWPEiPUIz/AGXj01V/VATW8XSpIvogwQ86Ifnl0iSQ+L2ZpOlUm/UDOxkADncghFVp5L0mtNEmzCciJjBIs2w4SLjeEXhVNk/1rRSfaHr2F4qeZhyS+bezXvw0oxGpIVlju2nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqEno4TtdVDgpE1SSFxU++RIemH6Otmj9mwX3G2xNzA=;
 b=S68MRtBwzqR37cspH0M3IUcxY5gx/O6WFkmSdFEig7JV98n2xOT4a753K9TZhN0vX1EtLJ5sjCl0jDNXoD5HlLHqsAo276+CURr64xmU5LaLg/i2rBq4l99IbmNMHlnHqDlfeeSfApo+406tUyxE7GoJHnQFW9jBTWWw0GT9iaQXvOHzoIZRtEwdolkfY/0v4mdc5w9kh91qCIxbnahRbV7PVrTHJr7DSddhmeiWK6H4bLPGPVJoCB4wvqxJcuOuMK4Yib/umb7MMeD5FHK3pu6CEBP3rCdXpgKOkHVftAvfwKrCyIieUHVUbWtiwLA2x6AjcKzLG9QC6smVs9L3PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqEno4TtdVDgpE1SSFxU++RIemH6Otmj9mwX3G2xNzA=;
 b=yY4D+2hm9RSB80BejMzBjqHbLNnjvnhX6fvv+dH1CjlZ8yV0KnwQSmhytVz06UcbEMKmD/WaVy9wzP3D58D6j0doPtvHl+9bPr/e8+zk5XHWaCV4kwzcEwhFDYNsnOFC5LNcXL2Pkx6RPiz+7oYdtb5Ph4RLLY63KMvdDBQKoqMx7SOQyi46TAhy4hwNQhT4cTlvn9oDDhmUs1TvPLoYZEN+wwm61CIO9fUh7SWdeqUOPtRz/NtsywdEbJu7aOr02Z/1qlNBWnhLhQbasbX3AIUtzdL2+BbEzI6lh1Iv+IvdnVXgi3shUoFE2QyZf46k6DUENLeRf2yv08gkSsbT0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB5912.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 17:56:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 17:56:47 +0000
Message-ID: <f6b821f5-bf7c-ceb1-b3c6-e7f5fc6ed587@siemens.com>
Date: Wed, 22 Feb 2023 18:56:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Inconsistency between documentation and code in
 lib/alchemy/task.c
Content-Language: en-US
To: "Rosenow, James" <jim.rosenow@mts.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Cc: "Ganz, Derek" <derek.ganz@mts.com>
References: <DM6PR04MB61228B4C5910471EEEE02ABFE2AA9@DM6PR04MB6122.namprd04.prod.outlook.com>
 <DM6PR04MB6122B1C2A8750460027C8852E2AA9@DM6PR04MB6122.namprd04.prod.outlook.com>
 <DM6PR04MB612217B2DBE5BF6E4961612DE2AA9@DM6PR04MB6122.namprd04.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <DM6PR04MB612217B2DBE5BF6E4961612DE2AA9@DM6PR04MB6122.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d3a7d1-c158-44e8-a56f-08db14fe2a9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iLGRMH6u8LfS3g/Gly8sOq4kpEahlXUo4OgyibpEWlWLybwDNv6h5vXm7Gk6koEnRdwF7b4Qt5naoMVIa7qZpxyuWoNqdTvhjYNrbQXf9zOVyCZX46ZG3BQc1forZmnF6w5UOIVthWAGLPiKgcd2tMHNXVQQFMWNFujk3s7u4B/Q9TGAfJE7FdszB46Z4M7Z3g3KDk2Z4ZNq4K8O9ecCLXTdZBGgcdXyopDw7Aulq0Oof+sIa1DYVlC9fyGbTEN62JuhxY1oAapptSJXDnzKzwToZQM4ssOM8cZ9ExzE19AoARNXTvXTCqD4y8YOHtHw9Nse6rnxxMGU256oU2qirYxwaUYrYKKjdxU7bbTHLylw/ruf8L0LkRNcKGzwUO/9II6c/pMhim4+c38tFTK/50dx9azycisAqAmE83DlyoMSnR47VTr3+Cc4sTWwjK9lbVNgDn3OmkFGt1PsCkoUlAdPF1V7OuT6z/PVL7cyZE/AO9GVai+kB20g/p8En1I8s7UrhZDzO0KkE5uo8vNtQCzrQucsyM5gbL8TW0rND6rPN+IUBpfyFc0xWMO70l+6fs0fNMndIsTLKiCahGnt02YbE/Bm0ZyDCvu065TpCegxP61GIapfj7oFloDkBgfqu7BE6AlZc4UWrX2e7RTd5u/RSGtjaOAvbyj3BYMIIPxiJKRpK302Z3EIsnYZNSaU+QpV9ofwb5yXce8a0qO5rSAYR3Mn+/5vo1dmYU+0Avs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199018)(83380400001)(41300700001)(186003)(26005)(6512007)(53546011)(6506007)(316002)(110136005)(86362001)(6666004)(31696002)(6486002)(478600001)(36756003)(8676002)(66946007)(66556008)(4326008)(66476007)(2906002)(82960400001)(2616005)(31686004)(38100700002)(8936002)(5660300002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MW5GVVh4clJsZGFKcU1SdTRlamIzcmtZcHdxSmtCNjZNUWxRNGlTQ3AzS0Rp?=
 =?utf-8?B?bnczSU1JdEtOM1ROcGY0WlFURmt5aEhmcmthbjBDWk1LUnA5ZVpENG5laW13?=
 =?utf-8?B?UzVKKzdRdXQ4UkhqcWZWUlVObDYxemxQMDg2MVhOWW5VdW04cmhJUFU5aS80?=
 =?utf-8?B?dDZrSjB1ZXpBczFlYkNzRXRQRi9QMmM3a0dNUnpKVFR2aWJDUi9GQXBTcHF3?=
 =?utf-8?B?ZGQ0a2ZoZ1FocXFWZk8rK3FqYVZhZWJLTWFrK256WlFZdG95MnpUb1pmWjd3?=
 =?utf-8?B?L2JuK3VHeTVxSkpFalFmT1lyL1YrM0kzOExJWlN0V2dSTS9wcWNUc2hqMWtB?=
 =?utf-8?B?R2FjcDRQRDYwRTJlUGF5bm5uQXhySzl5VVV4d0tlKzk0RkttdXp1aDBFcDMy?=
 =?utf-8?B?dENtVVRSQ0tYY05TalZRMUxzS2wxd1pTUGowNW5Ub3VmQzBCV0ZDbmsxOVV4?=
 =?utf-8?B?Vy9GU2pnRWIvdG5vVEhRK3cvTWQ4M3IzbXpiOUJySnAyV3M4N3Z5TzM3RWNq?=
 =?utf-8?B?b0o4VnIzc0VOLzlQNUhlZ0l2b2xCY1J0alkxS1o1dlZpdlEyL2hoVzN3ZVVl?=
 =?utf-8?B?Y21YMUx2SWpyS2FxUW13dTk5V1ZPbGk0MGFIS0pTcCt5aU5KdVpXMms0QjlD?=
 =?utf-8?B?R0tVUjRDczcwTy9sd3hxK3JlQ2VBRlliOThwNWZCRkdwNllaVmtieURGY3pC?=
 =?utf-8?B?cEV4bllSR0JxeUlQakY0NWovMTljRW1PcCtqODZ3K3A0eTR5b2FCOVRRQVNS?=
 =?utf-8?B?bkEwNjA5dTRqTHhjZHdpVlI0MzFFVFF0d0wwVTM2RmlCSFU1ZkpmL3l2TC84?=
 =?utf-8?B?RFdMWkdOZ1RKM3krR3pETEtRV0xNWHRIRmRqYlVYaXpWaWVPOUNBcWxqMThO?=
 =?utf-8?B?RjQwWDlOYnBYZUo5UytNUHE1NHRPTzJYOUlid3luU1I4MU5iblZJcXpCSUxh?=
 =?utf-8?B?cWlWOE9WQ05WdVUvZUFIVVR1Z2IxVTZ5d1dhQlpPV1hKYkZBQmh0aTlDb3NM?=
 =?utf-8?B?REk1NWJMbHdnekpIN0hXUi9mMS9NYTZQcnB0Tjk3dFlYcjgvQkxCMVQ3Q1RH?=
 =?utf-8?B?ZVRsSmQzZUtjb2NRTFFxczlsOWJHYlcrTjhhKzdidDVTWDVyQnVWRzJNVXVI?=
 =?utf-8?B?eUhEUXI5K2JvL0pPREJ1VzM3V1Zjdmxaajh6MXVFN3Nhc1lFTklKRmYzWlNO?=
 =?utf-8?B?TWpKQzZ1Q3U3L0tvTWVXMCtHS3lsUitXRHZMUytJNk1KeVh6ZXVpMCt5OERu?=
 =?utf-8?B?VUlVaEIvOW4xa0lFTGNKME5WaDVxWUxaSHhJWCs0Q3RSM1RXQk84NjRzTTN2?=
 =?utf-8?B?cFhwdUg2M0JDUU5IZjEvYUhRenYvWDRLWFREQzVOQkJaOG1MaVRMak1tM2JK?=
 =?utf-8?B?UGFhZmhmL2REYUNtVXJJeERzS0lEam90WlhKcVFHVmpFNVEyRFJPanloTVFh?=
 =?utf-8?B?MWRNNlFJMTczRm5FUExENHY2OU53Z1M3SlArSk1US0FRd3hTTWo4K0xFSTVn?=
 =?utf-8?B?dzQrTy9rWjdadVJzR3lDdnBLV0tCbm1GS0FBUU9SVzJFTE9aMGRuUGliYVBx?=
 =?utf-8?B?dm9OSVpIdEc2TGI3VVJZNnpuYlBQQWMyMW03bElMNFBGQXp1U3huNVhQL2NV?=
 =?utf-8?B?Y2EwaTc3UHNrZkFNL1FnaVBKeXBPdW80UWloYTIwNHZqZ1hmcEpoSXhHV2JM?=
 =?utf-8?B?UlovR1hvUUsrVGtFWHVJcldNYmhMSDRnSXA4SHBMZDlZTWJGTDVtdnExeVl2?=
 =?utf-8?B?bWhQNmVJUHUxTUhPU2E4b2NQS0tIdUxMMzhSSTREMmU1SU9NdUhycUF6Z0ZG?=
 =?utf-8?B?cXBLSExieUVKSFN6NHJvanhZK1ZKS1ZOZytBekFWZThPU0dRcGlHK3VWcmlk?=
 =?utf-8?B?eWJlNFQxdzVzNEZqS3IwMSsyK1paTGo4QWRtNGFDSjFuVWVTWjh1aFZvN1J5?=
 =?utf-8?B?NkJQUTBlMlJvM29RZm1PZDNMZytoWU5hNFRiWE5UblY0SEVXVDkrb1NnZDNt?=
 =?utf-8?B?QjF2OHhvL3podXJWenlzZjU2KzFYTGdSRTNsSkpjTWI1NXYzZUNEMXJ3bHFm?=
 =?utf-8?B?dHN6S2JmSkQ3S3Y2c1M4MmZ0Y0Y5QnJTc3B5RVBKcFZ4SUE4RGE3aWZwUFlu?=
 =?utf-8?B?dWpYYUh0YVdnUjlEclNWbnpXY0Q5ZXJlRkhlOW5iMkRCMXFIS2RjRkVlcEo0?=
 =?utf-8?B?bHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d3a7d1-c158-44e8-a56f-08db14fe2a9a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 17:56:47.5520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKLfXt+Dus+oocB82foWjUYKTJBDFKWGHA6618aCVbDg/3FPSPAENBSwYYggsUiBGR1NkAK2NgdKL4zOJVpobQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5912

On 22.02.23 17:32, Rosenow, James wrote:
> Greetings,
> 
> We are experiencing a crash in rt_task_inquire() and found an apparent inconsistency between the doc and the code.  Our code is passing a NULL 'info' pointer and subsequently crashing.  See code snipped below.
> 
> Best regards,
> Jim Rosenow
> MTS Systems Corporation
> 
> /**
> * @fn int rt_task_inquire(RT_TASK *task, RT_TASK_INFO *info)
> * @brief Retrieve information about a real-time task.
> *
> 
> <<<<<<< snip >>>>>>>>
> 
> * @param info  The address of a structure the task information will be
> 
>                                          Passing NULL is supposed to be valid but
>                                          below it is not checked before use.
>                                           |
>                                          \/
> * written to. Passing NULL is valid, in which case the system is only
> * probed for existence of the specified task.
> *
> 
> <<<<<<< snip >>>>>>>>
> 
> */
> int rt_task_inquire(RT_TASK *task, RT_TASK_INFO *info)
> {
>                     struct alchemy_task *tcb;
>                     struct service svc;
>                     int ret = 0;
> 
>                     CANCEL_DEFER(svc);
> 
>                     tcb = get_alchemy_task_or_self(task, &ret);
>                     if (tcb == NULL)
>                                          goto out;
> 
>                                                                                                       'info' is not checked
>                                                                                                       for NULL before
>                                                                                                       dereference.
>                                                                                                       |
>                                                                                                      \/
>                     ret = __bt(threadobj_stat(&tcb->thobj, &info->stat));
>                     if (ret)
>                                          goto out;
> 
> <<<<<<< snip >>>>>>>>
> 
> 
> 

We probably didn't read or forgot to update the documentation while
porting from Xenomai 2 to 3. Checking... Yeah, 2.x implemented this in
the kernel and did take care of this case. But already the first version
of rt_task_inquire in 3.x, now in userspace, got this wrong.

I'm fine with re-adding that feature to the code and taking that fix
into stable branches - want to send a patch for this more than 11 years
old bug?

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

