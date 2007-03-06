From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-help] CAN problem continued
Date: Tue, 6 Mar 2007 16:05:03 +0100
References: <bc4264770703060003t2f7a9555o27a0f26df5a43205@domain.hid>
	<E1HOaJT-0001zs-SA@mailer.emlix.com>
	<bc4264770703060637k51d0ad99qa96b14656c2001c0@domain.hid>
In-Reply-To: <bc4264770703060637k51d0ad99qa96b14656c2001c0@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1HObDh-00060e-TM@mailer.emlix.com>
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

Hi,

now the picture becomes clearer. :)

roland Tollenaar wrote:
> Hi
>
> > > > If this is the can_id field what do the data fields say?
> > >
> > > 00 00 80 19 00 00 00 00
> > >
> > > But once again, the node is sending.
> >
> > It really, really seems that you are sending a message via your CAN
> > interface.
>
> you mean from my application?  Certainly not.

Yes, you do, and luckily you admit it later. ;)

> If this were the case I 
> presume it would appear on rtcanrecv (when I run that it shows also
> whatever my application is sending and if I run it at the same time as
> my application then it only displays what is coming in from the node).
>
> > The 0x80 states that you got an error during transmission(!),
>
> Do these errors stay resident? I have to send in the beginning to get
> the node into a mode where it will transmit PDO's it does not do so
> otherwise.

Ok, that was an important missing piece of information.

> > What are the contents of /proc/rtcan?
>
> rtcan0 rtcan1 and rtcan2 The first 2 are from the virtual can device.

Only to be absolutely sure: Please don't load the virtual device for now.

> > > May I me having problems with the BEI because of this error?
> >
> > You should not get this error when you don't send anything.
>
> Well that mystery is solved. Sorry for the confusion. I do have errors
> when I send messages (but the messages are arriving at the node
> because it responds PERFECTLY) no amount of playing with the
> termination improves matters during startup I always get the buserror
> when I am sending. Maybe it taks a whle for the bus to come up and in
> that little period there is an error. i do know that one write cycle
> is always run twice before the node responds. But this is very
> consistent behaviour.

OK, this could be an explanation for the error frames. Good news that they 
appear only during setting up the node.

>
>
> But the real-time behaviour continues to e disruppted when the node is
> rotated.

Could you do the following: Fire up rtcanrecv and send out the setup message 
to the node with rtcansend. Don't start your application during the whole 
time and watch what happens.

-- 
Sebastian

