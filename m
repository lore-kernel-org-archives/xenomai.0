In-Reply-To: <437DA982.3040603@domain.hid>
Subject: Re: [Xenomai-core] [pipe.c] hairy synchronization -> "flush the output
	queue upon closure"
Message-ID: <OF6B03266F.E2C02C00-ONC12570BD.00393A33-C12570BD.003ADFA5@domain.hid>
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Fri, 18 Nov 2005 11:43:03 +0100
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFA2EDFAABCA38f9e8a93df938690918c4EBBFA2EDFAABCA3"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

--0__=4EBBFA2EDFAABCA38f9e8a93df938690918c4EBBFA2EDFAABCA3
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable



Philippe Gerum <rpm@xenomai.org> wrote on 18.11.2005 11:14:26:

> > ...
> >
> > it looks like we can't make the whole xnpipe_release() atomic becau=
se
of
> > PREEMPT_RT + wake_up_interruptible_all() things, right? Or no.
>
> You must _never_ _ever_ reschedule with the nucleus lock held; this
> is a major cause of
> jittery I recently stumbled upon that was induced by
> xnpipe_read_wait() at that time. So
> indeed, xnpipe_release() cannot be made atomic this way under a
> fully preemptible kernel.

Yep.

Now keeping in mind the observation I have made yesterday, it looks lik=
e,
in fact, there is no need in wake_up_*(readers) call in
file_operations::release(). There is nobody to be woken up at the time =
when
release() is called:

1) The reference counter of "file" object is 0, i.e. there are no reade=
rs
since read() increases a counter before getting blocked.

2) noone else can use anew that "file" object since close() does the
following:

 filp =3D files->fd[fd];
 if (!filp)
      goto out_unlock;
 files->fd[fd] =3D NULL;        <--- it's invalid from now on

so it's not possible that some new readers may occur when a counter =3D=
=3D 0.

Hm.. but we still have fasync_helper(-1,file,0,&state->asyncq); which i=
s
about sending a signal and that's perfectly valid (a file::counter is n=
ot
involved here). And that call may lead to re-scheduling (linux
re-scheduling of course) so we can't put it in a blocked section.

So the best way I see is to have something like():

xnpipe_drop_user_conn()
{
      xnlock_get_irqsave(&nklock,s);

       while ((holder =3D getq(&state->outq)) !=3D NULL)

state->output_handler(minor,link2mh(holder),-EPIPE,state->cookie);
            }

        while ((holder =3D getq(&state->inq)) !=3D NULL)
            {
            if (state->input_handler !=3D NULL)

state->input_handler(minor,link2mh(holder),-EPIPE,state->cookie);
            else if (state->alloc_handler =3D=3D NULL)
                xnfree(link2mh(holder));
            }

      __clrbits(state->status,XNPIPE_USER_CONN);

      xnlock_put_irqrestore(&nklock,s);
}

and call it everywhere instead of clrbits(state->status,XNPIPE_USER_CON=
N);

This way we may be sure there are no pending messages left.


> --
>
> Philippe.

---

Dmitry=

--0__=4EBBFA2EDFAABCA38f9e8a93df938690918c4EBBFA2EDFAABCA3
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><tt>Philippe Gerum &lt;rpm@xenomai.org&gt; wrote on 18.11.2005 11:14=
:26:<br>
<br>
&gt; &gt; ...</tt><br>
<tt>&gt; &gt; <br>
&gt; &gt; it looks like we can't make the whole xnpipe_release() atomic=
 because of <br>
&gt; &gt; PREEMPT_RT + wake_up_interruptible_all() things, right? Or no=
.<br>
&gt; <br>
&gt; You must _never_ _ever_ reschedule with the nucleus lock held; thi=
s <br>
&gt; is a major cause of <br>
&gt; jittery I recently stumbled upon that was induced by <br>
&gt; xnpipe_read_wait() at that time. So <br>
&gt; indeed, xnpipe_release() cannot be made atomic this way under a <b=
r>
&gt; fully preemptible kernel.</tt><br>
<br>
<tt>Yep.</tt><br>
<br>
<tt>Now keeping in mind the observation I have made yesterday, it looks=
 like, in fact, there is no need in wake_up_*(readers) call in file_ope=
rations::release(). There is nobody to be woken up at the time when rel=
ease() is called:</tt><br>
<br>
<tt>1) The reference counter of &quot;file&quot; object is 0, i.e. ther=
e are no readers since read() increases a counter before getting blocke=
d.</tt><br>
<br>
<tt>2) noone else can use anew that &quot;file&quot; object since close=
() does the following:</tt><br>
<br>
<tt> filp =3D files-&gt;fd[fd];</tt><br>
<tt> if (!filp)</tt><br>
<tt>	goto out_unlock;</tt><br>
<tt> files-&gt;fd[fd] =3D NULL;		&lt;--- it's invalid from now on</tt><=
br>
<br>
<tt>so it's not possible that some new readers may occur when a counter=
 =3D=3D 0.</tt><br>
<br>
<tt>Hm.. but we still have fasync_helper(-1,file,0,&amp;state-&gt;async=
q); which is about sending a signal and that's perfectly valid (a <a hr=
ef=3D"file::counter">file::counter</a> is not involved here). And that =
call may lead to re-scheduling (linux re-scheduling of course) so we ca=
n't put it in a blocked section.</tt><br>
<br>
<tt>So the best way I see is to have something like():</tt><br>
<br>
<tt>xnpipe_drop_user_conn()</tt><br>
<tt>{</tt><br>
<tt>	xnlock_get_irqsave(&amp;nklock,s);</tt><br>
<br>
<tt>	 while ((holder =3D getq(&amp;state-&gt;outq)) !=3D NULL)</tt><br>=

<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;state-&gt;o=
utput_handler(minor,link2mh(holder),-EPIPE,state-&gt;cookie);</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}</tt><br>
<br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp;while ((holder =3D getq(&amp;state-&gt;=
inq)) !=3D NULL)</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;{</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (state-&gt;input_handl=
er !=3D NULL)</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;state-&gt;i=
nput_handler(minor,link2mh(holder),-EPIPE,state-&gt;cookie);</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;else if (state-&gt;alloc_=
handler =3D=3D NULL)</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;xnfree(link=
2mh(holder));</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}</tt><br>
<br>
<tt>	__clrbits(state-&gt;status,XNPIPE_USER_CONN);</tt><br>
<br>
<tt>	xnlock_put_irqrestore(&amp;nklock,s);</tt><br>
<tt>}</tt><br>
<br>
<tt>and call it everywhere instead of clrbits(state-&gt;status,XNPIPE_U=
SER_CONN);</tt><br>
<br>
<tt>This way we may be sure there are no pending messages left.</tt><br=
>
<br>
<tt><br>
&gt; -- <br>
&gt; <br>
&gt; Philippe.<br>
</tt><br>
<tt>---</tt><br>
<br>
<tt>Dmitry</tt><br>
</body></html>=

--0__=4EBBFA2EDFAABCA38f9e8a93df938690918c4EBBFA2EDFAABCA3--


