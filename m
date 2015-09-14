References: <20150914062111.GE4195@hermes.click-hack.org>
 <CAPRPZsB5PCNmrrqfE4u8E23JEL=_aRhTPS=kUHtEZwpRPjhagw@mail.gmail.com>
 <20150914074527.GA17701@hermes.click-hack.org>
 <CAPRPZsADxhfhhGOP_9rE__yR-Bb_QgJzyGn4K-kmgHvjO=3WjA@mail.gmail.com>
 <55F7037D.609@siemens.com> <20150914190123.GA27502@hermes.click-hack.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <55F71AE8.9090706@siemens.com>
Date: Mon, 14 Sep 2015 21:07:20 +0200
MIME-Version: 1.0
In-Reply-To: <20150914190123.GA27502@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] SMI count polling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2015-09-14 21:01, Gilles Chanteperdrix wrote:
> On Mon, Sep 14, 2015 at 07:27:25PM +0200, Jan Kiszka wrote:
>> On 2015-09-14 10:09, Jeroen Van den Keybus wrote:
>>>> Well, in that case you can install msr-tools:
>>>> https://01.org/msr-tools
>>>
>>> Thanks for pointing out. I didn't know these existed. Always used
>>> direct msr device access.
>>>
>>>> And run:
>>>> rdmsr 0x34
>>>
>>>> Of course, this requires CONFIG_X86_MSR in the kernel configuration,
>>>> which putting the count in /proc would avoid. But still, this would
>>>> be a bit redundant.
>>>
>>> True, but given the frequent usage of SMI on many mainboards, their
>>> serious impact on realtime performance and SMIs being designed to
>>> remain undetected, a convenience function wouldn't hurt. Especially
>>> since I have the impression that it's an important stumbling stone for
>>> first-time users.
>>>
>>> Also, the total count would be useful since you would have to run
>>> rdmsr -p <CPU> 0x34 for every CPU in the system. I believe it's
>>> important to check for SMI occurrence on non-realtime CPUs as well,
>>> since I understand any of them might be handling them eventually ?
>>
>> Usually, the BIOS will force all cores into SMM: one core receives a
>> triggering SMI and then it sends SMIs as IPIs to the others. So the
>> counters increases on all cores, just with a minor delay.
>>
>> That said, having the rmdsr diagnosis documented would already be a
>> valuable addition for users.
> 
> On the machine I was using where I discovered that tool, the value
> is indeed the same on all cores, and it incremented by the number of
> cores when . So, Jan, what do you think about
> adding code to the tracer generating an event when the counter
> value changes?

As we will have to poll for that event, it may be a little bit costly to
do this on every ipipe tracer entry. But then we could make it
configurable (via /proc) with default off - worth a try.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

