Message-ID: <fd6a47a90602151250k4eb0b3b0s@domain.hid>
Date: Wed, 15 Feb 2006 21:50:32 +0100
From: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Subject: Re: [Xenomai-core] Handling PCI MSI interrupts
In-Reply-To: <43F38A5E.9030402@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_21700_3018616.1140036632993"
References: <fd6a47a90602140744lc1d4365q@domain.hid>
	<43F220D7.6040705@domain.hid>
	<fd6a47a90602141052u1e136db8y@domain.hid>
	<fd6a47a90602141133v6aeae6e1n@domain.hid>
	<fd6a47a90602141341j21ce1b77l@domain.hid>
	<43F2521E.7040200@domain.hid>
	<fd6a47a90602150300y5e435a22i@domain.hid>
	<fd6a47a90602151002q3f38748ep@domain.hid>
	<fd6a47a90602151034q8ed6920r@domain.hid>
	<43F38A5E.9030402@domain.hid>
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
Cc: xenomai-core <xenomai@xenomai.org>

------=_Part_21700_3018616.1140036632993
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>
> It's definitely an Adeos issue and msi.c needs fixing. What about this
> patch, do
> things improve with it (against 2.6.15-ipipe-1.2-00)?
>
> I going to try the patch later on. I have currently a =B4fully instrument=
ed=B4
kernel against which this patch would not ever work... I=B4m keeping that
kernel for now, because I=B4m also investigating why MSI also doesn=B4t wor=
k
under RTDM. It=B4s merely a coincidence that the above bug (MSI interrupts
from Linux devices getting blocked) emerged and produced exactly the same
behaviour (system hanging).

But, normally, that path is not used in RT mode, is it ? So something else
is getting in the way.

At the first look of it, I=B4m a bit wary of touching that msi.c . I was
rather thinking of kicking out __ack_APIC() altogether ? Or is that not
possible ? (I see only problems in p4.c and smp.c - but I haven=B4t looked =
at
these very closely.)

------=_Part_21700_3018616.1140036632993
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(=
204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">It's definit=
ely an Adeos issue and msi.c needs fixing. What about this patch, do<br>thi=
ngs improve with it (against=20
2.6.15-ipipe-1.2-00)?<br><br>
</blockquote></div>I going to try the patch later on. I have currently
a =B4fully instrumented=B4 kernel against which this patch would not ever
work... I=B4m keeping that kernel for now, because I=B4m also investigating
why MSI also doesn=B4t work under RTDM. It=B4s merely a coincidence that
the above bug (MSI interrupts from Linux devices getting blocked)
emerged and produced exactly the same behaviour (system hanging).<br>
<br>
But, normally, that path is not used in RT mode, is it ? So something else =
is getting in the way.<br>
<br>
At the first look of it, I=B4m a bit wary of touching that msi.c . I was
rather thinking of kicking out __ack_APIC() altogether ? Or is that not
possible ? (I see only problems in p4.c and smp.c - but I haven=B4t
looked at these very closely.)<br>
<br>
<br>

------=_Part_21700_3018616.1140036632993--

