Message-ID: <461E4D9E.6090107@domain.hid>
Date: Thu, 12 Apr 2007 17:17:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <200704111656.18894.jweber@domain.hid>
	<200704120818.00897.jweber@domain.hid>
	<461E4101.1030200@domain.hid>
	<200704120957.52109.jweber@domain.hid>
In-Reply-To: <200704120957.52109.jweber@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: Jeff Weber <jweber@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Jeff Weber wrote:
> On Thursday 12 April 2007 09:24, Gilles Chanteperdrix wrote:
> 
>>instance, the Xenomai service for getting the current date is
>>rt_timer_read or clock_gettime(CLOCK_REALTIME)).
> 
> I would like to use the Xenomai clock routines.  However, these are not [yet] 
> able to stay synchronized to an external time reference, like an ntp server. 
> For my application, the ensuing drift is a problem. The Linux kernel clock is 
> able to synchronize to an external time reference.

You could call xnpod_settime "often enough". But agreed, this is not the
way these things should work.

-- 
                                                 Gilles Chanteperdrix

