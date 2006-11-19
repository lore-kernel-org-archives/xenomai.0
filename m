Message-ID: <b647ffbd0611190255g11b79febhfa0619a2bf768b01@domain.hid>
Date: Sun, 19 Nov 2006 11:55:10 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <455E022D.2000306@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_45867_608294.1163933710289"
References: <b647ffbd0611111559y8e66c37m12deb64828a85d08@domain.hid>
	<455E022D.2000306@domain.hid>
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

------=_Part_45867_608294.1163933710289
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> I see two paths now:
>
> A) If we go for atomic_inc/dec with such locking service,
> xnarch_memory_barrier__after_atomic_inc & friends will be needed anyway
> and could be already introduced now.


Yes, this would be better.



> Any thoughts?


I have already sent once to you the message, but I do it now once more. Just
to give some more stuff to think about (although, nobody seems to be
inetersted in memory-barriers :) and maybe, if I'm wrong, someone will point
it out.

**********************************************************

I just noticed that probably the code is still, at least very theoretically,
not perfectly safe.

let's consider the following scenario:

op1;

lock();
op2;
unlock();

op3;

from the Documentation/memory-barriers.txt follows that the only guarantee
here is that "b = c" is executed inside the lock-unlock section (of course,
that's what locks are up too).

But the funny thing is that non of the ops are ordered in respect to each
other!

iow, e.g. the following sequences are possible :

lock(); op1; op2; op3; lock();
or
lock(); op3; op2; op1; lock();

and moreover, pure lock/unlock (without irq disable/enable) doesn't even
imply a compiler barrier for UP.

[ read starting from the line 1150 in the above mentioned doc ]

And now apply all the said above to xnintr_detach() or even linux's
synchronize_irq(). IOW, spin_unlock() doesn't guarantee we have a mb between
element deletion and checking the active flag :)

Ok, maybe it's just in theory. e.g. lock and unlock for x86 seem to imply a
full memory barrier (and, probably, all the rest systems does the same).
Just look at definitions of mb() and spinlocks() for x86. asm("lock; some
write ops") does the trick in both cases.


Jan
>
>
>
>


-- 
Best regards,
Dmitry Adamushko

------=_Part_45867_608294.1163933710289
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>
<div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I see two paths now:<br><br>A) If we go for atomic_inc/dec with such locking service,<br>
xnarch_memory_barrier__after_atomic_inc &amp; friends will be needed anyway<br>and could be already introduced now.</blockquote><div><br>
Yes, this would be better. <br>
</div><br>
<div>&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Any thoughts?</blockquote><div><br>
I have already sent once to you the message, but I do it now once more.
Just to give some more stuff to think about (although, nobody seems to
be inetersted in memory-barriers :) and maybe, if I'm wrong, someone
will point it out.<br>
<br>
**********************************************************<br>
<br>

I just noticed that probably the code is still, at least very theoretically, not perfectly safe.<br>

<br>

let's consider the following scenario:<br>

<br>
op1;<br>

<br>
lock();<br>
op2;<br>

unlock();<br>

<br>
op3;<br>

<br>
from the Documentation/memory-barriers.txt follows that the only
guarantee here is that &quot;b = c&quot; is executed inside the lock-unlock
section (of course, that's what locks are up too).<br>

<br>

But the funny thing is that non of the ops are ordered in respect to each other!<br>

<br>

iow, e.g. the following sequences are possible :<br>

<br>

lock(); op1; op2; op3; lock();<br>

or<br>

lock(); op3; op2; op1; lock();<br>

<br>

and moreover, pure lock/unlock (without irq disable/enable) doesn't even imply a compiler barrier for UP.<br>

<br>

[ read starting from the line 1150 in the above mentioned doc ]<br>

<br>

And now apply all the said above to xnintr_detach() or even linux's
synchronize_irq(). IOW, spin_unlock() doesn't guarantee we have a mb
between element deletion and checking the active flag :)<br>

<br>

Ok, maybe it's just in theory. e.g. lock and unlock for x86 seem to
imply a full memory barrier (and, probably, all the rest systems does
the same). Just look at definitions of mb() and spinlocks() for x86.
asm(&quot;lock; some write ops&quot;) does the trick in both cases.<br>
&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Jan<br><br><br><br></blockquote></div><br><br clear="all"><br>-- <br>Best regards,
<br>Dmitry Adamushko

------=_Part_45867_608294.1163933710289--

