Message-ID: <49E1C43A.6060009@domain.hid>
Date: Sun, 12 Apr 2009 12:36:42 +0200
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
> The xeno-test script doesn't work when /bin/sh isn't bash. In
> particular, under Unbuntu and other recent debian derivatives,
> xeno-test doesn't work, because such distributions use dash instead of
> bash. See:
> 
>    http://en.wikipedia.org/wiki/Debian_Almquist_shell
> 
> Thus, when I run xeno-test on Ubuntu, I see the following:
> 
>    running: generate_loads 1
>    dd workload started, pids 10309 stored in /var/lock/xeno-test.10169.pids
>    10309 pts/0    00:00:00 dd
>    something died a 10309 or
>    something died a 10309 or
>    something died a 10309 or
>    ...ad infinitum...
> 
> However if I change the first line of xeno-test from "#! /bin/sh" to
> "#! /bin/bash", then the script works.
> 
> The source of the problem is an interaction between the statement:
> "eval $* &" in the following procedure, and the exit handler that is set
> up in the generate_loads() procedure.
> 
>    loudly() {
>        [ "$1" = "" ] && return
>        # run task after announcing it
>        echo; date;
>        echo running: $*
>        eval $* &                   # eval helps w complex cmds, like zegrep -E
>        wait $!
>    }
> 
> When the following statement is executed:
> 
>    loudly generate_loads $workload
> 
> "loudly" runs the generate_loads procedure as a background job (via
> the "eval $* &" statement). One of the statements in generate_loads()
> is the following:
> 
>    trap cleanup_load EXIT  # under all exit conditions
> 
> This is clearly intended to terminate the workload process when the
> xeno-test script ends. However because the background_loads procedure
> is executed as a background job (via the "eval $* &" statement of
> loudly()), the cleanup_loads() procedure is called as soon as the
> generate_loads() procedure finishes, not when the parent script that
> ran it via loudly() exits, as appears to have been intended.

No, that is the intended behaviour, as the name "cleanup_load" suggests,
cleanup_load is intended to be called when generate_load terminates. The
real problem is to know why generate_loads terminates early. Maybe you
have not installed dd ?

-- 
					    Gilles.

