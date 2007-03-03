Message-ID: <bc4264770703030323q602f0c55s9ead5826eacad7eb@domain.hid>
Date: Sat, 3 Mar 2007 11:23:37 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] some problems using RTCAN on PEAK dongle
In-Reply-To: <45E88077.5020407@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770703021005g52d0e416i359e9de91bcd38c9@domain.hid>
	<45E88077.5020407@domain.hid>
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

Hi Wolfgang,

> # rtcanconfig -c none rtcan0
>
> Wiil be documented a.s.a.p.

Thanks.


>
> O, ah, what gets logged that often?

This message 89.5 billion times:
xeno_can: socket buffer overflow (fd=1), message discarded
each time followed by this message
xeno_can: socket buffer overflow (fd=0), message discarded

I am not sure how this happens. I write once every cycle and when I
perform a read I  read the message buffer until it is empty. This
should not be possible unless there is yet another setting that should
remove the message read from the buffer. But the way i uderstand it
one must pass the PEEK flag in order to NOT remove the message under
normal circumstances the message should be extracted from the buffer.
What am I missing?



>
> > time. Obviously everything gets sticky but I can still see that the
> > task times are being maintained and the actual applicaiton is using
> > less than 3% of the processor time.
>
> Polling too often is a typical problem of the polling method.
Well I have this same technique operational on a vxWorks system and it
works like a charm. I can't see that reading out the buffer once every
1ms can be a problem for rtcan. Can it?


>
> > Besides this simple can functionality there is nothing happening in
> > the tasks and this does not happen if I write and read on rtcan0.
> >
> > Finally after a long while of running and stopping the application I
> > get the message
> >
> > rt_dev_bind: -no space left on device.
> >
> > This bind is called before the read-call.
> >
> > Can anyone please shed some light on these issues. Much appreciated as
> > usual.
>
> Grrr, I already told you that it does not make sense to use bind and
> ioctl SSIOCGIFINDEX for every read here:
Not explicitly you haven't. :) If its any consolation it occurred to
me that this might be a problem. But only on my way home last night.

> https://mail.gna.org/public/xenomai-help/2007-02/msg00354.html. Please
> (re-)read
> http://www.xenomai.org/documentation/trunk/html/api/group__rtcan.html#Bind
> and
> http://www.xenomai.org/documentation/trunk/html/api/group__rtcan.html#gee74ae50c8ea0a6aee277c6f124a3866
> to understand why.

Are you pulling my leg? Even if I know what I am looking for the above
documentation does not make it evident that one must only bind once
for a socket and that the socket does not get "unbound" if I exit the
function it was bound in.

>
> Nevertheless, there seem to be a memory leak when re-binding the device.
> I will have a look a.s.a.p. (but it should not be a problem for your app
> when you just do it once per socket).
Doing that now, seems to have sorted the problem out. Mind you I am
not sure you have a memory leak, I did not notice the memory filling
up.


The following new issues:
If I run my loop in normal mode with nothing attached, I presume there
will be the typical CAN Errors flying around (I can see them counting
up in /proc/rtcan/rtcan2/info).  I am trying to figure out how to get
hold of them, using rtcanrecv . The documentation is difficult to use.
For example I checked up on the control modes but the only thing
hinting that there IS a third normal mode (if one does not know this)
is the word special. Please look. Also if one is looking for how to
handle errors without knowing then the assumption develops that the
CAN errors are pumped into the message buffer along with the normal
messages and that the application must sift them out using the error
masks.

If this is the case then clearly they do not come out iwth the normal
recv read because I don't see them. So this is why i have to use the
masks. How? Well I hope that studying rtcanrecv will tell.

Is the above correct? (if not detailed and complete). Because I can
only make this out from the documentation by implication and making a
couple of guesses here and there.

Perhaps these errors are the reason that the message buffer gets
overfull? They are not read out by the normal recv. Is there any way
to flush the errors out of the message buffer?


Thanks

Regards,

Roland

>
> Wolfgang.
>
> >
> > Kind regards,
> >
> >
> > Roland
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
> >
> >
>
>

