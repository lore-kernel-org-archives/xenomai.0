From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-help] CAN problem continued
Date: Tue, 6 Mar 2007 11:10:52 +0100
References: <bc4264770703060003t2f7a9555o27a0f26df5a43205@domain.hid>
	<E1HOUrr-0000FF-0J@mailer.emlix.com>
	<bc4264770703060129i6e74086lc2cf09b413e7c4a9@domain.hid>
In-Reply-To: <bc4264770703060129i6e74086lc2cf09b413e7c4a9@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1HOWd0-0008TE-LU@mailer.emlix.com>
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
> On 3/6/07, Sebastian Smolorz <ssm@domain.hid> wrote:
> > roland Tollenaar wrote:
> > > And i get these messages in dmessage.
> > >
> > > Assertion failed! drivers/xenomai/can/rtcan_raw.c:rtcan_tx_push:171
> > > dev->tx_socket == 0
> > > (3) TX skb still in use
> >
> > Why are you trying to send loopback messages?
>
> I'm not. Of that I am certain.

The above kernel message states it clearly. Something on your computer is 
trying to send loopback messages. The above message can *only* appear if 
loopback is activated. So please investigate this issue and switch it off.

>
> Please strip your application
>
> > down to the actual problematic situation. That means, remove all sending
> > code and deactivate CONFIG_XENO_DRIVERS_CAN_LOOPBACK.
>
> It takes 2 hours to rebuild the kernel and all the modules.

2 hours?? Why?

> I hope 
> this is not a kernel setting. loopback and listenonly capability is
> set in the kernel but I am not using it at the moment. But it is
> usefull for testing and it should not be a problem if not turned on?

So far you are right.

> It is NOT turned on.

See above. I'm not convinced.

>
> > We don't need it here.
> > Please ensure that you open only one socket and bind it once.
>
> I have ensured. I am 100000% certain that it is only called once. I
> have not touched rtcanrecv either.

Then please do me a favour and only start rtcanrecv when your CAN node is 
sending. rtcanrecv is known to work. There should not be a socket buffer 
overflow.

> The only possibility is that if I 
> start the application multimple times that the old binds do not get
> undone. What must I do to ensure that they are? How can I check for
> this?

cat /proc/xenomai/rtdm/open_fildes
shows you all open descriptors. If there are some of then although your 
application is not running then do
echo 0 > /proc/xenomai/rtdm/open_fildes
for closing FD 0,
echo 1 > /proc/xenomai/rtdm/open_fildes
for closing FD 1, etc.

>
> Start a RT
>
> > thread that does nothing else than receiving CAN messages with a blocking
> > call inside a while(1)-loop.
>
> I cannot use blocking mode unless I cahnge the design intent of my
> program. In that case I will run recv in blocking mode, write the
> messages to a buffer of my own and perform my read on my own buffer. I
> suggested doing this from the start but Wolfgang made me aware of the
> DONTWAIT flag. If I have to resort to the other method it will be
> because there is something wrong with rtcan recv functionality in non
> blocking mode.

I suggested blocking mode only for testing purpose. I don't say that you can't 
use DONTWAIT. But if you want to find your bug your application should be as 
simple as possible.

>
> I have now recompiled the kernel + modules with larger buffer AND no
> debug messaging (XENO_CAN_DEBUG something or other disabled). I have
> reduced the output of the node to give so few messages that the buffer
> overflow does not occurr anymore.

As I said in a previous mail, disabling the DEBUG option does not make the 
overflows disappear, only their reporting. If your really want to solve your 
issue then you should activate it again.

>
> I am STILL getting fluctuations in period time when I turn the encoder
> shaft. A little bit better than it used to be but not something I
> would call real-time.

Probably because the overflows still take place but are not reported any more.

> The flipping can controller is still starting up in passive mode and I
> don;t know why.

How do you get this information?

-- 
Sebastian

