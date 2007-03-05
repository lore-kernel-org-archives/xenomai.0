Message-ID: <45EC55E2.90306@domain.hid>
Date: Mon, 05 Mar 2007 18:39:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] how to ensure whethere application is running
	on	Xenomai domain?
References: <38b44d590703050928u2c1c9u22797bef6e57f186@domain.hid>
In-Reply-To: <38b44d590703050928u2c1c9u22797bef6e57f186@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Saiful Khan <saiful.etc@domain.hid>
Cc: xenomai@xenomai.org

Saiful Khan wrote:
> Hello,
> 
> I have ported my GNU/Linux(Posix) application in Xenomai, and I have
> used the xenomai skin. My application is running in highest priority (99).
> 1. How can I be sure that my application is running in Xenomai/Primary
> domain with highest priority?

cat /proc/xenomai/sched

should give you a list of the threads that are actually known by xenomai.

> 2. How can I ensure whethere it is switching to secondary mode due to
> some calls like pritf()?

You have an example of using the SIGXCPU signal for this purpose here:
http://www.xenomai.org/documentation/trunk/html/api/sigxcpu_8c-example.html

This example uses the native API, if you are using the posix api, you
should replace rt_task_set_mode with pthread_set_mode_np, documented here:
http://www.xenomai.org/documentation/trunk/html/api/group__posix__thread.html#g9dd3db5524fccb05a8868b7c33ccaa79

-- 
                                                 Gilles Chanteperdrix

