Subject: Re: Xeno3-x86: system freezes with SEGFAULT
References: <89a388f9-f30b-59d5-7a6f-e46026793089@tin.it>
From: "Mauro S." <mau.salvi@tin.it>
Message-ID: <2c802ed0-30eb-1717-1cf4-904ad49af5cd@tin.it>
Date: Tue, 29 Jun 2021 14:42:13 +0200
MIME-Version: 1.0
In-Reply-To: <89a388f9-f30b-59d5-7a6f-e46026793089@tin.it>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: it-IT
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Il 28/06/21 16:33, Mauro S. via Xenomai ha scritto:
> Hi all,
> 
> I'm using Xenomai3 (master branch, commit 
> d98c99798836dd3571144203b51ff787d2108f1b) on a X86_64bit Intel Atom 
> x5-E8000 with 2GB RAM, using kernel from Xenomai repos, in Cobalt 
> coniguration.
> Just for completeness, I'm using a Yocto built filesystem (but I think 
> it doesn't matter to the issue that I'm going to describe).
> 
> Consider the simple test program attached: it creates 120 tasks that 
> does nothing than sleep. This test is compiled with the Yocto toolchain 
> using the attached makefile. Toolchain have Xenomai installed in.
> 
> (By the way, I needed to raise to 2048 the registry slots number in 
> kernel configuration: without raising this, I cannot create more than 
> 110 tasks.)
> 
> If I kill this program with TERM signal, sighandler does its work and 
> the application exits cleanly.
> 
> If I kill this application with SEGV signal (no custom sighandler 
> installed), system freezes.
> 
> If I build this application with 50 tasks, then SEGV does not cause 
> system to freeze.
> 
> Bisecting the number of tasks, SIGSEGV freezes starts with a number of 
> tasks greater than 85.
> 
> I enabled watchdog (and almost all of the debug options) in Xenomai 
> section of the kernel configuration, without success.
> 
> Are there some system limits? I checked under /proc/xenomai but all 
> seems to be OK.
> 
> Thanks in advance, regards
> 

Hi all,

update: I tested also latest commit of 5.4-x86 kernel + latest commit of 
Xenomai master branch, same behavior.

In one test, with 86 tasks active (just one more than the maximum number 
of tasks that does not freeze system), system didn't freeeze 
immediately, so I had the time to launch a `cat 
/proc/xenomai/sched/stat`. I saw that all the process task were in 
000480c0 status, consuming 0.0% CPU, except the last one (the 86th one) 
that were in 00048040 status, consuming 100% CPU (system is quad core).

In previous mail I also forgot to mention that:
- this CPU is actually used with success with Xenomai 2.6 (32bit mode)
- all dangerous settings (e.g. c-states) are off in BIOS (in fact 
Xenomai 2.6 works well)
- xeno-test is executed without errors
- latency measurements are good
- SMI workaround is applied

Thanks in advance, regards

-- 
Mauro S.

