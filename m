Subject: Re: Antwort: Re: [Xenomai-help] pSOS skin questions
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200609181414.06234.thomas.necker@domain.hid>
References: <OF1CB72C09.F6D4F8B3-ONC12571EA.0055805B@uk.marconicomms.com>
	<1158508252.4979.19.camel@domain.hid>
	<200609181414.06234.thomas.necker@domain.hid>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 15:35:56 +0200
Message-Id: <1158586556.5009.19.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Thomas Necker <thomas.necker@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-09-18 at 14:14 +0200, Thomas Necker wrote:
> > I checked both tm_evafter() over the UVM and the simulator, and this
> > call works as expected here, so I guess that the source of the problem
> > was elsewhere (maybe the timing mode).
> 
> I meanwhile identified a problem with the systick functionality. The original
> program does some short housekeeping in the systick_isr before calling
> tm_tick. In Xenomai this is not handled anymore which could explain a lot of
> the strange behaviour. Now here come the questions:
> - The systick ist handled in Xenomai by the xnpod_announce_tick function.
>   The xnpod_announce_tick is initialised using the xnpod_start_timer function
>   in __uvm_skin_init. As far as I understand this all happens when the UVM
>   skin is set up before a single line of my program is executed. What I would
>   need is to pass a different function than XNPOD_DEFAULT_TICKHANDLER
>   where my program could do its housekeeping as before and then call
>   xnpod_announce_tick. Is there any way to exchange the default tick handler
>   without patching Xenomai?

No, actually old Xenomai versions used to allow that, but this became a
real pain maintaining such typical RTOS "feature", with the current
global one-timer-for-all-skins approach.

If you want to do that right now, you could override the initial timer
setup using xnpod_stop_timer(), then install your primary handler using
xnpod_start_timer() again from your app init code, then make sure to
call XNPOD_DEFAULT_TICKHANDLER at the end of your primary handler. It's
a hack, but this should work, including over the UVM.

> - The function tm_tick is implemented in the pSOS skin. I don't see the reason
>   since everything seems to be taken care of by the pSOS skin initialisation.

Because you could still hook a foreign interrupt to get the timing and
inform the nucleus about incoming ticks that way, provided you stop the
initial timer.

> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



