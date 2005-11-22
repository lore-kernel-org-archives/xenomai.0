In-Reply-To: <4382F115.5010007@domain.hid>
Subject: Re: [Xenomai-core] [RFC] define your own pipe heap
Message-ID: <OF293DA25F.F77BC86C-ONC12570C1.00394E8C-C12570C1.003AFD12@domain.hid>
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Tue, 22 Nov 2005 11:44:18 +0100
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFA52DFAAC81C8f9e8a93df938690918c4EBBFA52DFAAC81C"
Content-Disposition: inline
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

--0__=4EBBFA52DFAAC81C8f9e8a93df938690918c4EBBFA52DFAAC81C
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable



xenomai-core-bounces@domain.hid wrote on 22.11.2005 11:21:09:

> Jan Kiszka wrote:
> > ...
> > A patch says more than thousand words. ;)
> >
> > As a first approach, I picked the second variant and implemented a =
new
> > function called rt_pipe_setpool. I also had to extend rt_pipe_alloc=
 and
> > rt_pipe_free so that the right pool is used by them.
> >
>
> I thought about this variant again, and it seems to me rather unsafe =
in
> case some buffer allocation takes place between rt_pipe_create and
> rt_pipe_setpool. So, here is a patch which extends rt_pipe_create wit=
h a
> new argument poolsize instead.

I haven't read the patch thoroughly yet so just a few common remarks. I=
MHO,
the interface would be much clear in case a rt_pipe_create() is extende=
d
since:

- we avoid a misuse when a rt_pipe_alloc() is called with an old pool b=
ut
rt_pipe_free() (explicitly or implicitly internally) is called with a n=
ew
one;

- rt_pipe_setpool() can be successfuly called only once and a user must=

care that:
      o  either this is next call after a pipe has been created;
      o  or all messages allocated from the "old" pool have been freed =
by
that moment (otherwise we need to extend a pipe::message interface so t=
hat
every message knows the exact pool it has been allocated from and,
moreover, implement the reference counting so that a pool object exists=
 as
long as there is at least a reference on it - and we don't need that
complications).

So, yep, adding an additional parameter to the rt_pipe_create() would b=
e a
better solution. My humble 2 cents :o)

Once I thought about an interface that allows to "attach/detach" an
existing RT_HEAP object to any pipe/queue/maybe_smth_else but here we w=
ould
need to extend the underlying mechanisms as I mentioned above.
And likely, such an interface is not something of big avail for strict
real-time environments. Keep it simple instaed :o)


---
Best regards,
Dmitry=

--0__=4EBBFA52DFAAC81C8f9e8a93df938690918c4EBBFA52DFAAC81C
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><tt>xenomai-core-bounces@domain.hid wrote on 22.11.2005 11:21:09:<br>
<br>
&gt; Jan Kiszka wrote:<br>
&gt; &gt; ...<br>
&gt; &gt; A patch says more than thousand words. ;)<br>
&gt; &gt; <br>
&gt; &gt; As a first approach, I picked the second variant and implemen=
ted a new<br>
&gt; &gt; function called rt_pipe_setpool. I also had to extend rt_pipe=
_alloc and<br>
&gt; &gt; rt_pipe_free so that the right pool is used by them.<br>
&gt; &gt; <br>
&gt; <br>
&gt; I thought about this variant again, and it seems to me rather unsa=
fe in<br>
&gt; case some buffer allocation takes place between rt_pipe_create and=
<br>
&gt; rt_pipe_setpool. So, here is a patch which extends rt_pipe_create =
with a<br>
&gt; new argument poolsize instead.</tt><br>
<br>
<tt>I haven't read the patch </tt><tt>thoroughly yet so just a few comm=
on remarks. IMHO, the interface would be much clear in case a rt_pipe_c=
reate() is extended since:</tt><br>
<br>
<tt>- we avoid a misuse when a rt_pipe_alloc() is called with an old po=
ol but rt_pipe_free() (explicitly or implicitly internally) is called w=
ith a new one;</tt><br>
<br>
<tt>- rt_pipe_setpool() can be successfuly called only once and a user =
must care that:</tt><br>
<tt>	o &nbsp;either this is next call after a pipe has been created;</t=
t><br>
<tt>	o &nbsp;or all messages allocated from the &quot;old&quot; pool ha=
ve been freed by that moment (otherwise we need to extend a pipe::messa=
ge interface so that every message knows the exact pool it has been all=
ocated from and, moreover, implement the reference counting so that a p=
ool object exists as long as there is at least a reference on it - and =
we don't need that complications).</tt><br>
<br>
<tt>So, yep, adding an additional parameter to the rt_pipe_create() wou=
ld be a better solution. My humble 2 cents :o)</tt><br>
<tt><br>
Once I thought about an interface that allows to &quot;attach/detach&qu=
ot; an existing RT_HEAP object to any pipe/queue/maybe_smth_else but he=
re we would need to extend the underlying mechanisms as I mentioned abo=
ve.</tt><br>
<tt>And likely, such an interface is not something of big avail for str=
ict real-time environments. Keep it simple instaed :o)</tt><br>
<br>
<br>
<tt>---</tt><br>
<tt>Best regards,</tt><br>
<tt>Dmitry</tt><br>
</body></html>=

--0__=4EBBFA52DFAAC81C8f9e8a93df938690918c4EBBFA52DFAAC81C--


