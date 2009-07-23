Date: Thu, 23 Jul 2009 21:28:52 +0200 (CEST)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <4A68A3F5.1000705@domain.hid>
Message-ID: <Pine.LNX.4.62.0907232117060.9450@domain.hid>
References: <Pine.LNX.4.62.0907231644270.9450@domain.hid>
	<4A688232.6040403@domain.hid>
	<Pine.LNX.4.62.0907231741280.9450@domain.hid>
	<4A68A3F5.1000705@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

Hi,

> However, I really think we whould fix this issue. Not having access to a

Sure, but I'm afraid I can't work much on it once I found one working
combination... I furthermore have strong problems using GDB here;
sometimes it doesn't halt at breakpoint main() but the program simply
runs over it and exits successfully, sometimes it segfaults or reboots.

> issue with a stable release of xenomai such as xenomai 2.4.8 ?

It seems to. At least the very same "try", when run on an older
uClinux-dist release from the Blackfin uClinux site (2008R1.5-RC3, with
Xenomai 2.4.0), returns zero from all mutex_lock attempts.

However, the app that I just converted to use the native API now returns
-1 from one particular rt_mutex_acquire :/ on the old dist, and
at some point reboots the target on the new...

Kolja



