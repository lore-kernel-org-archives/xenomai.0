Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278012594
	for <xenomai@lists.linux.dev>; Mon, 18 Sep 2023 11:48:32 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 8FCAA200003
	for <xenomai@lists.linux.dev>; Mon, 18 Sep 2023 11:48:25 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on0626.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::626])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 7D68D941647;
	Mon, 18 Sep 2023 11:48:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k98O6jVA9UsXENyjpP5bCXmdkmqcEbxhugbu96G2gJr6LsVbK+HprCbkomsP0KDRxqJYr9GLfelsv8s33dtxylmZ9WME5hGIEYJnycbo+TwgvV8TPniZcvrfSS9XpNYFzAiTXSGcQkeOCCPn2YUqL4FTTBCyh0iWJ4pOmPFYg4CoOorcAoutcKseBJBJyeaZtG47btbMfooYVEXOFK/Fcm9I1SgoqxWdaH5VBnU3R89ZA8ZWkV431pRk3EA63+B/fdVmWimDbBb5Z3WauJUpNuisZXMyhLuazNUxULNAAjyW2ZSsGvg9G2nF5vrDA4HIfUFp4VvcCy3zPDqQ9bOdvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5FgQzvmnaVcxrJIpSdDVpRPEdmiV1OcVxaoz6I5u8Y=;
 b=Cnv8gryI3IlJX099j4/mBz/Od9i0bvJfpSOs+fkhdlrpAvWg09saAEW24OneiJ1vrlpF+b5e2jgVNY7TqeCrSe2HkwSg+ZNw41MWxA0qFDvim4b+U0CWl8qV45vkLQ1BhDV/OSNRUoP2vD5Gif5bRGd5TY4oTKHTDrx9/4L2GEMXjDqUSirbZXnHDGcsRUJVLSo4lZcpkDUV6d5Rez/5OqofAJRSMkEWEJGZG2TY+PvSkdkj+pkHgMBUWX5Qo6qf6M47eyDj6hMqQ4zqojGIboTCSZvnO1JmJnejO9cLr67SXrZzaUPupPXpFLJM+8TRd7m0H2l5+zLTN/S8SOftwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5FgQzvmnaVcxrJIpSdDVpRPEdmiV1OcVxaoz6I5u8Y=;
 b=Ofbc8JfWtYslUQ8/EL3TPElQrDcYES4WhKOizeqcSccN4NxbONuY53l1hwIR1UqkNCLgJR0kwcJh961rpkXFPb+eXIAtvcX2NNP0/4tW4dgXhidLiXas02/kadZhML03TkzOhpPsifbsswkzHpJXgAQO6KkDBEkwQAoNW9GSV/NumnjMeAdaiiHrntJID0hXFEKTQVzKXMzbFOjtM3XTP6VFINRmC7KbVzcK0l/21BJB+TJxNHO7mCE0l3ix+b3iLHdv+/w2IM/x/XB3huuddeHla0Vwt9YRfwL0PoJAFWoH/nXj+Wy7Vxz8MJGpDFk4i5ViV9dOaVKPWa8faEQqhg==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 11:48:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6792.021; Mon, 18 Sep 2023
 11:48:23 +0000
Message-ID: <92fd29bd-849c-4582-a2c9-9edd2d3cc37e@siemens.com>
Date: Mon, 18 Sep 2023 13:48:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Downloads and mailing list pages broken
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
Cc: Alec Ari <neotheuser@ymail.com>, "xenomai@xenomai.org"
 <xenomai@xenomai.org>
References: <2099512930.605027.1694630572180.ref@mail.yahoo.com>
 <2099512930.605027.1694630572180@mail.yahoo.com>
 <95d4f7a6-1237-4ae0-9fb6-3979fa058bcc@siemens.com>
 <87a5tj7llz.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <87a5tj7llz.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0005.namprd19.prod.outlook.com
 (2603:10b6:610:4d::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5675:EE_
X-MS-Office365-Filtering-Correlation-Id: f168ee09-7ea8-4d8f-f3a7-08dbb83d2948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SzaqkCj1yLLOGSPJKODVKRMgVwsFRW0zG94T/oi8N4J2G8O9lURwNmDMvweRPpT2JV/rxMDRWL7Xjy2YnITo92YM18/Yzag+WW8925RLd0G0RqvFK0x9vvIH5gPwoLPdaYKG7+gOiJQcEcjp0w4h+6jVjMkWYtFWuB/rOdOMOx2nko48r3ncSPUhYYUtybG/FIL2U/M0EpqRkBXpV5F2Nh9CHum95JdHLLPcifrDyhbbOBY0DvvA4mLwb6sI+VNMU/YlYoFZFg1iTHw9KhfaoArau1uJzCebe5k8RyIpbRjqQGQMRxufBFAmtyyYfFhIH9lovyLuL2s/BrT1wkoeWy+QpF+iZxncEIqQ8xjZ+9q9GWXUWZht/jKE6mgajBG73EyJsrmRBe+ZVJ+razQREMWHuM1Wpa9moVwrITweWRwPvphUeFW5Ts2flEnrglRmgcTth8Br5wP/L5SLQpArd1+iSNgDpqtRX5h9efjCe1zBlvfoYlgLVanP/o0OejJHGfRAg4o4SYDLMnnILvXdCCXJc5Cx+2VuLrnxI383KMmmK57xGw3yLTYBeXH7fRU+w25O9kftRmdRevlpQdpeuZwoT9XiQhE8rtjvBjjCVqFuMK1jjgXTODrT2ld0xqlQ5l3nSY2eC5CweoHDuDAtyCefif7GXiWhNQYIuO9o2Gtx9vposNQsS62yfdYJOK149U08oYRKFOThCOugFtTjSw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(346002)(136003)(1800799009)(186009)(451199024)(5660300002)(26005)(8936002)(4326008)(8676002)(2616005)(2906002)(4744005)(31696002)(86362001)(82960400001)(38100700002)(36756003)(83380400001)(44832011)(66946007)(6506007)(6486002)(966005)(53546011)(66476007)(66556008)(54906003)(31686004)(6666004)(478600001)(6512007)(41300700001)(6916009)(316002)(130980200001)(223123001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmU2VjA5VmNleCtKdTdPSGRSZHJicjhqZW1QV0tSVkJxQTJ2SHZBMC9nMUFB?=
 =?utf-8?B?WWRwbXdsSTNKS1dBNVlKZFBNYXZHcXBINnVES0Vvd3ZFdjRlb2lVRkhZbWhO?=
 =?utf-8?B?VlE3MUE4QUxFSlB6ODRhL21hWElseVpqazJteGxyZVVaN3R2TlFMcGtqbmgr?=
 =?utf-8?B?RXJMOGt1Kyt3TERpTXMrYk5vSHZCbFhzOHlnWEhDQmU4ZTN3K1FZY0hSMXA4?=
 =?utf-8?B?L1VrazNWMmVaLzhmWCtyTkxULzV0bXd2T2xqSXZYSUJEdWRxOW5Ka3ZrelRl?=
 =?utf-8?B?TEhLSlh4TmhxUlJQdHhhSXVtdWF3d21qc1dmb05JRi94VkwyTlpoR0s3c3dH?=
 =?utf-8?B?L0Q5WGV1anRQVndlcmVYQU9Mb3p0NzNPajVuWmR6VE13MTBId0F0SE45NVdh?=
 =?utf-8?B?cHpldUoxZGNid2paODFoTEg0c05HZ1dyd0NOQXRobHdmRE1uK1NPV0x0SVBw?=
 =?utf-8?B?RGp0Q2ZLVW9IMTUvNEhrMjhEclpBTWloaVRGSEdQNUVWNk1ZeDFwVGtXZWRj?=
 =?utf-8?B?ZHNMZmRmSjM5MTdQWHpmZjhQeVQ1RkNZQXNSeWgwSDd3UWp2S3FLYUt3eFd1?=
 =?utf-8?B?dkNiOFlzcU9nL05jenFzN1NyZzdSSUYrMCtIUUhCMUg1ZzVuVHc0aGV0K1NF?=
 =?utf-8?B?K3hUcUJKdWdZM0RHblZHRlZta0VEK2RCandBNDRWMStJSkxGVTR1aEVRbm5N?=
 =?utf-8?B?UDl2YkFmQXJZUW8wbkpVSlNMMjF1Ukw2dk1TTW9Pc0FidjRqR2JGZVEvWVBG?=
 =?utf-8?B?VnFhNVN0dERlNmh4NnpFYUJGZzJvdS9WUDBTd2xSWGpLRWQ3TitBa3dCN1Yz?=
 =?utf-8?B?MFRUTXBQcHVEbVd6THJ5WVcreFZXODhpaSsxU0Y4L05lYklTRjFKczF2V1g1?=
 =?utf-8?B?bzdTQnJ3VUJnbHEzZVZ0NTd6K0VUYmlJL0NUZy9VUFBKSWpybUhIVkpRL1Yw?=
 =?utf-8?B?M3Yra00reThrZ25odnNNeUhweGw1R1lnQUNMRDJDOU1xc1RYenNkSWpaN0o4?=
 =?utf-8?B?WmZlRUNnK3l5cVdNUWdpRVd6QkhPczNzVzJDaUI4cmYrbVdlY2svWTZQcThx?=
 =?utf-8?B?YS9vRkZkbFBGQ2tFUHFWZ3YvMnYwY1lFU2djOVY3MmpxL3hORE5oMGxweURs?=
 =?utf-8?B?NFNHZnlGSlp1bUxpcERPS2NOMzRrTWlaSFBUZHQ1ZWk0MEdxalBwbHB1UGhT?=
 =?utf-8?B?QWVCbW5KVzZlZ2pTc3dPSUhvbmNYRkZpZDJYMnNrMFMxb2NrQmcyeGY4Z2lQ?=
 =?utf-8?B?ZXdWYTAwV0pTVDlPS3hkSmoyUlB5bktDS0pvU2JDVEVkKzlBRWhnYmhYakwr?=
 =?utf-8?B?UWx3YnBpT1pSMVUvMzdlVlduSTJOOHFRSjIrbEZDWDdLTTRzY01PM0hDVnNI?=
 =?utf-8?B?MmkrZGVqZlB1SlIrSWNXMUtIMmZ2MG9vbWh6NzBacWJySnZ5T1QybS9nUVVp?=
 =?utf-8?B?azZrWDFTNnY2K04xMlZnVWd6MkRxRXRibkZFNmNES1ljZDNPUHoreVdOcFBF?=
 =?utf-8?B?UndCWmZWQmR2aWJGbGhKTGRIaXQ2QlJIZE1xTW1HazBWa0NseGdlV082aDNx?=
 =?utf-8?B?QWxYaVEvUDFGaWhuUHM1NDRjYU9Oc1B6UGVGU3dtZ3BhWXVRdWppTzBBSXNu?=
 =?utf-8?B?Z3M3SHlnTldPR3l4Q1QrN202OUtwdW5rTzRETXNNa2RBYU1aKzBRYkptNjc5?=
 =?utf-8?B?ZXA3eElOcXpjQXVGTUd3UVpqQlhGMy9MYk14akV1UFNMRC9teDlqeG9FL2dp?=
 =?utf-8?B?cVZqNHp6bDVzM0NnMVBvTHhqdDhUUFFrc1h2ZVlINnNRUzhlaEFQanp6b1V5?=
 =?utf-8?B?Y29MSGE5NGs5eFQyNjFKOVVrdjYyQThiQithQ3dGOCtGUVQ5ZmtobU5jRVFH?=
 =?utf-8?B?ZktKK3hTSnNjVjV5TkFHcDl1cjlidjl4NjFqOTd5aG5zbVdya05tYy9aN2FR?=
 =?utf-8?B?bTdZQjRiemE0MkRkR24zQmtySnJGTXRsWHNXKzBFVTlyNVlzU2xpUXRielIz?=
 =?utf-8?B?R1UxSGRBMElvbktPYVEwZENzNU1GQWdRdlBzdml3MlBlT2hBWElNTVYrVENw?=
 =?utf-8?B?a0FYc3pSQXUvbUNHSUIybWkxc2JpQTk4KzQxQ09CN2tEeTRtSFJqRkFYMVYr?=
 =?utf-8?B?aW1UdEdLTlorUlE0SWxlT2lFakNTNThVYmswSGJXQlN3MlF5cWs4VTF3NWdq?=
 =?utf-8?B?M0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f168ee09-7ea8-4d8f-f3a7-08dbb83d2948
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 11:48:23.0231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDEa02Gj83qyEOVv71h5LoGkbfMsvI9Fa1yPjp9p20EsgS2zVWJF41UE0w7SwLSkxvaS4LcEoJeppISVvQgIgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5675
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=Ofbc8JfW;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f400:fe0e::626 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com

On 18.09.23 13:40, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 14.09.23 00:12, Alec Ari wrote:
>>> The following links no longer work:
>>>
>>> https://xenomai.org/downloads/
>>>
>>> https://xenomai.org/downloads/xenomai/stable/
>>>
>>> https://xenomai.org/mailman/listinfo
>>>
>>> https://xenomai.org/mailman/listinfo/xenomai
>>>
>>> Just letting you know.
>>
>> Yes, we rearranged things recently, see also [1].
>>
>> The mailing list moved to kernel.org a while ago, you now find it under
>> [2]. Older downloads are now at [3].
>>
>> Philippe, setting aliases, specifically for historic download URLs, is
>> not possible with the new hosting, right?
> 
> I'll ask. The landing page now has an 'Archive' button pointing at the
> new location of the legacy Xenomai tarballs and I-pipe patches.
> 

Thanks! Problem can be pre-existing fetcher scripts (yocto & Co.) that
may now be broken when they pointed to an old URL.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

