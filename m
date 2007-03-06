Message-ID: <bc4264770703060637k51d0ad99qa96b14656c2001c0@domain.hid>
Date: Tue, 6 Mar 2007 14:37:45 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] CAN problem continued
In-Reply-To: <E1HOaJT-0001zs-SA@mailer.emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770703060003t2f7a9555o27a0f26df5a43205@domain.hid>
	<E1HOZj9-00077R-TX@mailer.emlix.com>
	<bc4264770703060546i5de1f89cxc4af26ad1f30ec74@domain.hid>
	<E1HOaJT-0001zs-SA@mailer.emlix.com>
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

Hi

> > > If this is the can_id field what do the data fields say?
> >
> > 00 00 80 19 00 00 00 00
> >
> > But once again, the node is sending.
>
> It really, really seems that you are sending a message via your CAN interface.
you mean from my application?  Certainly not. If this were the case I
presume it would appear on rtcanrecv (when I run that it shows also
whatever my application is sending and if I run it at the same time as
my application then it only displays what is coming in from the node).

> The 0x80 states that you got an error during transmission(!),
Do these errors stay resident? I have to send in the beginning to get
the node into a mode where it will transmit PDO's it does not do so
otherwise.

 the 0x19 says
> that this error is due to not being ack'ed. So this is strange. Once again:
> Please don't execute your program but execute rtcanrecv and see what happens.
There seems to be no problem there. I also used the switch -e CAN_ERR_BUSERROR
but it only returns the PDO messages from the node. My applicaiotn
also returns them only it also sees the bus error??? Why is my
application seeing the error and rtcanrecv not?

I do know that if I look at the error count in /proc/rtcan/rtcan2/info
that it increases a bit after every start of my application by while
my application is running the count remains constant. Oops I have just
noticed that the stream I am putting out from my application only
results from startup, so I may now safely say that during running
there are no BUSERRORS.

>
> Also post your insmod line.

modprobe xeno_can_peak_dng type=epp io=0x378 irq=7


>
> What are the contents of /proc/rtcan?
rtcan0 rtcan1 and rtcan2 The first 2 are from the virtual can device.

>
> > Last sentence may be a bit ambiguous. I mean the node is sending
> > proper readings despite the CAN error.
>
> Does that mean that you are receiving correct CAN frames sent from the node
> i.e. you can verify the correct contents?
Yes. They are correct.


>
> > May I me having problems with the BEI because of this error?
>
> You should not get this error when you don't send anything.
Well that mystery is solved. Sorry for the confusion. I do have errors
when I send messages (but the messages are arriving at the node
because it responds PERFECTLY) no amount of playing with the
termination improves matters during startup I always get the buserror
when I am sending. Maybe it taks a whle for the bus to come up and in
that little period there is an error. i do know that one write cycle
is always run twice before the node responds. But this is very
consistent behaviour.


But the real-time behaviour continues to e disruppted when the node is rotated.

Does any of the above info help?

Roland

>
> --
> Sebastian
>

