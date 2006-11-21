Message-ID: <b647ffbd0611210132r3002191bj2cca5df3dcd5b861@domain.hid>
Date: Tue, 21 Nov 2006 10:32:49 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <45623D01.9000404@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_72193_1458947.1164101569859"
References: <b647ffbd0611111559y8e66c37m12deb64828a85d08@domain.hid>
	<455E022D.2000306@domain.hid>
	<b647ffbd0611190255g11b79febhfa0619a2bf768b01@domain.hid>
	<456171C7.2090006@domain.hid>
	<b647ffbd0611201209s9d2348bx9579b382b12c7780@domain.hid>
	<45623D01.9000404@domain.hid>
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

------=_Part_72193_1458947.1164101569859
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> > Think about it : spinlocks act as "one-way permeable barriers" and
> lesser
> > (one-side) variants of compiler barriers do not exist (it's from the
> same
> > document :) - just barrier().
> > So if spinlock doesn't imply a compiler barrier by default (+ (one-way
> > where
> > it's available) CPU memory barrier), it's just broken.
>
> As we learned, spin-unlock comes with a one-way barrier. I was referring
> two a full compiler barrier to avoid reordering of post-lock with
> in-lock code.


There is no one-way "compiler barrier".

Or is it even a memory barrier? I hate this. It confuses me.


(1) "compiler barrier" - prevents a compiler from reordering load/store
operations;

(2) "memory barrier" (real CPU memory barrier) - prevents a CPU from doing
the same.

For the spinlocks to be able to guarantee (at least) a "one-way" barrier,
both (1) and (2) have to be combined to achive that goal.

Now, as I said above (it's according to the memory-barrirers doc), there is
just _no_ one-way compiler barrier. So (1) implies the use of barrier() -
which is a "full" compiler barrier.

Moreover, one may consider a memory barrier (2) as a "stronger" version of
the compiler barrier. IOW, a memory barrier (2) is always used in pair with
the compiler one (1).
Otherwise, one asks a CPU not to do reordering but a compiler still may do
it under the hood.
The other way around is not always true, a compiler barrier can be used
without the memory one.


Well, I guess it's best to leave xnlocks as they are (when they really
> match Linux characteristics) and put the required but missing barrier
> for xnintr_synchronize() explicitly into the code. To play save (and as
> performance is not important in that path), we can use a memory barrier.


Yes, I agree here.

> xnlock_get() makes use of atomic_cmpxchg() which is mapped on linux's
> > cmpxchg() which, in turn, is said to be smp_mb() alike.
>
> My whole feeling on the xnlock is not that positive. Maybe it would be
> good to go through all "home-made" locking primitives with barriers in
> mind and an eye on the Linux implementation.


Ack.



> Ok, I'm stopping further speculations here... Back to practice, so do we
> go
> > for smp_mb__before/after_atomic_* counterparts or live it as is? I
> guess,
> > those would be more optimal.
> >
>
> As I said, I'm still not sure if we finally need it when we may use
> per-cpu counters for efficiency reasons on the long-term. If this will
> add code or - even more important - an interface (of the system layer)
> that will soon be removed again...


So could you reveal your vision of per-cpu counters in this scenario (or
something in linux does use it under similar circumstances.. RCU?) At the
first glance, it doesn't seem to be much better. Although, I haven't
elaborated more thoroughly yet...


Jan
>
>
>
>


-- 
Best regards,
Dmitry Adamushko

------=_Part_72193_1458947.1164101569859
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; Think about it : spinlocks act as &quot;one-way permeable barriers&quot; and lesser
<br>&gt; (one-side) variants of compiler barriers do not exist (it's from the same<br>&gt; document :) - just barrier().<br>&gt; So if spinlock doesn't imply a compiler barrier by default (+ (one-way<br>&gt; where<br>&gt; it's available) CPU memory barrier), it's just broken.
<br><br>As we learned, spin-unlock comes with a one-way barrier. I was referring<br>two a full compiler barrier to avoid reordering of post-lock with<br>in-lock code.</blockquote><div><br>
There is no one-way &quot;compiler barrier&quot;.&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"> Or is it even a memory barrier? I hate this. It confuses me.
</blockquote><div><br>
(1) &quot;compiler barrier&quot; - prevents a compiler from reordering load/store operations;<br>
<br>
(2) &quot;memory barrier&quot; (real CPU memory barrier) - prevents a CPU from doing the same.<br>
<br>
For the spinlocks to be able to guarantee (at least) a &quot;one-way&quot;
barrier, both (1) and (2) have to be combined to achive that goal.<br>
<br>
Now, as I said above (it's according to the memory-barrirers doc),
there is just _no_ one-way compiler barrier. So (1) implies the use of
barrier() - which is a &quot;full&quot; compiler barrier.<br>
<br>
Moreover, one may consider a memory barrier (2) as a &quot;stronger&quot; version
of the compiler barrier. IOW, a memory barrier (2) is always used in
pair with the compiler one (1). <br>
Otherwise, one asks a CPU not to do reordering but a compiler still may do it under the hood.<br>
The other way around is not always true, a compiler barrier can be used without the memory one.<br>
<br>
</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Well, I guess it's best to leave xnlocks as they are (when they really<br>match Linux characteristics) and put the required but missing barrier
<br>for xnintr_synchronize() explicitly into the code. To play save (and as<br>performance is not important in that path), we can use a memory barrier.</blockquote><div><br>
Yes, I agree here. <br>
</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; xnlock_get() makes use of atomic_cmpxchg() which is mapped on linux's<br>&gt; cmpxchg() which, in turn, is said to be smp_mb() alike.
<br><br>My whole feeling on the xnlock is not that positive. Maybe it would be<br>good to go through all &quot;home-made&quot; locking primitives with barriers in<br>mind and an eye on the Linux implementation.</blockquote>
<div><br>
Ack.&nbsp;<br>
</div><div><br>
&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; Ok, I'm stopping further speculations here... Back to practice, so do we go
<br>&gt; for smp_mb__before/after_atomic_* counterparts or live it as is? I guess,<br>&gt; those would be more optimal.<br>&gt;<br><br>As I said, I'm still not sure if we finally need it when we may use<br>per-cpu counters for efficiency reasons on the long-term. If this will
<br>add code or - even more important - an interface (of the system layer)<br>that will soon be removed again...</blockquote><div><br>
So could you reveal your vision of per-cpu counters in this scenario
(or something in linux does use it under similar circumstances.. RCU?)
At the first glance, it doesn't seem to be much better. Although, I
haven't elaborated more thoroughly yet...<br>
&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Jan<br><br><br><br></blockquote></div><br><br clear="all"><br>-- <br>Best regards,
<br>Dmitry Adamushko

------=_Part_72193_1458947.1164101569859--

