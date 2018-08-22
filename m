Date: Wed, 22 Aug 2018 18:22:00 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20180822182200.15c4fe00@md1pvb1c.ad001.siemens.net>
In-Reply-To: <20180713143732.1bd0fc30@md1pvb1c.ad001.siemens.net>
References: <3319d6fa-2541-67bf-f03b-15b440a1b8a6@siemens.com>
 <20180713143732.1bd0fc30@md1pvb1c.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Eager FPU vs. recent kernels
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

Am Fri, 13 Jul 2018 14:37:32 +0200
schrieb "[ext] Henning Schild" <henning.schild@siemens.com>:

> Am Mon, 9 Jul 2018 19:48:28 +0200
> schrieb Jan Kiszka <jan.kiszka@siemens.com>:
> 
> > Hi,
> > 
> > the x86 FPU changes that so far only affected 4.14 and delayed its
> > ipipe progress on that arch. However, CVE-2018-3665 is not making it
> > a topic for every ipipe kernel (that should be kept up to date):
> > lazy FPU is history, now also for security reasons (before that
> > only for performance reasons).  
> 
> I have just reached that point in the 4.14 x86 work. And from what i
> can see right now is that it would be a good idea to look into the FPU
> thing independent of 4.14. So i will start working on that for 4.9 and
> probably 4.4 to understand what 4.14 needs.

After fighting with that topic for some time i finally came up with a
version that works for 4.9. I will turn that into a patch or a series
of patches for 4.4 and 4.9 and look at 4.14, which might be a little
different.

Henning

> Henning
> 
> > That raises the question how much the Xenomai 3 core depends on lazy
> > FPU state switching. Philippe, can you describe the general flow of
> > context switching /wrt the FPU state so far? Can we overcome lazy by
> > just replacing the current FPU functions in
> > kernel/cobalt/arch/x86/thread.c with eager ones, maybe depending on
> > some CONFIG_IPIPE_X86_HAS_EAGER_FPU compile-time dependency?
> > 
> > Thanks,
> > Jan
> >   
> 
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


