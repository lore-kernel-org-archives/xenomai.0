Message-ID: <55899613.10006@siemens.com>
Date: Tue, 23 Jun 2015 19:23:31 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <CAOL1OyMgNHaY4tgbUXM0Ytm9YnR3VGaJN-c60_5fuMayjz4aSw@mail.gmail.com>
 <558843FB.3040704@siemens.com>
 <CAOL1OyOWmGY2TFo6LaydWmeFqThHnVHNHtgk_iFZJ9aiwOM6uw@mail.gmail.com>
 <5588FA58.2080403@siemens.com>
 <CAOL1OyMJ9BS8jHWrHHVeCbP7tYJ7-Kgz6KzB4DAkBDpAGENUVA@mail.gmail.com>
 <20150623141142.GK17436@csclub.uwaterloo.ca> <55896A1A.2030408@siemens.com>
 <c2c68cadb110b6c7963aa06cadde978b.squirrel@sourcetrek.com>
 <CAOL1OyM2ViCuuD1BPRze0yhX6cSNqCRxMvu3mM=frnXA5Ly5NA@mail.gmail.com>
 <20150623160736.GL17436@csclub.uwaterloo.ca>
 <CAOL1OyOdg9S=G412PAsiJCkaSii9Pgu17a_0=gOHaOyr=fHaDQ@mail.gmail.com>
 <55899093.4050006@siemens.com>
In-Reply-To: <55899093.4050006@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] I-Pipe Tracer and linux ftrace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Antoine Durand <wanipof@gmail.com>, Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On 2015-06-23 19:00, Jan Kiszka wrote:
> On 2015-06-23 18:18, Antoine Durand wrote:
>> booting with 'maxcpus=2' in my case has the same behavior than
>> CONFIG_NR_CPUS=2
>> the clocksource switche to refined-jiffies and system time is wrong (very
>> very slow)
> 
> Ugh, reproduced something with a 4-core VM and maxcpus=2. I get a kernel
> crash in __ipipe_ack_hrtimer_irq. Probably an online vs. possible cpus
> issue. Will look into this.

Interesting: maxcpus limits the number of cores the kernel will bring
online on its own, but it does not stop the kernel from detecting more,
keeping them recorded as offline. Now userland jumps in and may decide
to bring them online as well, which happens with my recent OpenSUSE
system, not with a much older one. And that means cpu hotplugging, which
does not work when Xenomai considers those CPUs as part of the RT set.
Still, excluding the additional ones per supported_cpus mask is not
sufficient.

Anyway, what works fine here is nr_cpus=2 - clocksource TSC is chosen,
and no crash. Could you check that as well?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

