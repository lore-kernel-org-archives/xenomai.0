References: <BY5PR11MB4306385582356B11B21A19E1BA919@BY5PR11MB4306.namprd11.prod.outlook.com>
 <875z1il23m.fsf@xenomai.org> <8735wmkvno.fsf@xenomai.org>
 <517d5246-1176-af9f-e5c6-efeaf484dde8@siemens.com>
 <87pmzqj6vx.fsf@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Xenomai Community Call Minutes - March 10, 2021
In-reply-to: <87pmzqj6vx.fsf@xenomai.org>
Date: Tue, 23 Mar 2021 15:13:45 +0100
Message-ID: <87mtuuj6ue.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Wang, Rick Y via Xenomai" <xenomai@xenomai.org>


Philippe Gerum <rpm@xenomai.org> writes:

> Jan Kiszka <jan.kiszka@siemens.com> writes:
>
>> On 23.03.21 11:32, Philippe Gerum wrote:
>>> 
>>> Philippe Gerum <rpm@xenomai.org> writes:
>>> 
>>>> Hi,
>>>>
>>>> I will not be able to attend the next meeting planned tomorrow. Here is
>>>> the update from my side since the last time we met:
>>>>
>>>> - The Xenomai/arm64 port to Dovetail is complete, available from my
>>>>   private tree. Tested on kvm/aarch64, imx8mm, rpi4 and Odroid C4 so
>>>>   far.
>>>>
>>>> - All pending patches now merged into my 3.2 tree.
>>>>
>>>> - A regression with Xenomai/I-pipe on this tree was fixed a couple of
>>>>   days ago, causing switchtest to freeze the machine. You may want to
>>>>   rebase on it.
>>>>
>>>> Thanks,
>>> 
>>> - I have also addressed the COW-breaking issue for Dovetail
>>>   (dovetail/v5.10 and dovetail/master), leveraging the existing work
>>>   already done in copy_page_present() for supporting the pin_user_page
>>>   API. Tested extensively here by tracing the behavior upon mlocking and
>>>   fork with real-time tasks, but since the issue with the I-pipe was not
>>>   trivial to reproduce with the I-pipe it seems, any help appreciated
>>>   validating this.  As a result, force_commit_memory() disappeared from
>>>   the Dovetail API.
>>
>> Running smokey (full set) over Dovetail triggers it easily. Like it did
>> over I-pipe.
>>
>
> Which test in particular?


Reply to self: anything that forks under testsuite I guess.

-- 
Philippe.

