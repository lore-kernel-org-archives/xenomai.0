From: Thomas Necker <thomas.necker@domain.hid>
Subject: Re: Antwort: Re: [Xenomai-help] pSOS skin questions
Date: Mon, 18 Sep 2006 14:14:06 +0200
References: <OF1CB72C09.F6D4F8B3-ONC12571EA.0055805B@uk.marconicomms.com>
	<1158508252.4979.19.camel@domain.hid>
In-Reply-To: <1158508252.4979.19.camel@domain.hid>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200609181414.06234.thomas.necker@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

> I checked both tm_evafter() over the UVM and the simulator, and this
> call works as expected here, so I guess that the source of the problem
> was elsewhere (maybe the timing mode).

I meanwhile identified a problem with the systick functionality. The original
program does some short housekeeping in the systick_isr before calling
tm_tick. In Xenomai this is not handled anymore which could explain a lot of
the strange behaviour. Now here come the questions:
- The systick ist handled in Xenomai by the xnpod_announce_tick function.
  The xnpod_announce_tick is initialised using the xnpod_start_timer function
  in __uvm_skin_init. As far as I understand this all happens when the UVM
  skin is set up before a single line of my program is executed. What I would
  need is to pass a different function than XNPOD_DEFAULT_TICKHANDLER
  where my program could do its housekeeping as before and then call
  xnpod_announce_tick. Is there any way to exchange the default tick handler
  without patching Xenomai?
- The function tm_tick is implemented in the pSOS skin. I don't see the reason
  since everything seems to be taken care of by the pSOS skin initialisation.

Thomas

