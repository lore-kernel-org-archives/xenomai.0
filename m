From: Wolfgang Denk <wd@domain.hid>
Subject: Re: [Adeos-main] Re: [RFC] git workflow 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 19 Dec 2006 17:59:21 +0100."
	<45881A69.1040704@domain.hid> 
Date: Tue, 19 Dec 2006 22:30:10 +0100
Sender: wd@domain.hid
Message-Id: <20061219213010.AF2A4352664@domain.hid>
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

Dear Jan,

in message <45881A69.1040704@domain.hid> you wrote:
>
> This is one of my motivations to push git forward. Having
> 2.6.20-rcX+ipipe already available for download and testing may help to
> follow the kernel development on the bleeding edge more closely.

Agreed.

> The other aspect is that when you merge the kernel patches into a
> working ipipe tree and you get a conflict, you also directly obtain
> information about what change caused it and maybe what the background o=
f
> that patch was. That's at least my theory which still needs to be prove=
n
> in practice.

THis will work, but if you go this route you will sonn have the git
repo only, as it will become more and more difficult to extract the
ipipe patches which you need anyway.

That's why I recommend to use stgit to maintain the ipipe patches. So
you have a clearly defined flow of information.

> I heard about it before, but I still have to take a closer look. Does
> this generate also some kind of publishable git tree with history for
> the managed patches? ...

Yes, it does.

>                  ... One problem with a stack might be that we loose
> information about ipipe changes themselves. ...

No, that's not true, as the patches itself are managed under git,  so
you have the full power of git for the patch history, too.

This will be much more powerful than the  other  approach  -  if  you
maintain  a  patched  tree  under git, it will be pretty difficult to
find out which changes make up the ipipe patch, and which  are  other
stuff.

>                                         ... My idea is that some
> modification to the ipipe core stored as commit in the reference tree
> could directly be pulled by other arch maintainers.

That sounds as if you are planning  to  use  stgit  already,  without
knowing it yet :-)

Best regards,

Wolfgang Denk

--=20
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
"Just think, with VLSI we can have 100 ENIACS on a chip!"
- Alan Perlis

