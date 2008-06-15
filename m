MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18517.41596.577449.774168@domain.hid>
Date: Mon, 16 Jun 2008 01:15:08 +0200
In-Reply-To: <e4ef24880806151610s634307efi73c47695eadde067@domain.hid>
References: <e4ef24880806151540r477dbe2bq6162a7b781c60f7e@domain.hid>
	<18517.40944.439081.634345@domain.hid>
	<e4ef24880806151610s634307efi73c47695eadde067@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] CPU affinity on a per thread basis
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rob Gubler <rgubler@domain.hid>
Cc: xenomai@xenomai.org

Rob Gubler wrote:
 > On Sun, Jun 15, 2008 at 4:04 PM, Gilles Chanteperdrix <
 > gilles.chanteperdrix@xenomai.org> wrote:
 > 
 > > Rob Gubler wrote:
 > >  > Hello,
 > >  >
 > >  > I am using Xenomai 2.4.  I'd like to explicitly control which CPU a
 > >  > particular thread executes on.  The Xenomai POSIX skin documentation
 > > says to
 > >  > achieve this with
 > >  > pthread_attr_setaffinity_np(...)<%28
 > > http://www.xenomai.org/documentation/trunk/html/api/group__posix__threadattr.html#gc79718c596b9cb0fdff961eede1f5995%29
 > > >my
 > >  > thread needs to be created in the kernel space. I just want to verify
 > >  > that this can not be accomplished in a user space thread?
 > >  >
 > >  > I found a post<
 > > https://mail.gna.org/public/xenomai-help/2007-05/msg00300.html>a
 > >  > year or so ago about this that mentions CPU affinity using
 > >  > sched_setaffinity(...).  My understanding though is that this particular
 > >  > call sets the affinity for the entire process/task and doesn't allow
 > > thread
 > >  > specific CPU affinity control.  Is this true?
 > >
 > > The posix skin documentation only documents the kernel-space service,
 > > because there is no special need to implement these services in
 > > kernel-space: the libc already implements both
 > > pthread_attr_setaffinity_np and pthread_setaffinity_np
 > >
 > 
 > 
 > Thanks Gilles.  Did you mean:  "The posix skin documentation only documents
 > the kernel-space service, because there is no special need to implement
 > these services in **user-space** ..."  ??

Yes, in user-space, because they already exist there.

-- 


					    Gilles.

