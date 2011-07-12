Message-ID: <4E1C28E1.3090906@domain.hid>
Date: Tue, 12 Jul 2011 12:58:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAL+uwv-XzsN_+4MHXTo+SW7jAh98rf22ER4uGb5DV+HXktELOg@domain.hid>	<4E1B3988.9000907@domain.hid>	<CAL+uwv_pGnuuWir_qC+sHLn=Te6NFgrO4XUpaXjLpGZ=1-C_JQ@mail.gmail.com>	<4E1B48B8.4090007@domain.hid>	<CAL+uwv8yEu92kUAnyCq1Q3LQ9fB0EzFJQA0028nJ-hyWP0m03Q@mail.gmail.com>
	<CAL+uwv90pAbaXS0KvUhzoMz9ns1bsUjx=-WJ_SJUTSBfAuVWpQ@mail.gmail.com>
In-Reply-To: <CAL+uwv90pAbaXS0KvUhzoMz9ns1bsUjx=-WJ_SJUTSBfAuVWpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Fwd: Regarding xeno test (somethign died at 3150)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: suresh reddy <sureshreddy.balijepalli@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 07/12/2011 11:24 AM, suresh reddy wrote:
> Dear Giles,
> 
> /usr/bin/latency  results in command not found.
> 
> ubuntu@domain.hid$ sudo ./clocktest
> [sudo] password for ubuntu:
> Xenomai or CONFIG_XENO_OPT_PERVASIVE disabled.
> (modprobe xeno_nucleus?)
> ubuntu@domain.hid$ sudo ./latency
> [sudo] password for ubuntu:
> Xenomai or CONFIG_XENO_OPT_PERVASIVE disabled.
> (modprobe xeno_nucleus?)
> ubuntu@domain.hid$ modprobe xeno_nucleus
> FATAL: Module xeno_nucleus not found.
> ubuntu@domain.hid$ cd
> ubuntu@domain.hid:~$ /usr/bin
> -bash: /usr/bin: Is a directory
> ubuntu@domain.hid:~$ cd /usr/bin
> ubuntu@domain.hid$ sudo ./latency
> [sudo] password for ubuntu:
> sudo: ./latency: command not found
> ubuntu@domain.hid$
> 
> 
> But the configuration has config_XENO_OPT_PERVASIVE=y

Your user-space support is mis-compiled. See README.INSTALL for an
explanation of the ARM specific options to be passed to the configure
script.

-- 
                                                                Gilles.

