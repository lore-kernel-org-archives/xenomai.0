From: Jeff Weber <jweber@domain.hid>
Date: Thu, 12 Apr 2007 09:57:51 -0500
References: <200704111656.18894.jweber@domain.hid>
	<200704120818.00897.jweber@domain.hid>
	<461E4101.1030200@domain.hid>
In-Reply-To: <461E4101.1030200@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704120957.52109.jweber@domain.hid>
Subject: Re: [Xenomai-help] Linux system calls from RT kernel task
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

On Thursday 12 April 2007 09:24, Gilles Chanteperdrix wrote:
> instance, the Xenomai service for getting the current date is
> rt_timer_read or clock_gettime(CLOCK_REALTIME)).
I would like to use the Xenomai clock routines.  However, these are not [yet] 
able to stay synchronized to an external time reference, like an ntp server. 
For my application, the ensuing drift is a problem. The Linux kernel clock is 
able to synchronize to an external time reference.

	Jeff

