From: Wolfgang Denk <wd@domain.hid>
Subject: Re: [Adeos-main] Re: [RFC] git workflow 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 19 Dec 2006 15:40:14 +0100."
	<4587F9CE.3060403@domain.hid> 
Date: Tue, 19 Dec 2006 17:42:22 +0100
Sender: wd@domain.hid
Message-Id: <20061219164222.EB5D735261B@atlas.denx.de>
Content-Transfer-Encoding: quoted-printable
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, adeos-main <adeos-main@gna.org>

In message <4587F9CE.3060403@domain.hid> you wrote:
>=20
> Once there is a public tree with 2.6.20-rc1 + ipipe + -rc2, you cannot
> simply turn that tree into 2.6.20-rc1 + -rc2 + ipipe. The order of
> patches is practically frozen once published. In your private tree you
> are, of course, free to do this and then extract some patch to post
> upstream.

I'm not sure if it really makes sense to maintain this as a git
repository - that would be OK if we wanted to provide a pre-patched
tree to the public (which might be a good thing to have, btw.).

As long as we're basicly trying to manage the patches in a way that
integrates well with git we should do exactly that: manage the
patches under git, i. e. use stgit (see http://www.procode.org/stgit/).

Just my 0.02 <insert your favorite currency unit here>

Best regards,

Wolfgang Denk

--=20
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
The best things in life are for a fee.

