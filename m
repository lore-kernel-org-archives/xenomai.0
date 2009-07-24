Date: Fri, 24 Jul 2009 17:25:49 +0200 (CEST)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <1248384209.3998.20.camel@domain.hid>
Message-ID: <Pine.LNX.4.62.0907241723290.11473@domain.hid>
References: <Pine.LNX.4.62.0907231644270.9450@domain.hid>
	<4A688232.6040403@domain.hid>
	<Pine.LNX.4.62.0907231741280.9450@domain.hid>
	<4A68A3F5.1000705@domain.hid>
	<Pine.LNX.4.62.0907232117060.9450@domain.hid>
	<1248380847.3998.18.camel@domain.hid> <1248384209.3998.20.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] POSIX skin,
	simple example with mutex not working...
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

Philippe,

> That was indeed a fastsync related issue; here is a workaround on top of
> 2.5-rc2 that should bring your POSIX mutexes back to life. A better fix

Thanks for the very quick fix! Your patch solves my issue with
pthread_mutex_lock(). I'm still having problems with the POSIX skin but
that'll be a topic of separate postings.

Kolja


