Message-ID: <bc4264770703060504j558de158xc37f1efa403b126b@domain.hid>
Date: Tue, 6 Mar 2007 13:04:35 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] CAN problem continued
In-Reply-To: <bc4264770703060455p489f6711t49a968a49344ece3@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770703060003t2f7a9555o27a0f26df5a43205@domain.hid>
	<E1HOUrr-0000FF-0J@mailer.emlix.com>
	<bc4264770703060129i6e74086lc2cf09b413e7c4a9@domain.hid>
	<E1HOWd0-0008TE-LU@mailer.emlix.com>
	<bc4264770703060455p489f6711t49a968a49344ece3@domain.hid>
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

Slight correction. I AM getting CAN errors at the moment
 000000088. I believe this is bus error and protocol error.

Not sure why, termination seems right and the PDO messages are coming
across perfectly.

But perhaps this will give you some ideas?

Roland

On 3/6/07, roland Tollenaar <rolandtollenaar@domain.hid> wrote:
> Hi
>  > > >
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
> > loopback is activated. So please investigate this issue and switch it off.
> The place i look is in proc/rtcan/rtcan2/info. The mode is empty.
> Always. I don;t set the mode in the application and on running
> rtcanrecv I don't specify loopback.
>
> What else can I do to make certain there is no listen_only mode on?
>
> > > this is not a kernel setting. loopback and listenonly capability is
> > > set in the kernel but I am not using it at the moment. But it is
> > > usefull for testing and it should not be a problem if not turned on?
> >
> > So far you are right.
> >
> > See above. I'm not convinced.
> If its any consolation I have not seen that message for a while. But
> of course I have debug messages turned off in the kernel config now.
>
>
> > > > Please ensure that you open only one socket and bind it once.
> > >
> > > I have ensured. I am 100000% certain that it is only called once. I
> > > have not touched rtcanrecv either.
> I think the messag overflowing is over now with the larger buffer and
> the reduced baudrate. I have discovered that the 1ms was not 1ms when
> the baudrate was at 1MB/s so that could have been the major cause for
> the overflowing.
>
> >
> > Then please do me a favour and only start rtcanrecv when your CAN node is
> > sending. rtcanrecv is known to work. There should not be a socket buffer
> > overflow.
> This can be confirmed.
>
> >
> > > The only possibility is that if I
> > > start the application multimple times that the old binds do not get
> > > undone. What must I do to ensure that they are? How can I check for
> > > this?
> >
> > cat /proc/xenomai/rtdm/open_fildes
> > shows you all open descriptors. If there are some of then although your
> > application is not running then do
> > echo 0 > /proc/xenomai/rtdm/open_fildes
> > for closing FD 0,
> > echo 1 > /proc/xenomai/rtdm/open_fildes
> > for closing FD 1, etc.
> Have checked. My application neatly alsways has 1 entry there and when
> stopped the entry neatly dissapears. I only have a single bind.
> But the message overflowing is over.
>
>
> >
> >
> > I suggested blocking mode only for testing purpose. I don't say that you can't
> > use DONTWAIT. But if you want to find your bug your application should be as
> > simple as possible.
> I have done this now. I have a thrid rt task called task3 which is
> also set to run periodically only I have placed the blocking recv
> function in there. This function puts all messages into a buffer of my
> own which I read with a light read function from the 1ms task. See
> later
>
>
> > As I said in a previous mail, disabling the DEBUG option does not make the
> > overflows disappear, only their reporting. If your really want to solve your
> > issue then you should activate it again.
> Ok. I can activate it again but before I deactivated it, the overflow
> problem was over. See above.
>
>
> >
> > Probably because the overflows still take place but are not reported any more.
> No. Certain about this. I will reconfirm becaause I have saved the
> other kernel and modules so I can easily reload them. But I just
> wanted to be sure that the messages were not the cause of the
> fluctuations.
>
>
> > > The flipping can controller is still starting up in passive mode and I
> > > don;t know why.
> >
> > How do you get this information?
> cat/proc/rtcan/rtcan2/info.
>
> Quickly reverting to current state of affairs. I now do use the
> blocking call and I have the same behaviour. It is impossible that I
> have overflowing buffers now, yet when I turn the encoder shaft the
> period times of task 1 and task2 fluctuate. task 3 is violating its
> task time all the time because obviously it is stuck in the loop in
> which I am continuously calling the blocking receive function.
>
>
> There is no obvious process that is taking up a lot of CPU time, I can
> see that there is system activity when I rotate the encoder shaft. I
> have no idea how this is possible.
>
> Maybe the violating task 3 is generating messages (which cannot be
> seen because dmesg remains quiet and I have not disabled general rt
> xenomai messages) but if that is the case why only when I let my node
> send messages when I am rotating the shaft?
>
> Are there any CAN errors that I can check for that might be causing
> this? The idea that you had yesterday regarding the acknowledge? I
> have run out of ideas, hope you have some.
>
> I will turn on the debug messaging again since that clearly was not the problem.
>
> Regards,
>
> Roland
>
>
>
> >
> > --
> > Sebastian
> >
>

