Message-ID: <499A830C.3070803@domain.hid>
Date: Tue, 17 Feb 2009 10:27:40 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <9c789a000902160455k7dcae1d2tc151b12df6140ec0@domain.hid>
	<200902170000.00900.berlemont.hauw@domain.hid>
In-Reply-To: <200902170000.00900.berlemont.hauw@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Comedi drivers in Xenomai porting/integration
	status ?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: xenomai@xenomai.org

Alexis Berlemont wrote:
> Hi,
> 
>> Hello all! I would like to know what is the current status of the Comedi
>> port to Xenomai.
>>
>> Should all the specific Comedi drivers (ni_pcimio, ni_mite) be available
>> for testing (by me or someone with a supported DAQ card) and (if ok) for
>> futher integration ?
> 
> I am still working on that port. It is a long work and I am wondering at each 
> line whether I should rewrite any part of code which does not comply with 
> common coding constraints. Unfortunately, I currently do not have a lot of 
> spare time. Anyway, most of the ni subdevices drivers have been ported (mite, 
> tio, mio, 8255). I am trying to finalize the global driver port.
> 
> By the way, in the middle of january, I noticed that the legacy Comedi branch 
> found its way into the mainline (through the staging tree). I do not know 
> what will be the future of such a package in mainstream. I assume the main 
> goal is the definition of a global framework for acquisition boards like V4L2 
> is for video cards. 
> 
> Starting from here, I have been thinking on some alternatives so as to benefit 
> from the kernel code. But I am a bit perplexed as the code does not seem to 
> evolve a lot (the 2.6.29-rc5 patch still contains some rtlinux/rtai/fusion 
> related code). I was unable to notice any significant work on the framework 
> to reach main kernel standards.
> 
> Since the beginning of January, there was only one mail thread which dealt 
> with Comedi on the lkml (which is, by the way, interesting): 
> http://lkml.org/lkml/2009/2/9/335

The staging tree does not start an automatic merging process. Unless the
original maintainers or some new pusher (don't count on GKH for this)
step in and work with the kernel people to address remaining issues
beyond coding style, staging may also be a dead end (specifically if the
project is adding a new user space interface that always needs extra
care). For larger projects like comedi, I would say staging is more of a
test if someone is serious about mainlining it.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

