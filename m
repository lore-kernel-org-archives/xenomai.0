Message-ID: <463F1BFF.1010303@domain.hid>
Date: Mon, 07 May 2007 14:30:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4639D724.5010702@domain.hid>	<1178198991.29605.54.camel@domain.hid>	<463AE79E.2090901@domain.hid>	<1178281926.29093.93.camel@domain.hid>
	<463B2A69.7080704@domain.hid> <463EE376.9030702@domain.hid>
In-Reply-To: <463EE376.9030702@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Latency calculation and test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: Xenomai-help@domain.hid, Jan Kiszka <jan.kiszka@domain.hid>

Johan Borkhuis wrote:
> void timeStampGet(clockid_t which_clock, struct timespec *curtime)
> {
>     unsigned long lo, hi, hi2;
>     unsigned long long tr;
>     long double tmpVal;
> 
>     if(hwtimer == 0)
>     {
>         clock_gettime(which_clock, curtime);

If you do not compile for Xenomai posix skin (i.e. passing
-Wl,--wrap,clock_gettime -lpthread_rt to gcc), this causes a switch to
secondary mode.

-- 
                                                 Gilles Chanteperdrix

