From: Wolfgang Denk <wd@domain.hid>
Subject: Re: [Xenomai-core] Re: Xenomai broken on Linux 2.4 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 12 Jan 2006 23:06:45 +0100."
	<43C6D2F5.2050607@domain.hid> 
Date: Fri, 13 Jan 2006 02:14:49 +0100
Sender: wd@domain.hid
Message-Id: <20060113011449.E32C7353CCD@atlas.denx.de>
Content-Transfer-Encoding: quoted-printable
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
Cc: xenomai@xenomai.org

Dear Philippe,

in message <43C6D2F5.2050607@domain.hid> you wrote:
>=20
> We try to find a way to wrap class_device_create properly depending on =
the kernel=20
> version Xeno is compiled against. The parent device class argument in t=
his call=20
> (2nd in order) seems to show up in 2.6.15 for kernel.org, but 2.6.14-de=
nx-git has=20
> it too. So we have a problem relying on the version sublevel.

I see. Well, I feel honored, but the reference in such  cases  should
always be Linus' tree (i. e. the "official" kernel.org tree). Xenomai
cannot  and  should  not  have  to be considerate of all the N vendor
kernel trees that exist out there in the wild...

And if some user should use our old 2.6.14 tree and run into problems
we can just tell him to use  current  code  -  so  no  problem  here,
either.

Please use kernel.org as reference (and  remember  that  decision  in
case other vendors should come urging you).

Best regards,

Wolfgang Denk

--=20
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
"Unix is simple, but it takes a genius to understand the simplicity."
					             - Dennis Ritchie

