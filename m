Message-ID: <49E1C2F9.1070509@domain.hid>
Date: Sun, 12 Apr 2009 12:31:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <Pine.LNX.4.64.0904081243120.22300@domain.hid>	<Pine.LNX.4.64.0904081659110.22300@domain.hid>
	<Pine.LNX.4.64.0904101250540.4820@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0904101250540.4820@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xeno-test bug
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Martin Shepherd <mcs@domain.hid>
Cc: xenomai@xenomai.org

Martin Shepherd wrote:
> To work around the problem for now, people running xeno-test on
> systems that have bash, can change "#! /bin/sh" at the top of the
> xeno-test script to "#! /bin/bash", or run it under busy-box.

That is not acceptable. We have to get xeno-test to run in embedded
environment where bash is not available. We alread fixed a few bash-ism,
we will fix all of them, that is all.

> 
> Alternatively, edit xeno-test and remove the following lines:
> 
>      if test 0 -eq $withBusybox ; then
>          reaper() { echo something died a $! or $* ; sleep 1;  }
>          trap reaper CHLD
>          trap cleanup_load EXIT  # under all exit conditions
>      fi

It looks like this problem was already worked around to run xeno-test
with busybox' ash, so why not renaming the withBusyBox variable notBash,
and set it to 1 also in the case of dash ?

-- 
					    Gilles.

