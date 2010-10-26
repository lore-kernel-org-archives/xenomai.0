Message-ID: <4CC665AC.5030802@domain.hid>
Date: Tue, 26 Oct 2010 07:22:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinN+KBK2B77opSCwDvb9bneObxL1+FTmmwpQGup@domain.hid>	<4CC20AD2.4060501@domain.hid>
	<AANLkTi=W0w277PctkebaC=BcTLNZeW3KMzPzp=X1isB=@mail.gmail.com>
In-Reply-To: <AANLkTi=W0w277PctkebaC=BcTLNZeW3KMzPzp=X1isB=@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Slow hard drive access in xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Pastor <peter.pastor@domain.hid>
Cc: xenomai@xenomai.org

Peter Pastor wrote:
> Hey Gilles,
> 
> Thanks for you prompt response !
> 
> I noticed that the problem of slow hard disc access does happen after
> a certain event. Right after booting xenomai "hdparam -t" gives me
> 120MB/s which is what I get when running the non-real-time kernel.
> Even when I run my real-time tasks everything seems to be fine.
> However, I just had the case that I tried to play a sound (just for
> testing) which triggered some output in the dmesg (see attached
> xenomai_problem.txt). The output of dmesg up to this point is
> contained in xenomai_fine.txt and the dmesg log of the non-real-time
> linux kernel is in dmesg_linux.txt.
> 
> I disabled the audio card again and as of now, I haven't seen that
> problem. I can't really make sense out of what dmesg spit out. Would
> be great if someone could shine some light on this. It would be great
> if someone could let me know whether disabling the sound card solved
> the problem.
> 
>>> Do you really need things like NUMA, SPARSEMEM, SECCOMP, AUDITSYSCALL,
>>> KPROBES, FTRACE, SELINUX?
> I am actually not sure what all these options mean, I also haven't
> spend time to figure things out. What impact could disabling these
> options have ? Do they decrease latency? address the problem above?
> other things?

dmesg_fine is not fine at all. The SATA drives attached to the "ioc" SAS
controller, seem to experience continuous errors. And since this
interrupt line is shared with the HDA driver, there is something
suspicious here. You can know which one of the two drivers has issues by
disabling one of them.

Also, Linux seems to complain that it sees 32 cpus whereas you limited
the number of cpus to 8.

-- 
                                                                Gilles.

