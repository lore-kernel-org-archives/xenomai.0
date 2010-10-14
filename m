From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4CB72B5D.1070304@domain.hid>
References: <4CB06CE9.9090204@domain.hid>
	<1287070938.1628.20.camel@domain.hid>
	<4CB72B5D.1070304@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 14 Oct 2010 18:16:53 +0200
Message-ID: <1287073013.1628.25.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [forge] irqbench removal
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>, Wolfgang Grandegger <wg@domain.hid>

On Thu, 2010-10-14 at 18:10 +0200, Jan Kiszka wrote:
> Am 14.10.2010 17:42, Philippe Gerum wrote:
> > On Sat, 2010-10-09 at 15:23 +0200, Jan Kiszka wrote:
> >> Philippe,
> >>
> >> irqbench does not inherently depend on a third I-pipe domain. It is a
> >> useful testcase, the only in our portfolio that targets a peripheral
> >> device use case. In fact, it was only of the first test cases for Native
> >> RTDM IIRC.
> >>
> >> Please revert the removal and then cut out only the few parts that
> >> actually instantiate an additional domain (i.e. mode 3.
> > 
> > So, what do we do with this? Any chance we move to arch-neutral code for
> > this test?
> 
> Arch-neutral is impossible due to the inherent hardware dependency. But
> I'm waiting on some comments by Wolfgang on their work as that's
> probably the best requirements source for multi-arch support.

I mean that the bulk of the code could be made arch-neutral, with only
callouts to solve the arch-dependent/uart issues. Typically, 16550's are
not uncommon on powerpc, but we obviously don't program them via
ioports. A second level of indirection could provide the entire chip
handling, to fit other uarts, maybe?

> 
> For now the existing test should not cause any harm if cleaned up from
> the domain stuff and not built on non-x86 archs (which is already
> properly guarded for user space, the kernel driver may deserve an
> additional dependency).
> 
> Jan
> 

-- 
Philippe.



