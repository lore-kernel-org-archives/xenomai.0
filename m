Message-ID: <4A028D87.1000808@domain.hid>
Date: Thu, 07 May 2009 09:28:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF649EE419.F6596615-ONC12575AF.001F4A33-C12575AF.00268522@domain.hid>
In-Reply-To: <OF649EE419.F6596615-ONC12575AF.001F4A33-C12575AF.00268522@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] gatekeeper/0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: henning.richter@domain.hid
Cc: xenomai@xenomai.org

henning.richter@domain.hid wrote:
> Now I'm using xenomai 2.4.7 on kernel 2.6.27.19.
> 
> The sigxcpu example from xenomai is now working correctly.
> 
> After removing some outputs there are no more modeswitches in my task,
> apart from some debugging output while initilization.
> 
> But now my system is no longer stable. It freezes.

Show us /proc/interrupts, /proc/xenomai/irq, your .config if it changed.

What kind of freeze is this? Do you run in graphical or in text mode? If
in graphical mode, try and get the console output using serial console
or netconsole.

Does the system restart when you hit the keyboard?

Does the system freeze when using the latency test alone? Same question
with switchtest?

-- 
                                                 Gilles.

