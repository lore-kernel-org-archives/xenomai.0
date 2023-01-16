Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2491852
	for <xenomai@lists.linux.dev>; Mon, 16 Jan 2023 09:10:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFz4MuhqNkNt+cZXMEXWjIE3bgl1KvK11nNfi5QmroL+tHSykPCrlVtznxxkhzxF4wpD28Hjw5OduT4ZVgo3o73zSKlbAQX9MUNDMXHK6EcNbl0PiA0pRlP4iSDNg0PaeSD2GC0MYJhgiQbNFlfYfUwUWLfnCs3uXFazjBZNs4WoumbnW139MWzJaAWua8c5jT1nNR0Jh04JjItzipizbxhAysJTR35K0jrp6oxcfyvTieA1tDdyyesYsSwJDj25mxGaOT8HLL7pbjBK5Ymo9E27j7Tg6UttwZmPfmDAgXw3MAX3Z/lKqVQL+W1BYt1jtYYwb/YlWQYj/fpnKgD0sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aj1v0zpK5VKKnBlMowiO1Z224u08hcWjpsNZG1lQnxw=;
 b=LTGtzCjkQnubLH4IMk9B2E5AkDaRwCLa0HdRlC4pggC5wsgzcoudYyIXbHJkoPBenAKazvIzIuM73bb9THV31t/peDbgnHe2wrUG5XJOZiKXPtHo4foS8aznRaiT0w/Z11qVFEx6SZCoekQSSlQ24Q6GojhpjqKWUbfBYRyoOu/G74LWZw5m0aZrzjmLX8Va7yRTe7sJcO15B6ldElRx1X5NBB+73A7QxQoJUbUeMWNxagppkU9sf2SOCw/YQ4jj2mK+zFDs+qjTWwhgzLVKSOGecOn29bGwOvrIdN28Whpnvv7m1DQkcHAwTZV6Nw4MfHyoaZJpN7Oimq7Tb3/eRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aj1v0zpK5VKKnBlMowiO1Z224u08hcWjpsNZG1lQnxw=;
 b=mFwi7zUZFOItsjXKU2T+G9Ah9Ge7wC1l71hu3i9fB87xJI/DqttPEkSqMZiVUgf9zU/YOooclh3BMkxLx2MdNxo4/jy18Am4vrpFUiU+jdFjSX0NE4DIJdcuGC9R1bnTuBswlJ67Q9lZX5X2nUEsd4Ql8ifTJfRdX7JM5z3IMa2gEfHTYzmIHAMRwl4GA5dzSLmhmcJSQ4gfQmTsskoMhZjbHFF8hDXlgeTdj2UnmDI0TwwNyWDiT0mOccbDY+5+dciJrbxnioCNVJ8cYVN8InLugOMxjP0wzWS44Ng3Qh8i2OKA/52wXRMvj0khxegjMM+lxLHCmwQNFYGHoS1frw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3123.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 09:10:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.5986.019; Mon, 16 Jan 2023
 09:10:47 +0000
Message-ID: <94fdf3b0-bc07-7063-7cc6-f6987ad1ed10@siemens.com>
Date: Mon, 16 Jan 2023 10:10:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: while loop in a multi-core cpu
Content-Language: en-US
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 Yunjie Gu <yunjie.gu1@gmail.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <1673779013-11742-mlmmj-00f27513@lists.linux.dev>
 <CAKcohPxHzbQvztgQMQaFq-EoXGbpfQxi1HpPV9nogBUaQ+PUSw@mail.gmail.com>
 <CAKcohPxdhCMohJZfSNaL2EvEDcLdm8CRgdy3hUusCu9Y5jexxw@mail.gmail.com>
 <MN2PR11MB42854A69C41937ADA0F29CDAF2C19@MN2PR11MB4285.namprd11.prod.outlook.com>
 <e8f0810b-7104-18a2-9931-a1df6ede2917@siemens.com>
 <MN2PR11MB42855B83E5F981669B6B0ED9F2C19@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <MN2PR11MB42855B83E5F981669B6B0ED9F2C19@MN2PR11MB4285.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0003.namprd14.prod.outlook.com
 (2603:10b6:610:60::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3123:EE_
X-MS-Office365-Filtering-Correlation-Id: 92eb424d-cb09-4c70-d4af-08daf7a18e4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AMY9/r1mvwlKaSJ7sMHxd1fLQXRoNuqz97BsY4vbfeGcGMxUF8j6YFhKuMKIq9OXARu/Iw995tbwjrGS1H0cVDjPk7ogckqfGMH8s+e6O0qp4+alRLHhjduftEhyhlvX9UBn/RKH1n6Gaxq+LNUnj4YDuqWhUYKVZJY9Bs+tNSTpvmmvGmNeCoeL2m4Y4GdDP6eUg6kmK9wj8+TjoVViZ1yft43PExcT1eurkJgJyjCj8vk6ll8p+JQ2vwCdX2GNDs8SCkBNbiTRScDzSFwLzbzFriCnMH4OGpWTWjoKAH/DLElcxHE9gMx8Zgd4v2izwYLdvDHiLlcQrP8i3dDcJmwO0i1LbLSxI7HJRiMSbArSbPLKalMvWX2zPapYBSN7vm8IEy4ikfd83Vl6/PDJWsZGZ0qHHFOVGhK0aDacPKDsLQ7+fzGc9UaUmdELDJUHPw2gU/Y5VWG8f8f3hC1ZZIZ7Nt0uTNXQqyfms7ABkKmMfAIOE+KKhpjhQVm4qtuhsmqg97dOv7BB5r1TkL8A0NTMHQYp7JaV+tjX07kFggYlZ+V9GsnkGwiZlqk2foDf7dk264g1GBxZ+/h5geQagrqlw2fu9m1E1WybOHAryrOo1fhIInMAfjtSC4WsUxBsZUc5eln2nO17HcWm9dWlkZK/vPKDg0Nuh+6f2jTr3Tpj6eYDKFuM3Jzv3okmO5g3eRmhAMeZ7vahRFGaoBNZK/mPSgQoLGtm8SCqyfLA8P8O9XZKePSV7ZgIIprpx+jG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199015)(31686004)(36756003)(966005)(83380400001)(6486002)(478600001)(2906002)(44832011)(31696002)(82960400001)(110136005)(38100700002)(41300700001)(316002)(186003)(2616005)(6666004)(26005)(53546011)(6512007)(6506007)(86362001)(5660300002)(8676002)(8936002)(66946007)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjdoNHRWZ2kxK3Fud0NOakd1Q1FQRlBjWmdhV2d0L3prOHdIU2NvZHlyZGpV?=
 =?utf-8?B?c2xDSlJyU0hWS1UzdmZYL3o3UWF1dWg2Sis5aW5GdTVwK1ZESlR1QUk5L2h4?=
 =?utf-8?B?ZFh4YkYyVzJHdjRiWEd0d1pNcXZOUGxuTzNPYVl4ZE1iR2NqUXNIVTdiNkJM?=
 =?utf-8?B?b2w4eExXRWk1SzVxKzFLUzk4R3hrT0JiVW5FeGNNZG1QRThqMnRGSmNZdlZ0?=
 =?utf-8?B?OE5KK0lnNFN2YTM2N1pBRkdCYkxzbHNDSWxyNkZ3L21INjJYb0YwU1dNN05y?=
 =?utf-8?B?MGtVZnFYeGloZTc4YTNueE8yUlpmUGZZY1V5emVxN3AxcjE3MVBXMHZHeGls?=
 =?utf-8?B?V0hyeW9RTDJBeHVMbTdsWW9saG4rZnZYYXVrQVBuMjF4di9SSEZCRHQ5dlhr?=
 =?utf-8?B?clpGbGEzUE9wVEFIM1ZuRDRuVGVhVllMRjF6SnFZUGZQRFZxeHJOcjBhK1pa?=
 =?utf-8?B?Rkh2SEZBa1E5WEtva3FnY1pSWEpuTnZzWDdHbnBlTnVWNmxLNjNxSVRKQU5L?=
 =?utf-8?B?VytzQTV6MjN1ckFKelBjQ3VDclM0UmJKcDNPeGcxZzR0V2NEZHBTUy84OXpL?=
 =?utf-8?B?WEJ4VGFVOUxTaUtOUlpkdWtGbDg0Y25XdjIrZWJUN1N5R3JIU2FpV0NlRVlG?=
 =?utf-8?B?cEFEaGN0djUrYzkrWXFnQVNxdjdxbGxodmxkazBTL0VEaThBSHc5N0VQbUt0?=
 =?utf-8?B?YktYSlhKdWlKZ3hHQmFPa2E3M0tvU1Z5RXorU0VWUVM5bGNtK1JZWWRGWmJQ?=
 =?utf-8?B?bUVtVTVWZlpaeFJHZWwrOEdnZDJ5NzFVSllQVjl2NThjcHRjTlFkcm9uYll3?=
 =?utf-8?B?RlRnazlHdXRSSHNVSzFLVlZjYTFNVmpQOUZvSW0rdy9ORTYyNlNIa1I4c3hD?=
 =?utf-8?B?WEE2Q204SW1HZDdtY3pETTBjczkwWEh4aXlCSTJjMk9PZmJKRVJvMU1CNGxK?=
 =?utf-8?B?a0g5ZVpQOFVCZ25rbjBudGRpT01CUnM2WFg1NktNSGFGVWFGQkJpME5jL1do?=
 =?utf-8?B?U25kTTk5TmRyb09vaElNcktjMUxpYXpHRUYrVVEwdG1aaE1IQzYyeXhGUzMy?=
 =?utf-8?B?SmxEMDNUT1JtVzNrWFd3OFZuNk5ZbFA5YVBJQ0svNkkybHRnd1UxT3V3Yytm?=
 =?utf-8?B?Wm40VEZqRVpPbHU4d2ZxV1BNWjdVbTZ5ejN5dXNJNXVlUzhXNzBzc3R0V0NM?=
 =?utf-8?B?VjZuMk1rVXY4VXB6dXZJVEpkQTd3ZUUvUWxwai9UaWx1VGYydGFEMTZRQjBF?=
 =?utf-8?B?cGRRSWRmR2tkcmlQZ0txYzNVbm5JSWhuSzBnQXYvNXZqVU0vaUQ2c0Rsc2dn?=
 =?utf-8?B?YkpyV1BWbGQrTm9kb0xXMEllc1FlaGpwc0VGRWNhbDNDS3lpU2s4bkIzZGR6?=
 =?utf-8?B?cUFxblhIYWxZK0h1V3dIOUY0Ynd2Ui8yWXJqeWNNRWZqUmZSc09Zb1BnT1VC?=
 =?utf-8?B?dzBVMVlaUEtJTmhJVGQ4MTVvZVlDdE55Wlh3a204eCtDcmRIZFhPcjRqTUhR?=
 =?utf-8?B?T09lczJKbm0za0tPampEVXVpN2hnUGNCTWM5OWZlMEp2eUpuK01Ca01LdDdx?=
 =?utf-8?B?U2Y3YUhBd1Z3NGJSSUthZWt2ekVoN3dmNmdhNWtBWXNvbkxpdXhPQi9xdkJJ?=
 =?utf-8?B?SnJxZCtBNTZMM0JxY1Nwckh3b29McDFtK05LNzFFUEg0dmJLdG9mdDJkL3Nm?=
 =?utf-8?B?c01PelZ1TzFaSHVMM2hTa0RFMW5scVlVN3AzaUlTYndYR2VrLy8zeWVZcnJD?=
 =?utf-8?B?YU5QMktWOUcrWXI5MStyTnB2WXFzbFdvQ01CQlhOQ1MwaGg4UW1RSGo4S1c0?=
 =?utf-8?B?OHdhMGY1ZGxXRGpQMFFtWEhFbVNvcVpPaG84c1g5TEFIbHo2V3J5RnVmNTJU?=
 =?utf-8?B?UGhXQ3I1bmx0c1BNcUxwZXNKVEllbko0OXU2SjBlNFNyQVVsSktUQmMzZDI0?=
 =?utf-8?B?aWRzOXpaVTFEZjUvR2svWlNML1IrcDh6cnhnTnhpOE1XL1M3THljNzQ1Y2d2?=
 =?utf-8?B?cEdTSm96dTNJd0VlalRXWGdjSlNlOThod1luL2Fxc2xmVzlieGdKYkpiVVZU?=
 =?utf-8?B?bnlQRE9ZNmlpQi9qV2dlamlGcmh1ZHBHMlRXRjhSdERnL2FWcnlMS2RZdXZk?=
 =?utf-8?B?VzNOZ2Z5UGpJeGt3K2ZpNyt6TllFa09uZlljdVNteEZkYjJrWGVuN0M4RkNi?=
 =?utf-8?B?Umc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92eb424d-cb09-4c70-d4af-08daf7a18e4b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 09:10:47.6725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYqYIv53jS91Ud8vJtWJn4320b8c+gIodJSdYCCoerLcrY+iA42166mZ2A9C2xSESoJnbIhU77IGWo6zVJtygg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3123

On 16.01.23 06:53, Chen, Hongzhan wrote:
> 
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Monday, January 16, 2023 1:17 PM
>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; Yunjie Gu
>> <yunjie.gu1@gmail.com>; xenomai@lists.linux.dev
>> Subject: Re: while loop in a multi-core cpu
>>
>> On 16.01.23 04:05, Chen, Hongzhan wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Yunjie Gu <yunjie.gu1@gmail.com>
>>>> Sent: Monday, January 16, 2023 12:08 AM
>>>> To: xenomai@lists.linux.dev
>>>> Subject: while loop in a multi-core cpu
>>>>
>>>> Hi Guys,
>>>>
>>>> We are trying to develop a polling mode thread to skip the delay of
>>>> the interrupt response. This is done by a while loop to check the
>>>> hardware (say a gpio or a timer) continuously. When we did this we
>>>> found that the system was frozen, meaning that the other cores are not
>>>> functioning when we run a polling loop on a single core. But if we do
>>>> the same in a normal Linux thread, the system is not frozen. I'm just
>>>> wondering if polling mode is allowed for xenomai, or if we did
>>>
>>> Xenomai threads should not dominate cpu too much time in dual kernel
>> configuration.
>>> When xenomai was dominating cpu too long time, from Linux 's view, cpu is
>> like dead
>>> and Linux can not handle it correctly in such case.  If you enable
>> CONFIG_XENO_OPT_WATCHDOG,
>>> it may notify system to avoid such thing from debug point.
>>
>> Theoretically, a stable NOHZ-full setup should be able to tolerate on
>> top a Xenomai-only schedule with full CPU domination. However, achieving
>> that under Linux is already not trivial, and I haven't tested if Linux
>> is actually entering the right state when out-of-band Dovetail/Xenomai
>> takes over.
> 
> What do you means about NOHZ-full setup? Is it just related to configuration or commands passed for linux?
> Is it possible to fix such issue that we do not need to modify Linux kernel?
> 

I'm referring to
https://www.kernel.org/doc/html/latest/timers/no_hz.html#omit-scheduling-clock-ticks-for-idle-cpus

If all works well in such a setup, a single(!) Linux userspace task can
run at 100% without being interrupted by any timers and other background
activity. Difference to Xenomai: If Linux finds out that the promise to
that task cannot be fulfilled, it simply interrupts it. But if that
should happen to a Xenomai task, Linux can't express that, and we would
be back to a deadlock situation.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

