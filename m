Date: Mon, 20 Apr 2009 15:13:10 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
In-Reply-To: <49ECBEE6.2060201@domain.hid>
Message-ID: <Pine.LNX.4.64.0904201444200.26654@domain.hid>
References: <Pine.LNX.4.64.0904201026330.23588@domain.hid>
	<49ECBEE6.2060201@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Xenomai-help] Success! (was Re: Tests with 2.5rc1)
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


On Mon, 20 Apr 2009, Gilles Chanteperdrix wrote:
>...and should try to disable high
> res timers to see if it helps further.

Excellent suggestion. This has completely fixed the problem. To be
precise, starting with the config of the last problematic kernel, I
toggled off the high-res timer option in menuconfig, recompiled the
kernel, and booted into the new kernel.  I have now booted twice into
the resulting kernel, and have been unable to provoke a single hang in
either case, whereas before this change, I could reliably always
provoke a hang within a few seconds of running "dd if=/dev/zero
of=/dev/null". I have also now run xeno-test twice, all the way
through, for the first time.

Do you have any idea why having the high-resolution timers option
enabled was causing the system to hang?

Thankyou for the help,

Martin

