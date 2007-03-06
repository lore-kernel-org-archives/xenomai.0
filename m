Message-ID: <bc4264770703060546i5de1f89cxc4af26ad1f30ec74@domain.hid>
Date: Tue, 6 Mar 2007 13:46:14 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] CAN problem continued
In-Reply-To: <E1HOZj9-00077R-TX@mailer.emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770703060003t2f7a9555o27a0f26df5a43205@domain.hid>
	<E1HOWd0-0008TE-LU@mailer.emlix.com>
	<bc4264770703060455p489f6711t49a968a49344ece3@domain.hid>
	<E1HOZj9-00077R-TX@mailer.emlix.com>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai@xenomai.org

> > The mode is empty.
> > Always. I don;t set the mode in the application and on running
> > rtcanrecv I don't specify loopback.
> >
> > What else can I do to make certain there is no listen_only mode on?
>
> You could explicitely call SIOCSCANCTRLMODE with 0.
Am now doing so. No difference.

>
> >
> > > > this is not a kernel setting. loopback and listenonly capability is
> > > > set in the kernel but I am not using it at the moment. But it is
> > > > usefull for testing and it should not be a problem if not turned on?
> > >
> > > So far you are right.
> > >
> > > See above. I'm not convinced.
> >
> > If its any consolation I have not seen that message for a while. But
> > of course I have debug messages turned off in the kernel config now.
>
> Without CONFIG_XENO_DRIVERS_CAN_DEBUG this message will never pop up.
>
> > Slight correction. I AM getting CAN errors at the moment
> > 000000088. I believe this is bus error and protocol error.
>
> If this is the can_id field what do the data fields say?
00 00 80 19 00 00 00 00

But once again, the node is sending.


>
> --
> Sebastian
>

