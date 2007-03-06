From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-help] CAN problem continued
Date: Tue, 6 Mar 2007 14:29:25 +0100
References: <bc4264770703060003t2f7a9555o27a0f26df5a43205@domain.hid>
	<E1HOWd0-0008TE-LU@mailer.emlix.com>
	<bc4264770703060455p489f6711t49a968a49344ece3@domain.hid>
In-Reply-To: <bc4264770703060455p489f6711t49a968a49344ece3@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1HOZj9-00077R-TX@mailer.emlix.com>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

roland Tollenaar wrote:
> Hi
>
> > > > > Assertion failed! drivers/xenomai/can/rtcan_raw.c:rtcan_tx_push:171
> > > > > dev->tx_socket == 0
> > > > > (3) TX skb still in use
> > > >
> > > > Why are you trying to send loopback messages?
> > >
> > > I'm not. Of that I am certain.
> >
> > The above kernel message states it clearly. Something on your computer is
> > trying to send loopback messages. The above message can *only* appear if
> > loopback is activated. So please investigate this issue and switch it
> > off.
>
> The place i look is in proc/rtcan/rtcan2/info.

Why do you have so many CAN interfaces? What about rtcan0 and rtcan1? Does 
your CAN hardware have several CAN ports?

> The mode is empty. 
> Always. I don;t set the mode in the application and on running
> rtcanrecv I don't specify loopback.
>
> What else can I do to make certain there is no listen_only mode on?

You could explicitely call SIOCSCANCTRLMODE with 0.

>
> > > this is not a kernel setting. loopback and listenonly capability is
> > > set in the kernel but I am not using it at the moment. But it is
> > > usefull for testing and it should not be a problem if not turned on?
> >
> > So far you are right.
> >
> > See above. I'm not convinced.
>
> If its any consolation I have not seen that message for a while. But
> of course I have debug messages turned off in the kernel config now.

Without CONFIG_XENO_DRIVERS_CAN_DEBUG this message will never pop up.

> Slight correction. I AM getting CAN errors at the moment
> 000000088. I believe this is bus error and protocol error.

If this is the can_id field what do the data fields say?

--
Sebastian

