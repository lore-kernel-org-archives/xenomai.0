References: <87r1op4jpt.fsf@xenomai.org>
 <b0ebf71e-52ca-5915-7a07-4ff17c5865fc@siemens.com>
 <CALLqZ8T_x5hJQjKnjRUxu9h0e78=WArxw3R7SDmmJTiGWryZLQ@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Xenomai 3.x over Dovetail
In-reply-to: <CALLqZ8T_x5hJQjKnjRUxu9h0e78=WArxw3R7SDmmJTiGWryZLQ@mail.gmail.com>
Date: Thu, 19 Nov 2020 15:39:02 +0100
Message-ID: <87d0094dix.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "Chen, Hongzhan" <hongzhan.chen@intel.com>, xenomai@xenomai.org


Greg Gallagher <greg@embeddedgreg.com> writes:

> On Thu, Nov 19, 2020 at 7:58 AM Jan Kiszka via Xenomai <xenomai@xenomai.o=
rg>
> wrote:
>
>> On 19.11.20 13:25, Philippe Gerum wrote:
>> >
>> > All,
>> >
>> > After some recent discussion with Jan, I'm joining the fray in order to
>> > get Xenomai rebased on Dovetail, replacing the I-pipe, the in-kernel
>> > software layer which connects the real-time (Cobalt) core to the
>> > mainline Linux implementation. The main goal is to enable Xenomai 3.x
>> > for the most recent LTS kernel releases, such as the upcoming v5.10. A
>> > bit of context in the form of a Q&A:
>> >
>> > Q: Why do we need the I-pipe to be replaced in the first place?
>> > A: Because Dovetail - as the successor to the I-pipe - addresses
>> >    important implementation and maintenance issues of the latter.
>> >    Maintaining two interfaces with identical goals concurrently any
>> >    further would make no sense, and would keep on diluting the scarce
>> >    manpower resources we have.
>> >
>> > Q: Why can't we just port the I-pipe to v5.10, etc.?
>> > A: Because the aging design of the I-pipe would make this a very
>> >    difficult task, especially when confronted to massive code churn,
>> >    like the one which took place in the v5.8 cycle for x86. Although I=
'm
>> >    not claiming the upgrade process has become trivial, Dovetail is
>> >    certainly simpler to port to newer kernel releases than doing so for
>> >    the I-pipe might ever be. Dovetail tracks the kernel development ti=
p,
>> >    runs v5.10-rc4 at the moment.
>> >
>> > Q: What kind of I-pipe issues does Dovetail fix?
>> > A: Basically, a better integration with the mainline kernel
>> >    implementation, which eases the work of rebasing it on top of newer
>> >    kernel releases. It also provides crucial built-in capabilities such
>> >    as time and clock source management, real-time context switching and
>> >    fpu handling shared with the common kernel implementation, which
>> >    the real-time core does not have to care about anymore.
>> >
>> > Q: Will switching to Dovetail have an impact on applications?
>> > A: No, the nitty-gritty details should live into the kernel and
>> libcobalt,
>> >    without affecting the APIs.
>> >
>> > Q: Will switching to Dovetail have an impact on the Xenomai ABI?
>> > A: Yes. Therefore the changes involved will be at core of Xenomai
>> >    3.2+. They won't be backported to Xenomai 3.1 or earlier.
>> >
>> > Q: Which CPU architectures does Dovetail support today?
>> > A: aarch64, aarch32 (armv7 essentially), x86_64.
>> >
>> > =3D=3D Now, to the proposed broad plan for achieving this port:
>> >
>> > 1- the ability to test the very same Cobalt code base on top of Doveta=
il
>> >    or the I-pipe alternatively may go a long way toward debugging the
>> >    port, particularly when it comes to spotting regressions. For
>> >    achieving this, we should insert some "interrupt pipeline"
>> >    abstraction layer into the Cobalt code. Depending on some build time
>> >    selector, the I-pipe or Dovetail interface would be used. Initially,
>> >    we could focus on having the I-pipe interface side working, which
>> >    should not be prone to regression since this task is basically about
>> >    moving code around, reorganizing the Cobalt code base.
>> >
>> > 2- once the dust has settled on moving the code around, we need to
>> >    rework the timer management layer (xntimer) in order to switch the
>> >    internal date and delay representation from "clock ticks" (e.g. TSC
>> >    counts, or whatever unit some time hardware might use) to plain
>> >    nanoseconds, in order to align on the regular kernel representation
>> >    of time values (ktime_t, which Dovetail shares). Those changes will
>> >    impact libcobalt as well. Bonus: once this is done, applications may
>> >    safely get time stamps from primary mode using the fast vDSO
>> >    mechanism via clock_gettime() for instance. In addition, variation =
of
>> >    the CPU frequency (CPU_FREQ) will stop being a showstopper, since o=
ur
>> >    time stamps would not depend on the duration of a hardware tick
>> >    anymore.
>> >
>> > 3- then, we may flesh out and test the Dovetail side of the abstraction
>> >    layer, comparing results to the I-pipe version, thanks to having #1
>> >    done.
>> >
>> > Both the I-pipe and Dovetail maintain a version targeting kernel v5.4
>> > LTS. We may use this common ground for comparing results, chasing
>> > regressions during the initial phase of the port. Once we are confident
>> > that the Dovetail side is in good shape, we may switch it to v5.10.
>> >
>> > =3D=3D Where do we start from?
>> >
>> > In order to bootstrap this effort, I can resurrect the code I mentioned
>> > in some other thread [1], which contains some groundwork for abstracti=
ng
>> > the interrupt pipeline. Looking at the changes which have been pushed =
to
>> > the Xenomai master branch since then, pulling them into this initial
>> > work may be the more tractable option, in order to complete task #1.
>>
>> This is fine if we consider [1] similar to [3]: a platform to get
>> something building and then running. After that, a patch series against
>> master needs to be shaped, already to get the y2038 related refactorings
>> included (which are currently hacked away also in [3] but are now also
>> WIP).
>>
>> >
>> > In terms of documentation about Dovetail, [2] is the place to look for.
>> >
>> > ---
>> >
>> > All the hard work which already took place on trying to get this port
>> > done is certainly not lost, as it helped getting more people diving in=
to
>> > the innards of the dual kernel machinery. With more people sharing this
>> > knowledge, we should be able to achieve this port quicker, and most
>> > importantly, have a better chance keeping the pace with the Linux kern=
el
>> > development in the long run.
>> >
>> > I'm looking forward to discussing this proposal, other ideas, and
>> > sharing the effort with anyone willing to contribute. The plan is to
>> > start this work shortly, so please chime in early on if you intend to
>> > discuss, help with this.
>> >
>> > Thanks,
>> >
>> > [1] https://lab.xenomai.org/xenomai-rpm.git/log/?h=3Dwip/dovetail
>> > [2] https://evlproject.org/dovetail/
>> >
>>
>> Thanks for picking this up, your knowledge of both systems will be very
>> valuable!
>>
>> Jan
>>
>> [3] https://gitlab.denx.de/Xenomai/xenomai/-/commits/wip/dovetail
>>
>> --
>> Siemens AG, T RDA IOT
>> Corporate Competence Center Embedded Linux
>>
>
> Hi,
>    I have the arm/arm64 5.4 Ipipe ported, my plan is to continue testing
> and push the branches up on the weekend.
>
>   I=E2=80=99m available to help with the port.   Tasks I can take on woul=
d be
> dependent on how much time I have available but definitely willing to help
> out.
>

Ack, thanks. The list of SoCs Dovetail is known to run on is published
at [1]. We will need a broader coverage for testing.

[1] https://evlproject.org/ports/

--=20
Philippe.

