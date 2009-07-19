From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4A633A57.1090005@domain.hid>
References: <4A62D1C1.9050807@domain.hid> <4A62D2B8.8030907@domain.hid>
	<4A6337D8.7030300@domain.hid>  <4A633A57.1090005@domain.hid>
Content-Type: text/plain
Date: Sun, 19 Jul 2009 17:35:14 +0200
Message-Id: <1248017714.4228.157.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 2/3] x86-64: Work around gcc issues with
 populating syscall registers
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Petr Cervenka <grugh@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Sun, 2009-07-19 at 17:23 +0200, Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
> > Jan Kiszka wrote:
> >> gcc-4.1.3 of kubuntu has problem with proper syscall register
> >> initialization in rt_task_shadow if TLS is enabled. But it is likely
> >> that more compiler versions below 4.3 and more configuration variants
> >> are affected.
> >>
> >> This patch installs a workaround for these gcc versions which places an
> >> optimization barrier before the register variable setup. This forces gcc
> >> to actually load the registers.
> > 
> > I have tried the barrier with arm gcc, it does not work. However,
> > marking the registered clobbered instead of the memory fixes arm gcc 4.3
> > bug. So, I wonder, would not it make more sense to mark the registers as
> > clobbered by the barrier instead of memory on x86 too?
> > 
> 
> Sounds reasonable. Will give it a try later.
> 
> I just noticed that my unification patch includes some unwanted merge
> artifact, so it requires another round in any case.

So I'm discarding the pending pull request entirely. Please re-submit
when ready.

> 
> Jan
> 
-- 
Philippe.



