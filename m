Message-ID: <bc4264770703060710l792d6173v9aec4bfeff0715d3@domain.hid>
Date: Tue, 6 Mar 2007 15:10:35 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] CAN problem continued
In-Reply-To: <E1HObDh-00060e-TM@mailer.emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770703060003t2f7a9555o27a0f26df5a43205@domain.hid>
	<E1HOaJT-0001zs-SA@mailer.emlix.com>
	<bc4264770703060637k51d0ad99qa96b14656c2001c0@domain.hid>
	<E1HObDh-00060e-TM@mailer.emlix.com>
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

Hi Sebastian,

> > rtcan0 rtcan1 and rtcan2 The first 2 are from the virtual can device.
>
> Only to be absolutely sure: Please don't load the virtual device for now.
Hell, I think its baked into my kernel so I will have to recompile.
I'll explain some other time why this is such a big issue in my case.

> > Well that mystery is solved. Sorry for the confusion. I do have errors
> > when I send messages (but the messages are arriving at the node
> > because it responds PERFECTLY) no amount of playing with the
> > termination improves matters during startup I always get the buserror
> > when I am sending. Maybe it taks a whle for the bus to come up and in
> > that little period there is an error. i do know that one write cycle
> > is always run twice before the node responds. But this is very
> > consistent behaviour.
>
> OK, this could be an explanation for the error frames. Good news that they

> > But the real-time behaviour continues to e disruppted when the node is
> > rotated.
>
> Could you do the following: Fire up rtcanrecv and send out the setup message
> to the node with rtcansend. Don't start your application during the whole
> time and watch what happens.
:( Its not one message, its about 6 can rtcanrecv run scripts?

Will get onto it now.

Roland



>
> --
> Sebastian
>

