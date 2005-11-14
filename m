From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] xn_pipe_create [minor]
Date: Mon, 14 Nov 2005 19:33:25 +0100
References: <OF904A8BBE.F91DE4A2-ONC12570B9.005BDDF6-C12570B9.005CB25A@datacon.at>
	<4378CBA6.6000708@domain.hid>
In-Reply-To: <4378CBA6.6000708@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511141933.26292.dmitry.adamushko@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

On Monday 14 November 2005 18:38, Philippe Gerum wrote:
> xenomai@xenomai.org

> > If you want to have some fun (and you have some time and desire for 
> > that) then go ahead :) Otherwise, no problem, I'll do that.
> > 
> 
> Please make sure to implement this at the nucleus level, and if using a 
> bitmap to locate free/busy slots, it should be large enough to handle 
> FDSETSIZE  channels, not BITS_PER_LONG.

We have xnpipe_states[XNPIPE_DEVS] array of pipe objects. Choosing a minor 
value is about choosing a free slot (minor == id of that slot) so there are 
XNPIPE_DEVS possible values. The bitmap must contain at least XNPIPE_DEVS 
bits. I don't understand what FDSETSIZE has to do here (if you mean the one 
that is used to configure select() behaviour).

> -- 
>
> Philippe.

---

Dmitry

