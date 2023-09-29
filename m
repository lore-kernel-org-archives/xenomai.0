Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2077.outbound.protection.outlook.com [40.107.14.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99B84418
	for <xenomai@lists.linux.dev>; Fri, 29 Sep 2023 12:11:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJkPmwisuX7z2qZns9+fwD/oPzf1wFmn0pxNyRV8vigHFWNWUOJ0YVta9jaG/gDS/pUBQlzb5N3ziqUzfXOlbTeu2fS6RWX0ko6PgmG+UkNjH5UF7kpxzHyNvWb7iMLr6/V2l3zHohIgDKY7Y4n9HR8vtXmFJcJ8y0wD2v5TRM57m13BSmaNHUrMzWdHn/Sgwi4MhG9JAUZ3HusryKbN0d7FuZaA4mCLTGgFBsACLtyKkm/Z2LOwU33SIOvG6NReT/7rTY1vXWzRrwvuPSPQ4udy5sXo6CX2SBMDkrTEr3WmxwYprkbFySOuJKk7nMJ69K+z0lCUaZmb4Oun1mjbKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFnbdKGPZltkGrJdGAxnVNgrkrgbknGqoMNlu9VtJSY=;
 b=NXRG1NMDSAXCCt0mHNbDIum5AKpBvUszrn7EhDasTYdwh3s1a6p3Zo4+Rs4X/kdtn6jO+3LPDiUZBVfzDceHY1nb7GHsUM4jyg7Uvcd5EC1zuZI7rS+/wEoIhLxWNArb8fHF5oJedjCEgcxKbeNuI41w8r9yOpAWlSTkeQPFib+VuBZNnfIabB/90ufKz4DokMa9mfEr4o+mX0F+tUtM8JFjn/01fdBcjvtPTvmu5CHl9yXLdKtAiVGtB2WvL3a2NN9FHX/1iLmzAC4ny8iYcWWCMNnWCrr6lskjMRLh1a7VWFmzbmknDKxAB62WI52nAnLITVZCVZg5SEJLBKaJxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFnbdKGPZltkGrJdGAxnVNgrkrgbknGqoMNlu9VtJSY=;
 b=x3CKryEsn2LR0tR+6GwAONTVTshHBrqcWfZWoWdID2X4s6Y7QUfh6A4X1Ibjd95u8AbURW1HEupcEwhgk44RuIE3zJkVNhsxoeyHGY0mje452s5t5ur89Vk6MLk3l9QuMLqw1kuRdL2w8mQ7rkDY7obUyhBoQmdqn7Oa+IK2k8mWiYWuiliKANp3VXxoaPGV30FGk9q2B7O1iqGKxhwOzglKq6PFVyYurYD2+QwKh3OxFvl69FJGTAN99FGmJFbS+0XhoMurLWzCYeMR2ffCtWWqVQ9hetHbYFyrRASacNIh/U1YsWJXyJxUCVDAVAsPuj1EFO3POxlQaRDSdWQm8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6194.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:95::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 12:11:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Fri, 29 Sep 2023
 12:11:12 +0000
Message-ID: <c7f7dd00-cb79-4485-aba7-955c43309ea8@siemens.com>
Date: Fri, 29 Sep 2023 14:11:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: accept after select for RTNet/TCP
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Per Oberg <pero@wolfram.com>, xenomai@lists.linux.dev
References: <1477790382.2402907.1695827633513.JavaMail.zimbra@wolfram.com>
 <10067eb6a762f8f468b5f81db9f49b825f3ea96e.camel@siemens.com>
 <1723160879.2522128.1695880477176.JavaMail.zimbra@wolfram.com>
 <759339022.2543916.1695899840518.JavaMail.zimbra@wolfram.com>
 <3429d1091991ec499009a88b080657d0a7640e8c.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <3429d1091991ec499009a88b080657d0a7640e8c.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:610:4e::32) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f66c5a-b104-4265-f38f-08dbc0e52c37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1/RjPG9r+jO+iS6fnNO6xX/wtbjH6BG8ShKi5aZa68MSc67Q+UJth8OxJNvb02SE2NBmASDCIduxLrJGrUY7jIwWKwjkZYDdTgQEQr/iuERqTzlvUuUncYkVBhM8TJFT8h21K8orIIsWQIM4MCJNO6OTtMeIMVxsRe0YqSpV+VdmIIDivKsPaAwfmuURV7X3rPLEO6aDnk7NuicHEmsKGyRwkCDjacULuha5Rt+Ru55dha8U4uybHJvDiBPzboK1ubqPXOBbi6LuQS4h3Cp0QS4tIXZVBU/rB4jFbeUbJHn5NSrley1fZ/ElZsJ+kF3GRXggBM+fld4iwg79doZ2Ma2+U2EzKldOGi1gxxs4JgT82V9Ts33HklFUmnSpaNof2At1zlo0O7Ni3xGpHl0YmCPRb5Cefp676etsv4NGzAjFVKobn2kZntzltinQb3C7PqtGFJvPn2hDpSofUmrSZXuGcM5b/Rr4nZHyCtkYVy+CWU8pf2XsNH+1jxRyBNV40Li13zgJGgr5MSnSfpT0ep0HlPsJXOzBJPjBw0j1wfD7ugKYD7m2bt83K9MeQ7/VXCAfZ7ts9fQmXSJXuvBuI7cypFwMzUL+NrZr8XHhwYBwssXfjvAHMbWvp/6BRFTaNwQpP36pwVycOwBUZabFWA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(2906002)(44832011)(5660300002)(31686004)(8936002)(8676002)(26005)(36756003)(2616005)(41300700001)(66946007)(66476007)(66556008)(316002)(110136005)(6506007)(6666004)(83380400001)(6486002)(478600001)(966005)(66574015)(82960400001)(53546011)(38100700002)(86362001)(31696002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RG4vQnVjKytCZlRad1pHaXhCRUtVcnpERzVuV0JkbG52MVdtMTNLS0Jzdkht?=
 =?utf-8?B?aE9pUTNSUkc1QU9YZG9SU1VsVHRSQll4WWJqUVZzK1RwS1ZGVllHYkMrZjhm?=
 =?utf-8?B?RksvNlovSG0xa1BJK1U2QmIybHJsTXBTQzNpU1dGKzVrcnh4MUxJOWgwb2hL?=
 =?utf-8?B?WU1BY01rNXBTZVpxNWlWOFZQTEFsVnNyc1crdDFSN2JwcjhweG5qeUFQem9h?=
 =?utf-8?B?NU9PMEQ1S0ZXYUpQKzJwQ1FuVzdKSERXUjYzZ080V0JVSC9VMWFXcjdUSS9i?=
 =?utf-8?B?azVlamhSL01xZzRRQzNSaG80TXRjWGVPeWdCK1EzNncwMThCUDRUWUIvMHI3?=
 =?utf-8?B?UGZPazgvOTRZcURxVEp1NHdZMTIwTmd5Skp1S1VSUDJTSjhLOEs4T1JpRGZt?=
 =?utf-8?B?cFVwQ1JPWmh1cmY4M0FSdnFwWGs5eHFYTEs1QmlBRUl6azVjT00zSXFpaUc2?=
 =?utf-8?B?WXR0MU1wZ3k0VXoveEVIc0M2bi9CS0s4SktrZlQxRzErRExzUkNSUGprRnlw?=
 =?utf-8?B?dlRjQ3VJTzlJQVBvQXlwSURlOXZBRTIzSVFDVURVQVZxaEh6RjlUaHRvdzlW?=
 =?utf-8?B?bkdSTmcvU2NqbDdUeUpHQ2RlaVlWL2p5cUNiM09KWHlNVS9TcHpJdWU1RGo1?=
 =?utf-8?B?RGthWjl5TWRRN1BNTy9vSXM5RTA2NHhKMitqMkRITTAzcy9MU1ZxS29uVnFm?=
 =?utf-8?B?SW9sT0Mwd0kyN3g3TnhzUm9kY0hnN1o5c05IaUpFUHd2K1BEYzFLVEtrc0k3?=
 =?utf-8?B?SjBjRHROVWt3OWxjUFd4dW8yQlFQcFdrakJPRjgwMjZ6U1ZRWDZpa2JLUVFU?=
 =?utf-8?B?aTZwcG5hZmZhZGthK2tIRnNLTmY0enpCeThWWHJIU1Fjb0JOVXRlLzZ3TW05?=
 =?utf-8?B?bWhqRzRrazY3TnFoMmdoU1J4T2xsR084MnVHaUpTVUovR2lidk9uMHNRRUtw?=
 =?utf-8?B?cU5GMUxraXJYS3ArYmluNS8zTWZycFRxNXBIY295L04vNVRvMlhpemZJd1pS?=
 =?utf-8?B?SDV0Q1oyK1FJNUhXVWQ4V3V6TzNkT0VwTVNqeUMyV2Z3WUt4c2VXbjR5UmNZ?=
 =?utf-8?B?S0xSaWVFYjJ3blkrWHdsLytJR0dJdTZycks4ZzhaV0lIQnNMckhmOEErT0N5?=
 =?utf-8?B?RkNTc3dRcDF2dk5Na1lOYVdFcktrL3g1bTd2R3krQnN2UGdqYXllUGwzY2pB?=
 =?utf-8?B?NGpnZWQySlhyUTJ5Z1dlNmlQVmlqbUM0REFlQyswRHRQL1BjRmNoOW1zUG05?=
 =?utf-8?B?cVBVbzFMOFNYdW5DWmMwaWdSajBTYnlab2lrZ2ROa1EySEtrYkk5ZEZFRDNl?=
 =?utf-8?B?SC9OM3B6N01GT3VITDltcnZzSS9QUXN2UGpyRDByWlYxQVErMkkzcEFTS1BC?=
 =?utf-8?B?OURHQVIyWkNVK2NYN2VYQkhuT0RSZnpyWVNkNGJwR3ZFOTlTOCtQSFU3M1BP?=
 =?utf-8?B?dGVvaktJbnRZd3ZlR2lNQ0tTSnVId0NURjhZa2pWTTdzd2dSUHJYWFBWbUtV?=
 =?utf-8?B?R1V6YkJ4MjBoWjhkalRzTzM3R3JDZDRoSTUxZTROdWxzSStjVXQyWTdPQTRN?=
 =?utf-8?B?bFkyaHpybTgyL1NWZGUybklUWms5VGlhZTZLL2t0TG5URlg2YWloWS9TQklG?=
 =?utf-8?B?UnRQV1VuVUI4OCtPcG90ZDJCdzNnaXc5UXdwWDd5aU9CT08yeVB6dGRCOGpz?=
 =?utf-8?B?c1BPOVNGYnova3FZenV5clJMTHZQUzFpVS9lRmZTMVR1ZW1jUW81YVZqZmtH?=
 =?utf-8?B?Q25ibmYxVEFnMTlRblFDVFBwRURMVllNNG1tZUQ1eFBtWkhyb0NtSTR0Ukxv?=
 =?utf-8?B?RERHK2hTVXZBTHJraG5wRUNnWWlRQ3AwNEIyN3RKY0NyOXJIL1pJdSs5SWVT?=
 =?utf-8?B?Snh0Qm9DZzhmRm5KUDM4TnM4Njl6T1VHN3RybHEyQmdJbzJnRGg3MjlGVHd6?=
 =?utf-8?B?bTlLa0h5OWFKVld4Q1NidmNENGN0TlNtMWh6SSsvVkhTbER4QnlWbUZpcFJY?=
 =?utf-8?B?NG1tUU90Zm4vWmwrbWdINWxOL2hrMmZLV3l6cml5SHlOcW1FeDBieUhFdVBi?=
 =?utf-8?B?eVg5dEMzcVh6ZFVuWnE4R0h1bHpXUWwrbjNaOE5PMjdaMmJoYWhVTDNUeklS?=
 =?utf-8?B?YWVZc1hDeE1SdVFHb0hRY2lvQ05QV2txbEZzZHU0UzNlOHJKZGxlVTBTc1Qz?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f66c5a-b104-4265-f38f-08dbc0e52c37
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 12:11:12.7072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEzJrIGVwF1ES/4tJ3fsU627ryRaXcBrBC3uhpQVr9kd5qI9XQDhdhy9CGOFpaES4Ly8t8L9iOBoBXNlV151MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6194

On 29.09.23 12:41, Florian Bezdeka wrote:
> On Thu, 2023-09-28 at 06:17 -0500, Per Oberg wrote:
>> ----- Den 28 sep 2023, på kl 7:54, Per Öberg pero@wolfram.com skrev:
>>
>>> ----- Den 27 sep 2023, på kl 22:21, Florian Bezdeka florian.bezdeka@siemens.com
>>> skrev:
>>
>>>> Hi Per,
>>
>>>> On Wed, 2023-09-27 at 10:13 -0500, Per Oberg wrote:
>>>>> Hi
>>
>>>>> I'm currently porting parts of an application that uses some TCP during startup
>>>>> to Xenomai. I have a working example of a TCP server but i cannot make the
>>>>> "select" part work.
>>
>>>>> If I do
>>
>>>>> fd = __COBALT(accept(list_fd, (struct sockaddr *) &client_addr, &client_len)))
>>
>>>> The usage of __COBALT() should not be necessary, the Xenomai function
>>>> wrapping will take care of redirecting the call to the cobalt world.
>>>> (Assuming you are using the LDFLAGS and CFLAGS delivered by xeno-
>>>> config)
>>
>>>> That allows you to compile the same code - but with different flags -
>>>> for both worlds without modifications.
>>
>>>>> without the select part it works. If I do a select before it returns "Invalid
>>>>> argument".
>>
>>>> I can remember that I saw something similar in the past. If I recall
>>>> correctly there was an ordering problem. It somehow crashed when the
>>>> first connection request came in before the accept() call happened, or
>>>> something in this direction. The socket state was somehow "corrupted".
>>
>>>> I should have it on one of my TODO lists... Unable to find it right
>>>> now.
>>
>>>>> The "select" part:
>>>>> ------------------------------------
>>>>> fd_set in_fds;
>>>>> FD_ZERO(&in_fds);
>>>>> FD_SET(list_fd, &in_fds);
>>>>> int selRet = __COBALT(select(list_fd + 1, &in_fds, 0, 0, 0));
>>>>> (FD_ISSET(list_fd, &in_fds))
>>>>> {
>>>>> printf("list_fd (%i) is in FDSET\n", list_fd);
>>>>> }
>>>>> ------------------------------------
>>
>>>>> The program works when compiled for regular linux.
>>>>> Is select for TCP RTNet a no no ?
>>
>>>> select() should work as expected.
>>
>>>> Can you share a complete reproducer? That would simplify things and
>>>> increases the chance that someone is able to look into it.
>>
>>>> Best regards,
>>>> Florian
>>
>>>>> Best Regards
>>>>> Per Öberg
>>
>>> Hi Florian and thanks for answering
>>
>>> The explicit use __COBALT / __STD wrappers is for some of my code that sometimes
>>> go on a real time socket and sometimes on a regular socket (depending on the
>>> destination). I think I found an issue when leaving it out for some special
>>> cases. (But it might have been the missing pselect that was the real issue)
>>
>>> That said, I also use it to ensure that there are no missing syscalls when
>>> debugging. E.g. I think I recall that pselect was missing in the implementation
>>> and that became apparent when putting __COBALT in front of it.
>>
>>> My issue is 100% reproducible (afaik) so no timing issues show up for me in the
>>> regard.
>>
>>> I can certainly share the code. My example is an adapted version of a TCP
>>> Client/Server demo. I will put it on github if that would work?
>>
>>> A few other notes that came up during the porting:
>>
>>> 1. It seems like accept does not like beeing called with null pointers to client
>>> address
> 
> That might be a bug, or a RT simplification. Would have to look into it
> in more details. Jan, any idea?

Yes, it indeed looks like we demand a non-null pointer here. Can be
relaxed, just takes someone to send a patch.

> 
>>
>>> 2. Accept returns the same socket number as the listen socket, and thus closes
>>> the socket when the connection closes. I guessed that this was a simplification
>>> deemed ok for real time. This effectively makes the TCP server single client
>>> because SOCK_REUSE is not supported, right?
> 
> I'm not familiar with that code yet. But yes, might be a simplification
> for RT. Jan, any thoughts?

Yeah, we had there some simplifications built into the RT-TCP
implementation, see also [1]. It was originally designed to handle
point-to-point TCP traffic in RT to a single non-Linux peer. And IIRC,
there was even no need for server support on the Linux side for that

Jan

[1]
https://source.denx.de/Xenomai/xenomai/-/blob/master/kernel/drivers/net/doc/README.tcp?ref_type=heads

-- 
Siemens AG, Technology
Linux Expert Center

