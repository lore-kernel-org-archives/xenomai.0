Content-Type: text/plain; charset="us-ascii"
Date: Tue, 03 Jun 2008 16:29:47 +0200
From: "Karl Reichert" <Karl-Trampe@domain.hid>
In-Reply-To: <18504269.1212502025901.JavaMail.ngmail@domain.hid>
Message-ID: <20080603142947.115490@domain.hid>
MIME-Version: 1.0
References: <18504269.1212502025901.JavaMail.ngmail@domain.hid>
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] TSCs synchron on multi-core CPUs?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>, xenomai@xenomai.org

> Hi everybody,
> 
> I have a question concerning the time stamp counters of the Intel
> core2duo/quad CPUs.
> They will be used e.g. with the Xenomai native skin call rt_time_tsc which
> ends up in
> an assembler statement "rdtsc".
> My question is now:
> Are the values of TSC synchron with dual/quad core CPUs? Or is there a
> possible drift between
> the CPUs?
> Background of the question is:
> I want to measure the time of a event that occurs within one task.
> A second event is checked in another task on a different core. The time
> difference between the
> events has to be checked.
> Can this be done precisely with rdtsc() or is a mechanism required that
> uses the TSC of exactly one 
> core?
> 
> Thanks for all hints on that question!
> 
> Regards
> 
> Mathias

Hi Mathias,

TSC of the cores may differ: http://en.wikipedia.org/wiki/Time_Stamp_Counter

Best regards
Karl
-- 
von Karl Reichert


