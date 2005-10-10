In-Reply-To: <434A4BD9.1030407@domain.hid>
Message-ID: <OF67718347.A739127D-ONC1257096.003D7ADA-C1257096.003F7677@domain.hid>
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Mon, 10 Oct 2005 13:33:10 +0200
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFA05DFAEFC4A8f9e8a93df938690918c4EBBFA05DFAEFC4A"
Content-Disposition: inline
Subject: [Xenomai-core] Re: [syscall.c] rt_bind_queue/heap()
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

--0__=4EBBFA05DFAEFC4A8f9e8a93df938690918c4EBBFA05DFAEFC4A
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable


Philippe Gerum <rpm@xenomai.org> wrote on 10.10.2005 13:09:13:

> Dmitry Adamushko wrote:
> > Philippe Gerum <rpm@xenomai.org> wrote on 05.10.2005 14:13:07:
> >
> >  >
> >  > Your patch is ok, my implementation was uselessly convoluted.
> >
> > Ok, then it's enclosed.
> >
> > 2005-10-05  Dmitry Adamushko  <dmitry.adamushko@domain.hid>
>
> Applied, thanks.
> ...

btw,

It looks like something wrong with the xenomai mailing list. I have got=

your answer but only one copy (you specified my own e-mail) and I haven=
't
got my own message on the list (but I've cc'ed "xenomai-core").

One more thing. I had a discussion with Steven Seeger regarding the use=
 of
NULL-named objects from the user space. I cc'ed you but probably you we=
re
too buzy at that time. The problem is that one may create successfully =
a
NULL-named object but then there is no way to use it since all further
calls give an error (some funny stuff there indeed :)

So a simple fix would look like:

for all rt_OBJECT_create() calls in libnative:

int rt_mutex_create(RT_MUTEX *mutex, const char *name)
{

+     if (!name)
+           return -E_SOMETHING; // E_INVAL?

      return XENOMAI_SKINCALL2(__xeno_muxid,
                               __xeno_mutex_create,
                               mutex,
                               name);
}

What do you think? Or are there any reasons to keep it as is now?


p.s. I have cc'ed "xenomai@xenomai.org" for both reasons to test the
mailing list and, well, maybe someone else has an opinion on the matter=
.


> --
>
> Philippe.

---
Best regards,
Dmitry=

--0__=4EBBFA05DFAEFC4A8f9e8a93df938690918c4EBBFA05DFAEFC4A
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><tt>Philippe Gerum &lt;rpm@xenomai.org&gt; wrote on 10.10.2005 13:09=
:13:<br>
<br>
&gt; Dmitry Adamushko wrote:<br>
&gt; &gt; Philippe Gerum &lt;rpm@xenomai.org&gt; wrote on 05.10.2005 14=
:13:07:<br>
&gt; &gt; <br>
&gt; &gt; &nbsp;&gt;<br>
&gt; &gt; &nbsp;&gt; Your patch is ok, my implementation was uselessly =
convoluted.<br>
&gt; &gt; <br>
&gt; &gt; Ok, then it's enclosed.<br>
&gt; &gt; <br>
&gt; &gt; 2005-10-05 &nbsp;Dmitry Adamushko &nbsp;&lt;dmitry.adamushko@=
datacon.at&gt;<br>
&gt; <br>
&gt; Applied, thanks.<br>
&gt; ...</tt><br>
<br>
<tt>btw,</tt><br>
<br>
<tt>It looks like something wrong with the xenomai mailing list. I have=
 got your answer but only one copy (you specified my own e-mail) and I =
haven't got my own message on the list (but I've cc'ed &quot;xenomai-co=
re&quot;).</tt><br>
<br>
<tt>One more thing. I had a discussion with Steven Seeger regarding the=
 use of NULL-named objects from the user space. I cc'ed you but probabl=
y you were too buzy at that time. The problem is that one may create su=
ccessfully a NULL-named object but then there is no way to use it since=
 all further calls give an error (some funny stuff there indeed :)</tt>=
<br>
<br>
<tt>So a simple fix would look like:</tt><br>
<br>
<tt>for all rt_OBJECT_create() calls in libnative:</tt><br>
<br>
<tt>int rt_mutex_create(RT_MUTEX *mutex, const char *name)</tt><br>
<tt>{</tt><br>
<br>
<tt>+	if (!name)</tt><br>
<tt>+		return -E_SOMETHING; // E_INVAL?</tt><br>
<br>
<tt>	return XENOMAI_SKINCALL2(__xeno_muxid,</tt><br>
<tt>					 __xeno_mutex_create,</tt><br>
<tt>					 mutex,</tt><br>
<tt>					 name);</tt><br>
<tt>}</tt><br>
<br>
<tt>What do you think? Or are there any reasons to keep it as is now?</=
tt><br>
<br>
<br>
<tt>p.s. I have cc'ed </tt><tt>&quot;xenomai@xenomai.org&quot; for bot=
h reasons to test the mailing list and, well, maybe someone else has an=
 opinion on the matter.</tt><br>
<br>
<br>
<tt>&gt; -- <br>
&gt; <br>
&gt; Philippe.</tt><br>
<br>
<tt>---</tt><br>
<tt>Best regards,</tt><br>
<tt>Dmitry</tt><br>
</body></html>=

--0__=4EBBFA05DFAEFC4A8f9e8a93df938690918c4EBBFA05DFAEFC4A--


