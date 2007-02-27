Subject: RE: [Xenomai-help] Kernel-OOps
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB01B53705@domain.hid>
References: <DD39B5C3F4963040ADC9768BE7E430CB01B5368C@is-hdq-exchange.marel.net>
	<DD39B5C3F4963040ADC9768BE7E430CB01B536B3@domain.hid>
	<1172587094.27967.10.camel@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01B53705@domain.hid>
Content-Type: text/plain
Date: Tue, 27 Feb 2007 20:03:23 +0100
Message-Id: <1172603004.10171.24.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
Cc: xenomai@xenomai.org

On Tue, 2007-02-27 at 14:51 +0000, Daniel Schnell wrote:
> Philippe Gerum wrote:
> >
> > Some usage patterns involving permanent mode switches inside a large
> > set of real-time threads that only rarely relinquish the CPU to other
> > regular Linux tasks may cause this. This is specific to 2.4 kernels.
> > I will raise this value in the next patch update. Thanks,   
> 
> I think simply increasing this value to some other magic number could
> not be enough until somebody stumbles again upon this limit. How about
> implementing a kernel configuration option with a default value
> (although it is only 2.4 specific) ? This is probably a ipipe patch
> specific option ?
> 

It's not a magic value, it means that up to 32 memory contexts may be
stalled in the drop queue at any point in time, waiting for a normal
Linux task to be switched in to flush them, while a large number of
Xenomai threads is going through frequent domain migrations. Hitting
this limit _is_ where the problem lies, not the static limit itself, and
it tells that something needs to be fixed in the application, so that it
does not starve the regular Linux activities this way.

IOW, it's ok to raise this compile-time value to account for
applications living on the edge, but we should not make a feature out of
an application design issue, by adding such a configuration knob.

-- 
Philippe.



