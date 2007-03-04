Message-ID: <cbe23c50703040845v7125317amd915c3e199c9fd5f@domain.hid>
Date: Sun, 4 Mar 2007 17:45:54 +0100
From: "Eric Noulard" <eric.noulard@domain.hid>
Subject: Re: [Xenomai-help] syslogd breaking rt behaviour of xenomai?
In-Reply-To: <bc4264770703040818l43d966a1tba5d14fa3937c93a@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770703040818l43d966a1tba5d14fa3937c93a@domain.hid>
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
>
> Now I can make the buffer larger but that will take longer to read out
> and I don;t mind losing the messages. So how do i tell syslogd that it
> is acceptable that the buffer is overflowing to make it less busy?
>
> How could I make syslogd more quiet in general. It seems that it can
> be a major real-time destroyer?
>
> Hope someone can help.

Which process is calling syslog ? Your RT task? Another process/daemon
running on your system?

Be it with Xenomai or not, using syslog system call
in realtime application is a bad idea, moreover standard
syslogd daemon has really bad performance regarding
high volume of message.

If it is your RT task which calls syslog you  should
find a way to send message in another way.
May be adding a message queue and a non-RT task,
the RT task sends messages through message queue
and the non-RT task finally call syslog.

Your RT task may be prepared to receive
-ENOMEM if the queue if full.

You may want to try alternatives syslog daemon
implementation like syslog-ng (http://www.balabit.com/products/syslog_ng/)
which exhibits far better performance than "standard" syslogd.


-- 
Erk

