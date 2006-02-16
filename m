Message-ID: <b647ffbd0602160558i4112313an@domain.hid>
Date: Thu, 16 Feb 2006 15:58:23 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] Re: [PATCH] Shared interrupts (ready to merge)
In-Reply-To: <43F47705.90309@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_17236_709045.1140098303189"
References: <b647ffbd0602150939g59256b2bx@domain.hid>
	<43F3C4EA.7050303@domain.hid> <b647ffbd0602160220we254aacx@domain.hid>
	<43F47705.90309@domain.hid>
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

------=_Part_17236_709045.1140098303189
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 16/02/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Dmitry Adamushko wrote:
> > On 16/02/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> >
> > Hmm, I still find XN_ISR_NOINT in the patch. Shouldn't we solve this
> >> before merging (i.e. make XN_ISR_HANDLED non-zero)?
> >
> >
> > Ok, XN_ISR_NOINT is removed in favor of XN_ISR_HANDLED which is now
> > non-zero.
> > Actually, at first I wanted to make it just the other way about.
> >
>
> Hmm, thinking about this again, I would like to revert my suggestion in
> favour of a third approach (trying to keep you busy ;) ).


Ok, you are wellcome :)

I didn't get it, at least while looking briefly. To make it a bit easier, a=
t
least for me, let's go another way.

At the left is the list of allowed values as Philippe pointed out.
At the right is another list which corresponds to the left one but when
NOINT is used instead of HANDLED. Moreover, I have added another case - pur=
e
NOINT. The ISR says it's not mine and, well, it doesn't know whether it
should be propagated or no
(ok, so far CHAINED standed for NOINT).

HANDLED                     ->  0
HANDLED | ENABLE     ->  ENABLE
HANDLED | CHAINED    ->  CHAINED
CHAINED                      ->  CHAINED | NOINT
                                    ->   NOINT

Could you provide the 3-d corresponding table using your new flags?


> xnintr_t contains just the link "char *name" as you suggested but RT_INTR
> > contains the name[XNOBJECT_NAME_LEN] member (as it was before actually)=
.
> >
> > If it's ok,  then I'll send um... yet another final patch that addresse=
s
> > both issues :)
>
> I'm fine with this as well if you prefer it, no problem.


Yep, let's go this way.


Jan
>
>
>

--
Best regards,
Dmitry Adamushko

------=_Part_17236_709045.1140098303189
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><div><span class=3D"gmail_quote">On 16/02/06, <b class=3D"gmail_sendern=
ame">Jan Kiszka</b> &lt;<a href=3D"mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid=
.de</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-=
left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left=
: 1ex;">
Dmitry Adamushko wrote:<br>&gt; On 16/02/06, Jan Kiszka &lt;<a href=3D"mail=
to:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:<br>&gt;<br>&gt; Hmm,=
 I still find XN_ISR_NOINT in the patch. Shouldn't we solve this<br>&gt;&gt=
; before merging (
i.e. make XN_ISR_HANDLED non-zero)?<br>&gt;<br>&gt;<br>&gt; Ok, XN_ISR_NOIN=
T is removed in favor of XN_ISR_HANDLED which is now<br>&gt; non-zero.<br>&=
gt; Actually, at first I wanted to make it just the other way about.<br>
&gt;<br><br>Hmm, thinking about this again, I would like to revert my sugge=
stion in<br>favour of a third approach (trying to keep you busy ;) ).</bloc=
kquote><div><br>
Ok, you are wellcome :)<br>
<br>
I didn't get it, at least while looking briefly. To make it a bit easier, a=
t least for me, let's go another way.<br>
<br>
At the left is the list of allowed values as Philippe pointed out.<br>
At the right is another list which corresponds to the left one but when
NOINT is used instead of HANDLED. Moreover, I have added another case -
pure NOINT. The ISR says it's not mine and, well, it doesn't know
whether it should be propagated or no<br>
(ok, so far CHAINED standed for NOINT).<br>
<br>
HANDLED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
-&gt;&nbsp; 0<br>

HANDLED | ENABLE&nbsp;&nbsp;&nbsp;&nbsp; -&gt;&nbsp; ENABLE<br>

HANDLED | CHAINED&nbsp;&nbsp;&nbsp; -&gt;&nbsp; CHAINED<br>
CHAINED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
-&gt;&nbsp; CHAINED | NOINT <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
-&gt;&nbsp;&nbsp; NOINT<br>
</div><div><br>
Could you provide the 3-d corresponding table using your new flags?<br>
<br>
<br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; xnintr=
_t contains just the link &quot;char *name&quot; as you suggested but RT_IN=
TR
<br>&gt; contains the name[XNOBJECT_NAME_LEN] member (as it was before actu=
ally).<br>&gt;<br>&gt; If it's ok,&nbsp;&nbsp;then I'll send um... yet anot=
her final patch that addresses<br>&gt; both issues :)<br><br>I'm fine with =
this as well if you prefer it, no problem.
</blockquote><div><br>
Yep, let's go this way. <br>
</div><br>
<br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(2=
04, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Jan<br><br><b=
r>
</blockquote></div><br clear=3D"all"><br>-- <br>Best regards,<br>Dmitry Ada=
mushko

------=_Part_17236_709045.1140098303189--

