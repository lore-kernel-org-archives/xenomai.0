MIME-Version: 1.0
In-Reply-To: <20150513180613.GE3759@hermes.click-hack.org>
References: <CAKC9m6cqL6vFttH3QJM9Z64YqHscF1QGCeP6dq5w=XepGDXgeQ@mail.gmail.com>
 <20150513180613.GE3759@hermes.click-hack.org>
Date: Mon, 18 May 2015 10:32:49 -0700
Message-ID: <CAKC9m6edtqma0t4ddUpqker1Ofx5YDyV6TUXNY3EAZnxyDu2vQ@mail.gmail.com>
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

On Wed, May 13, 2015 at 11:06 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Wed, May 13, 2015 at 12:55:46AM -0700, Hongfei Cheng wrote:
>> Hi All,
>>
>> In the document of "Porting Xenomai dual kernel to a new ARM SoC",
>> section "flow handler" states: If the flow handler is
>> =E2=80=9Chandle_edge_irq=E2=80=9D, and the system locks up when the firs=
t interrupt
>> happens, try replacing =E2=80=9Chandle_edge_irq=E2=80=9D with =E2=80=9Ch=
andle_level_irq=E2=80=9D.
>>
>> Could anyone explain why =E2=80=9Chandle_edge_irq=E2=80=9D can cause sys=
tem to hang
>> while =E2=80=9Chandle_level_irq=E2=80=9D doesn't? I searched the archive=
s but failed
>> to find any discussion on this topic.
>
> level irqs are acked and masked at interrupt controller level on
> entry, whereas edge interrupts are only acked. The Adeos patch
> unmasks the irqs at processor level after this initial ack and mask
> or ack. So, if the interrupt controller keeps the interrupt asserted
> at the processor level when the level stays the same (IOW, if the
> interrupt controller only supports the "level" behaviour), unmasking
> the interrupt line will cause the interrupt to trigger again, being
> ack again, etc... without any chance for the handler to ack the
> interrupt at device level. The fix is to use handle_level_irq so
> that the irq is masked at interrupt controller level before irqs are
> unmasked at processor level.
>
> This does not happen with an unpatched kernel, because irqs are not
> unmasked at processor level until the handler has had a chance to
> execute and ack the interrupt at device level.

Gilles, thank you for the detailed explanation.

For ARM Cortex-A9/A15/A57, can we make the following statements as to
which irq flow handler can be used for a specific interrupt:
1. An interrupt input is programmed as "level-sensitive" on the
interrupt controller (GIC): only flow handler =E2=80=9Chandle_level_irq=E2=
=80=9D
should be used at the device driver level.
2. An interrupt input is programmed as "edge-triggered" on the
interrupt controller (GIC): either "edge" or "level" flow handler can
be used at the device driver level.

Hongfei

