MIME-Version: 1.0
In-Reply-To: <20150324152749.GA15125@hermes.click-hack.org>
References: <20150320181308.GA27775@hermes.click-hack.org>
 <CAKC9m6eFoRrFj_QteNeJmcbi+eir0SGzwoCTd2TVzPVuqDsiCQ@mail.gmail.com>
 <20150321131111.GA20203@hermes.click-hack.org>
 <20150321132130.GC20203@hermes.click-hack.org>
 <CAKC9m6ceEi593XX04-dLfQaVYHmQHmwe75oC+d4Qu-t9q1G9_A@mail.gmail.com>
 <550FD6CA.7080407@web.de>
 <20150323095340.GA5299@hermes.click-hack.org>
 <55101C6F.2030207@web.de>
 <20150323152540.GC5299@hermes.click-hack.org>
 <55117747.6040807@web.de>
 <20150324152749.GA15125@hermes.click-hack.org>
Date: Thu, 2 Apr 2015 01:12:11 -0700
Message-ID: <CAKC9m6e24UQg6NiYc+tJbQH-txLF6fvYKH-jca0oEnVMavmjpQ@mail.gmail.com>
From: Hongfei Cheng <hongfei@mperpetuo.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] ARMv8 (ARM64) port of Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@web.de>, xenomai@xenomai.org

Thank you all again for the clear and prompt responses, along with
the informative discussions.

A follow-up question to the kernel module(s) requiring changes for
supporting I-pipe for Aarch64/arm64: After enabling I-pipe (but with
xenomai-3 disabled) in the kernel with the ipipe-core patch for
Aarch32/arm, building the Aarch64 kernel image shows clear dependency on
I-pipe specific code in arch/arm64/kernel. This observation appears
to deviate from Gilles' earlier advice -- "there is no reason to touch
boot, kernel, mm".

Since the Aarch64 code in arch/arm64/kernel differs quite a bit from the
Aarch32 code in arch/arm/kernel, porting the ipipe-core code from
arch/arm/kernel to arch/arm64/kernel will require significant amount of
work. I'd appreciate if anyone can affirm or refute the need to touch
arch/arm64/kernel for Aarch64/arm64, before I go too far and veer off the
road.

Thanks!
Hongfei


On Tue, Mar 24, 2015 at 8:27 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Tue, Mar 24, 2015 at 03:40:07PM +0100, Jan Kiszka wrote:
> > On 2015-03-23 16:25, Gilles Chanteperdrix wrote:
> > > On Mon, Mar 23, 2015 at 03:00:15PM +0100, Jan Kiszka wrote:
> > >> There is a trend in industry towards virtual targets. That's because
> you
> > >> can do much more (and much earlier) with emulation than with real hw,
> > >> and handling is much easier (no wiring, no physical reset, free
> > >> replication of setups etc.).
> > >
> > > Being a trend does not mean this is a good idea. I still believe a
> > > lot of people using JTAG or gdb tend to see symptoms rather than
> > > real issue and misinterpret them.
> >
> > Yeah, real developers don't use debuggers or similar tools. Linus made a
> > similar statement some decade ago. He was wrong
>
> That is your opinion. Maybe he simply got fed up with that stupid
> debate and simply gave up knowing that he would never use such
> tools. Who knows ?
>
> > with this generalization
> > as well - one reason why we have kgdb upstream now. Debugging done right
> > is interactive code reading and model checking.
>
> Except that real world tool are always buggy, so when you see
> something, you waste time wondering if it is a tool bug or artefact
> or a real bug. And I am not only talking about free software, I have
> used expensive symbolic debug tools connected to JTAG, it was as
> buggy as the rest.
>
> --
>                                             Gilles.
>
