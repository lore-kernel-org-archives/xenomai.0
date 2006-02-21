Message-ID: <fd6a47a90602211320k21eb3b8w@domain.hid>
Date: Tue, 21 Feb 2006 22:20:45 +0100
From: "Jeroen Van den Keybus" <jeroen.vandenkeybus@domain.hid>
Subject: Re: [Xenomai-help] no-brainer issue found, but not solved
In-Reply-To: <43FB5DB1.2000703@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_6297_25822216.1140556845154"
References: <C02098C9.24B1%steve@domain.hid> <43FB5DB1.2000703@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

------=_Part_6297_25822216.1140556845154
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

It would be helpful if a complete code could be posted. That means,
including the main() function, in which the task dispatching is done as
well.

Furthermore, be sure to declare counting variables inside waiting loops wit=
h
the 'volatile' specifier. The compiler might optimize it away otherwise.

Another, maybe dumb suggestion: how is inb() / outb() actually implemented
on your platform ?


Jeroen.

------=_Part_6297_25822216.1140556845154
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>It would be helpful if a complete code could be posted. That means, in=
cluding the main() function, in which the task dispatching is done as well.=
</div>
<div>&nbsp;</div>
<div>Furthermore, be sure to declare counting variables inside&nbsp;waiting=
 loops with the 'volatile' specifier. The compiler might optimize it away o=
therwise.</div>
<div>&nbsp;</div>
<div>Another, maybe&nbsp;dumb suggestion: how is inb() / outb() actually im=
plemented on your platform ?</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Jeroen.</div>
<div>&nbsp;</div>

------=_Part_6297_25822216.1140556845154--

