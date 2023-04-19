Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775B53C34
	for <xenomai@lists.linux.dev>; Wed, 19 Apr 2023 12:39:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrDqmUrTii6rsylVVHHdcJiGujC6QW8AuKEZzJMgjKj6otZ+BXmrJSu0tCgnUUxCXF7Bq2vWS9zlJb8Y3xLd44Kty41RlD5h6faWF+Z6BBE0Zx5HQ0llrHsBns9tBe0i8meOLpn4WF0BDVNhzUkwbfQa3SaIpZWAY9yAipJJDEx1xus/po36z9QJOSGTJwVesaKu98SBnCjNFSM/fdwIlViffRqS6quBTOBima3cYPS0Vb24p0HsF/GByCLJKsdd9Oiu3TD+D4B0ig2B+z/fWHjUDZUeLHJIlGRtpTmBEMK9bqLiwe4ly67A6AcRrxFBHTV5qeV0ypaggRbVlPDp7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExGovKwM4x27dD1Pbo7GUT87sf50shAfLXRzLe6eojk=;
 b=iDZ3DIHY0s1fQtkJ5CqQoKj5SFa+tgX1i91g9DiF4kpgUXhF3zi3ZsKVjcrGL2s0jNnEEA1a6nm7eFMjSylvzIv+fD2uB9C1ECg2mJopyBM+FbDXqgAIrKyh3vNfcBzob0dCFHNuuNx6ub7PrFBP18awbp8UeqlGN7IsLlUBmXTPZZzpwAm0H5VrTZHlZaBvNBB6jHxpnNxupacD5D4smvIvPnoWl3UqVAoTBcHNLNvIMnF2kaZGvNePWc6ihjEGK80EZi79/2L7Pq964NA1AzfY75S1TD4oo1NA/RRBZq+AuKleXANX8bEyt1tH90KdXt4V87kN3nVXBKrdw+73qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExGovKwM4x27dD1Pbo7GUT87sf50shAfLXRzLe6eojk=;
 b=orvBGITmNoQBwQceQBJf0uF/agzuQND6PzqmnIfUMjGFoGLLG0ldHWg8sM4JyvcVWqvuxFRE5f9ySe/ojqeixp83IUXnCnUkGeqwuiNmO0sMWqQRkEXOQ83Yx0wy1u/pwGTKRJ/OfcbCsmCnnAQgijPGk2dS4OtVw3uxG13r8zhVwYY7Z8Vn1YPPC38Xfulx+1laC4F6ILkdoji/6+W/D1+u4qfNUnbpjElTlDQ6dTv0Jw2S5Z+ZsMpVEkj1GtP9rwH4WBD+d49vGO0vhHZzIujJz4USaJviZ01Gyo+4BOCnzZ+vhEPRdB8TPwkrFYaF6Y6IVFg6SiZZ8R5gE3OvZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6683.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:85::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Wed, 19 Apr
 2023 12:39:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.021; Wed, 19 Apr 2023
 12:39:50 +0000
Message-ID: <c5238f77-0f7a-34eb-6e8c-ef7bfb6908bb@siemens.com>
Date: Wed, 19 Apr 2023 14:39:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/3] rtsignals: part one, core code plus x86
Content-Language: en-US
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>,
 "Schaffner, Tobias (T CED SES-DE)" <tobias.schaffner@siemens.com>
References: <20220707135952.5171-1-johannes.kirchmair@sigmatek.at>
 <20220707135952.5171-2-johannes.kirchmair@sigmatek.at>
 <327d7547-3485-1aa4-c686-60e81d4885e1@siemens.com>
 <VE1PR08MB490960CBB789FC9F26E4210192829@VE1PR08MB4909.eurprd08.prod.outlook.com>
 <39d68bfe-f2ba-a183-f8d9-d477d696ffcd@siemens.com>
 <VE1PR08MB4909574295D8F9CE21C7DFB092C59@VE1PR08MB4909.eurprd08.prod.outlook.com>
 <35f36456-ee3a-12e6-3f90-83a1047aeb2c@siemens.com>
 <VE1PR08MB4909CA10A9C7E767BA97C2FA92629@VE1PR08MB4909.eurprd08.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <VE1PR08MB4909CA10A9C7E767BA97C2FA92629@VE1PR08MB4909.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0063.eurprd04.prod.outlook.com
 (2603:10a6:208:1::40) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: f676682d-6c57-4c51-3ce2-08db40d32a7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B8KgG0SaBvCMalHJeBad2RlcVeMeg6P32sZWQ9r7jlq5AhcZWoaKoPrXgPKhAmhQqQrL2huGE3SnqUgOBMQEmod+zd35uay7ViQKcu8kYrJGgnHUtEFSU/6Nbz9NYBqxb1k8wIt0FfKKIO+2hvF650Mj7go9y+BuzRKHtYGrhacAm8ygIJGoCzVov+qQ1+CQqfi8ITDK4k5eBqbGXCoCeW9aWH9Vp1+/ieLa7OwmPbYVZUueM9TLsWbPI+8UGEHwd+yEXLB54xPLpfBUomy0OB+HSty9kJHHR+f8OBRkWUzv7W22iKy5tZeexjduyfQ+eZGXaAokjJLqW4i4N5CwVlPpnztV/Y2Lv2+KFfCr2mgAWnfEF1zoK5z2JUzASzBBpNDwfSHo/tSlP0kcg0VTP1oc0Aw5QEPouuLCRD71QELpb5gS4CACNlg7CGl+/AmMFQImMorDGIBtKVH9gEpK7h2nRLSPDm4tENRLIQLPgwOpBW6RwdwMHfHYzZsJdtGAl5RkB4aMTgGX09qaoguSgR6L46C8N7rkwBjH+/c4tNKJkOSN5tePBuqaBY8P7aJ7wvrwYv9dONASpqmA41fjawXh5SyelnH4PGD7wMm7wU9FYa2JJGIu09CDgRu4ORgo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199021)(5660300002)(44832011)(2616005)(31696002)(107886003)(53546011)(82960400001)(6512007)(26005)(186003)(86362001)(6506007)(38100700002)(8936002)(478600001)(54906003)(966005)(6666004)(8676002)(316002)(4326008)(36756003)(6486002)(6916009)(66556008)(66946007)(41300700001)(66476007)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1RnVjFBM011RW1kMVZlcVFLR3NrZmVhZWxjSWxpNnNjckM3MVptQm5welgr?=
 =?utf-8?B?eDY1SzZWRGwyZGVTREVnQ0ZIU3UxeDMrNlEwQ1VVeHBFeW1Fb2xRMTdMejhX?=
 =?utf-8?B?Tk5LVVlGK05JTUFISUhCVnlSVzZzR1dVc1lzbzQ5STdCeTZrd0VDN0lBbnJ3?=
 =?utf-8?B?VzdTZVd0SmZOWlJlTTZrclc1UnVDSlpQZERXL0phLzhOT1V6ejFoN0NFMWpj?=
 =?utf-8?B?dlhVdXZYZko0ZjlvS3F4dFk0S1JlUUpsQ25rMjNZWjFVb1E2NGErd0FLVUJB?=
 =?utf-8?B?d1didVFrYWNKQXRjcDR0ckxYNS80aXVzeDJIVGNCaXplYlhHSHUyTUZOQW5v?=
 =?utf-8?B?MEtyWkpJN1VZUDNxbjgyNmVrNDJFVGFVU3dCU1BKQU5sU2dWUHkxL0Zjd3A3?=
 =?utf-8?B?S3plYmRpV29qM29NZURSb0d6aDhwbm9hVGNSWU5QVzM2TCthTDJXdmpNMEhT?=
 =?utf-8?B?QkpGYnlwSXgwc29kUjJqTGFSZDM0em5WUWtyTUFmQjh6dkdFVzMzYm9pZDBH?=
 =?utf-8?B?Q0xiaWZ4cWcwRVFYN29OeVVUMGt4NU12QWlFcHk4U1dGbi83bE9MenJTYWxW?=
 =?utf-8?B?NWtPbjRWb0x3Uk5IcWpJaGtOU1p4UFErWlBlNjYzKzF2R2dLUFBMalZyNE16?=
 =?utf-8?B?clcwMDZTaG5IOEpsVnovL3RMbDlQMSt2ekJBVGtCUC81VlFJSUV4RHg5V242?=
 =?utf-8?B?YkJnRUZockZ5Vjc2aytGc2FvMGgrZkdHT1ZzN1o4TGw0Vm1qZlE2Z2hndm1D?=
 =?utf-8?B?bm8zTzJ0OG4vY3dEbTFOUi9qcC9vb1lraFY3Qm16RU1zakdDcjQwcmJBYlhN?=
 =?utf-8?B?SUFFM0FlMERGbThTNUJ4WEtwVnJXUXFpL0ZhbnJMQVQxU1RHbVNuemo5d3lY?=
 =?utf-8?B?eCt6MHVCYnhCdlNtdWhWbUhJR2h2L2xPbTJyMFVuODJhZEdMdUduYXlZYjM1?=
 =?utf-8?B?NmhGcll0RnhwTzlXbjVZZjRqRVBrRmlYVGhuZVpsYUhNOC9RZUw4b3l3SXMz?=
 =?utf-8?B?ZDdGYW8rZ2FMUVkydXkrQ3RaVWducnFHaEo0bDFiSjdaLzJ0bElQRGhDTkox?=
 =?utf-8?B?VmVsL0tZR1huc1puOGlZc0w2dzNCQUl6NDF2RE0za1dvR0FZaU5yWlpWcVNE?=
 =?utf-8?B?YnAxSWpaMUJFbmZuQm1hTUNkdmNqVVJzR0VCVVlLcmZsTXVDYmYyMWNyYzJM?=
 =?utf-8?B?UFdUV1pTcXVzSnJWenA4K1Rxb2RPMjA1YU1FdE9DVWQ2YkJWYmp2UFB4UWp0?=
 =?utf-8?B?b2RXcE4zd2ljUzZzakRBaEZnNU5sQ0ZDd2lPUzFHbTJVWGhlMXFxRHlaSC9W?=
 =?utf-8?B?d1hJcEs1K1Y0SGZ3a2tvQ1k4ZVR5WVZLczgzWUlCZVFETE96dklDcnZEYkFB?=
 =?utf-8?B?dU85V1N3WnExMFU4NEpYb24wS2hJazVQckE4cGFhNDd3Nk9zMFcrWmZ5N3Z6?=
 =?utf-8?B?Q3dhYzFrTnVzVTFFeVkxREQ1dXFSNE9vVmo0ampjWVlNNjczUEZtTis5WlZh?=
 =?utf-8?B?RnpCODg4Zm4wREVWSEVoVTFNVDJMWmQxQjN2Yks5YVY2R2xhSm9mZDZDNXVi?=
 =?utf-8?B?RHMrcXIrVlYrTWQrWHRjM1pnZ0JaendIenNyYndhRnk0QmZiaTNncUw3MDNC?=
 =?utf-8?B?YTlhOWtMb3ZKR0hQeWdUMDMrdWtna3RQK2lRRWdvT1hVUW5vbmdZUmowTXRp?=
 =?utf-8?B?WERkYTJZb2V2dTNyV2Vrb3UvcU5GMUpoNVlVbUtSdE56dFRLV2xxbDhZRjVK?=
 =?utf-8?B?T2Zrb0hzU25zMmRtZmw5eVRpKzc0MS94Z0xOVVU0cWw3eGtTSE4xTTJqQmlJ?=
 =?utf-8?B?eXFvcHlIT1l1bjFmQjE1dTBFTGo5MVY3UHBrbWt6aVFkRXVnaUg3bUU1cTJD?=
 =?utf-8?B?MUE5aklzRFF3N1IyOTR3RGk4UW9reWlNVmsvalU3ODBsblVaSnV3alNPTWhx?=
 =?utf-8?B?eFY3MXRuV0hreUN6RmNuRXhNRTIyaG93NVE2a2FlZmw5TElQZGQ3d2JtSndW?=
 =?utf-8?B?RHZFWGd4OVcxTVdvZ2lrb0dHU0RkSGRCQ2pJbzFEdHEwWHFtM25XRTQzdDhB?=
 =?utf-8?B?czFTTFNuR1RrNDdtZ0o5T0NUenVaRlEycERudWRkWFlFUHRXaHFJTXFlU1RD?=
 =?utf-8?Q?FBQyWtr1kRtG/tV5OiJHWgCb6?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f676682d-6c57-4c51-3ce2-08db40d32a7d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 12:39:50.6156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qKLOk3/mdMQ9pJgq3n7bENOwEEuhltIGuOpqIIcOwuvLZpdxPuZpDrvs9pHxh91HkySUQ50YnHu6AF+DY33Low==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6683

On 19.04.23 11:18, Johannes Kirchmair wrote:
> Hey Jan, 
> 
> Richard told me that there was the topic of rt-signals in the community call today. 
> He said that you asked if there are newer version of the rt-signal patches finally.
> 
> After the last call I attended, I did some work moving the signal frame setup and restoring into the dovetail part. As you said that this is the way if we want to use some of the Linux functions.
> 
> Unfortunately I had to stop working on it due to another topping popping up. 
> 
> I just look into the stuff I changed and it seems like it should work the way it is now.
> But I will have to test it again (because I don’t remember, if it really worked after my changes).
> 
> After that I could provide patches for Dovetail and Xenomai. With this we could start discussing if I use to much of Linux code for real time. I am not really sure what is viable to do in oob stage and what is not. So I will depend on the experience of you and other experts.

Right, we definitely need everyone on the table to for that, including
Philippe.

> And we should also speak about the interfaces and the functionality we really want to provide for rt task.

Agreed. That's one reason Tobias wrote a smokey test case which he will
share with us soon.

> 
> Sorry for the rather slow process of this features development.

No problem, I know this situation very well.

> 
> FYI: I will be at EOSS in June and would be glad if we could meet up there.

Great, then we are at least 3: Maybe also follow-up on
https://lore.kernel.org/xenomai/CAFLxGvwrKVG8aBhrv5-VwfiQeCcgfGswXDnC=3FawvQMd58c6w@mail.gmail.com/T/#t

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

