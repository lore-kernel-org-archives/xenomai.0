Message-ID: <48C2B543.7000307@domain.hid>
Date: Sat, 06 Sep 2008 18:52:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <C4E7FEAF.8C9%samf48@domain.hid>
In-Reply-To: <C4E7FEAF.8C9%samf48@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai kernel compile issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sam Ferguson <samf48@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Sam Ferguson wrote:
> No, I get the same error as before. Am I using the right patch?  I have an
> HP laptop with an AMD chipset in it, should I be using i386 or x86.  I've

i386 is the old branch, x86 the new one, so the one you should choose
depends on the kernel version you are using. If you are using 2.6.26,
you should definitely use x86.

> tried both now with the same problem as before.  I start the script, then
> after 2 seconds it returns me to the terminal.  I am now using xenomai-2.4.5
> and linux-2.6.26.3 with no luck.  Is there a log file generated from the
> prepare-kernel.sh script I can look at?

You can run prepare-kernel --verbose to see a bit more what the script
is doing.

But could you send me your .config file and the exact steps you follow
in private so that I can try to reproduce your issue ?

-- 
					    Gilles.

