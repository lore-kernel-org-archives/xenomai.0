Message-ID: <b647ffbd0601061206y79ac77a4o@domain.hid>
Date: Fri, 6 Jan 2006 22:06:49 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
In-Reply-To: <b647ffbd0601061202g4414bb86k@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_52854_24192654.1136578009027"
References: <b647ffbd0512310437x6e92487es@domain.hid>
	<43B69CEC.1040606@domain.hid>
	<b647ffbd0601021042h140c0f7dk@domain.hid>
	<b647ffbd0601021043n1e8704aco@domain.hid>
	<43BD6CC1.7080103@domain.hid>
	<b647ffbd0601061202g4414bb86k@domain.hid>
Subject: [Xenomai-core] Re: [PATCH,
	RFC] nucleus:shared irq and possible ipipe problem
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_52854_24192654.1136578009027
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 05/01/06, Philippe Gerum <rpm@xenomai.org> wrote:
>
> Dmitry Adamushko wrote:
> >
> > err... I have to orginize some issues next few days so I'll be out of m=
y
> > notebook. Then I'll finilize the ipipe-irq-related patch so to be ready
> > for the .01 version.
> >
>
> Meanwhile, I have finished merging the shared IRQ infrastructure into
> the Adeos codebase for all supported archs. The Xenomai trunk/ has been
> upgraded accordingly too.


Thanks and sorry for aditionally taking your time on some work I shoud have
completed on my own.
Actually this infrastructure is by no means a _must_ for introducing the
shared irq feature on the nucleus layer.

I doubt that we may gain any noticeable benefits, latency-wise, having got
the one-layer-less irq processing chain. Just hope there is no regression.

So, my hope is rather that the new interface has become a bit more clear an=
d
usefull, e.g. there is no need to implement any other per-irq tables to
introduce the "cookie" concept no matter where it has to be used (even
directly at the adeos layer).



x86-wise, please make sure to rebase your
> development on 1.1-02.


Sure.


--
>
> Philippe.
>



--
Best regards,
Dmitry Adamushko

------=_Part_52854_24192654.1136578009027
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 05/01/06, <b class=3D"gmail_sendername">Philippe Gerum</b> &lt;<a href=
=3D"mailto:rpm@xenomai.org" target=3D"_blank" onclick=3D"return top.js.Open=
ExtLink(window,event,this)">rpm@xenomai.org</a>&gt; wrote:<div><span class=
=3D"q"><span class=3D"gmail_quote">
</span><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rg=
b(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Dmitry Adamushko wrote:<br>&gt;<br>&gt; err... I have to orginize some issu=
es next few days so I'll be out of my<br>&gt; notebook. Then I'll finilize =
the ipipe-irq-related patch so to be ready<br>&gt; for the .01 version.
<br>&gt;<br><br>Meanwhile, I have finished merging the shared IRQ infrastru=
cture into<br>the Adeos codebase for all supported archs. The Xenomai trunk=
/ has been<br>upgraded accordingly too.</blockquote></span><div><br>
Thanks and sorry for aditionally taking your time on some work I shoud have=
 completed on my own.<br>
Actually this infrastructure is by no means a _must_ for introducing the sh=
ared irq feature on the nucleus layer.<br>
<br>
I doubt that we may gain any noticeable benefits, latency-wise, having
got the one-layer-less irq processing chain. Just hope there is no
regression.<br>
<br>
So, my hope is rather that the new interface has become a bit more
clear and usefull, e.g. there is no need to implement any other per-irq
tables to introduce the &quot;cookie&quot; concept no matter where it has t=
o be
used (even directly at the adeos layer).<br>
 <br>
<br>
</div><span class=3D"q"><br><blockquote class=3D"gmail_quote" style=3D"bord=
er-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-l=
eft: 1ex;"> x86-wise, please make sure to rebase your<br>development on 1.1=
-02
.</blockquote>
</span><div><br>
Sure.<br>
&nbsp;</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px=
 solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">-=
-<br><br>Philippe.<br></blockquote></div><br><br clear=3D"all"><br>-- <br>B=
est regards,
<br><span class=3D"sg">Dmitry Adamushko

</span><br clear=3D"all"><br>


------=_Part_52854_24192654.1136578009027--

