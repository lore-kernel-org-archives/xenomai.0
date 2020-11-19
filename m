References: <87r1op4jpt.fsf@xenomai.org>
 <b0ebf71e-52ca-5915-7a07-4ff17c5865fc@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Xenomai 3.x over Dovetail
In-reply-to: <b0ebf71e-52ca-5915-7a07-4ff17c5865fc@siemens.com>
Date: Thu, 19 Nov 2020 15:25:18 +0100
Message-ID: <87h7pl4e5t.fsf@xenomai.org>
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
Cc: xenomai@xenomai.org, "Chen, Hongzhan" <hongzhan.chen@intel.com>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 19.11.20 13:25, Philippe Gerum wrote:
>> 
>> All,
>> 
>> After some recent discussion with Jan, I'm joining the fray in order to
>> get Xenomai rebased on Dovetail, replacing the I-pipe, the in-kernel
>> software layer which connects the real-time (Cobalt) core to the
>> mainline Linux implementation. The main goal is to enable Xenomai 3.x
>> for the most recent LTS kernel releases, such as the upcoming v5.10. A
>> bit of context in the form of a Q&A:
>> 
>> Q: Why do we need the I-pipe to be replaced in the first place?
>> A: Because Dovetail - as the successor to the I-pipe - addresses
>>    important implementation and maintenance issues of the latter.
>>    Maintaining two interfaces with identical goals concurrently any
>>    further would make no sense, and would keep on diluting the scarce
>>    manpower resources we have.
>> 
>> Q: Why can't we just port the I-pipe to v5.10, etc.?
>> A: Because the aging design of the I-pipe would make this a very
>>    difficult task, especially when confronted to massive code churn,
>>    like the one which took place in the v5.8 cycle for x86. Although I'm
>>    not claiming the upgrade process has become trivial, Dovetail is
>>    certainly simpler to port to newer kernel releases than doing so for
>>    the I-pipe might ever be. Dovetail tracks the kernel development tip,
>>    runs v5.10-rc4 at the moment.
>> 
>> Q: What kind of I-pipe issues does Dovetail fix?
>> A: Basically, a better integration with the mainline kernel
>>    implementation, which eases the work of rebasing it on top of newer
>>    kernel releases. It also provides crucial built-in capabilities such
>>    as time and clock source management, real-time context switching and
>>    fpu handling shared with the common kernel implementation, which
>>    the real-time core does not have to care about anymore.
>> 
>> Q: Will switching to Dovetail have an impact on applications?
>> A: No, the nitty-gritty details should live into the kernel and libcobalt,
>>    without affecting the APIs.
>> 
>> Q: Will switching to Dovetail have an impact on the Xenomai ABI?
>> A: Yes. Therefore the changes involved will be at core of Xenomai
>>    3.2+. They won't be backported to Xenomai 3.1 or earlier.
>> 
>> Q: Which CPU architectures does Dovetail support today?
>> A: aarch64, aarch32 (armv7 essentially), x86_64.
>> 
>> == Now, to the proposed broad plan for achieving this port:
>> 
>> 1- the ability to test the very same Cobalt code base on top of Dovetail
>>    or the I-pipe alternatively may go a long way toward debugging the
>>    port, particularly when it comes to spotting regressions. For
>>    achieving this, we should insert some "interrupt pipeline"
>>    abstraction layer into the Cobalt code. Depending on some build time
>>    selector, the I-pipe or Dovetail interface would be used. Initially,
>>    we could focus on having the I-pipe interface side working, which
>>    should not be prone to regression since this task is basically about
>>    moving code around, reorganizing the Cobalt code base.
>> 
>> 2- once the dust has settled on moving the code around, we need to
>>    rework the timer management layer (xntimer) in order to switch the
>>    internal date and delay representation from "clock ticks" (e.g. TSC
>>    counts, or whatever unit some time hardware might use) to plain
>>    nanoseconds, in order to align on the regular kernel representation
>>    of time values (ktime_t, which Dovetail shares). Those changes will
>>    impact libcobalt as well. Bonus: once this is done, applications may
>>    safely get time stamps from primary mode using the fast vDSO
>>    mechanism via clock_gettime() for instance. In addition, variation of
>>    the CPU frequency (CPU_FREQ) will stop being a showstopper, since our
>>    time stamps would not depend on the duration of a hardware tick
>>    anymore.
>> 
>> 3- then, we may flesh out and test the Dovetail side of the abstraction
>>    layer, comparing results to the I-pipe version, thanks to having #1
>>    done.
>> 
>> Both the I-pipe and Dovetail maintain a version targeting kernel v5.4
>> LTS. We may use this common ground for comparing results, chasing
>> regressions during the initial phase of the port. Once we are confident
>> that the Dovetail side is in good shape, we may switch it to v5.10.
>> 
>> == Where do we start from?
>> 
>> In order to bootstrap this effort, I can resurrect the code I mentioned
>> in some other thread [1], which contains some groundwork for abstracting
>> the interrupt pipeline. Looking at the changes which have been pushed to
>> the Xenomai master branch since then, pulling them into this initial
>> work may be the more tractable option, in order to complete task #1.
>
> This is fine if we consider [1] similar to [3]: a platform to get
> something building and then running. After that, a patch series against
> master needs to be shaped, already to get the y2038 related refactorings
> included (which are currently hacked away also in [3] but are now also WIP).
>

Yes. The original effort was based on #3f1ee69208b0 from master,
somewhere between 3.1-rc1 and -rc2. Gradually picking anything which has
landed on top of this over time should properly reconcile wip/dovetail
with master.

-- 
Philippe.

