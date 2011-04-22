Message-ID: <4DB143E8.3000900@domain.hid>
Date: Fri, 22 Apr 2011 11:01:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTimmraMpqpZ2areb0z9aC2U19SE5_w@domain.hid>
In-Reply-To: <BANLkTimmraMpqpZ2areb0z9aC2U19SE5_w@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] first module help
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Aurele Traynard <aurele.traynard@domain.hid>
Cc: xenomai@xenomai.org

Aurele Traynard wrote:
> hello,
>=20
> I am new in xenomai, I am trying to make a module to read a "FPGA regis=
ter"
> who is on the "data bus".
> without xenomai I use "ioremap" and "readl/writel" but with xenomai tho=
se
> doesn't work...
>
> so i would like to know how i could read this register?
> i would like to know if there is a book i could read?


Ok. No answer, I probably started on the wrong foot. First, you should
read the documents here:

http://www.xenomai.org/index.php/Publications
http://www.xenomai.org/index.php/Included_documentation_summary

More generally, we try to have most ressources in the wiki
http://www.xenomai.org

Then, you will understand that your question is a bit vague. I recently
answered the more precise question which you will probably have after
you have read all this, see:
https://mail.gna.org/public/xenomai-help/2011-04/msg00059.html

> i would like to know if a rt_task can read/write memory allocated by th=
e
> kernel ("kmalloc")?

Yes, it can.

> i would like to know if there are any forums where i could find any hel=
p?
>=20
> i would like to know a lots of things...


This list is the right place to ask, but please take care of reading the
documentation and especially the FAQ, in order to avoid asking questions
 which have already been asked.

http://www.xenomai.org/index.php/FAQs


> thanks for any help
>=20
> Aur=C3=A8le
>=20
> PS : http://www.captain.at/xenomai.php is dead...

This site is not Xenomai website, so, there is nothing we can do about it=
=2E


--=20
					    Gilles.


