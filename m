Date: Wed, 22 Feb 2006 06:21:50 -0800
Subject: Re: [Xenomai-help] no-brainer issue found, but not solved
From: Steven Seeger <steve@domain.hid>
Message-ID: <C021B37E.24C4%steve@domain.hid>
In-Reply-To: <fd6a47a90602211320k21eb3b8w@domain.hid>
Mime-version: 1.0
Content-type: multipart/alternative;
	boundary="B_3223434111_8818570"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>, Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

> This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--B_3223434111_8818570
Content-type: text/plain;
	charset="ISO-8859-1"
Content-transfer-encoding: quoted-printable

There is a awful amount of code in this project, and I should point out tha=
t
this same code did not exhibit these problems under a fusion cvs from
October. I can see about posting the full code, but my supervisors don=B9t
want anything having our hardware addresses in it going out.

This is an x86 board, so inb/outb are just instructions.

I know about the volatile thing but that isn=B9t my problem. I=B9m having
realtime preemption issues.

Steven

On 2/21/06 1:20 PM, "Jeroen Van den Keybus" <jeroen.vandenkeybus@domain.hid>
wrote:

> It would be helpful if a complete code could be posted. That means, inclu=
ding
> the main() function, in which the task dispatching is done as well.
> =20
> Furthermore, be sure to declare counting variables inside waiting loops w=
ith
> the 'volatile' specifier. The compiler might optimize it away otherwise.
> =20
> Another, maybe dumb suggestion: how is inb() / outb() actually implemente=
d on
> your platform ?
> =20
> =20
> Jeroen.
> =20
>=20



--B_3223434111_8818570
Content-type: text/html;
	charset="ISO-8859-1"
Content-transfer-encoding: quoted-printable

<HTML>
<HEAD>
<TITLE>Re: [Xenomai-help] no-brainer issue found, but not solved</TITLE>
</HEAD>
<BODY>
<FONT FACE=3D"Verdana, Helvetica, Arial"><SPAN STYLE=3D'font-size:12.0px'>There=
 is a awful amount of code in this project, and I should point out that this=
 same code did not exhibit these problems under a fusion cvs from October. I=
 can see about posting the full code, but my supervisors don&#8217;t want an=
ything having our hardware addresses in it going out.<BR>
<BR>
This is an x86 board, so inb/outb are just instructions. <BR>
<BR>
I know about the volatile thing but that isn&#8217;t my problem. I&#8217;m =
having realtime preemption issues.<BR>
<BR>
Steven<BR>
<BR>
On 2/21/06 1:20 PM, &quot;Jeroen Van den Keybus&quot; &lt;jeroen.vandenkeyb=
us@domain.hid&gt; wrote:<BR>
<BR>
</SPAN></FONT><BLOCKQUOTE><FONT FACE=3D"Verdana, Helvetica, Arial"><SPAN STYL=
E=3D'font-size:12.0px'>It would be helpful if a complete code could be posted.=
 That means, including the main() function, in which the task dispatching is=
 done as well.<BR>
&nbsp;<BR>
Furthermore, be sure to declare counting variables inside waiting loops wit=
h the 'volatile' specifier. The compiler might optimize it away otherwise.<B=
R>
&nbsp;<BR>
Another, maybe dumb suggestion: how is inb() / outb() actually implemented =
on your platform ?<BR>
&nbsp;<BR>
&nbsp;<BR>
Jeroen.<BR>
&nbsp;<BR>
<BR>
</SPAN></FONT></BLOCKQUOTE><FONT FACE=3D"Verdana, Helvetica, Arial"><SPAN STY=
LE=3D'font-size:12.0px'><BR>
</SPAN></FONT>
</BODY>
</HTML>


--B_3223434111_8818570--


