From: Paul <paul_c@domain.hid>
Subject: Re: [Adeos-main] port 2.6.19 x86_64 to 2.6.20
Date: Fri, 30 Mar 2007 11:16:35 +0100
References: <45E220D7.6060004@domain.hid> <45EB0295.5070506@domain.hid>
	<1174843188.5612.4.camel@domain.hid>
In-Reply-To: <1174843188.5612.4.camel@domain.hid>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200703301116.35813.paul_c@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org, rpm@xenomai.org

On Sunday 25 March 2007 18:19, Philippe Gerum wrote:
> > The patch (2.6.20 x86_64) can be found here :
> > http://zarb.org/~trem/adeos-ipipe-2.6.20-x86_64-1.7-07-trem.patch
> >
> > I hope it could be used.
>
> Merged, thanks. This upgrade is now available from the Adeos GIT repo
> and Xenomai's SVN trunk.

Attempting to compile against 2.6.20.4, hit a couple of minor snags.. Two 
includes in kernel/ipipe/tracer.c. linux/ipipe.h for __ipipe_pipeline and 
linux/sched.h for tasklist_lock - Also needed to insert an extern for cpu_khz 
in asm-x86_64/ipipe.h (no diffs available I'm afraid)..

It looks like the kernel developers are starting to clean up the rats nest of 
includes, so I suspect there are going to be more "undefined variable" errors 
cropping up in the future.


The 2.6.20.4 packages are available on http://zathras.tuxcnc.org/xenomai if 
anyone would like to test - Latest builds use r2340 trunk from SVN.


Regards, Paul.

