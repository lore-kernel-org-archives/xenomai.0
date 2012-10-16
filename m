From: "Leopold Palomo-Avellaneda" <leo@alaxarxa.net>
Date: Tue, 16 Oct 2012 15:16:28 +0200
References: <507C8977.506@nta-inc.net> <201210161315.09263.leo@alaxarxa.net>
	<507D573F.3000601@xenomai.org>
In-Reply-To: <507D573F.3000601@xenomai.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201210161516.29107.leo@alaxarxa.net>
Subject: Re: [Xenomai] Problem with ipipe-core-3.2.21-x86-1.patch?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

A Dimarts 16 Octubre 2012, Gilles Chanteperdrix va escriure:
> On 10/16/2012 01:15 PM, Leopold Palomo-Avellaneda wrote:
> > A Dimarts 16 Octubre 2012, Gilles Chanteperdrix va escriure:
> >> On 10/16/2012 12:08 AM, Jeff Webb wrote:
> >>
> >>> I am trying to build xenomai from the xenomai-2.6.git repo under
> >>> ubuntu 12.04 on a x86_64 desktop machine.  When I try to build a
> >>> xenomai-enabled kernel from the 3.2.21 sources, the build fails with
> >>> a compile error.  (Sorry, I didn't save the error message, but I can
> >>> repeat the process if necessary.)  In order to get things to compile,
> >>> I made the following change to ipipe-core-3.2.21-x86-1.patch.  Is
> >>> this a bug?  If so, I'm wondering why no one else has run into this
> >>> one yet.  I think I built a kernel without any compiler errors under
> >>> ubuntu 10.04 using this patch, but I'm not 100% certain about that.
> >>
> >>
> >> Yep, it has been reported already, and is fixed in the 3.4 branch, not
> >> backported in 3.2 yet.
> > 
> > hi,
> > 
> > 1) does it means that this patch could be considered a backport to 3.2?
> > 
> > 2) we use orocos and their xenomai part. We have found that when we run an 
> > application in xenomai, although the framework could do it, there's no 
> > migration between cpus, and all is executed in cpu0. The main developer 
have 
> > commented that a some test isolating xenomai should be done. 
> > 
> > I have seen that the patch touch something of affinity. Some one you have 
> > experienced some trouble when you run a multithread application and all 
the 
> > threads are executed in cpu0 and no migration is done?
> 
> A migration is detrimental to determinism, so Xenomai takes the easy way
> out of this dilemna: absolutely no migration is done automatically. So,
> if you want to run a thread on a different cpu, you have to set the
> affinity yourself. It has always been that way.

We do it using the Orocos api, but it doesn't work, so we don't know if it's a 
Orocos problem or Xenomai problem.

> 
> What this patch touches is automatic migration of IRQs, which is
> necessary, when as far as I understood, the IOAPIC does not do load
> balancing correctly.

I will test it.

Regards,

Leo



-- 
--
Linux User 152692
Catalonia

