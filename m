Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820363208
	for <xenomai@lists.linux.dev>; Wed, 14 Dec 2022 19:39:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzE0XbZ1CzU98BVKjOfwhNuxoj5iUA1JsrDpezVx1cpIKpRjs5LN66KeAdQM13bZ0ibrMoGZYg1xXu8fzLaUhPj/if0VhW2eLfEHsY8A2EqYGs/Ov8UON6CDR6NFoNy8ehFwiv/QfiOTgpAQqg7bP1q/7PATiMLMy2GSE6pZhMEP1e9X3dItoFUi2Ofl3698qCAmePafkq4T6zSw2B+K7gT3MQ893riZxiiR3XvLN765aDeG+KU8mnsUMWOjVZPa/PyJWG+6pB8TfAEdoup1wRL9V/YNXAgVBjIXlNIbMX35RUaDA+rrThns3uG0SUv4BjqOpKZqvVdv8L9yCdIuaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Md/pJlveq0XqCptY6LY3KWAbPFkk9n+qvlzdvU6taY=;
 b=DuefOydhHKpimSr+c50hn/pSJIBewSeSEssaqOzuKm9yvQQ2izwvve04ZSNUbpjGNiYwodkAw60gfxWYlbFnPBTvdqmWtFIE3SyhTBJ4zfC9voy6/XMHHzlS2ac6Esr53+6L2LAAoGnMcmEAfXrddEaK5/Fwaeo8MaTQyWEVLUS31acihxcwYQaFha41BYavVbzFTb2jATxPWIS3j0AGGHj82zfZZxBJwJVUaQgOm+8PHn7TnGOhJzI4FB07xZ7KqXWJbkv9XCSkdUmEK0T2LZmHZGCxtITtXaWrIPywCelUuphgwXBZ/MNjysL50y8oUEnQaOecSwEhnrGCDKSs7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Md/pJlveq0XqCptY6LY3KWAbPFkk9n+qvlzdvU6taY=;
 b=WKTVOWVKtAFwtB2D2bxV7tgBLeldJF2dtN9GXEYHsfev8m5HVXXffxXl0r5d2dkbOx6ppEyyg2idkxm/Evan2TqFTVh82d+aDHrqjgNPzX4HoYi+kCuzOCBNB5rb/r57/Yz4KEjMO0n+l6EFadY19oj2+a6Z8y4sXGESfDWKSxZyacI6Nx4wQD1escgYT3hP23QyFhfevCKyJKDKEQWQgVkZHTyRCwDR4w4OaaaT2vx2Trks+yehAlS/JDXkzvB+TXrHONtLXh96Lx4g4VgB8OoTuNovmRtki1Q1tW2jVQNuPv5Yy1xOAkbGtSGOk35yToQQ36Ips64oOR7zus1M9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PRAPR10MB5249.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:29a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 19:39:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%8]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 19:39:08 +0000
Message-ID: <ed42864a-f219-0e57-9638-bd0a6c4c2aec@siemens.com>
Date: Wed, 14 Dec 2022 20:39:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: Patching Dovetail with xenomai-3
Content-Language: en-US
To: "Auel, Kendall" <Kendall.Auel@3DSystems.Com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <MW3PR12MB4460A675E6117835996906F0C2E09@MW3PR12MB4460.namprd12.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <MW3PR12MB4460A675E6117835996906F0C2E09@MW3PR12MB4460.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PRAPR10MB5249:EE_
X-MS-Office365-Filtering-Correlation-Id: a369f116-faea-4baf-7518-08dade0adde6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ApymXCmMr6CUQHxBn5cJbdfS7BQtHIVoz+rgTVHXyvzw9AS2EUkKmQ8mZkkI/OBJVLqrJCWHsflxLR1jRToclk6FawzTdaSrz0CW+dE+j9rJhElVLQHX5MbHH/1HWrbPQyVLZWu/rXb5rIhUhIdInv151ITJrd+dZQFMYdO5Q4l/EDdRmnUhREgmCyWIf13/BtS9NGKNTAJajSu2BcyQoRWTA3rqyOITS/zO5BJPptOla0fOwNVWm+3rOP5t2d5C2ZBUHs5Zvi1wPzOtIh9DZtDYOQCbX1SOzE9PSgADwi4UEKzCtxm0Af4/eWP8x6lzAr4VBF/UOlqZVrRUkS84GcUSU/rdT4Jvs4ZYU+oFeNZp77IN9rlUeYX0vVjO0RATtr4jW3ytRiXMs7rn7iOnnKWor4QwKTsdER9CnL6HYuitLW2mzH4fWZ7dzE0ivhyS19IXmOloAXNUJjXja0W0G6MNBukiMdtFYLEqdaD024u7VX3e3IS2hEDBKBE5EbHBFGay0O08MR/P6tPDerDLHPp6l/r9RgK2+0MNUN9AMFzi6Q/Knu4CgGlEHXz1JrchL47NFZbYP9/fEhhUg06DNoHip07MiuRokgZu4WcOb7pFBSVciai8jHEmidEVfXlwEKVr3wF9TlAI2zMWrtPf/S2E1kme/D62ptcA2Ph1F64q5qdm+B1sXLpLO41GnCiSaFL6Q4n0OIBfhQY+8BI9vC1X+q3qq5nQn4X45wnUHBI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199015)(6666004)(6506007)(6486002)(110136005)(478600001)(8936002)(2906002)(66946007)(66476007)(66556008)(2616005)(8676002)(41300700001)(186003)(44832011)(31686004)(5660300002)(53546011)(38100700002)(36756003)(316002)(26005)(31696002)(82960400001)(86362001)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFEvVjVzakduU3pPYk90ZmVYbmxMMVgzY3QzQVZVdFpVZnRIRkpBTU5Bd0VP?=
 =?utf-8?B?SS9jU3dUTHFIeEg4TUYyMS96N0p1Sk5QVkVJdngxR2ZmK3B6Y0tDSmRBbkpy?=
 =?utf-8?B?aGZXNHRFMUN0R0FUaEVnVE5iR21rMUlxSU9UZnZHUlRQOFdwNTBHdjgrckVN?=
 =?utf-8?B?MW02UEJscDlSL1JJTGdVeHJ0QmVFZ1pzZStYYm0zNmxsMHJGa3d0T3lncGpW?=
 =?utf-8?B?cFhzYS82bGxkNDk5MGhlTEhJdVgvVjNiQUJ3WUw3ZXRqSW1JNlkrVUxreCtQ?=
 =?utf-8?B?ekJGMUJrR3NJZ2UwR1l4S0Y0SXpDY2xiR09TTy8xc3JiK3BYQ21JZHp2K3VG?=
 =?utf-8?B?bC94ZUpFVEZWYW1JSFhUTnd4bTBYSElGTVV1ZzhuUUJ3VmUrWWV1UGF2MVh6?=
 =?utf-8?B?dldIYUQzckZWNWpZbVlFamJmUE50U3Z5dDFYN3B5WlZHTFZadHJiZVIzczFW?=
 =?utf-8?B?N3lhS0hqRUhPeVVKZG9MUk5pNkZkZit5RDJXTnhJWHhReWxXOG9QV0lqUmV0?=
 =?utf-8?B?TTBZU0lkeTRSdG93bTIwODVSRWtzTWNZczUrSytMalVTbXJGMngrejBSQjdl?=
 =?utf-8?B?bktKeTk5U3RPZm9oZ2Q2eDBoc0ltN2wzMXREaUZrdHJkUU42d2hoU0hpMzg5?=
 =?utf-8?B?V2lWQUdBOG12UFZFNDQxYk9BTlNSaW1YNE1NS2R3czFjQTI1dVhrWFh6aTh4?=
 =?utf-8?B?dXZGKzdsWll4NTJPUEpabGJQVzdmbTRHTk5xS1hrdDNlUEZXaDkvaTZLb1Ja?=
 =?utf-8?B?VWd5NGwwVnREcVdVQTh4OElsbkFic2ZKTm9mWjhwa2I3d1o0UWRONWg3Y05m?=
 =?utf-8?B?Tk54RnZwVTlEMFZrRTBCUXJCWFNFemc4bXo0MkhRL3hCSk5kTWVuRlNmUTdr?=
 =?utf-8?B?OEkvQTlaUXVSWTV4bVdudzFuYlZadlRjY25XY0krU2JCazZrL1JVSm5qcDA4?=
 =?utf-8?B?SDBnNk5oSWp5RDRIY01CdjNIVXdITnpBQ1VScm5TYzlsNDU0RUp2OHljbS9p?=
 =?utf-8?B?ZVR4cnk2OVZKNWZTWThabyt0SzlLUHFpelV5eWJQdDNwWGZnTVBDMW5QS1Jo?=
 =?utf-8?B?VXBDdGJGMFlndXA4eGRRelJsZEttejFJK0cxbmJVK2J4UmFZSnlUUkkxWnha?=
 =?utf-8?B?ejF6U3RPV0RCK1ppSTk4WWhzMjJrZ25WTW5mU1RLaDI2NytYSC9OZWpBbVB3?=
 =?utf-8?B?V0N5cStSUy92WWVXd05CdmJJVE16MGRZSDl2NkZjMHV5R2U3cDVIc0VjZXZy?=
 =?utf-8?B?QjZ0TU5NZitCcFNpdmdva0l2RXVwMDNmeTJOK3h6NjZKeC9iQ00wbGZ2bUVY?=
 =?utf-8?B?eDdITmJ3Z3VIWlRiTFpsQkZUZ0J2TUwvdXN1WGJBM1BWZFRzZW13TjVqWTFi?=
 =?utf-8?B?cWxtTVZjR1hoNVJDSWo3aUJUMEt0cklRejRORlcrbWhJMlFFOFp0K0ozeU43?=
 =?utf-8?B?UUk1WUIrYlRZajVRTUUraTJqQ3Q4RTZkUWNWWk1mMnlKc2xUUWFYR3dmQjNK?=
 =?utf-8?B?aitBZld2QWtTenVrQmpkUk1WUDFBeEhpa1lySnp6a1YxYnJOV3J2Y0IzdHdt?=
 =?utf-8?B?Zlp1QlF5enlxenZyOWJXaUZ3OWRkSFJSSE83YllmOVpvZitXNXVPWk9oeDlG?=
 =?utf-8?B?Y25vL2U5U2F2MStmZzEvZHRUbjYwK0F4SEZKN2pEYTBubHJGNXViWXNIMlFL?=
 =?utf-8?B?a2hRK2JQWkVQUXprNnhrNmltTk1FR1h3WlB2ZnZyN0hYd2ljVmxZb1U1TDBW?=
 =?utf-8?B?dTUxamFtYmVodG1GN0J3aitBVFFXMGdqNjIxTjhXVkxvOERmNWdMa3dkZEpu?=
 =?utf-8?B?dmhGTVhUNERWZkRVeUIyVUs5OU5PYUNmb0xja2R0RGlodEJyeDVoVmZ1dkty?=
 =?utf-8?B?RDZIUkYxZTNYc3N6b1VPaXJJc2dQOEZuMksrRndxeHhzRitRb1lFTU9PSk9E?=
 =?utf-8?B?eUd1eXhNRmRsdnlpNUVBeTU3T3JUemcwMEk0bnlYTkhPT1BiVmRkVFFtdUNw?=
 =?utf-8?B?dytFVFpUaVVPKzhQdG1BMlpaOUNCR3dvUnFOM0dEOVhnTFVPKytDd0JvTGc4?=
 =?utf-8?B?dmVDSkRMRmdzcmFESjF4MnpVV0haLzJKTGdTVVZBdEVhNXR4bVZ3UlpYbDU4?=
 =?utf-8?B?aVZLQ29yTzNkbjhaYjRlZkZnUjVwaUtwVnVtUis2eE41bU94ZUpnZHBuekxP?=
 =?utf-8?B?OGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a369f116-faea-4baf-7518-08dade0adde6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 19:39:08.1034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4mgwOzJcUS1CoQjS7HmORB0tZKcipc26Hgc/F9wBDZqkXoBFn1WlDhRpI5PLKHAReSfOQ4GaMyjQc1vGm0Gqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5249

On 14.12.22 19:59, Auel, Kendall wrote:
> For months I have been using the xenomai-3 v3.2.2 tag when patching
> the linux-dovetail kernel source from there. Today I turned on the debug
> options in the kernel (specifically looking for relaxes) and got the
> VM_DENYWRITE error reported about a year ago. Comparing the
> v3.2.2 tag with master I see that the ipipe code has been removed
> along with other structural changes.
> 
> So my question is: what version of xenomai-3 is best for patching the
> 5.15.77 Dovetail kernel (for example)? I don't see any tags or branch
> versions that are obvious for Cobalt on Dovetail. Should I simply go
> with master?

Stable 3.2.x supports up to kernel 5.10 officially (that's what we
test), but it may work with 5.15 as well because many adjustments needed
for it hit 3.2 as well. Would take someone to look into that, possibly
suggesting more patches from master.

So the safer bet with 5.15 is master for now.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

