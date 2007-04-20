From: Jeff Weber <jweber@domain.hid>
Date: Fri, 20 Apr 2007 11:43:01 -0500
References: <200704161449.27506.jweber@domain.hid>
	<200704170821.10282.jweber@domain.hid>
	<17957.7492.656703.120363@domain.hid>
In-Reply-To: <17957.7492.656703.120363@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704201143.01336.jweber@domain.hid>
Subject: Re: [Xenomai-help] page faults
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
Cc: Xenomai Help <xenomai@xenomai.org>

On Tuesday 17 April 2007 14:17, Gilles Chanteperdrix wrote:
> Jeff Weber wrote:
>  > On Monday 16 April 2007 16:34, Gilles Chanteperdrix wrote:
>  > > Jeff Weber wrote:
>  > >  > On Monday 16 April 2007 15:43, Gilles Chanteperdrix wrote:
>  > >  > > If the fault you observe is due to an access to some memory after
>  > >  > > a call to fork or one of its derivative (such as system, popen,
>  > >  > > etc...), the patch would have copied the whole real-time process
>  > >  > > address space at fork time instead of setting up COW mappings.
>  > >  >
>  > >  > No process forks are involved.  Though mlockall() was called from
>  > >  > Linux main(), and the page fault was encountered by a separate
>  > >  > Xenomai task. Here's the task history:
>  > >
>  > > The fork may well be hidden in some library. The best way to know if
>  > > there is really no fork is to register a callback with pthread_atfork.
>  >
>  > pthread_atfork confirms that there is no fork.
>
> Ok. I am afraid you will have to help us a bit. Could you try Xenomai
> 2.3.1 in case the nocow patch magically solves your issue ?
Indeed, stepping up to:

linux-2.6.20.3
xenomai-2.3.1
ipipe-1.7-03

magically solved my page faults.

	thanks!
	Jeff

