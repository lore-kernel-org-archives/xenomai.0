Message-ID: <511B7ED3.8060106@xenomai.org>
Date: Wed, 13 Feb 2013 12:53:55 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <DC570CF5-F540-40FB-B313-596AF53EDDA2@mah.priv.at>
	<F43474DF-1ADA-4463-AF44-2B498EF3024E@mah.priv.at>
In-Reply-To: <F43474DF-1ADA-4463-AF44-2B498EF3024E@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] puzzled: running switchtest improves latency figures
 permanently
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: Schooner <schooner30@tiscali.co.uk>, sam sokolik <samco@empirescreen.com>, John Morris <john@zultron.com>, xenomai@xenomai.org

On 02/13/2013 10:26 AM, Michael Haberler wrote:

> 
> We have a report from 'the field' which we cannot make sense of.
> 
> The situation:
> - an AMD board: http://www.asus.com/Motherboard/F1A75M_PRO 
> - dmesg post boot: http://pastebin.com/38XrxNBy
> - xeno-regression-test runs well, max 32us jitter


Please do not rely on latency results with xeno-regression-test,
switchtest artificially increases latencies by locking the scheduler.
The tool to make latency benchmarks is xeno-test.

> what we observed:
> 
> 1. Problem behaviour
> ---------------------
> - boot
> - run LinuxCNC latency-test
> - observe massive spikes in latency
>  - >100uS on a 25uS thread!
>  - http://static.mah.priv.at/public/latency/skunkworks-unprimed.png


Do you get the same results with Xenomai latency test?

> now any of 2), 3) or 4) improve latency:
> - running "/usr/lib/xenomai/testsuite/switchtest -s 1000" in a separate

>  - while true; do echo "nothing" > /dev/null; done

> - the key observation: if you break by ^C out of xeno-regression-test, *latency
> figures remain low*
> - note that breaking out of xeno-regression-test left some processes running, obviously dd and ls:  http://pastebin.ca/2313116 


Yes, that is a known behaviour of dohell. Fixing this in a manner
portable accross various shell implementations proved to be a task not
as easy as it seems. So, for the sake of simplicity, we simply ignore
the problem, xeno-regression-test or xeno-test are meant to be run not
very often, so a reboot after running them, or manually kill the task is
not much of an issue.

> Any suggestions?


You have an issue with the idle loop. The three cases you mention cause
the Linux kernel never to use the idle loop:
- switchtest run with the -s argument as a (non real-time) loop
occupying 100% of the CPU.
- the shell loop does the same
- running dohell does the same.


-- 
                                                                Gilles.

