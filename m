From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB01EB160E@is-hdq-exchange.marel.net>
References: <1178727256.11688.35.camel@domain.hid>
	<22908039.1178707932628.JavaMail.ngmail@domain.hid>
	<12120203.1178785866207.JavaMail.ngmail@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01EB160E@is-hdq-exchange.marel.net>
Content-Type: text/plain
Date: Thu, 10 May 2007 17:16:35 +0200
Message-Id: <1178810195.11688.185.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and futexes - Native API optimized
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org, "M. Koehrer" <mathias_koehrer@domain.hid>

On Thu, 2007-05-10 at 09:46 +0000, Daniel Schnell wrote:
> If so, this is really something one should try to improve, because one has to "pay" a lot
>  for the relatively unlikely event of a reschedule. And mutexes are and will/should be used a lot.
> 
> I have to support Mathias here: it is not so easy as blaming bad design of the application or the used tooling.
> One often has dependencies on legacy code / tools / external libraries.

Ack. Xenomai is very much about helping people to migrate from legacy RT
environments to Linux-based systems; this is why Xenomai has a skin
layer instead of a single wired-in interface in the first place. In that
sense, we _must_ accept the fact that such code needs to be ported with
the fewest changes that make the transition possible, basically because
even as mis-designed or sloppy as it could be, such code often has one
single very desirable property: it _works in the field_ (damnit! (c)),
and an awful lot of effort has likely been put to fix the real-world
issues which have popped during the application lifetime no one wants to
start again, and any knowledge about those bugs and how they have been
fixed has often vanished many moons ago.

To sum up, I have no problem trying hard to make some ugly legacy code
shine by mean of a smart implementation on our side, that's usual
business after all.

This is not to say that we should plumb any number of evil core
interfaces into Xenomai, or tweak the existing ones, just for making new
things as silly or ugly as they might have been in the legacy context.
But, improving the performance of mutual exclusion would _not_ impact
any Xenomai interface, but only the innards of some skins, for the best
in terms of performance. So, FWIW, I agree, we must improve this when
time allows, and yes, it should probably be high enough priority-wise in
the TODO list, especially if measurements confirm the problem.

I see two distinct improvements we could achieve:

- optimize our syscall path, between user-space and the nucleus. This
would have a positive impact on every syscall from every skin. My
feeling is that I-cache penalty is way too high presently when
dispatching syscall events within the Adeos layer. We must do so while
keeping the pipeline scheme so we could still downgrade syscalls from
the Xenomai domain to the Linux one when needed.

- implement the fast acquisition path for core Xenomai mutexes (to be
defined) in the non-contended case, using a piece of pinned memory
shared between kernel and user spaces.

-- 
Philippe.



