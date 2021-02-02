References: <20210131144540.243363-1-rpm@xenomai.org>
 <20210131144540.243363-6-rpm@xenomai.org>
 <dc0e32e6-b7f8-85c9-7c15-7bd9b10e6c6a@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 06/13] cobalt/clock: drop timer calibration
In-reply-to: <dc0e32e6-b7f8-85c9-7c15-7bd9b10e6c6a@siemens.com>
Date: Tue, 02 Feb 2021 17:26:38 +0100
Message-ID: <87mtwmtozl.fsf@xenomai.org>
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
Cc: xenomai@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 31.01.21 15:45, Philippe Gerum wrote:
>> From: Philippe Gerum <rpm@xenomai.org>
>> 
>> The calibrated timer setup time is currently accounted for in the
>> timer gravity triplet (.user, also used as default .irq latency),
>> exclusively. This forces in a dynamically calculated parameter with no
>> way to override it. Meanwhile, this value would be already included in
>> every gravity value which autotune may determine, so this setting is
>> pretty much redundant.
>> 
>> Drop nktimerlat and the requirement for the machine section to provide
>> a timer calibration handler, we don't need these.
>> 
>
> Do you recall the history of this features? Was it first, and then
> autotune came along, silently obsoleting it?

This stuff dates back to the early 2k, when we still used the i8254 for
timing on x86. Programming the I/O ports to schedule the next clock tick
was so excruciatingly slow that we had to account for such overhead in
the timeout date. Other archs simply mimicked this for their own
hardware timers following x86, but certainly with much less of a reason
to do so (some would actually set nktimerlat to 1 clock cycle...).

When autotune came in, the reasoning for having nktimelat was not
reconsidered, although it should have since as a result, this setting
became not only useless, but in fact redundant.

-- 
Philippe.

