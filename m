Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 4 Jun 2008 16:35:36 +0200
Message-ID: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E025B28C6@domain.hid>
In-Reply-To: <2ff1a98a0806040640s544b34d9rb11d833dd616bfae@domain.hid>
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E025B28C5@domain.hid>
	<2ff1a98a0806040640s544b34d9rb11d833dd616bfae@domain.hid>
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

thank you for the fast response.
Can you give me a hint which patch this is?
We use kernel 2.6.18 and ipipe 1.5-01, which I think is the latest for
this kernel.
We could backport the ipipe patch, but we don't want to change the
kernel.
Thanks.

Markus



-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Sent: Mittwoch, 4. Juni 2008 15:40
To: Markus Osterried
Cc: Xenomai-core@domain.hid
Subject: Re: [Xenomai-core] system hangs with "ifconfig eth0 down"

On Wed, Jun 4, 2008 at 3:10 PM, Markus Osterried
<markus.osterried@domain.hid> wrote:
> Hi,
>
> I am using Xenomai with pSOS-skin.
> The application and the whole system crashes when I call the following

> statement from a pSOS-thread:
>
> system("ifconfig eth0 down");
>
> Any other call to system(), e.g. system("ls") works fine.
> On the other hand, if I call "ifconfig eth0 down" from a shell outside

> the Xenomai-application, it works also fine.
>
> I have reduced the whole application to only one pSOS-thread which=20
> only call system(), it crashes.
> If I call system() in the main() function before creating/starting the

> pSOS-thread, it works fine.
>
> Anybody any idea why this call to system() doesn't work from inside=20
> the application?

A similar issue has been fixed in recent I-pipe patches. Could you try a
more recent I-pipe patch ?

--
 Gilles

