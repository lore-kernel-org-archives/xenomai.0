From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17314.54898.461639.638533@domain.hid>
Date: Fri, 16 Dec 2005 16:00:02 +0100
Subject: Re: [Xenomai-help] [testsuite/latency] intervals are much > than
	1	second
In-Reply-To: <43A2BB1F.1070707@domain.hid>
References: <b647ffbd0512160453w6baa9d4g@domain.hid>
	<43A2BB1F.1070707@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
 > Dmitry Adamushko wrote:
 > > 
 > > Hello all,
 > > e.g. it took 1 minute and 30 seconds to get 21 lines of statistics on 
 > > the screen (-p 100) but should have been ~22-23 seconds.
 > > 
 > > And the latency thread really reported the presence of collected data 21 
 > > times (through rt_sem_v()) .
 > > 
 > > So have I missed something important? any ideas are wellcome.
 > >
 > 
 > Dunno yet, but this reminds me of a trap I've been into recently that 
 > caused a massive slowdown of the latency test (v2.0.x) whilst the 
 > reported real-time activity seemed to be ok. Weird enough, actually. The 
 > explanation was that I mistakenly left the full ACPI support and SUSPEND 
 > active in my kernel config (Asus box with ICH6 chipset). Shutting them 
 > down solved the issue. I've not investigated further which one of the 
 > ACPI options or SUSPEND caused that trouble yet.

I am observing a similar issue here; after a suspend/resume cycle,
running the latency test gives low latencies and every second is at
least two seconds long.

If I load the cpufreq module, I notice that even if when suspending,
/proc/cpuinfo indicates 1.5 GHz, after resuming, it indicates 600 MHz.

So, maybe, when doing a suspend/resume cycle without the CPUFreq modules
loaded, Linux assumes that the CPU frequency remains the same whereas
ACPI/BIOS changes it ?

-- 


					    Gilles Chanteperdrix.

