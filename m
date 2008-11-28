Message-ID: <493015CD.9010000@domain.hid>
Date: Fri, 28 Nov 2008 17:01:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <200811281535.7647@domain.hid>
	<200811281536.819@domain.hid>	<200811281537.16959@domain.hid>
	<200811281538.1680@domain.hid>	<200811281539.441@domain.hid>
	<200811281540.19192@domain.hid>	<200811281541.22553@domain.hid>
	<200811281542.10754@domain.hid> <200811281542.2528@domain.hid>
In-Reply-To: <200811281542.2528@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Hang at glibc time() function call
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Petr Cervenka wrote:
> Hello, we have a problems with hanging of our real-time application.
> In fact, the computer stops to respond totally. I succeeded to find
> the exact hang position in couple of our tasks (but not all of them)
> by setting of some digital outputs of HW device: 1) The most
> real-time task with the highest priority is still running as it
> should be (100us period). 2) Some of the tasks are in "sleep" state.
> They are waiting on some event or timeout. 3) One low priority task
> seems to be blocked at glibc time() function call.
> 
> But I would like to know if it is the source of the problem or only a
> consequent. I will try to replace the time() function call with
> rt_timer_read(), but couldn't be the problem elsewhere?
> 
> Configuration: Athlon XP 4600+ linux-2.6.26.3 xenomai-2.4.5 + patch
> for proper queue deletion

Could not it be that the highest priority task is using all the CPU?

-- 
                                                 Gilles.

