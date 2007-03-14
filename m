From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-help] RT-Socket-CAN bus error handling (was CAN errors
	and real-time behaviour (IRQ raise forever and may lock system))
Date: Wed, 14 Mar 2007 14:24:20 +0100
References: <bc4264770703030609w188a675cj618872986ff1071c@domain.hid>
	<E1HRSws-0007cE-R3@domain.hid>
	<45F7F611.3090602@domain.hid>
In-Reply-To: <45F7F611.3090602@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1HRTSg-0001KE-5x@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

Wolfgang Grandegger wrote:
> Sebastian Smolorz wrote:
> > Wolfgang Grandegger wrote:
> >> The Socket-CAN
> >> implementation actually restarts the CAN controller after a certain
> >> amount of bus error interrupts (200 by default) which matches your first
> >> policy above. But in RT-Socket-CAN, we do not automatically re-start the
> >> device by purpose. Therefore I tend to just stop the device. It's then
> >> up to the application to restart it. What do you think?
> >
> > No fundamental objections but it would be best if an application would be
> > informed of this special situation e.g. through an error frame with the
> > meaning "controller was stopped because of a disconnected bus after
> > trying to send 200 times the same message".
>
> D'accord, but we need another error definition for it, e.g.
> CAN_ERR_BUSERROR_FLOOD.

Agreed.

> I also plan to reset the error count in case of 
> a successful transmission (counting only successive errors).

That would make sense.

-- 
Sebastian

