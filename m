Message-ID: <fd6a47a90602010157w57051089p@domain.hid>
Date: Wed, 1 Feb 2006 10:57:25 +0100
From: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Subject: Re: [Xenomai-core] [BUG] racy xnshadow_harden under CONFIG_PREEMPT
In-Reply-To: <43DFDA6E.5000700@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_2886_26224456.1138787845834"
References: <43D21144.8040005@domain.hid>
	<b647ffbd0601220010x3cc023an@domain.hid>
	<fd6a47a90601220819n3f4cd382t@domain.hid>
	<E1F16LA-0001ku-C4@domain.hid> <43D52BA3.6020005@domain.hid>
	<43DE27E5.3010206@domain.hid> <43DE3243.8080603@domain.hid>
	<fd6a47a90601311309i18d2ab31i@domain.hid>
	<43DFDA6E.5000700@domain.hid>
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

------=_Part_2886_26224456.1138787845834
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>
> > I've installed both patches and the problem seems to have disappeared.
> > I'll try it on another machine tomorrow, too. Meanwhile: thanks very
> > much for the assistance !


While testing more thoroughly, my triggers for zero mutex values after
acquiring the lock are going off again. I was using the SVN xenomai
development tree, but I've now switched to the (fixed) 2.1-rc2 in order to
apply the patches. Is Jan's bugfix included in that one ?

Jeroen.

------=_Part_2886_26224456.1138787845834
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">&gt; I've installed both patches=
 and the problem seems to have disappeared.<br>&gt; I'll try it on another =
machine tomorrow, too. Meanwhile: thanks very
<br>&gt; much for the assistance !</blockquote>
<div>&nbsp;</div>
<div>While testing more thoroughly, my triggers for zero mutex values after=
 acquiring the lock are going off again.&nbsp;I was&nbsp;using the SVN xeno=
mai development tree, but I've now switched to the (fixed) 2.1-rc2 in order=
 to apply the patches. Is Jan's bugfix included in that one ?
</div>
<div>&nbsp;</div>
<div>Jeroen.</div>
<div>&nbsp;</div><br>&nbsp;</div>

------=_Part_2886_26224456.1138787845834--

