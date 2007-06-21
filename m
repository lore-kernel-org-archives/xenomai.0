From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <467A5B85.9010103@domain.hid>
References: <46782305.4080501@domain.hid>
	<b647ffbd0706201404r256038b7sbb9318cdc1746b7c@domain.hid>
	<4679A302.2060403@domain.hid>
	<b647ffbd0706210103q186c00d7wdb861759ff5c0d78@domain.hid>
	<467A42F6.8080706@domain.hid>  <467A5B85.9010103@domain.hid>
Content-Type: text/plain
Date: Thu, 21 Jun 2007 19:24:15 +0200
Message-Id: <1182446655.9709.83.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [RFC][PATCH] shirq locking rework
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2007-06-21 at 13:05 +0200, Jan Kiszka wrote:
> Jan Kiszka wrote:
> > Well, and I wonder what this xnarch_memory_barrier() at each handler
> > entry is for. Seems to be there for ages, don't see why right now.

AFAICT, this probably dates back to Xenomai 1.x, when we used to have a
threaded interrupt model. The actual code looked like as follows, and
the barrier was likely here to make sure that any change to the
interrupt hit counter was visible from any other CPU which would run the
interrupt service thread. The funny thing is that we did not have SMP
support at that time, anyway...

static void xnintr_irq_handler (unsigned irq, void *cookie)

{
    xnintr_t *intr = (xnintr_t *)cookie;
    int s = XN_ISR_SCHED_T;

    intr->hits++;

    xnarch_memory_barrier();


In short, I don't see any reason to keep this membar.

>  (The
> > kernel has a golden rule for this: no barrier without comments!)

Yeah, right. It looks like the kernel has a slew of very official golden
rules it basically does not care one dime to enforce in practice.
Looking at the code, commenting membars is surely one of them...

-- 
Philippe.



