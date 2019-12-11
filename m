Subject: Re: Lockdep splat around rq->lock (Was: Re: [Xenomai] am335x xenomai)
References: <CAOf5uw=i62dBaP1KidqJ09RFYz7hwPDj4e9cCwvNQzq9h61n5A@mail.gmail.com>
 <2008645939.112092.1575975265668.JavaMail.zimbra@nod.at>
 <45cda878-fa53-c1b2-881b-06d52e66a32a@siemens.com>
 <4298ac73-340f-5699-7176-ef48b5ab2294@xenomai.org>
 <316849456.112635.1576006265616.JavaMail.zimbra@nod.at>
 <e58f57ef-4de9-ea9c-708c-6138aa2662e0@siemens.com>
 <739572661.112669.1576007544977.JavaMail.zimbra@nod.at>
 <7b252bfb-2a37-ef80-a18a-c4603b98036c@siemens.com>
 <2080699744.113026.1576059451250.JavaMail.zimbra@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <fe199dbf-67be-2026-a011-5255eee81cbc@siemens.com>
Date: Wed, 11 Dec 2019 11:45:33 +0100
MIME-Version: 1.0
In-Reply-To: <2080699744.113026.1576059451250.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard@nod.at>
Cc: Philippe Gerum <rpm@xenomai.org>, Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, xenomai <xenomai@xenomai.org>

On 11.12.19 11:17, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>> An: "richard" <richard@nod.at>
>> CC: "Philippe Gerum" <rpm@xenomai.org>, "Michael Nazzareno Trimarchi" <michael@amarulasolutions.com>, "xenomai"
>> <xenomai@xenomai.org>
>> Gesendet: Mittwoch, 11. Dezember 2019 08:24:41
>> Betreff: Re: Lockdep splat around rq->lock (Was: Re: [Xenomai] am335x xenomai)
> 
>> On 10.12.19 20:52, Richard Weinberger wrote:
>>> ----- Ursprüngliche Mail -----
>>>> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>>>> That's untested even on x86 - and likely not working, with any kernel.
>>>>
>>>> Do you have a use case for kprobe?
>>>
>>> Yes. On the old kernel we used to have many hooks (function pointers)
>>> within kernel to allow installing notification functions by our modules.
>>> It is basically a hand made tracing/notify framework.
>>>
>>> To get rid of the mess we decided to use kprobes instead of our plain
>>> pointers. So far the probes worked nicely and helped us a lot to cleanup
>>> the code base.
>>>
>>> If this is not supported, please make ipipe depend on !CONFIG_TRACEPOINTS. :-(
>>
>> CONFIG_KPROBES. We do support tracing (ftrace, down to functions), and
>> that is what I would recommend to you.
>>
>> In general, there are likely more things from the debugging section
>> unsupported. It's hard to hunt them all down, but CONFIG_KPROBES is
>> probably worth to add.
> 
> Let's put it differently. What is missing to have reliable kprobes?
> Maybe this is a small and nice project to get a better grip on ipipe
> internals.

Probably something similar to what we did for enabling kgdb: Analyze to
code path taken on hit, handle it without migrations or worse things -
and then make sure this is continuously tested. Due to missing tests of
kgdb e.g., I would not assume it still works.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

