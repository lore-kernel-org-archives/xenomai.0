Message-ID: <b647ffbd0602161128t70d1f08ax@domain.hid>
Date: Thu, 16 Feb 2006 21:28:29 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] Re: [PATCH] Shared interrupts (ready to merge)
In-Reply-To: <43F48832.7060804@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_2936_28547361.1140118109114"
References: <b647ffbd0602150939g59256b2bx@domain.hid>
	<43F3C4EA.7050303@domain.hid> <b647ffbd0602160220we254aacx@domain.hid>
	<43F47705.90309@domain.hid> <b647ffbd0602160558i4112313an@domain.hid>
	<43F48832.7060804@domain.hid>
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

------=_Part_2936_28547361.1140118109114
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 16/02/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Dmitry Adamushko wrote:
> > On 16/02/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> >> Dmitry Adamushko wrote:
> >>> On 16/02/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> >>>
> >>> Hmm, I still find XN_ISR_NOINT in the patch. Shouldn't we solve this
> >>>> before merging (i.e. make XN_ISR_HANDLED non-zero)?
> >>>
> >>> Ok, XN_ISR_NOINT is removed in favor of XN_ISR_HANDLED which is now
> >>> non-zero.
> >>> Actually, at first I wanted to make it just the other way about.
> >>>
> >> Hmm, thinking about this again, I would like to revert my suggestion i=
n
> >> favour of a third approach (trying to keep you busy ;) ).
> >
> >
> > Ok, you are wellcome :)
> >
> > I didn't get it, at least while looking briefly. To make it a bit
> easier, at
> > least for me, let's go another way.
> >
> > At the left is the list of allowed values as Philippe pointed out.
> > At the right is another list which corresponds to the left one but when
> > NOINT is used instead of HANDLED. Moreover, I have added another case -
> pure
> > NOINT. The ISR says it's not mine and, well, it doesn't know whether it
> > should be propagated or no
> > (ok, so far CHAINED standed for NOINT).
> >
> > 1.) HANDLED                     ->  0
> > 2.) HANDLED | ENABLE     ->  ENABLE
> > 3.) HANDLED | CHAINED    ->  CHAINED
> > 4.) CHAINED                      ->  CHAINED | NOINT
> > 5.)                                    ->   NOINT
> >
> > Could you provide the 3-d corresponding table using your new flags?
> >
>
> Still not 3D, but hopefully clarifying: :)



1.) XN_ISR_HANDLED |XN_ISR_NO_ENABLE
> 2.) XN_ISR_HANDLED
> 3.) XN_ISR_HANDLED | XN_ISR_PROPAGATE
>     (nucleus ignores implicit IRQ enable)
> 4.) XN_ISR_NOINT | XN_ISR_PROPAGATE
> 5.) XN_ISR_NOINT


Then why do we need XN_ISR_NOINT? is it not just the same as ~HANDLED?

Moreover, I tend to think now that PROPAGATE (CHAINED) should not be
normally used by ISRs at all. The only exception would be irq sharing
between RT and non-RT domains, but that's of no concern for most part of rt
drivers and, as last events revealed, it's very partially supported at the
moment and possible implementations are quite arguable.

So HANDLED means the irq line is .end-ed by xnintr_irq_handler()
(xnarch_end_irq(irq)  is called).

If one wants to do it on his own later, NOENABLE can be returned
additionally.
But then, one must use xnintr_end_irq() and not just xnintr_irq_enable().

If xnintr_end_irq() would be always the same as xnintr_irq_enable() or we
would decouple ending and enabling operations on the line (don't have
sources at hand); we could go Linux way and make use of a "nested" counter
in xnintr_t, so that xnintr_irq_disable() could be called in a nested way.
This said, calling xnintr_irq_disable() in ISR leads to the interrupt line
being still disabled upon return from xnintr_irq_handler() and re-enabled
again by the user later.

~HANDLED means the ISR was not concerned about this interrupt. i.e. :

- there is ISR in another domain (down the pipeline) which is interested in
this irq ;

     well, the designer of the system should be aware of such cases and
probably avoid that on hw layer or, at least, to know what she is doing.

- this is a spurious irq.

So upon getting ~HANDLED, xnintr_irq_handler() does :

success =3D xnintr_irq_chained(irq);

if (success)
{
/* i.e. another domain is really interested and got this irq as pending*/

return without .end-ing
}
else
{
/* this is a spurious irq */

make use of some accounting of spurious interrupts (if we need it)), i.e.
keep the irq line disabled if the % of unhandled requests > some limit.

otherwise

xnintr_end_irq() and return
}

too long :) ok, it's quite similar indeed to what you have suggested,
with the exception that

- no need for NOINT (if it's really =3D=3D ~HANDLED);
- nucleus provides some additional logic while handling ~HANDLED case.
- user don't need to return ENABLE explicitly - in most cases, that's what
he actually needs but sometimes just forgets (I recall a few questions on
the mailing list about "only one interrupt".


Jan
>
>
--
Best regards,
Dmitry Adamushko

------=_Part_2936_28547361.1140118109114
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><div><span class=3D"gmail_quote">On 16/02/06, <b class=3D"gmail_sendern=
ame">Jan Kiszka</b> &lt;<a href=3D"mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid=
.de</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-=
left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left=
: 1ex;">
Dmitry Adamushko wrote:<br>&gt; On 16/02/06, Jan Kiszka &lt;<a href=3D"mail=
to:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:<br>&gt;&gt; Dmitry A=
damushko wrote:<br>&gt;&gt;&gt; On 16/02/06, Jan Kiszka &lt;<a href=3D"mail=
to:jan.kiszka@domain.hid">
jan.kiszka@domain.hid</a>&gt; wrote:<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; Hmm, I sti=
ll find XN_ISR_NOINT in the patch. Shouldn't we solve this<br>&gt;&gt;&gt;&=
gt; before merging (i.e. make XN_ISR_HANDLED non-zero)?<br>&gt;&gt;&gt;
<br>&gt;&gt;&gt; Ok, XN_ISR_NOINT is removed in favor of XN_ISR_HANDLED whi=
ch is now<br>&gt;&gt;&gt; non-zero.<br>&gt;&gt;&gt; Actually, at first I wa=
nted to make it just the other way about.<br>&gt;&gt;&gt;<br>&gt;&gt; Hmm, =
thinking about this again, I would like to revert my suggestion in
<br>&gt;&gt; favour of a third approach (trying to keep you busy ;) ).<br>&=
gt;<br>&gt;<br>&gt; Ok, you are wellcome :)<br>&gt;<br>&gt; I didn't get it=
, at least while looking briefly. To make it a bit easier, at<br>&gt; least=
 for me, let's go another way.
<br>&gt;<br>&gt; At the left is the list of allowed values as Philippe poin=
ted out.<br>&gt; At the right is another list which corresponds to the left=
 one but when<br>&gt; NOINT is used instead of HANDLED. Moreover, I have ad=
ded another case - pure
<br>&gt; NOINT. The ISR says it's not mine and, well, it doesn't know wheth=
er it<br>&gt; should be propagated or no<br>&gt; (ok, so far CHAINED stande=
d for NOINT).<br>&gt;<br>&gt;
1.)
HANDLED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
-&gt;&nbsp;&nbsp;0<br>&gt; 2.) HANDLED | ENABLE&nbsp;&nbsp;&nbsp;&nbsp; -&g=
t;&nbsp;&nbsp;ENABLE<br>&gt; 3.) HANDLED | CHAINED&nbsp;&nbsp;&nbsp;&nbsp;-=
&gt;&nbsp;&nbsp;CHAINED<br>&gt;
4.)
CHAINED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&gt;&nbsp;=
&nbsp;CHAINED
| NOINT<br>&gt;
5.)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&gt;&=
nbsp;&nbsp;
NOINT<br>&gt;<br>&gt; Could you provide the 3-d corresponding table using y=
our new flags?<br>&gt;<br><br>Still not 3D, but hopefully clarifying: :)</b=
lockquote><div><br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">1.) XN_=
ISR_HANDLED |XN_ISR_NO_ENABLE<br>
2.) XN_ISR_HANDLED<br>3.) XN_ISR_HANDLED | XN_ISR_PROPAGATE<br>&nbsp;&nbsp;=
&nbsp;&nbsp;(nucleus ignores implicit IRQ enable)<br>4.) XN_ISR_NOINT | XN_=
ISR_PROPAGATE<br>5.) XN_ISR_NOINT</blockquote><div><br>
Then why do we need XN_ISR_NOINT? is it not just the same as ~HANDLED?<br>
<br>
Moreover, I tend to think now that PROPAGATE (CHAINED) should not be
normally used by ISRs at all. The only exception would be irq sharing
between RT and non-RT domains, but that's of no concern for most part
of rt drivers and, as last events revealed, it's very partially
supported at the moment and possible implementations are quite arguable.<br=
>
<br>
So HANDLED means the irq line is .end-ed by xnintr_irq_handler() (xnarch_en=
d_irq(irq)&nbsp; is called). <br>
<br>
If one wants to do it on his own later, NOENABLE can be returned additional=
ly.<br>
But then, one must use xnintr_end_irq() and not just xnintr_irq_enable().<b=
r>
<br>
If xnintr_end_irq() would be always the same as xnintr_irq_enable() or
we would decouple ending and enabling operations on the line (don't
have sources at hand); we could go Linux way and make use of a &quot;nested=
&quot;
counter in xnintr_t, so that xnintr_irq_disable() could be called in a
nested way.<br>
This said, calling xnintr_irq_disable() in ISR leads to the interrupt
line being still disabled upon return from xnintr_irq_handler() and
re-enabled again by the user later.<br>
</div><br>
~HANDLED means the ISR was not concerned about this interrupt. i.e. :<br>
<br>
- there is ISR in another domain (down the pipeline) which is interested in=
 this irq ;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; well, the designer of the system should be
aware of such cases and probably avoid that on hw layer or, at least,
to know what she is doing.<br>
<br>
- this is a spurious irq.<br>
<br>
So upon getting ~HANDLED, xnintr_irq_handler() does :<br>
<br>
success =3D xnintr_irq_chained(irq);<br>
<br>
if (success)<br>
{<br>
/* i.e. another domain is really interested and got this irq as pending*/<b=
r>
<br>
return without .end-ing<br>
}<br>
else<br>
{<br>
/* this is a spurious irq */<br>
<br>
make use of some accounting of spurious interrupts (if we need it)),
i.e. keep the irq line disabled if the % of unhandled requests &gt;
some limit.<br>
<br>
otherwise<br>
<br>
xnintr_end_irq() and return<br>
}<br>
<br>
too long :) ok, it's quite similar indeed to what you have suggested,<br>
with the exception that<br>
<br>
- no need for NOINT (if it's really =3D=3D ~HANDLED);<br>
- nucleus provides some additional logic while handling ~HANDLED case.<br>
- user don't need to return ENABLE explicitly - in most cases, that's
what he actually needs but sometimes just forgets (I recall a few
questions on the mailing list about &quot;only one interrupt&quot;.<br>
<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Jan<br><br></bloc=
kquote></div><br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_2936_28547361.1140118109114--

