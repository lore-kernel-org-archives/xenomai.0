From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-help] CAN problem continued
Date: Tue, 6 Mar 2007 15:06:57 +0100
References: <bc4264770703060003t2f7a9555o27a0f26df5a43205@domain.hid>
	<E1HOZj9-00077R-TX@mailer.emlix.com>
	<bc4264770703060546i5de1f89cxc4af26ad1f30ec74@domain.hid>
In-Reply-To: <bc4264770703060546i5de1f89cxc4af26ad1f30ec74@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1HOaJT-0001zs-SA@mailer.emlix.com>
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
> > > Slight correction. I AM getting CAN errors at the moment
> > > 000000088. I believe this is bus error and protocol error.
> >
> > If this is the can_id field what do the data fields say?
>
> 00 00 80 19 00 00 00 00
>
> But once again, the node is sending.

It really, really seems that you are sending a message via your CAN interface. 
The 0x80 states that you got an error during transmission(!), the 0x19 says 
that this error is due to not being ack'ed. So this is strange. Once again: 
Please don't execute your program but execute rtcanrecv and see what happens.

Also post your insmod line.

What are the contents of /proc/rtcan?

> Last sentence may be a bit ambiguous. I mean the node is sending
> proper readings despite the CAN error.

Does that mean that you are receiving correct CAN frames sent from the node 
i.e. you can verify the correct contents?

> May I me having problems with the BEI because of this error?

You should not get this error when you don't send anything.

-- 
Sebastian

