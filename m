MIME-Version: 1.0
From: Patrick Doyle <wpdster@domain.hid>
Date: Fri, 3 Feb 2012 15:07:55 -0500
Message-ID: <CAF_dkJCxiyMmQaK9w_udT-pR2vR8-rzEJDtzFD80bMh=U+entw@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] Get current wallclock time from RT task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

What is the easiest way to determine the current wallclock time from
within an RT task?

I see that I can call rt_timer_inquire() and get back an RT_TIMER_INFO
structure containing an RTIME type field labeled "date" and a very
promising comment "Current wallclock time".

But how do I convert that to e.g. something I could pass to ctime() to
get something reasonably close to the current wallclock time?

--wpd

