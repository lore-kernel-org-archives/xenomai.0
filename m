Subject: Re: clocksource 'tsc' marked unstable, CLOCK_HOST_REALTIME went
 bananas
References: <76739224.1358458.1553762865210.JavaMail.zimbra@wolfram.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ed17fd73-1e56-b786-8ddd-5e3b9fda4219@siemens.com>
Date: Tue, 2 Apr 2019 13:05:34 +0200
MIME-Version: 1.0
In-Reply-To: <76739224.1358458.1553762865210.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Per Oberg <pero@wolfram.com>, xenomai <xenomai@xenomai.org>

On 28.03.19 09:47, Per Oberg via Xenomai wrote:
> Hello list!
> 
> I am running Xenomai 3.0.7. released version with Kernel 4.9.90 patchlevel 6.
> 
> We have a new x86-64 hardware, and during a test-run the clocksource went unstable, see (1) below for dmesg.
> 
> After this, calls to "clock_gettime(CLOCK_HOST_REALTIME,&timeStamp)"  went bananas. Like if time stopped completely, (or possibly jumped back in time at least a few hours). Stuff running on timers (using CLOCK_MONOTONIC)kept running fine. I tried switching time to hpet using "clocksource=hpet" but this didn't work at all. Either time (CLOCK_HOST_REALTIME) jumped back and forth or it completely stopped.  Now I'm using "tsc=reliable" and haven't seen any issues since.
> 
> I think I know why tsc may be deemed unreliable, but why can't I run using hpet?
> 

The TSC may be detected as unreliable by Linux if a the RT application disturbs 
the detection algorithm too much (e.g. via long-running RT workload). You can 
let it switch to HPET, but CLOCK_HOST_REALTIME will no longer work, as you 
noticed, because it assumes that Linux is using TSC as clocksource.

> What are the drawbacks for xenomai with using tsc=reliable ?
> 

Practically, none, provided your tsc is actually reliable. If not, also Xenomai 
and its RT applications would have serious problems.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

