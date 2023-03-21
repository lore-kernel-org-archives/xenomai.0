Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2055.outbound.protection.outlook.com [40.107.104.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D783733F0
	for <xenomai@lists.linux.dev>; Tue, 21 Mar 2023 18:38:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsLSWg8tK4YfVXCvxu2vF8NxVdeb4YjhqQKJx1Hc/Yi/NJh/ORp2kwqfFzZUqE4l40Rc/0UNFH+Ml7W5WKNBR56aSUaekmu64dv35kNrlhS6xphTKkmFMeYiitgx6xEX3uqzs7EmLq4IKW5Abk/CpflG2ltArA7yNf2Hkz630mhAfjIqJuVXrghVGvITeGk5GrIgA/YJ03LOlezUrYrEx/v52S6U4V56zIyxNiCWsTsx4MsVWCL8pCv/ER5P1SMBTenuEJpzzPfSAbWjz2AViU0CynhVpiuTIuClk3CJ3SLUOu1UbfHV1PiPq9GBDHrnpjPiEqzuIN6wKCAZ16wiwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvKiyTkG2s8udrmI4LZRDMvzmdZ/EbV/OjB/FjMx3Uc=;
 b=VGRJxlFeO33YzJmrbqLuGJqbwShddD0Cm54mi2TwbZbeRTZIFfVozkGP5fGdiTds8QQkiJLSgved/yN6ZPnJOD1XzWjX3uClnTFjt94g4njDwHcxk3AXVuFuT9gUebi53Cirx7DTCdEWkuX0XVKt78voaLR18/1QZkbOUrpRRroCHNFdDIBvZf/WVLHt9xG1Apysq9fCkJO1KiC+VrjGjSSWTQ9lV/IChcCuI9KkrdOXi+goMZYo+8ySBCCQZmDFnkkZJrI6lS+V+jgg+gdRCGAzAF29RK70WfGkeswIOyfVTL4gPa/Dq7yQ5YDwVm/Q1bNG2YJgXePmr4F5Cc++2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvKiyTkG2s8udrmI4LZRDMvzmdZ/EbV/OjB/FjMx3Uc=;
 b=RCFVQRICWjl23AI070eqeCLYRcxvZAs7H+yO6Cn7B0cu3hjBDXGqI1R6QUHqf5oRXMzKV2nWWDp6OzlNZu0v/fzo5wXgK5L0xuuKjlnk33yDLmCiUekP8vlGYTcbk84AOOE9qnY2gMXWAUJnPL2XxDFATDDQzlHN/RTolW7jXEOC7RPLl+nn47egW08dFVeq7F227eFIi/cFKeUzrkOebclI8yeg1DgmSZziQvt0Ru2RSUX9HmgZj5uIsO9bxVBhFuogm0QyW7KHxSE09ECBzN6QtljMsisyvtdUUIoSlgSoak/rojwS2AagpoJO3IXLAdK62Oj6yoyD4JFTLVzaSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.10; Tue, 21 Mar
 2023 18:38:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6178.026; Tue, 21 Mar 2023
 18:38:51 +0000
Message-ID: <16ada5ce-2bca-4169-05ba-517fe1a57d78@siemens.com>
Date: Tue, 21 Mar 2023 19:38:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Segfault on exit after commit ec804ffbd "lib/copperplate: Release
 main threadobj on exit"
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: "Mauro S." <mau.salvi@yahoo.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <233902a7-0911-06e8-a54b-dd7a1d568264.ref@yahoo.com>
 <233902a7-0911-06e8-a54b-dd7a1d568264@yahoo.com>
 <645dbe21-4dc6-1449-bf73-ea83165fa4d6@yahoo.com>
 <75e4fb40-027a-7e00-d565-ed765b1739a7@siemens.com>
In-Reply-To: <75e4fb40-027a-7e00-d565-ed765b1739a7@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4019:EE_
X-MS-Office365-Filtering-Correlation-Id: 57cda381-3a8e-4c09-64b1-08db2a3b8421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	esHTDJGxgLhO8D1U6V3HZnzoOmwgz8jHx3clI3s9tTj3Qs40oVLyR6CV8ZvyzisjLR26O6SmekqVVgPuwF8vzMPePrI0kN2J6zFaeTbhdGkcRySPKVYz88EH4umi84WBh70SKUtF83eo8Yj28Lzmqy+PS6hDs6vYhY79WX28aJ9tUDFIUxRTXnaqoKmtM6Y0+5PLFlmh2oYr4iyIOxyRCCxOzmv7ZbRp51QHfsIApEVgMVRM6i7z1russXBd/+iNqEmjEU9ObuCT1UWgjtaJq64LKNlYo4uSIyQRnQiJsVhgyO9fd8H/m0KoU+hoHRYzsqukzXimeNOGed+2vzjF9jf63HDT+5KiYwOPxEO9JuXFgVIr8mIGbSWuYeKd4hhjIfB092ukjkxV5MPkAPBSGqmdnmNpgRr1xnt0h4zUJH8HJz0o2UcUMVVvVFWNzc6iDh3PkUeK+Z+vovyJvWUFLxuHUvLZbpfRdzvIBYLlbbnoAAvUF/uHHPoPlzbyujel4i7Tfleho4ZwLzeKZ7cgmiSVMcoxk8EngdpVxX/+8Gh0ps7ZZxoIaln5rXUeSx/irLsX0S4v/csYclCxte583/VM7JW5xYSYLyHx5ybKddlg4zoREM3oWjZSfcnu8VJEUBTYfnNHv0cVd8ao7voE0jiZdlEzqPoBWZ8ywMAps8Fzr6sm4y0c0TjLgy9zd3I3stiAzAV+bwrYXh9GNIYfRtsi8epYL7soaPDvpUSMnJA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199018)(2616005)(110136005)(6506007)(53546011)(26005)(6512007)(31686004)(6486002)(6666004)(316002)(66476007)(66556008)(8676002)(83380400001)(186003)(478600001)(66946007)(44832011)(8936002)(5660300002)(82960400001)(2906002)(41300700001)(66899018)(38100700002)(86362001)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STJvOWUxUmM4L0JYWEkvQmJGRGxiK3JrM0JkVnpESmlQR3dxSisvWUkvUEhz?=
 =?utf-8?B?YTRaQnh2ZXhOZHJobEthUk5iaW92V0NRbWo3L0dSbVR2bTBocGVraTRlUVk4?=
 =?utf-8?B?d3FWWFphaDUydm13VDRaRTMrb2gwU1FCZUptM2RMMngvK3ZFSjNaM1VITXVw?=
 =?utf-8?B?b2toTVZnWkc4Zk03MytnSElxdDVqQ2RtMEVSTkFHRU1QMmpxWWs3djR2MElN?=
 =?utf-8?B?UTZYakovaXJranZQSTkyeXhzSTZSaS9vVDFEOENkMElnTnFXSjM1TzZmeGJh?=
 =?utf-8?B?ZVlpbVA4Tk4vRXJNS1V1S3N0WDVWeVRXa0g3bFhBVHJYalR0UXkyWGE0UGFq?=
 =?utf-8?B?dThZeForTCsxdzNOWkhzRlV0bVY2WUdpT3ovTGhnS202RFlzV0U0ZEdpbXc1?=
 =?utf-8?B?anJlczE5WFZtSFBYbk1ScXNGcW04RnoxakdjbkdEdHp4enlCbHk1WFpNMVcr?=
 =?utf-8?B?ajBKNEdtVGxEQnM1aUJMbWxGa1RvQ3BmZlh4WjJZWkN5RVhVTUVEQjgyZkp1?=
 =?utf-8?B?N1FwT2tZSy8xNFlUekVGWEdvNTJSRWh6Q2tDcG5icEFSa2FNek5MbWZua2xT?=
 =?utf-8?B?RXBQMVRRTXArSHI1VFJQZUkzV3ZxdlJQckExdnRvWURmY1ZLanIxcHRzSHhH?=
 =?utf-8?B?R1hOUlBFY1ZRM3RQblN5VTVvd3VPTmVjb3p6OGtjck5ydS8vL1dPOCtJV3JF?=
 =?utf-8?B?aHhXNXhOMlIycWh6ZW1nZzlGQjM0NzQrSXBjM1lEeUtxM096eUQ5aVpoWm9i?=
 =?utf-8?B?eStRWU9pWTFwMlM4YlVBa3VvdGU0bE56ZzNWcTlaZ204MmtTd21jVW8yZVV0?=
 =?utf-8?B?QkNIQWwvbG4yUnV0aDh2bmRnV0FGNWQ0dWlKLzJNTGljL0JPakFkcmR2Mmg3?=
 =?utf-8?B?cDJGZ3pUYy90U1Z5WHRKZ3VWcklxRHRvNmpvR1h5Y2EvSEpaaTRtdXRqT2pE?=
 =?utf-8?B?ZWkyWVdsK0Y5MnJSTURMajRCQkJ1OHZyWHdoNzJJbXlVMkRPSHhwc2JiMitR?=
 =?utf-8?B?aThsSmFTdW9RQjcvbjVQQzNUdjAwamhEQktYQ2hVNU1RR0dDdGc5djRJQzg5?=
 =?utf-8?B?N2swcTkwTWI3VldyY3FCMlQvZld2YnJ5VlN5Ym9GNUtJUzRUc3UxU3hhQktH?=
 =?utf-8?B?aUJXb3lVWTB1YmVuQkJsZW9sY24rTkQwaGttR05oSVBVbHhtY0dESGEwd1RY?=
 =?utf-8?B?bmN0eXJ3MEw3azRzZnlJb1VPckkxN2treTgxcklyTm9nbmd5UVVjRWxpNE1G?=
 =?utf-8?B?VGVIVms1OEJpY2RSd0xLS0Q2OGJJaHZTYXNtR0c4ZldKRUJ6cngyNDBNNWkr?=
 =?utf-8?B?UXFmaHNpaUp2K0NxWVMzaGNWWVZnaG1WMUZ3SW1FYlM2YjA5eTE4bmFlaGhC?=
 =?utf-8?B?TkxrVUVzWk5MWXp3SzZwYTc2bkw0eTQxbEZvb2JtNDFqWmxSR3k4L2N2WWM1?=
 =?utf-8?B?eG9oeEdZQnpreTFPMUpXZ0JVc0I2MlR0VlQybjRRdXJuT1pZa3libUNVZE9u?=
 =?utf-8?B?aHlVczZodXA1V1U4M0hNQ1d3Mk9hVVBKMlduSmR3dmV6OW1oakpaUStObHFG?=
 =?utf-8?B?aThNUWVBcFpPS0J3K0hDeExMMWFJZjNZZEE5K0dlL0dORWJtNm90WHcwc2o3?=
 =?utf-8?B?a0d6eWpyWFloeUk4Y1h4akx5ZlRYbFViak83cWJMYkVzUENMaW1WZS9sQ3A4?=
 =?utf-8?B?d1F5WnRvenVxaVorTVhvTmRGZzRpMTZXeUZPTVBpMXo1YTA0b2FlR1BMaDVT?=
 =?utf-8?B?M0F4R1VwN1VpM0VhOE5SN0ZrdmJwZmtrZUNTenRMeFBHeXlkWE9tOGlrMnMw?=
 =?utf-8?B?bElxL1RMbjNYVkgzcU5Mc3NPZnJRWk5ia0Q2dVdDbTBnNkQ2Z3lpVlVaK25Q?=
 =?utf-8?B?VEhXbUVyTzRuTGx4TTQ0cGtUcVljOWRtNkttOXFZZzUyVTh4d3Y4cUNobXBJ?=
 =?utf-8?B?aFQ2cXRxek5jZ2svc0dJZTRSdTZLZDl1dFJaSE5UenZNbnc0WGhwOWZmcVRm?=
 =?utf-8?B?ZEdCUjlkUzU3Zk1hNTVRN3hlYnpkcFhMelp4YWV4UDN1MUpNNkZmeml4cEY1?=
 =?utf-8?B?dVJOaTByMlhpYzloTmpqVVBjd24yZTYyeThZNVVCaXhHRzBiTHJuYUNqcjd6?=
 =?utf-8?B?a3l3RUlMb2pzU212Mnd3OXFLTzY5QllkNHp0ZmFyb3JDS0QyQWxSZkpGUXFv?=
 =?utf-8?B?blE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57cda381-3a8e-4c09-64b1-08db2a3b8421
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 18:38:51.2837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VglKOCwgTZ9AQjFYyBlj6x5cdZwQHGf+TwgjKhI6rCzk+Nz4fL1yGqcFfwXI3fRRF8XsiMpVadzywiPJYbyjTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4019

On 28.02.23 13:51, Jan Kiszka wrote:
> On 28.02.23 13:10, Mauro S. wrote:
>> Il 21/02/23 15:13, Mauro S. ha scritto:
>>> Hi all,
>>>
>>> I'm using Xenomai 3.2.2 at commit ec804ffbd, kernel 5.4.228, cobalt
>>> mode, on a Atom x5-E8000 x86-64.
>>>
>>> Since I trarted to use the commit in message, I have a subtle segfault
>>> when I close my application.
>>>
>>> I managed to reduce the case in the simple code attached to the message.
>>> If you run the script, almost always the
>>> xeno-test-session-segfault-mainproc generates a segfault at exit.
>>>
>>> Analyzing the core, the involved code is always the same:
>>>
>>> #0  0x00007ff729498400 in __hash_key () from /usr/lib/libcobalt.so.2
>>> #1  0x00007ff729498897 in hash_remove () from /usr/lib/libcobalt.so.2
>>> #2  0x00007ff7294b49ac in syncluster_delobj () from
>>> /usr/lib/libcopperplate.so.0
>>> #3  0x00007ff7294ce06d in ?? () from /usr/lib/libalchemy.so.0
>>> #4  0x00007ff7294b6774 in semobj_destroy () from
>>> /usr/lib/libcopperplate.so.0
>>> #5  0x00007ff7294ce216 in rt_sem_delete () from /usr/lib/libalchemy.so.0
>>> #6  0x0000559ca0298651 in SubDummyFn (arg=<optimized out>) at
>>> main_proc.c:55
>>> #7  0x00007ff7294cca0a in ?? () from /usr/lib/libalchemy.so.0
>>> #8  0x00007ff7294b5ce9 in ?? () from /usr/lib/libcopperplate.so.0
>>> #9  0x00007ff729494f7e in ?? () from /usr/lib/libcobalt.so.2
>>> #10 0x00007ff729461ea4 in start_thread (arg=<optimized out>) at
>>> pthread_create.c:477
>>> #11 0x00007ff72937859f in clone () at
>>> ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
>>>
>>> Reverting the commit in object the segfault disappears.
>>>
>>> Applying the commit to 3.1 branch results in the same problem.
>>>
>>> Seems to be a corruption of the session memory shared between
>>> processes caused by the atexit() callback introduced by the commit.
>>>
>>> Some notes:
>>> - seems that it depends on when the xeno-test-session-segfault-secproc
>>> exits: if exit happens during the SubDummy tasks start, the segfault
>>> is generated, otherwise no
>>> - seems to be related with the number of calls of the
>>> xeno-test-session-segfault-secproc: with only one call (change i == 2
>>> with i == 1 at main_proc.c:139 and remove one call in the script), the
>>> problem does not happen
>>>
>>> Thanks in advance, regards.
>>>
>>
>> Hi all,
>>
>> just a kind ping.
>>
>> Is there anything I can do to try to solve this problem / do you have
>> some indications?
>>
>> Thanks in advance, regards
>>
> 
> Sorry, the original email didn't make it to my inbox, but I see it now
> in the archives. Will try to have a look but would also welcome if
> someone else can debug deeper.
> 

Finally found time to debug. This seems to resolve the issue:

diff --git a/lib/copperplate/threadobj.c b/lib/copperplate/threadobj.c
index 6808bcf164..db18f4ffa3 100644
--- a/lib/copperplate/threadobj.c
+++ b/lib/copperplate/threadobj.c
@@ -1773,7 +1773,10 @@ int threadobj_set_schedprio(struct threadobj *thobj, int priority)
 #ifdef CONFIG_XENO_PSHARED
 static void main_exit(void)
 {
-	threadobj_free(threadobj_current());
+	struct threadobj *thobj = threadobj_current();
+
+	sysgroup_remove(thread, &thobj->memspec);
+	threadobj_free(thobj);
 }
 #endif
 

Can you confirm this? I hope we are not missing more things. Needs a 
second check.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

