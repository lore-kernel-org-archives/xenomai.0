Message-ID: <bc4264770703040952x61e3c15icc8d041bf108506@domain.hid>
Date: Sun, 4 Mar 2007 17:52:08 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] syslogd breaking rt behaviour of xenomai?
In-Reply-To: <cbe23c50703040845v7125317amd915c3e199c9fd5f@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770703040818l43d966a1tba5d14fa3937c93a@domain.hid>
	<cbe23c50703040845v7125317amd915c3e199c9fd5f@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Eric Noulard <eric.noulard@domain.hid>
Cc: xenomai@xenomai.org

Hi

> Which process is calling syslog ? Your RT task? Another process/daemon
> running on your system?

I don't  know. Before this started happening I was never aware of
syslogd. I certainly never called it myself explicitly. Apparently it
is called by something monitoring the CAN message buffer? Don't know.

>
> Be it with Xenomai or not, using syslog system call
> in realtime application is a bad idea,

evidently.

>moreover standard
> syslogd daemon has really bad performance regarding
> high volume of message.
Ok.

>
> If it is your RT task which calls syslog you  should
> find a way to send message in another way.

Its not me. Or not that I know of.

> May be adding a message queue and a non-RT task,
> the RT task sends messages through message queue
> and the non-RT task finally call syslog.

Sounds like a good idea. But first I must find out what is calling
syslogd in the first place and stop that happening.

>
> Your RT task may be prepared to receive
> -ENOMEM if the queue if full.
Ah, this sounds like a lead. How would I confirm this and then how do
I change that setting?


>
> You may want to try alternatives syslog daemon
> implementation like syslog-ng (http://www.balabit.com/products/syslog_ng/)
> which exhibits far better performance than "standard" syslogd.

I'd much rather just switch it off entirely when I am running my
rt-task. If I have a problem and need to debug with it I can always
switch on. During debugging I am not so worried about the hardness of
the RT behaviour.

Anyone know how to switch off syslogd or block all calls to it?

Thanks.

Regards,

Roland.


>
>
> --
> Erk
>

