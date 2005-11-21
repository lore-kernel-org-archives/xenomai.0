In-Reply-To: <4381AE89.4070103@domain.hid>
Subject: Re: [Xenomai-help] pipe fun
Message-ID: <OFB5DCE336.B4DDC2FD-ONC12570C0.00415BF3-C12570C0.0042FBDA@datacon.at>
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Mon, 21 Nov 2005 13:11:38 +0100
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFA53DFD2DD638f9e8a93df938690918c4EBBFA53DFD2DD63"
Content-Disposition: inline
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ignacio =?ISO-8859-1?Q?Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai@xenomai.org

--0__=4EBBFA53DFD2DD638f9e8a93df938690918c4EBBFA53DFD2DD63
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: quoted-printable



Ignacio Garc=EDa P=E9rez <iggarpe@domain.hid> wrote on 21.11.2005 12:24:5=
7:

> Dmitry Adamushko wrote:
>
> >            /* Return buffer is too small - message is lost. */
> >            ret =3D -ENOSPC; <---- That's the error you are getting.=

> >
> Maybe "No space left on device" is a bit misleading. Wouldn't ENOMEM =
fit
> better? (or event EINVAL)
>

Actually, looking now at the linux sources, -ENOSPC is used for describ=
ing
the same reason (buffer is not big enough) in some places; although the=
re
is, at least, one more value -ENOBUFS that's used for the same reason.

#define ENOSPC          28      /* No space left on device */
#define ENOBUFS         105     /* No buffer space available */

So it looks like both may be used in the same context but, I guess, a
definition of -ENOBUFS is less confusing.


---
Best regards,
Dmitry=

--0__=4EBBFA53DFD2DD638f9e8a93df938690918c4EBBFA53DFD2DD63
Content-type: text/html; charset=ISO-8859-1
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><tt>Ignacio Garc=EDa P=E9rez &lt;iggarpe@domain.hid&gt; wrote on 21.11=
.2005 12:24:57:<br>
<br>
&gt; Dmitry Adamushko wrote:<br>
&gt; <br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* Return buffer is =
too small - message is lost. */<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ret =3D -ENOSPC; &lt=
;---- That's the error you are getting.<br>
&gt; &gt;<br>
&gt; Maybe &quot;No space left on device&quot; is a bit misleading. Wou=
ldn't ENOMEM fit<br>
&gt; better? (or event EINVAL)<br>
&gt; </tt><br>
<br>
<tt>Actually, looking now at the linux sources, -ENOSPC is used for des=
cribing the same reason (buffer is not big enough) in some places; alth=
ough there is, at least, one more value -ENOBUFS that's used for the sa=
me reason.</tt><br>
<br>
<tt>#define ENOSPC &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;28 &nbsp; &nbsp; &=
nbsp;/* No space left on device */</tt><br>
<tt>#define ENOBUFS &nbsp; &nbsp; &nbsp; &nbsp; 105 &nbsp; &nbsp; /* No=
 buffer space available */</tt><br>
<br>
<tt>So it looks like both may be used in the same context but, I guess,=
 a definition of -ENOBUFS is less confusing.</tt><br>
<br>
<br>
<tt>---</tt><br>
<tt>Best regards,</tt><br>
<tt>Dmitry</tt><br>
</body></html>=

--0__=4EBBFA53DFD2DD638f9e8a93df938690918c4EBBFA53DFD2DD63--


