Date: Fri, 14 Aug 2009 12:08:49 +0200 (CEST)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <4A853707.10509@domain.hid>
Message-ID: <Pine.LNX.4.62.0908141206480.14595@domain.hid>
References: <Pine.LNX.4.62.0908141030170.14595@domain.hid>
	<4A853707.10509@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] T_WARNSW ignored?
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


> I do not know if that may be your issue, but gdb cause mode switches,

That explains the SIGXCPU after SIGINT.

> to run your application outside gdb and see if the MSW increments.

It does. But no XCPU occurs, neither when started via GDB nor when run
standalone...

Kolja


