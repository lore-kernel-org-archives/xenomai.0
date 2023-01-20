Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2088.outbound.protection.outlook.com [40.107.247.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243CBBD3A
	for <xenomai@lists.linux.dev>; Fri, 20 Jan 2023 09:04:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEdbbCV7c/XcTcGyV1H1TUoUmCNdvIWxofEgES9yYG5eUhqtoZS9Q7ckBAcPnnsZnVGU/LF00Lf9UYtP9cIOLdKd8izJyUxetZbNTclR0oAuv05cjfmStZh5v3vJt18zm337pYG921N5nGEAZHjlMq1gZbHkbiS1glShwqlyc/J341rPW+N4df5f5Kk4hUsGkUKtoS6lxZEYiz1JZKUPLEmSXfxwtiw1zf1zkm2XDnOlNXFEDxP87scfQj25CCCseMAtzV+muOGyCiemURV21iM+nviGX68kUmEosYZ0xhZOq1GVBZJvfBeC0FxILR7VQHHSedOro59pfzg/1YK4QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nl+sE/Nb9jIQujtS+xd6IVekhjQxeMDtntXm99jEEu4=;
 b=feIRYtBwCUALf7lRWcZUYW5n8Moy/rkZlfEBwf9aEfpZuVV0XTjnUxFoE5k/cMpsGQBHeQj1uz4UeyCK11m/iod1BGI/QscrA3hydoK7VPKp5dd/A/GwcpeEXLhISGqy/t1ANUDK5solMm4DtEDAinqFETyFZbJ7KTGU5FjKZMrhdP5RFgKtq7KaOAwbmNr7UmCIFcZKhoYTZzwdWXYs3oY3Y1hLroJosf2UVdbdRwC+VGP8wfm8MzT8YCYXe0yOeJVojyBOXxNz86+LYKv4e1jAjdfkoHqjiyN/hZg11PQ9d7JzgQD8wgChYj0lCpVK1B3hIkpsiLXmH15OBvN5jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nl+sE/Nb9jIQujtS+xd6IVekhjQxeMDtntXm99jEEu4=;
 b=koDoJfvF8kxxuJDJeYGuy17i0gK9Z8lPaBzi9coTNEyqim3d56SvyDaBkuNecu2/X1tuby5LZl6b6qconzmnTXAFX2OzF+p/p1x4/3kie8ZPat+FpxMFuc/jEQ1yMnFliWAX6kMWokVcdzpZT1JVRqn5KnS43kwnEI1LRXfDlPfZwm1kEBvFhinbSg8WBntLYWQ7+uslSSOZlDcx2AScX+3TWBExNQGe2g+Ftf03Wh9fU774baXpb3BwGulx8Q0yNN7yV7n+BrerHAEkSGWBItNK8ZMedBGCMRyoVDNmZ8pipP2sOiebPfQvZSWTR2YhrNNwMWy/561aRt2XhMnP1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7507.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:426::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Fri, 20 Jan
 2023 09:04:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.6002.027; Fri, 20 Jan 2023
 09:04:49 +0000
Message-ID: <39d68bfe-f2ba-a183-f8d9-d477d696ffcd@siemens.com>
Date: Fri, 20 Jan 2023 10:04:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] rtsignals: part one, core code plus x86
Content-Language: en-US
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <20220707135952.5171-1-johannes.kirchmair@sigmatek.at>
 <20220707135952.5171-2-johannes.kirchmair@sigmatek.at>
 <327d7547-3485-1aa4-c686-60e81d4885e1@siemens.com>
 <VE1PR08MB490960CBB789FC9F26E4210192829@VE1PR08MB4909.eurprd08.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <VE1PR08MB490960CBB789FC9F26E4210192829@VE1PR08MB4909.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d787cc-cdae-4ce0-e55a-08dafac56254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iZ/7F+rmpdU/kUaIggYPQBiIj4XcJmKb++PaM1eUCXAE22HCDdMWDBcQdl6ssGEVDRCwbpYpYo9xn/MWocGtpFCKcNiTqcYHkHkekh9O3GWbWX1/QMhbm8HculknnRY10eZQyDdWUGtMpn3iNRy9WijWi9x1jGakbbK/nITU663gSMoLg4h8g5IjrkD91P3rmwh25wFN6lMhbYNTe5gb9YARp1dP9Pe+psaVJCrRqNAf9X5dIfJyLQpAnDPJ2BfVAK2K8PyGvzGUHsLGqi/K6SLfeClysBZbOoJRH9rWcv/udLzaCED7tGtbt15zzGifQeaBnNHK7JOWGu5WHzAP8mPYLgXKtZRTjkXzxZVSuZ+DBg8NhUCOFkv0yka/51PiiPmMJyHSHLRWiY752nYK7fDKrTZQal/yG3vZSZDd9BrleU7DytKFa1avBEkGqbrmHiumjAddKsdNjf+Klq3D7pq0cgbjNwd+kTzmVZtiE5srradvgFa6rgSwmzMKn8I0RKtJkfk7KUxIQQc8iA1yVaa9Cx/4MvFKrQ94q1U+Hys+v1BC3qabZDSERxAzfwZTGnCZzNn1uoAvcnEEdlx11B3JItLq2wjeRGG6ZagqL4tv1U44C6FP4IQbS9Zn2gBbZWegyulKHKw4Oa4qJ2FR+KiIeSdnSjNDGoKu17gembeyTiXhgbBrSiMFuRx3Q6zlDKWIokiQxZGQ7ic8z/44JrDnGQHGvLosFaLNvJ2o8fFiTExBhkbzP6qMfmxU9s+dpY2zt7pZwE8LVJlIAwFmlw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199015)(83380400001)(36756003)(8936002)(41300700001)(2616005)(316002)(110136005)(66556008)(66946007)(66476007)(8676002)(31696002)(82960400001)(86362001)(38100700002)(44832011)(2906002)(5660300002)(6486002)(6512007)(26005)(186003)(478600001)(6506007)(31686004)(6666004)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHpibmlYR1owRUViNUJ5V3FieFlxSXhjQkF2RUQwWVozYXZLNExmMUJIYVdv?=
 =?utf-8?B?Z1dLSUt1djJSZWxKS3RWQWxaYjZQVnJVbXhFMk9oRC9MbUYwVy9tck1MNnBN?=
 =?utf-8?B?eWpGeFU1bUJqRVNPNUpkWkhGeUd3LzZtYnhibHp4SHpYMlZ6bXgwU0t1SC9I?=
 =?utf-8?B?ZXN2ZmlHYUVUeklyOHc0aGN4U2l1cll3cnR1M2xlVEx5K2t5MmNTKzRKZC8w?=
 =?utf-8?B?WjRFRS9peG8vaVFwbHdhNm1iQzVKTEZNVWVoV1Vmd1ZoTkdxdm5mSGhNaTNa?=
 =?utf-8?B?aFl0dW9BS29hS1pqT2l1cEEwbUZ4MDJCZkhRQ1R2cUJ1RWczcDRxVktYTlBz?=
 =?utf-8?B?V21OTnR2Q0tnRXAxWk1CTXhjbFdnNHYvTUlGT0ovL3BhUmxJbE9tOWFRZ1ZY?=
 =?utf-8?B?ME9vZzlsZVBneXdrUW95dXk5VXRtRVBMNHpJUXlHam5rVDhhT0FORDA3KzR4?=
 =?utf-8?B?K3EyZ2Jmd2F6V3VKRVI1QlYyZ1EzMU8xOWJTc3QxdkJnaDAzSi9iMGFLYVNV?=
 =?utf-8?B?S1lVdFBJakJUY0p2bmJXM3g3V3hJNHpjMWVWM0cvM2tZaUZHQnR1SWplb0tQ?=
 =?utf-8?B?Slg0dWVWTFEyZTR4amFHUzBvMnJraEhiZ0tuNzJCZFhJUmRjWTNOSFNRZUlp?=
 =?utf-8?B?cDh3LzhDMWpYZjI1bkxPRzVaQ2Rxb01HOFpPempzYjBwQnlFWnBCdUFtZmo2?=
 =?utf-8?B?WFliWTlkK1M4UjB2MS80TTRaUXhGSDBRaXhIampXQ3JvM042TDFnOVRuR2sy?=
 =?utf-8?B?N1VGR2JxekFiYjhaTXhOcTFURkRNZXlyb2lTeURBV0pydXlwWFhLZVVVYnZq?=
 =?utf-8?B?M0pkWXdLRitSU0wzVU1yQlJEdmpmODh1RkU4T1d5b2M5TnBjT1NQSE5tNVpB?=
 =?utf-8?B?ZEkzWkVSaDdqM2JCWnFlQW92Uk9jTEo5Rm95S3pzVlNhV0I3V1A0cWo4UkUv?=
 =?utf-8?B?bDZCRGJCM0h6Z3M1OHc5T2pDOFhkUVZjV3RKMVlvVXNPajR1SHprKzcwWm9k?=
 =?utf-8?B?Z2NyWkNqaEU2OGtjMEhMZDN0YlNwOEZpSW5rVUVFK1AwQWF3ZVBMRWdPQ2t1?=
 =?utf-8?B?RXM2NTdVL3RIRU5ZQ3NCMUR0bitjc0RNMnpIZkFQU0M4UWg0bnl5QVFOR2FM?=
 =?utf-8?B?RmVHTzBXMU84bXVJUSs2Z2p3K1JBV29NNGU0ZzZXVzJNMkJFYU9JbkFBMzVQ?=
 =?utf-8?B?UEVvMWRnRVRsY2duTWxhVTU0ZHBwbWNsTVl2ZEFscmJNbkZRNmNkN0MydG4v?=
 =?utf-8?B?N1Rxd3ZQcFZkSzF1RDNEc3JJby9qaUJUNXFQWDMzeUNWLzhjOXFZL0ROVVhS?=
 =?utf-8?B?ZUZ6R1ZLN3lWVHpWWVRyMFJ6cGN3ZjZHK1VxUVBSVjdkQk84bGdSYnYza3RY?=
 =?utf-8?B?QXIyMVpBV3FvMWF0cHJEU2RoU3d4SWRKdmcyUHlRL2NEdjRUbEp2MGltT2Nv?=
 =?utf-8?B?UXF5Y2FSTEpMay94UzM1dWRraDBnMkdoQ1hRMGhJY09Vb0JjekNZVy9LR2VK?=
 =?utf-8?B?MUxLWVBVT2dlMHVuSXhobmtDWmxyNzFYZGZWSTFlZ0J1cmVDWjJOaitJOTY2?=
 =?utf-8?B?ZVpOTzIza1d6RTkzcitiRmp0Ti8zc2F5OGFPZWJJWTI2MzRZQjY1Y0VOSE1h?=
 =?utf-8?B?NXcrc2FLTGtxckxZMUk1ZDJxRVJsSlFNSzFLMTl3ZS9ZTEpRU2xieHh5eXJV?=
 =?utf-8?B?VmU4T3QyVWptVStpYkNyQkVwMnM5bkJ2NVBGOG1Md2cvUndTN252YmdOTDBR?=
 =?utf-8?B?Z0xnMkIwRTRER2ZpcUNOOU83VG1LSkxFbGltTEFrU1ZzcU5kb0ZjOXpNVWNk?=
 =?utf-8?B?d2NPMklKTktSWE1UaDgxWkNla1BjcTMyenVwNUc1eGN1VkVwajRWOGdGTzZT?=
 =?utf-8?B?TWZBYjNIckNaOWUydGp1UzltZWxYN2RvZFVRUDNxZDI2ZlhVNnEzek9NemF2?=
 =?utf-8?B?RkJDdHMveCtnZU83dFJJNTQ4UVhaZUpOaHVkb3czUE8rYkxqaVU2aVBwNUxY?=
 =?utf-8?B?MTVBbmJrN01xZ0FhK0x2TExrZGkxK1NoaEdVOHVWaThlTy9IdmsraTlnaWNk?=
 =?utf-8?B?ZGg3bUg0R1ZBYXR5M2lUMy92dzkrRHFZMVR1VXBHa1YxRlgrMzNkVFRzT1Ni?=
 =?utf-8?B?UmhTeUdKQUxiV2dvN252dHZqMEM5ZkxTNklQbmZja212UjYzdXpXc0J1dDFo?=
 =?utf-8?B?enc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d787cc-cdae-4ce0-e55a-08dafac56254
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 09:04:49.3297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKoOFZOy/MHaFsXZC2/VGVeWkuqW6Zt/RJoDbgXe7VFempRnb6QGdVwezI0qIKCSCLNbvX2AXKXlPOssmsBU3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7507

On 08.07.22 09:30, Johannes Kirchmair wrote:
> Hey Jan,
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Donnerstag, 7. Juli 2022 17:24
>> To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>;
>> xenomai@lists.linux.dev
>> Subject: Re: [PATCH 1/3] rtsignals: part one, core code plus x86
>>
>> On 07.07.22 15:59, Johannes Kirchmair wrote:
>>> From: Richard Weinberger <richard@nod.at>
>>>
>>> Adds code for implementing signals that are handled in the real time
>>> domain. This is done for 32bit process under an 64bit kernel.
>>> It works in a similar way to signals in the Linux kernel.
>>>
>>> Edited-by: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
>>
>> ...
>>
>>> +static int ia32_setup_sigcontext(struct sigcontext_32 __user *sc,
>>> +				 void __user *fpstate, struct pt_regs *regs,
>>> +				 unsigned int mask)
>>> +{
>>> +	int err = 0;
>>> +
>>> +	put_user_try
>>> +	{
>>> +		put_user_ex(get_user_seg(gs), (unsigned int __user *)&sc->gs);
>>> +		put_user_ex(get_user_seg(fs), (unsigned int __user *)&sc->fs);
>>> +		put_user_ex(get_user_seg(ds), (unsigned int __user *)&sc->ds);
>>> +		put_user_ex(get_user_seg(es), (unsigned int __user *)&sc->es);
>>> +
>>> +		put_user_ex(regs->di, &sc->di);
>>> +		put_user_ex(regs->si, &sc->si);
>>> +		put_user_ex(regs->bp, &sc->bp);
>>> +		put_user_ex(regs->sp, &sc->sp);
>>> +		put_user_ex(regs->bx, &sc->bx);
>>> +		put_user_ex(regs->dx, &sc->dx);
>>> +		put_user_ex(regs->cx, &sc->cx);
>>> +		put_user_ex(regs->ax, &sc->ax);
>>> +		put_user_ex(current->thread.trap_nr, &sc->trapno);
>>> +		put_user_ex(current->thread.error_code, &sc->err);
>>> +		put_user_ex(regs->ip, &sc->ip);
>>> +		put_user_ex(regs->cs, (unsigned int __user *)&sc->cs);
>>> +		put_user_ex(regs->flags, &sc->flags);
>>> +		put_user_ex(regs->sp, &sc->sp_at_signal);
>>> +		put_user_ex(regs->ss, (unsigned int __user *)&sc->ss);
>>> +
>>> +		put_user_ex(ptr_to_compat(fpstate), &sc->fpstate);
>>> +
>>> +		/* non-iBCS2 extensions.. */
>>> +		put_user_ex(mask, &sc->oldmask);
>>> +		put_user_ex(current->thread.cr2, &sc->cr2);
>>> +	}
>>> +	put_user_catch(err);
>>
>> Am I missing something - or did you miss to add the magic for this
>> get/put_user_try/catch?
> Tried to figure it out this morning, but don’t understand it fully jet. Actually don’t quite get, how the errors of put_user_ex are propagated into the err variable. Probably in this case put_user_try, put_user_catch is only for disabling SMAP. But I will have a deeper look at it in the beginning of August after my vacation.
> 

Was there a follow-up on this? I'm planning to revive this finally,
figuring out if there are pitfalls in going the sigaction/sigreturn path
for Xenomai.

BTW, I do not understand why you made the restorer function a direct
parameter of the sigaction syscall. It comes from the sigaction
structure. And your implementation cannot provide oact when we want to
add sigaction as library call as well.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

