Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70084.outbound.protection.outlook.com [40.107.7.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308AB1FA6
	for <xenomai@lists.linux.dev>; Mon, 11 Jul 2022 06:12:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l02rBKjEDdqTnvb2QxUopM+nSIkPGCNiOUyNybEQx3gsQc3dfq8sU2AW+nXKQhUT1REjNmHXrG6h1xmQnCxTGaEpZIgOSH+DVrlvSkzZ7J3x9UD5f7htqZ/CJ80v6cjG8BaeNP5iwR3lBkqGlCJpMQx+KWO3FQJxKJnevqrw4iRwu7eghwbOsP9GLHbykS6UlcKSQjhls95X8V6jFMacak0Qq0iqHZVJTk/c20OIcbYiN3ZODJk2j276Q+lV4xaTPM9t+/duMmzwxz/X48I7/olizoacFvm8i1nDPdDb5kdqt2awbZTO9y2Suig/z/uzLrVJqnvjyK7/jRL7rInJeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDwhjp5Tv3Ml23BUCf/U0h64QBf4WtDI/WSUTA+reZE=;
 b=OV//BNgUlzLvsT5LRGC0bUwUMxNhMiYzrBIlN+teOj9xtmySLFA43pn9jukAOo7MtNDLkHXvgFwUE+REQvEIr9x3UG1Q8uoH4ZTamDDYJmHkhmQmPSowbX093ku0AHd3qfn0Firf7I1TTQ4SPIMGq1ZxPRAIJ0TBBYwHOblQV//kU2LaZPphtIbUdqyMiZkNoVHDF7O5ebvKt6CV1IKqd8dybZ0Q/tiyA49MfvuFdczSQimivsJ4RsJImRSgpTOoy5YJizXwYIg5TwrNikGedoCFLTSBB3PMJ9C6Iujs+wAiYQ2wwYHlvEQFRdU0l048qh3hIMvNkBpsqTVMf2GgLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=xenomai.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDwhjp5Tv3Ml23BUCf/U0h64QBf4WtDI/WSUTA+reZE=;
 b=X06fQBMN/t0wSRBZLeCLC2pO+qJ9PifgtmL4u7JVXjGn+ZEbsjQEwZX+rQeDnBO4q7WNb/StTTe0Fuf1+e4v/Vj1nAuelikzxbRd2kqzyMIVId0V/ZVOmVtNPQsqt+x10uJGDBNR1W5v23pybmjjadhB18JgBvMd5WP6KYdIqBtVihKZZZnuD6WkSV+YokiUHGUnwhm6agKA+8QplmJXTGwPG9xSQaaCrGalN/zj5PKIPHTNHQ4NPzQXIf/BvIhTM8NcR5a5IAKtJAfNMPAXJZYysdfdaf6Ur3POvmCOQ84HH2ywluZmUtlHASL9MJtpHHzK22fZ4ezRAcahneesfQ==
Received: from DU2PR04CA0090.eurprd04.prod.outlook.com (2603:10a6:10:232::35)
 by VI1PR10MB3182.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:137::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Mon, 11 Jul
 2022 06:12:39 +0000
Received: from DB5EUR01FT088.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:232:cafe::79) by DU2PR04CA0090.outlook.office365.com
 (2603:10a6:10:232::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Mon, 11 Jul 2022 06:12:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 DB5EUR01FT088.mail.protection.outlook.com (10.152.5.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15 via Frontend Transport; Mon, 11 Jul 2022 06:12:39 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 11 Jul 2022 08:12:39 +0200
Received: from [139.22.134.113] (139.22.134.113) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 11 Jul 2022 08:12:38 +0200
Message-ID: <22868853-89a8-b03c-e90a-23e4faf0765d@siemens.com>
Date: Mon, 11 Jul 2022 08:12:38 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] prove of concept
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, Johannes Kirchmair
	<johannes.kirchmair@sigmatek.at>
CC: <xenomai@lists.linux.dev>
References: <20220707135952.5171-1-johannes.kirchmair@sigmatek.at>
 <875yk7mqdn.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <875yk7mqdn.fsf@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.134.113]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--27.337500-8.000000
X-TMASE-MatchedRID: grK+ChACArw5QaOxwNGfvo9bHfxDWoibjtapcCTXkeCx7mG1y/Bbs4Ia
	4bVhEGCnMtnJCTb1F/ig2iP/9C0IeYpsmNGAE/ypyZtfLSxQhyrcAUnQBuvU5L6EJGSqPePTYpX
	1XVIG1s5KDy5+nmfdPv3DXO1BtpLIqUz/GbLdMsBQgnaJzMnnaauh+nsiiEbDlXePXNM4FjMO9z
	+P2gwiBesXqsMsKb3ssREym4hTah5YcBc+7vfewAf+4OZFFSvWRXiIMJvvfA9aC03arbLUeIiAe
	Z2rVOJt5X8t/NkKVxk9oz+BtG+PV8/WF3RkwdIDZKoGiCqESWKwbAwEDxVgPiy1aQ0Cuqm2AQ8m
	tiWx//pSS74U9vhKf4VxhIirkzyBtPcjs/NXBdUoeLDu5XHT9yhW3rCVLjsctRoHk3L5VJw1byN
	CHOgAtSDGktqhDjiwI1EqUsnvZrAzU8lN24wq5gQK2jI7MmxUAVkhK9J7Br9KbJsr2oxf7PmoZ6
	x4ZgCUg8vHe9ji82Ktg0pkemZ4orafONFDFMOJTfV2XksdUkGuNpYhT6CV5CTc3NdTt+Z6CiTOK
	JLx+V7RILTJwv3HGR6GhShaHasg7NkxtkwbFMLNJarnrGYYR7r4uLbhgYsKrdLFFKR7dul9dEBz
	6zdEVxcEqqa7hWagwIA/EGEHAbJ2v864CtvhKBoPH3disD0LvQD1u18WepESq+XFWzaAymj1Cdg
	kJWDyghHheTmVLsX7H57HrDfNKY7XXI9QF+S8XHBqzCLfY3HNWR1oLHKsZIS/TV9k6ppA1wL0Wt
	LXyRqXPCOB3g3KSxlOsr4jr49qKjhHFjw20emRk6XtYogiau9c69BWUTGwVnRXm1iHN1bEQdG7H
	66TyOk/y0w7JiZo
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--27.337500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 2C524D4A84A7AC8673AA843D87DDAF8746329A6563D6F71D2F3B4A8AD64DE1822000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7de31f3-b2bc-4e46-f15a-08da63045bbf
X-MS-TrafficTypeDiagnostic: VI1PR10MB3182:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MhyPIFROPd0b5hnJDHwY9c8/54PnHw5uSZyrGswqXyy1ztkiep/ZGvJTNMFREdMnRjmltzfgMYr/haZDTtOjjOl5GfM7czaVdJPxl4E0lg+wv8EALS458mRhZ2snoykYNIjK4ItGBfu2noyjqMzeJ3+9JcadAaHuJSCjp+xGgUmZVsqpVNWZcw61S/O4s3iIkU1PHlXA1+nHPAbvk1bjdHFGEMLeJOR6V4QgUnnFWnXUNgZD66sDpdem8fJ4j9kdu4cAFj9evJw9feVKpvKS1tTSO7mN1Wv5TFifUNbaOu8As1Qy+NMZaacYrLw6BlgIJhHc/AlBsdXASKmYmXDQCJpuiFsY3EJlMUf99JEuT9Z6Oq0Z9ZGUk8J/MiXccJpnb798w+yrUfhe7I1NSPqUqNypgfq0rsNkknz8xiCXHBq5ZVgGjaxnMaHwFQg5YuWtlv55n4WdeNUHmR2lHvvKXnxAdyhNFzwC5FbeLXMegi7gCVuFg6XRlyCXsx1pRvrg4eJP5M33tBMlPfGKpEU1TvJGP34kryzfV+4tsHwYru0yISbhMDtktKRFQvWn7N5i6VqAnSFNFEgvGIqf/XF5IzNTgMclxy3hCID2eF80f2wkc4cBQwpK9lDOENDbxLICYkpIrVCs7o8Yq7MJ9cjQws/XhwuxKP5AxkTjW2rTvWqjXW0Tq6lD1OK/69TrRVuKO2aY6DdSmSgdVZ0KsWASEOWsL8eHySzzG/C2LkzyFFHXn8r6ZBB+DeeGnjtrqDtHyvrzrI8uNN4IAdFTpzctCIsMxgzgmxVUhxactYrd8mIIibtjZNtoYf+FDY0JmR0px/9RvCiavF43LepB4s9YOXMSmMNltWU84NeTl3HOWiYMo88nAVVi7mgjW2/lATy11rsXSrtbHvThbnsIauOqIhLO3Vu6sYyYtT+g2wzNZ6o=
X-Forefront-Antispam-Report:
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(376002)(46966006)(36840700001)(40470700004)(47076005)(2616005)(956004)(36756003)(110136005)(336012)(478600001)(53546011)(81166007)(82740400003)(16526019)(186003)(316002)(26005)(2906002)(16576012)(6706004)(31686004)(40480700001)(41300700001)(86362001)(36860700001)(82310400005)(44832011)(70206006)(83380400001)(8676002)(82960400001)(70586007)(356005)(40460700003)(8936002)(31696002)(5660300002)(4326008)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 06:12:39.5890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7de31f3-b2bc-4e46-f15a-08da63045bbf
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT088.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3182

On 08.07.22 19:42, Philippe Gerum wrote:
> 
> Johannes Kirchmair <johannes.kirchmair@sigmatek.at> writes:
> 
>> This is a prove of concept implementation of exception handling in Xenomai real
>> time.
>>
>> It implements an interface similar to the posix signals but with a much smaller
>> feature set.
>>
>> For now, this feature can be used for handling floating point exception (fpe)
>> and illegal opcode exception in user space without losing real time.
>>
>> The fpe exception handling can be used for fixing division by zero errors in
>> user space code without dropping out of the real time domain.
>>
>> The illegal opcode exceptions can be used for implementing breakpoints. This
>> can be done by replacing the breakpoints original instruction by an illegal
>> opcode. At the time a task tries to execute the instruction an illegal opcode
>> exception will be triggered. The thread can be  suspended in the signal handler
>> in user space. There are two main advantages of having it done in real time.
>>
>> The first is if a task does some time critical IO or has to meet some watchdog
>> constrains, the signal handler can be used to bring the IO into a sane state
>> before the task is stopped. Same for the watchdog, it can be stopped before it
>> sends the whole process into an error state.
>>
>> The second advantage is for processes that have several real time tasks. For
>> example consider a process with rt tasks task1 and task2, where task1 is of a
>> higher priority than task2. If task1 triggers an exception and is relaxed to
>> the Linux domain, task2 of a lesser priority would take over and could block
>> the handling of the maybe more imported work/exception handling in task1.
>>
>> Disclaimer:
>> This implementation is far from being ready to merge. It is mainly intended to
>> be a starting point for discussions about rather we (the community) want some
>> kind of exception handling interface in Xenomai and what a maintainable
>> interface for this could look like.
>>
> 
> Thanks for taking a close look to this. Since the proposal is about
> handling CPU traps in user-space, I have a couple of observations
> regarding the kernel side of things, and some questions regarding the
> intended use cases application-wise.
> 
> With respect to x86, the traps roughly fall into these categories:
>    
> - #NM, #XF, #XM, #MF, #DB, #PF, #AC and #BP may need some kernel fixup
>   to be applied when taken from non-privileged mode, we cannot just
>   return from the oob handler and be done with it in every possible
>   case.
> 
> - #DF, #MC, #SS and #TS do not involve user-space activity, so let's
>   ignore these, along with any trap involved in virtualization
>   management, there is no point in routing them to a user-space handler
>   anyway.
> 
> - #GP, #DE, #OF, #BR and #UD either do not need further kernel fixup, or
>   at least such fixup can be done transparently on the oob stage with no
>   impact on the worst-case latency. Routing them to a rt signal handler
>   in user-space could be done.
> 
> The first set looks problematic though:
>   
> * duplicating the original fixup code in the real-time core
>   (e.g. Cobalt, EVL) would be a bad idea (obsolescence, portability
>   issues, prone to hidden regressions). We have been there with the
>   I-pipe and FPU management offloaded to Cobalt already. This is the
>   reason why Dovetail provides built-in scheduling and FPU management in
>   oob mode, offloading such tasks to the real-time core can only end up
>   in some interstellar mess.
> 
> * however, reusing the existing kernel fixup code may require to
>   re-enter the regular inband execution context. In most cases, the
>   portion of that code which handles user-originated traps cannot
>   support out-of-band traversal (e.g. takes regular spinlocks we
>   certainly do not want to convert to hard locks). Dovetail already
>   tries hard not to notify the core about any fault which can be fixed
>   up without switching in-band first, IOW: we leave oob mode only when
>   we really have to, not systematically upon trap.
> 
> Because of this, generalizing the ability for the core to bypass the
> kernel fixups for any kind of trap does not look right.
> 
> This does not impede us from looking for a way to catch the events from
> the 3rd set which could be handled safely from user-space in oob mode
> though. You mentioned so far the following use cases:
> 
> - unchecked maths: #DE handling
> 
> - I/O stall detection: watchdog disabling, hw cleanup then
>   self-suspension on #UD (used as a way to force a breakpoint)
> 
> What a handler would do looks obvious with respect to receiving a
> forced #UD, the user code may even be allowed to resume normally
> from the suspension point at some point later.
> 
> However, it is unclear to me what a handler might do upon other traps,
> such as #DE, #GP, #OF and so on: the faulty thread could not be allowed
> to resume execution from the code location which caused the exception,
> as I don't see how the original issue could be fixed reliably from the
> rt signal handler.
> 
> I see two options for this handler:
> 
> - it does a siglongjmp() to some recovery point in the call stack:
>   fairly ugly and basically unreliable for any state machine above
>   trivial.
> 
> - it notifies some health monitoring agent to take over, in order to run
>   some recovery steps, then self-suspends the current thread. We would
>   not need POSIX signal semantics to implement this.
> 
> In other words, is a generic async signal API the best - and required -
> way to address the issue(s) at hand?
> 

We have two kinds of reaction scenarios on our side:

 - fix up a by kind of siglongjmp (restart thread with a good state)
 - inform higher prio threads immediate about the problem of this
   thread, rather then doing that only after lower prio threads were run
   (analogous to pre/post debug handlers)

Regarding an asynchronous signal API in general: We are also considering
if timer signal handlers could allow to resolve certain scheduling /
schedule overflow scenarios. That would make another reason to consider
introducing RT signal frames. But that's not settled yet and has lower
prio than the exception topic.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
