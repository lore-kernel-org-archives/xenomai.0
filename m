Date: Mon, 9 Feb 2009 17:50:09 +0100
From: Tom Schouten <tom@domain.hid>
Message-ID: <20090209165009.GD12938@domain.hid>
References: <20090204141542.GA9557@domain.hid>
	<20090204161903.GA27688@domain.hid>
	<20090205093528.GC11556@domain.hid>
	<498D56C7.7020504@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <498D56C7.7020504@domain.hid>
Subject: Re: [Xenomai-help] posix shm problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Sat, Feb 07, 2009 at 10:39:19AM +0100, Gilles Chanteperdrix wrote:
> Tom Schouten wrote:
> > Hello,
> > 
> > I tried with a different kernel .config (right.config) which made the 
> > userspace posix shm problem go away.  The significant difference I can see 
> > is this:
> > 
> > ## cat right.config |grep SHM
> > CONFIG_SHMEM=y
> > # CONFIG_TINY_SHMEM is not set
> > # CONFIG_XENO_OPT_POSIX_SHM is not set
> 
> Ok. In this case, you use Linux' shared memories, not xenomai's.
> 

Aha.  

Does this have any impact on real-time behaviour after the memory is 
mapped?

> There is something I do not understand, though. Is right.config the
> config that you use with 2.4.4 too ?

Yes.. 

> Just to know if the problem comes
> from recent changes or has always been there.
> 

So I guess this report is not very informative..  I didn't try to
enable CONFIG_XENO_OPT_POSIX_SHM on 2.4.4, only with the newer Xenomai 
versions.

