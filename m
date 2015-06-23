Message-ID: <55899093.4050006@siemens.com>
Date: Tue, 23 Jun 2015 19:00:03 +0200
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
In-Reply-To: <CAOL1OyOdg9S=G412PAsiJCkaSii9Pgu17a_0=gOHaOyr=fHaDQ@mail.gmail.com>
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

On 2015-06-23 18:18, Antoine Durand wrote:
> booting with 'maxcpus=2' in my case has the same behavior than
> CONFIG_NR_CPUS=2
> the clocksource switche to refined-jiffies and system time is wrong (very
> very slow)

Ugh, reproduced something with a 4-core VM and maxcpus=2. I get a kernel
crash in __ipipe_ack_hrtimer_irq. Probably an online vs. possible cpus
issue. Will look into this.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

