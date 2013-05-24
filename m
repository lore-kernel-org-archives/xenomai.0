From: Wolfgang Denk <wd@denx.de>
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <519F08C1.6060306@xenomai.org>
References: <E9605457112439448B6B3ED284E06533317AC337@mbx256-1.adm.swri.edu>
	<20130523213304.D53E738047C@gemini.denx.de>
	<519F08C1.6060306@xenomai.org>
Date: Fri, 24 May 2013 09:22:36 +0200
Message-Id: <20130524072236.A90C738047C@gemini.denx.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Next Xenomai Release?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Dear Gilles,

In message <519F08C1.6060306@xenomai.org> you wrote:
>=20
> > Adding support for a v3.8.x kernel appears to be not really
> > attractive, given that v3.8 has already reached EOL...
>=20
> From what I understand from this post:
> http://www.linuxfoundation.org/news-media/blogs/browse/2013/02/linux-38=
-not-longterm-kernel
>=20
> And this page:
> https://www.kernel.org/category/releases.html
>=20
> Every stable kernel until october 2013 will be EOLed when the next
> kernel is out.
>=20
> So, any other kernel than 3.0 and 3.4 is not "attractive" until october
> 2013.

Yes, probably.  The whole situation with LTS trees is IMO deeply
dissatisfactory, as it is not possible to plan anything in advance.
This has been discussed a couple of times before, but Greg Kroah-
Hartman refuses to provide any information in advance; he repeatedly
stated that a LTS kernel will be declared as such only after the
release; appearently after sufficent testing by a large number of
users has verified that there anre not too many serious issues in it.

> As it turns out however, 3.8 is a bit less unattractive than the others=
,
> because Canonical seem to have announced they would be maintaining it
> for a while longer (until August 2014, it seems) in the following post:
> https://lwn.net/Articles/550581/

Yes, indeed - but I wonder where this will lead to.  Now we have
"official" stable kernel trees, and in addition vendor specific stable
trees - this doesn't really scale to me.  If Canonical is willing to
support 3.8 longer, they should take over the stable tree on
kernel.org from Greg Kroah-Hartman.  But this is off topic here...

In any case, the whole situation is a mess.

Best regards,

Wolfgang Denk

--=20
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A stone was placed at a ford in a river with the inscription:
"When this stone is covered it is dangerous to ford here."

