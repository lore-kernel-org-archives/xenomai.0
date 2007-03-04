Message-ID: <cbe23c50703041007i743c2babjdf914d3b2b3ced91@domain.hid>
Date: Sun, 4 Mar 2007 19:07:13 +0100
From: "Eric Noulard" <eric.noulard@domain.hid>
Subject: Re: [Xenomai-help] syslogd breaking rt behaviour of xenomai?
In-Reply-To: <bc4264770703040952x61e3c15icc8d041bf108506@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770703040818l43d966a1tba5d14fa3937c93a@domain.hid>
	<cbe23c50703040845v7125317amd915c3e199c9fd5f@domain.hid>
	<bc4264770703040952x61e3c15icc8d041bf108506@domain.hid>
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

2007/3/4, roland Tollenaar <rolandtollenaar@domain.hid>:
> > May be adding a message queue and a non-RT task,
> > the RT task sends messages through message queue
> > and the non-RT task finally call syslog.
>
> Sounds like a good idea. But first I must find out what is calling
> syslogd in the first place and stop that happening.

You are right.

> > Your RT task may be prepared to receive
> > -ENOMEM if the queue if full.
> Ah, this sounds like a lead. How would I confirm this and then how do
> I change that setting?

I think I did not tell it right.
IF YOU set up a message queue between YOUR RT task and
YOUR non-RT task that call syslog then the RT task should
be prepared to full message queue.

I'm NOT telling that full message WOULD generate syslog call
I DON'T know.

> > You may want to try alternatives syslog daemon
> > implementation like syslog-ng (http://www.balabit.com/products/syslog_ng/)
> > which exhibits far better performance than "standard" syslogd.
>
> I'd much rather just switch it off entirely when I am running my
> rt-task. If I have a problem and need to debug with it I can always
> switch on.

For this then simply try

/etc/init.d/syslogd stop

> During debugging I am not so worried about the hardness of
> the RT behaviour.
>
> Anyone know how to switch off syslogd or block all calls to it?

May be you can post the log excerpt you have in order
fo us to know where they come from?

log should show if they are coming from kernel or user process.



-- 
Erk

