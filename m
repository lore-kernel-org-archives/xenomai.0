Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3A02F2A
	for <xenomai@lists.linux.dev>; Fri, 13 Jan 2023 14:48:15 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::227])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 2ABF1C74D7
	for <xenomai@lists.linux.dev>; Fri, 13 Jan 2023 13:59:19 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay.mail.gandi.net (Postfix) with ESMTPS id C485020009
	for <xenomai@lists.linux.dev>; Fri, 13 Jan 2023 13:59:10 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2077.outbound.protection.outlook.com [40.107.105.77])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 854C9941983
	for <xenomai@xenomai.org>; Fri, 13 Jan 2023 13:59:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWUoSy3FlYxh2ZPr/OcPGfH8iiyAJLqbEk35jeqdCwSDxNk/ANmHJoMnltTVHJAJEuxoDNdA6AfHtv2m+JVmHw/qqIecNI6LJTKl1mmHsiW5D1WjxQse0J1O5UROesJcRAWpNNFwIXO4R15rbqoAHO6qyM0OUAUos4WICnLHuVmZW3kOMWp+IDNoc7+7l1oujbN/SlJV0dM2LolOSmAZJHHbcWJhwMrhITHl4uMynOc0m98LOh75cNSSfLAwCWH6Lzt0zvDLl7h+v2k537foUy3gN040WoY+IgkeSxle5oKIJhiuOii/HZ2DQwpCKxpFO2O8M5fGFAnH3x5lUyOWOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kp81eMT+PstoVC59hxurirSOiJo82AWxoOa9vHeFN7k=;
 b=FSyPYdGx7G27z8t+6jWxOMnsYDGVbPTBVcSvcJvS4CM6686Bvit7+ZbsTmWtBBwf/fTU0bBfDZofiH6mduvvHIg3o5SdItgX7WZS9i4v7vxVSfEbhgAntuOEaw5u3jQ8WRrg2C8C+2LsUMaLAKkDfdHIpkor+ywpOizH44yAq06CehYcaZZK1tDXjMKRrwp+XV9b9rDB8mxN5U/F5Q505396JNkNKFH5AYA3NDUMvuNXPCYZrJvMfPx7NzCj+vQoHZq67nyM6Qo+//a/nQIXb5hxb4bfoz15JpPVFlvyserqdczEVxKN7IpEEa2aRKr8vrMnyMhT0BZKAqv6nhGFfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kp81eMT+PstoVC59hxurirSOiJo82AWxoOa9vHeFN7k=;
 b=Byd93bM/+l9zUHBsv9JVbLlPcdswg+Jcu777pjB0b1h/L8sGz33ek3uCCgimM8idoX7Q9GbXLkBPSCbeme5xkXJC5ZCCK/PjyfPQoaTsYPeI1O/xKqB0tzaFGHKpaiaji4AFpEZO5K7P7RTKf7yjz7ZGGG8vcE6vyKXZNmfRi3gyH5VXJjcrTSRZXDH3XiEn2jOSCBW5xS4VNQkhvSbKBuFwpuqFfCh1qhprk2a3iAXfr1dTHqeWOw9tVPnZlqq0E62hleCi+soyZe/NcDbS/gKHutXQhWnyfaDLrJ5pHAyGPGThuxVZ1mmQY0+AhIAn56AFLs+gs5TWmX9Zo4+sWg==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB5901.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:526::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Fri, 13 Jan
 2023 13:59:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%6]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 13:59:08 +0000
Message-ID: <69e67416-2988-813c-6078-c81cccce16f3@siemens.com>
Date: Fri, 13 Jan 2023 14:59:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: kernel stack corrupted in xnarch_switch_to
Content-Language: en-US
To: "Mauro S." <mau.salvi@yahoo.com>,
 "xenomai@xenomai.org" <xenomai@xenomai.org>
References: <2d50524e-78e9-c696-8dcf-171fb8d58910.ref@yahoo.com>
 <2d50524e-78e9-c696-8dcf-171fb8d58910@yahoo.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <2d50524e-78e9-c696-8dcf-171fb8d58910@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f2c68e9-ad15-45dc-50f7-08daf56e5727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1cuJ4y/Tp8W+V5K9r3OVvO+ftioShuxEcnOiGG2xaF4UfFSuNKLVeN5vy6xyo9niFxwSVh+HyFkUZcJ0GOm+3nh4u+/2qDAJPwEsBVUEFjsgr+lYF0yVxOi4NX8KhxxrIguOzZdvINQDXgDBHUkjHnBkDxckvzb46F5eccwiLbOHH+nHYcsq0YJWpachvGrIe99nymQIyPvJQmNAW2X1HeYWJWxhWktaey585oLV0/kz6ChzJXM0H63x2jZ9/1x/oJtfnJTVkgIEv3s7syAeRzvWXGlbyeVdIfPeAD02PpDj3PmB1RX96xNKiTDrZ2Llnv4yc46xNyp+qdvwhKvGJK50DFxGaca1nUELE2uzAqSfXWh/qJEk0eyoBpSFyMo7HBUlgdejBfYN+RDbFtT4rAFJSV2HsuFeBBK65eC+rAqqwRBGIwLeuDWpGV+MQDgv4QMXZUGyjm6+OK8PlL5N44DUxPioLXLbzJeo0IZQnOF0Qz2EGQMoM9nNiuOEWU1KVJS4KbweK1jRDR9avB7zRuGExL1xI+gLsT48ImVeSqSXR/WWIUhW4WKMa2SFhQy8BF0lAdduj6sH23WdtQycal9+Y+EbTAnLZQD7MtJHb9uhQ1ly99Z5WaB4W37ePYKGTWiZPM1LgR/RyjGAGZJ6P9nvi9ST5sZApYlK34c0EB4KgDsSqeZRh/OqYieDy6OTo9YBbZ+TBBoS9/2kLIHLfOeNKSApcske7fWyc0jJRJg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(83380400001)(66574015)(31696002)(82960400001)(38100700002)(86362001)(2906002)(44832011)(41300700001)(5660300002)(8936002)(6666004)(53546011)(478600001)(6506007)(2616005)(186003)(26005)(6512007)(6486002)(316002)(8676002)(66476007)(66556008)(66946007)(110136005)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dG9yV0hRT3pFTEl1TC80V1FuNk1pa2hndFJtejdMR3JoQVpKd1lVWnZzWUoz?=
 =?utf-8?B?NVJ3QWVVellPdXJSRy9maW11YnZpMnFMc0tXYW01SjdocWtFSGhLUy9rS3Bw?=
 =?utf-8?B?djJmRnJoc2EvQkJtbVVyaWk2ekttU1M4VndVVlN6bHlDRm1wbW9RVjY3aHVt?=
 =?utf-8?B?eEpEZnpTOFJKcXpic212T3U3b3JCekMzZ3cxa0kzMVhicTRoTWs2UG5qaUlp?=
 =?utf-8?B?dVZYR3dXZHdWemZmaUJGVGdtb0lXOEUwVEh2SkhxcUxvaVJqajJKOWsrbFgv?=
 =?utf-8?B?UkZTU2Z3R1A5VjYyOEtWamxSWUFBVEZnWkZORHk5WG04eWlKV2hvWFBEK3lR?=
 =?utf-8?B?Vm4ybUpVdjNYbWgrMkhEZEhNQlQwK0M1S09NVUpBVldmaFJPcTFYSWJVM2tX?=
 =?utf-8?B?WlRhckVQS0N4Y1pkaTEwY2thQmpReUlOU1I1K0hMKzlud1pKL1BhVWtQdDJz?=
 =?utf-8?B?VXh0QTdOdjRyUFFRK2pjTkNYZWZzR1lCa2tPbDdkaWVoaFpFT1d5cHhJVEhp?=
 =?utf-8?B?QTgxQ051cjQ5YUtaRW9hMUZaWG5ya2tuK3JyUDZWcS9xL2pBR0E0NUJCTVhm?=
 =?utf-8?B?NCtmbUkxdHZBcHM0MUFtYUZtQ2hXaDhLcGk0K0V2WW9PWVVqWVlhQ3hYeXRj?=
 =?utf-8?B?Z3Z0OGw2Y0srbTRUeFhDUDVObjRrN29YZUFPY2w1ckJCSEw2Y2hPdjc0d1pq?=
 =?utf-8?B?YUg0SnVja2cveW9peXpVUFJjRVgwbUY0bDREMG5CQnYzajR6dDlBWEMvZXEx?=
 =?utf-8?B?NmFRRy91by9yUlJzdVJDN1pRRWhMSzkxSjE2MVZlcmFBL0FBd2UxdktKN0Ji?=
 =?utf-8?B?M004ZWhrRWFXYXpjQzhqN2NMalEzQzNhbEkyeVlnN1prKysvKzhzcmF0ZVVZ?=
 =?utf-8?B?Ymh4cUhxUDRlUVU5S3BjczN4a1Myb3pyS05UYlEzc0drV2pGS1FFVmdIR09T?=
 =?utf-8?B?Uncwc0l4Y2Y3ZE41bnZNc0JkbTYyeTRndmwzc25UcGJUMFdudkN3MkZCYmFY?=
 =?utf-8?B?VmFpQWpXT1RkL0RoM1BNaTQ1bitNQUhlZ2M5dVFpSEhsSFgxZTI5bGV0UDJS?=
 =?utf-8?B?WSs0bVVDNGhKSGF6cHQ4bWsrbllQOHpMNHlDL3pFYzhUbGs0WUhrallzcHc5?=
 =?utf-8?B?WDltaGpKR282cU9seXpxK0tZSEFBUXVhMlE2NEh6QlY0U25UbFEvU1pSOGJp?=
 =?utf-8?B?elVRSTdQbHZLU21xMmxQL21kcFlvRE50Z3U4NmV5R1k1R1NGN0ZDVFd2bUV1?=
 =?utf-8?B?R0Q3c09Nb3RYMTI0U09CUGpQSzZPUHdaUWZYWDV3LzVzaHZxVytBS3ZKWDJj?=
 =?utf-8?B?T1U1K3N1ZUNBa1ZZRDlLZ25qaDVPRERrR2lON1JsU3VyczI4RFdMd2d1ZjZV?=
 =?utf-8?B?Q3NqeHd0M3ZWaXNxRTc0OFhad0lNNDZmQTZESktneGdaeU9YbFpEenRuK3Ro?=
 =?utf-8?B?dEZWUUJKbG5Kb2xCTm1sUm5XaUZuYWsxcFF6V0NoYTEvdUJYbVcrVDZ1Y0hU?=
 =?utf-8?B?U0FmdXNWbTZUVXE2ekJnYVZiRXM5SytWdFZSc2luanRrMXd5eEJkRC9La0V6?=
 =?utf-8?B?YjFxVDRnSWhOMXFyME1VdnovdjdQTjB6SmxteTJaQTlqSDlGNytyQ00zS24v?=
 =?utf-8?B?RWt4MlIvL3dQNXI4eTdTQnU0dEtWeWRCRWcyRDllL2QvYWdncmZ3cTg1Ympp?=
 =?utf-8?B?Uy8rSkhyVlJwV2NFTFFiL0NVL1VQSEdoalREelMrQlhTcGZUN3QrS1gwRGFQ?=
 =?utf-8?B?UFlWd3dJQUtwNEg2UVJycXcwN29BQU4yay9MbmJxVy9LempndEljSkk2QUxs?=
 =?utf-8?B?ZEZpU1pPRTRSb21sNUp4VFI0MDhmNWZxUU85WlZoR1dQVlFici9WSGZSUVNC?=
 =?utf-8?B?OHJ0WllleXhEWTN3c1BpL2p2VW1VZ050Yit5eEV2dlFick5yRGhjL1NLeEl4?=
 =?utf-8?B?enJxZFEweEk4WjVjd1Mxb2t4RktUNUJST0poc0pNTUVpZ2k3d3gyeTVkTk9N?=
 =?utf-8?B?Y2ZTT1dwd0dRc0lqVS9NMUs0SFBpMTFzNzJGcW1SaGo2UTJuNEJoaTlQem9H?=
 =?utf-8?B?UHBLa095alBpOUZwM1pzWGdBUTJFbXBuUExBMTI2eGdVYzlLOGJMTERxZk9I?=
 =?utf-8?B?V0hRNlRQT2E5WFVZa0ZLVjR5bFNiVkdYa0dSU2xzbnZLcE91eDdnRldlakdX?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2c68e9-ad15-45dc-50f7-08daf56e5727
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 13:59:08.4842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HqelOAMXQwICsXQnqpmTPAitpe34IiUeTA2BeORkV5/kG1lgrPCIsCTWjGs7FeAj0gwlQfR0ns1x5A0uD88LgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5901
Received-SPF: pass (spool1: domain of siemens.com designates 40.107.105.77 as permitted sender) client-ip=40.107.105.77; envelope-from=jan.kiszka@siemens.com; helo=EUR03-AM7-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b="Byd93bM/";
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 40.107.105.77 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com;
	dmarc=pass (policy=none) header.from=siemens.com

On 13.01.23 14:49, Mauro S. wrote:
> Hi all,
> 
> first of all, I had to change my subscription mail address due to
> problems with the previous provider.
> 
> I'm using Xenomai 3.1.2 on a x86-64 Atom processor, with Copperplate.
> Linux kernel is 5.4.181.
> 
> Sometimes (not very frequently, but it happens) this system freezes and
> a hardware reset is required. Nothing is registered in the system logs,
> and no debug serial is available. The only useful interface is the
> screen, that in facts reports a kernel panic, captured in the attached
> screenshot.
> 
> Any hints from somebody on where to start digging/what could be the cause?

First thing is to make sure that you have the very latest versions, at
least from the respective stable branches (stable/v3.1.x is at
e6d90930a9, and that can matter here; 5.4 is at
pipe-core-5.4.228-x86-12). Also note that we do not test 3.1.x against
anything newer than 4.19. It may work, but it is not in support scope.
If you can update your test to stable/3.2.x, that could give some hint
as well.

The final step you know already ;): Help us to reproduce your issue as
well, then it is much easier to debug.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

