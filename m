Message-ID: <4A1167E7.1080001@domain.hid>
Date: Mon, 18 May 2009 15:51:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <37f89760905180612m6de18575w82d0f2f07d95c508@domain.hid>
In-Reply-To: <37f89760905180612m6de18575w82d0f2f07d95c508@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] timer_settime issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Marcel Soulot <msoulot@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Marcel Soulot wrote:
>         // Configure the timer to expire after 10 msec...
>         timer.it_value.tv_sec = 0;
>         timer.it_value.tv_nsec = 10000;*
> **
> *        // ... and every 10 msec after that.
>         timer.it_interval.tv_sec = 0;
>         timer.it_interval.tv_nsec = 10000;*

For documentation on the struct timespec structure, see:
http://www.opengroup.org/onlinepubs/009695399/basedefs/time.h.html

-- 
                                                 Gilles.

