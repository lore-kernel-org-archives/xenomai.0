MIME-Version: 1.0
In-Reply-To: <20150518173654.GC10686@hermes.click-hack.org>
References: <CAKC9m6cqL6vFttH3QJM9Z64YqHscF1QGCeP6dq5w=XepGDXgeQ@mail.gmail.com>
 <20150513180613.GE3759@hermes.click-hack.org>
 <CAKC9m6edtqma0t4ddUpqker1Ofx5YDyV6TUXNY3EAZnxyDu2vQ@mail.gmail.com>
 <20150518173654.GC10686@hermes.click-hack.org>
Date: Tue, 19 May 2015 10:23:36 -0700
Message-ID: <CAKC9m6d025dA-8hZ=tRS86+RP9jomraT9MKvBBDdiBNo9DUmwQ@mail.gmail.com>
From: Hongfei Cheng <hongfei@mperpetuo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai]
	=?utf-8?b?SVJRIGZsb3cgaGFuZGxlcjog4oCcaGFuZGxlX2VkZ2Vf?=
	=?utf-8?b?aXJx4oCdIHZzIOKAnGhhbmRsZV9sZXZlbF9pcnHigJ0=?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, May 18, 2015 at 10:36 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Mon, May 18, 2015 at 10:32:49AM -0700, Hongfei Cheng wrote:
>> On Wed, May 13, 2015 at 11:06 AM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>> > On Wed, May 13, 2015 at 12:55:46AM -0700, Hongfei Cheng wrote:
>> >> Hi All,
>> >>
>> >> In the document of "Porting Xenomai dual kernel to a new ARM SoC",
>> >> section "flow handler" states: If the flow handler is
>> >> =E2=80=9Chandle_edge_irq=E2=80=9D, and the system locks up when the f=
irst interrupt
>> >> happens, try replacing =E2=80=9Chandle_edge_irq=E2=80=9D with =E2=80=
=9Chandle_level_irq=E2=80=9D.
>> >>
>> >> Could anyone explain why =E2=80=9Chandle_edge_irq=E2=80=9D can cause =
system to hang
>> >> while =E2=80=9Chandle_level_irq=E2=80=9D doesn't? I searched the arch=
ives but failed
>> >> to find any discussion on this topic.
>> >
>> > level irqs are acked and masked at interrupt controller level on
>> > entry, whereas edge interrupts are only acked. The Adeos patch
>> > unmasks the irqs at processor level after this initial ack and mask
>> > or ack. So, if the interrupt controller keeps the interrupt asserted
>> > at the processor level when the level stays the same (IOW, if the
>> > interrupt controller only supports the "level" behaviour), unmasking
>> > the interrupt line will cause the interrupt to trigger again, being
>> > ack again, etc... without any chance for the handler to ack the
>> > interrupt at device level. The fix is to use handle_level_irq so
>> > that the irq is masked at interrupt controller level before irqs are
>> > unmasked at processor level.
>> >
>> > This does not happen with an unpatched kernel, because irqs are not
>> > unmasked at processor level until the handler has had a chance to
>> > execute and ack the interrupt at device level.
>>
>> Gilles, thank you for the detailed explanation.
>>
>> For ARM Cortex-A9/A15/A57, can we make the following statements as to
>> which irq flow handler can be used for a specific interrupt:
>> 1. An interrupt input is programmed as "level-sensitive" on the
>> interrupt controller (GIC): only flow handler =E2=80=9Chandle_level_irq=
=E2=80=9D
>> should be used at the device driver level.
>> 2. An interrupt input is programmed as "edge-triggered" on the
>> interrupt controller (GIC): either "edge" or "level" flow handler can
>> be used at the device driver level.
>
> I believe on cortex A9, the GIC irqs are of the "fasteoi" type.
> Which is a kind of level, but requires more patching of the irq
> controller routines. Is not that code shared between 32 and 64 bits?

The GIC code is indeed shared between AArch32 and AArch64. However on
our ARMv8 platform, only parts of the SPIs, 32~447, are initialized
and mapped to fasteoi. The rest of the SPIs, 448~639, are for platform
specific peripheral drivers. These drivers use handle_level_irq and
handle_edge_irq as flow handlers.

What we are seeing is that, when I-pipe is enabled, some of the
platform specific peripheral drivers receive numerous interrupts which
are nonexistent when I-pipe is disabled. At first glance, such problem
appears to match the pattern of using "handle_edge_irq" for
level-triggered interrupts at the GIC. However the number of the
"bogus" interrupts (per second) are only in the 100s. The handlers in
the device drivers still have chance to process these interrupts.

Here is a partial call stack:
<peripheral-driver-irq-mask>+0xc/0x18
gic_hold_irq+0xb8/0x134
__ipipe_ack_fasteoi_irq+0x14/0x20
__ipipe_dispatch_irq+0x90/0x2a8
__ipipe_grab_irq+0x5c/0x74

Does this call stack look correct to you? Any idea as to the cause of
such problem?

Thanks,
Hongfei

