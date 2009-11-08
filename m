MIME-Version: 1.0
In-Reply-To: <4AF46574.6010105@domain.hid>
References: <9b6d86ab0911050148k55e1d4a2k5c7e373da1357352@domain.hid> 
	<4AF46574.6010105@domain.hid>
From: Vincent Vanbesien <vincent.vanbesien@domain.hid>
Date: Sun, 8 Nov 2009 20:59:51 +0100
Message-ID: <9b6d86ab0911081159s254db179j3eee97c0d6c23590@domain.hid>
Content-Type: multipart/alternative; boundary=001485f723da4895620477e1865a
Subject: Re: [Xenomai-help] Porting Adeos-Ipipe on AVR32 (NGW 100).
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--001485f723da4895620477e1865a
Content-Type: text/plain; charset=ISO-8859-1

2009/11/6 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Vincent Vanbesien wrote:
> > It is maybe not the first time you receive this email sorry for
> > disappointment.
> >
> > Hello,
> > We are two students from Nantes (FRANCE) and we have to port adeos-Ipipe
> > on an AVR32.
> > We would like to know if there is already something which have been done
> > about that ? We checked the  Ipipe repository
> > http://git.denx.de/?p=ipipe-2.6.git;a=summary and we did not find
> > anything which would have benn done about the architecture AVR32.
> > best regards
> > BinomeB and BinomeA
> > Polytech'Nantes
>

Hello,
We are starting to port Adeos for the IRQs part. So now we have to program
the function __ipipe_handle_irq for the AVR32 architecture. First we are
reading the one for x86. It seems there are generic functions as for example
"ipipe_apic_vector_irq". We tried to find its definition but we didn't
achieve.
Do you know where is the definition? And do you know if there is
documentation about generic functions?
We know the following Adeos
documentation<http://home.gna.org/adeos/doc/api/globals.html>but there
is no function which begins with "ipipe_"
Regards
BinomeA and BinomeB

--001485f723da4895620477e1865a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote">2009/11/6 Gilles Chanteperdrix <span dir=3D"=
ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chantep=
erdrix@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" styl=
e=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; =
padding-left: 1ex;">

Vincent Vanbesien wrote:<br>
&gt; It is maybe not the first time you receive this email sorry for<br>
&gt; disappointment.<br>
&gt;<br>
&gt; Hello,<br>
&gt; We are two students from Nantes (FRANCE) and we have to port adeos-Ipi=
pe<br>
&gt; on an AVR32.<br>
&gt; We would like to know if there is already something which have been do=
ne<br>
&gt; about that ? We checked the =A0Ipipe repository<br>
&gt; <a href=3D"http://git.denx.de/?p=3Dipipe-2.6.git;a=3Dsummary" target=
=3D"_blank">http://git.denx.de/?p=3Dipipe-2.6.git;a=3Dsummary</a> and we di=
d not find<br>
&gt; anything which would have benn done about the architecture AVR32.<br>
&gt; best regards<br>
&gt; BinomeB and BinomeA<br>
&gt; Polytech&#39;Nantes<br></blockquote><div><br>Hello,<br>We are starting=
 to port Adeos for the IRQs part. So now we
have to program the function __ipipe_handle_irq for the AVR32
architecture. First we are reading the one for x86. It seems there are
generic functions as for example &quot;ipipe_apic_vector_irq&quot;. We trie=
d to
find its definition but we didn&#39;t achieve. <br>
Do you know where is the definition? And do you know if there is documentat=
ion about generic functions? <br>We know the following Adeos <a href=3D"htt=
p://home.gna.org/adeos/doc/api/globals.html" target=3D"_blank">documentatio=
n</a> but there is no function which begins with &quot;ipipe_&quot;<br>


Regards<br>BinomeA and BinomeB <br></div></div>

--001485f723da4895620477e1865a--

