Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 4 Jun 2008 17:09:38 +0200
Message-ID: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E025B28C8@domain.hid>
In-Reply-To: <2ff1a98a0806040754u8c3efd6u3121786c8fea43e@domain.hid>
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E025B28C5@domain.hid>
	<2ff1a98a0806040640s544b34d9rb11d833dd616bfae@domain.hid>
	<E5E9C6CC7DC8844A8DA7A9EFE7B5350E025B28C6@domain.hid>
	<2ff1a98a0806040754u8c3efd6u3121786c8fea43e@domain.hid>
From: "Markus Osterried" <markus.osterried@domain.hid>
Subject: Re: [Xenomai-core] system hangs with "ifconfig eth0 down"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-core@domain.hid

Hi,

our kernel (along with the device drivers) is specifically adapted to
our embedded system, it would be a huge bunch of work to change the
kernel.
I think to do the ipipe backport is a lot easier.

Markus


-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Sent: Mittwoch, 4. Juni 2008 16:55
To: Markus Osterried
Cc: Xenomai-core@domain.hid
Subject: Re: [Xenomai-core] system hangs with "ifconfig eth0 down"

On Wed, Jun 4, 2008 at 4:35 PM, Markus Osterried
<markus.osterried@domain.hid> wrote:
> Hi,
>
> thank you for the fast response.
> Can you give me a hint which patch this is?
> We use kernel 2.6.18 and ipipe 1.5-01, which I think is the latest for

> this kernel.
> We could backport the ipipe patch, but we don't want to change the=20
> kernel.
> Thanks.

Could you try with the latest kernel first ? We will tell you what to
backport if this solves your issue.

--
 Gilles

