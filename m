Subject: Re: [Xenomai-help] -110 error on rt_task_send... bug?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1155480473.11108.22.camel@domain.hid>
References: <44D7EDCF.9010409@domain.hid> <44D90C41.5070307@domain.hid>
	<b647ffbd0608090235o2868571ajbe74c0b09dd27282@domain.hid>
	<1155247988.4297.52.camel@domain.hid>
	<b647ffbd0608120333j7cd4ef35q7ed00bafab35753d@domain.hid>
	<1155417252.4381.49.camel@domain.hid>  <1155480473.11108.22.camel@domain.hid>
Content-Type: text/plain
Date: Sun, 13 Aug 2006 22:24:11 +0200
Message-Id: <1155500652.4298.15.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

On Sun, 2006-08-13 at 16:47 +0200, Philippe Gerum wrote:
> On Sat, 2006-08-12 at 23:14 +0200, Philippe Gerum wrote:
> 
> > IOW, a construct like "if (synch-> ...." when returning from suspension
> > is the root of all evil. We must not depend on anything requiring such
> > dereference when resuming the thread. A way to fix this would be to
> > introduce a new thread status flag which gets raised whenever some
> > object ownership is stolen, so that we would not have to inspect the
> > synch object anymore to know about such situation, and rely on
> > potentially wrong information from the ->owner field. We would only have
> > to inspect the status flags of the thread that got "robbed" (i.e. the
> > one that resumes) and act accordingly. I will post a patch implementing
> > this, after I have solved all the related issues.
> 
> The patch below provides a more general fix to the issues introduced by
> the resource stealing feature. There is still one case where this code
> could attempt to reuse a stolen resource unsafely,

More precisely, a stolen then deleted resource, and those events must
happen while the caller of xnsynch_sleep_on has been readied from
suspension, but not yet switched in. Deletion is the issue there,
meaning that the resource might be destroyed immediately after it has
been released, without any attempt to synchronize with the next consumer
of such resource.

-- 
Philippe.



