Message-ID: <4F049054.4000302@domain.hid>
Date: Wed, 04 Jan 2012 18:45:56 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <000301cccaed$80667540$81335fc0$@soterem.fr>	<4F046865.9000408@domain.hid>
	<000001cccafd$1c6046b0$5520d410$@soterem.fr>
In-Reply-To: <000001cccafd$1c6046b0$5520d410$@soterem.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] unresolved symbol - check the
	xenomai	installation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gregory Gosse <gregory.gosse@domain.hid>
Cc: xenomai@xenomai.org

On 01/04/2012 05:22 PM, Gregory Gosse wrote:
> I tried to install xenomai 2.4.4 but didn't go too far ( unable to prepare the kernell )
> Then I switched directly to 2.6.0 . Never used the 2.5 branch
> 
> The latency test gives me that:
> # /usr/xenomai/bin/latency -t0 -p200 -f -T50 
> Sampling period: 200 us 
> Test mode: periodic user-mode task 
> All results in microseconds 
> Minuterie d'alerte

This looks bad. Please re-run latency with no argument. If should
normally produce a report about min/average/max latency every second. If
it does not, I would recommend restarting the installation from scratch:
- first uninstalling any installed version, running "make uninstall" in
the build directory, this for xenomai 2.4.4 and 2.6.0.
- re-run prepare-kernel, recompile the kernel, leaving the xenomai
configuration options to their default value.

-- 
					    Gilles.

