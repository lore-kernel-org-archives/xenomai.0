Date: Tue, 7 Oct 2014 22:45:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141007204510.GD1685@sisyphus.hd.free.fr>
References: <D059B455.193D3%shartmann@cnt.canon.com>
 <20141007203650.GC1685@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141007203650.GC1685@sisyphus.hd.free.fr>
Subject: Re: [Xenomai] SIGXCPU on pthread_mutex_unlock()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve Hartmann <shartmann@cnt.canon.com>
Cc: Xenomai <xenomai@xenomai.org>

On Tue, Oct 07, 2014 at 10:36:50PM +0200, Gilles Chanteperdrix wrote:
> On Tue, Oct 07, 2014 at 08:16:39PM +0000, Steve Hartmann wrote:
> > Hi folks,
> >
> > I'm having an issue I hope someone here might be able to shed some light on.
> >
> > I am running Xenomai 2.6.4 on linux 3.4.6.  The application has a very large source base which was not originally designed for xenomai.   I am using xenomai because of some new requirements and the addition of EtherLabs Ethercat master.
> > So in one of the original threads, which is running at PRI 0,  I have two mutexes which when unlocked throw a SIGXCPU signal.  These mutexes are only locked/unlocked in this same thread.  I have seen this happen when a mutex which is not locked has an unlock attempt.  This is not the case for this issue.
> >
> > What could I be doing which would cause a pthread_mutex_unlock to throw the SIGXCPU signal?  Any suggestions for troubleshooting techniques?
>
> When you receive the SIGXCPU signal, you should check the reason as
> demonstrated in the examples/native/sigdebug.c program.

Or see:
http://xenomai.org/2014/06/finding-spurious-relaxes/

--
					    Gilles.

