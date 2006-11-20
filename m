Message-ID: <b647ffbd0611201209s9d2348bx9579b382b12c7780@domain.hid>
Date: Mon, 20 Nov 2006 21:09:21 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <456171C7.2090006@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_62793_5487335.1164053361061"
References: <b647ffbd0611111559y8e66c37m12deb64828a85d08@domain.hid>
	<455E022D.2000306@domain.hid>
	<b647ffbd0611190255g11b79febhfa0619a2bf768b01@domain.hid>
	<456171C7.2090006@domain.hid>
Subject: [Xenomai-core] Re: [patch] memory barriers in intr.c ::
	xnintr_lock/unlock()
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

------=_Part_62793_5487335.1164053361061
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 20/11/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:

> > Ok, maybe it's just in theory. e.g. lock and unlock for x86 seem to
> imply a
> > full memory barrier (and, probably, all the rest systems does the same).
>
> > Just look at definitions of mb() and spinlocks() for x86. asm("lock;
> some
> > write ops") does the trick in both cases.
> >
>
> Well, the essence is likely that we should put a real compiler barrier
> in spinunlock so that such /potential/ leaking of post-lock code into
> the critical region can be excluded.


But some CPUs still may reorder write ops. (the ones that have write-op
queues) and a compiler barrier doesn't help here. Moreover, a spinlock (here
I'm referring to the linux one) does seem to include a compiler barrier (any
real memory barrier also implies it).

Think about it : spinlocks act as "one-way permeable barriers" and lesser
(one-side) variants of compiler barriers do not exist (it's from the same
document :) - just barrier().
So if spinlock doesn't imply a compiler barrier by default (+ (one-way where
it's available) CPU memory barrier), it's just broken.

Errr... in fact, xnlock_put() doesn't seem to be safe in this respect.
Although, nobody uses it as is. xnlock_put_irqrestore() seems to be safe
though.

xnlock_get() makes use of atomic_cmpxchg() which is mapped on linux's
cmpxchg() which, in turn, is said to be smp_mb() alike.

Ok, I'm stopping further speculations here... Back to practice, so do we go
for smp_mb__before/after_atomic_* counterparts or live it as is? I guess,
those would be more optimal.


Jan
>
>

-- 
Best regards,
Dmitry Adamushko

------=_Part_62793_5487335.1164053361061
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 20/11/06, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">jan.kiszka@domain.hid
</a>&gt; wrote:</span><div><br>
</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; Ok, maybe it's just in theory. e.g. lock and unlock for x86 seem to imply a<br>&gt; full memory barrier (and, probably, all the rest systems does the same).
<br>&gt; Just look at definitions of mb() and spinlocks() for x86. asm(&quot;lock; some<br>&gt; write ops&quot;) does the trick in both cases.<br>&gt;<br><br>Well, the essence is likely that we should put a real compiler barrier
<br>in spinunlock so that such /potential/ leaking of post-lock code into<br>the critical region can be excluded.</blockquote><div><br>
But some CPUs still may reorder write ops. (the ones that have write-op
queues) and a
compiler barrier doesn't help here. Moreover, a spinlock (here I'm
referring to the linux one) does seem to include a compiler barrier
(any real memory barrier also implies it).<br>
<br>
Think about it : spinlocks act as &quot;one-way permeable barriers&quot; and
lesser (one-side) variants of compiler barriers do not exist (it's from
the same document :) - just barrier().<br>
So if spinlock doesn't imply a compiler barrier by default (+ (one-way
where it's available) CPU memory barrier), it's just broken.<br>
<br>
Errr... in fact, xnlock_put() doesn't seem to be safe in this respect.
Although, nobody uses it as is. xnlock_put_irqrestore() seems to be
safe though.<br>
<br>
xnlock_get() makes use of atomic_cmpxchg() which is mapped on linux's cmpxchg() which, in turn, is said to be smp_mb() alike.<br><br>
Ok, I'm stopping further speculations here... Back to practice, so do
we go for smp_mb__before/after_atomic_* counterparts or live it as is?
I guess, those would be more optimal.<br>
&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Jan<br><br>
</blockquote></div><br clear="all"><br>-- <br>Best regards,
<br>Dmitry Adamushko<br>
<br>



------=_Part_62793_5487335.1164053361061--

