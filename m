In-Reply-To: <4381BF59.1050704@domain.hid>
Subject: Re: [Xenomai-help] pipe fun
Message-ID: <OF9B0F824D.7587E331-ONC12570C0.00465803-C12570C0.0047036C@datacon.at>
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Mon, 21 Nov 2005 13:55:38 +0100
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=4EBBFA53DFD5DE938f9e8a93df938690918c4EBBFA53DFD5DE93"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

--0__=4EBBFA53DFD5DE938f9e8a93df938690918c4EBBFA53DFD5DE93
Content-type: multipart/alternative; 
	Boundary="1__=4EBBFA53DFD5DE938f9e8a93df938690918c4EBBFA53DFD5DE93"

--1__=4EBBFA53DFD5DE938f9e8a93df938690918c4EBBFA53DFD5DE93
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: quoted-printable



Philippe Gerum <rpm@xenomai.org> wrote on 21.11.2005 13:36:41:

> Dmitry Adamushko wrote:
> > Ignacio Garc=EDa P=E9rez <iggarpe@domain.hid> wrote on 21.11.2005 12:=
24:57:
> >
> >  > Dmitry Adamushko wrote:
> >  >
> >  > >            /* Return buffer is too small - message is lost. */=

> >  > >            ret =3D -ENOSPC; <---- That's the error you are get=
ting.
> >  > >
> >  > Maybe "No space left on device" is a bit misleading. Wouldn't EN=
OMEM
fit
> >  > better? (or event EINVAL)
> >  >
> >
> > Actually, looking now at the linux sources, -ENOSPC is used for
> > describing the same reason (buffer is not big enough) in some place=
s;
> > although there is, at least, one more value -ENOBUFS that's used fo=
r
the
> > same reason.
> >
> > #define ENOSPC          28      /* No space left on device */
> > #define ENOBUFS         105     /* No buffer space available */
> >
> > So it looks like both may be used in the same context but, I guess,=
 a
> > definition of -ENOBUFS is less confusing.
> >
> >
>
> Let's fix this.
>

Enclosed.

One more thing about xnpipe_read() though.


...
            }
        else
            /* Return buffer is too small - message is lost. */
            ret =3D -ENOBUFS;

So the message is lost in such a case. We may easily avoid that by maki=
ng a
proper check of the size when we are still in the locked section and
putting the message back into the queue (prependq() of course). I think=

that would be more sane.


> --
>
> Philippe.

---
Best regards,
Dmitry

(See attached file: pipe-ENOBUFS.patch)(See attached file: ChangeLog.pa=
tch)=

--1__=4EBBFA53DFD5DE938f9e8a93df938690918c4EBBFA53DFD5DE93
Content-type: text/html; charset=ISO-8859-1
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><tt>Philippe Gerum &lt;rpm@xenomai.org&gt; wrote on 21.11.2005 13:36=
:41:<br>
<br>
&gt; Dmitry Adamushko wrote:<br>
&gt; &gt; Ignacio Garc=EDa P=E9rez &lt;iggarpe@domain.hid&gt; wrote on 21=
.11.2005 12:24:57:<br>
&gt; &gt; <br>
&gt; &gt; &nbsp;&gt; Dmitry Adamushko wrote:<br>
&gt; &gt; &nbsp;&gt;<br>
&gt; &gt; &nbsp;&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* R=
eturn buffer is too small - message is lost. */<br>
&gt; &gt; &nbsp;&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ret =
=3D -ENOSPC; &lt;---- That's the error you are getting.<br>
&gt; &gt; &nbsp;&gt; &gt;<br>
&gt; &gt; &nbsp;&gt; Maybe &quot;No space left on device&quot; is a bit=
 misleading. Wouldn't ENOMEM fit<br>
&gt; &gt; &nbsp;&gt; better? (or event EINVAL)<br>
&gt; &gt; &nbsp;&gt;<br>
&gt; &gt; <br>
&gt; &gt; Actually, looking now at the linux sources, -ENOSPC is used f=
or <br>
&gt; &gt; describing the same reason (buffer is not big enough) in some=
 places; <br>
&gt; &gt; although there is, at least, one more value -ENOBUFS that's u=
sed for the <br>
&gt; &gt; same reason.<br>
&gt; &gt; <br>
&gt; &gt; #define ENOSPC &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;28 &nbsp; &n=
bsp; &nbsp;/* No space left on device */<br>
&gt; &gt; #define ENOBUFS &nbsp; &nbsp; &nbsp; &nbsp; 105 &nbsp; &nbsp;=
 /* No buffer space available */<br>
&gt; &gt; <br>
&gt; &gt; So it looks like both may be used in the same context but, I =
guess, a <br>
&gt; &gt; definition of -ENOBUFS is less confusing.<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; <br>
&gt; Let's fix this.<br>
&gt; <br>
</tt><br>
<tt>Enclosed.</tt><br>
<br>
<tt>One more thing about xnpipe_read() though.</tt><br>
<br>
<br>
<tt>...</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp;else</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* Return buffer is too s=
mall - message is lost. */</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ret =3D -ENOBUFS;</tt><br=
>
<br>
<tt>So the message is lost in such a case. We may easily avoid that by =
making a proper check of the size when we are still in the locked secti=
on and putting the message back into the queue (prependq() of course). =
I think that would be more sane.</tt><br>
<br>
<br>
<tt>&gt; -- <br>
&gt; <br>
&gt; Philippe.<br>
</tt><br>
<tt>---</tt><br>
<tt>Best regards,</tt><br>
<tt>Dmitry</tt><br>
<br>
<i>(See attached file: pipe-ENOBUFS.patch)</i><i>(See attached file: Ch=
angeLog.patch)</i></body></html>=


--1__=4EBBFA53DFD5DE938f9e8a93df938690918c4EBBFA53DFD5DE93--


--0__=4EBBFA53DFD5DE938f9e8a93df938690918c4EBBFA53DFD5DE93
Content-type: application/octet-stream; 
	name="=?ISO-8859-1?Q?pipe-ENOBUFS=2Epatch?="
Content-Disposition: attachment;
	filename="=?ISO-8859-1?Q?pipe-ENOBUFS=2Epatch?="
Content-ID: <10__=4EBBFA53DFD5DE938f9e8a93df938@domain.hid>
Content-transfer-encoding: base64

LS0tIHBpcGUuYy1vbGQJMjAwNS0xMS0yMSAxNDo1NjoyNS4wMDAwMDAwMDAgKzAxMDAKKysrIHBp
cGUuYwkyMDA1LTExLTIxIDE0OjU2OjU5LjAwMDAwMDAwMCArMDEwMApAQCAtNzQ5LDcgKzc0OSw3
IEBACiAJICAgIH0KIAllbHNlCiAJICAgIC8qIFJldHVybiBidWZmZXIgaXMgdG9vIHNtYWxsIC0g
bWVzc2FnZSBpcyBsb3N0LiAqLwotCSAgICByZXQgPSAtRU5PU1BDOworCSAgICByZXQgPSAtRU5P
QlVGUzsKIAogCWlmIChoYW5kbGVyICE9IE5VTEwpCiAJICAgIHJldCA9IGhhbmRsZXIoeG5taW5v
cl9mcm9tX3N0YXRlKHN0YXRlKSxtaCxyZXQsY29va2llKTsK

--0__=4EBBFA53DFD5DE938f9e8a93df938690918c4EBBFA53DFD5DE93
Content-type: application/octet-stream; 
	name="=?ISO-8859-1?Q?ChangeLog=2Epatch?="
Content-Disposition: attachment; filename="=?ISO-8859-1?Q?ChangeLog=2Epatch?="
Content-ID: <20__=4EBBFA53DFD5DE938f9e8a93df938@domain.hid>
Content-transfer-encoding: base64

LS0tIENoYW5nZUxvZy1vbGQJMjAwNS0xMS0yMSAxNTowNDo0MC4wMDAwMDAwMDAgKzAxMDAKKysr
IENoYW5nZUxvZwkyMDA1LTExLTIxIDE1OjA0OjI3LjAwMDAwMDAwMCArMDEwMApAQCAtMSw0ICsx
LDExIEBACiAKKzIwMDUtMTEtMjEgIERtaXRyeSBBZGFtdXNoa28gPGRtaXRyeS5hZGFtdXNoa29A
Z21haWwuY29tPgorCisJKiBudWNsZXVzL3BpcGUuYyAoeG5waXBlX3NlbmQpOiBSZXR1cm4gLUVO
T0JVRlMgaW5zdGVhZCBvZiAtRU5PU1BDCisJd2hlbiBhIGdpdmVuIGJ1ZmZlciBpcyBub3QgYmln
IGVub3VnaCBmb3IgdGhlIGVudGlyZSBtZXNzYWdlIHRvIGJlCisJd3JpdHRlbiBpbi4gcGVycm9y
KCkgZ2l2ZXMgYSwgaG9wZWZ1bGx5LCBtb3JlLXByZWNpc2UgYW5kIGxlc3MtY29uZnVzaW5nCisJ
ZGVzY3JpcHRpb24gZm9yIHRoZSBmb3JtZXIgb25lLgorCiAyMDA1LTExLTE4ICBIZWlra2kgTGlu
ZGhvbG0gPGhvbGluZGhvQGNzLmhlbHNpbmtpLmZpPgogCiAJKiBpbmNsdWRlL2FzbS1wb3dlcnBj
L3N5c3RlbS5oLCBrc3JjL2FyY2gvcG93ZXJwYy9zd2l0Y2hfNjQuUzogQWRkCg==

--0__=4EBBFA53DFD5DE938f9e8a93df938690918c4EBBFA53DFD5DE93--


