Message-ID: <2ff1a98a0806040640s544b34d9rb11d833dd616bfae@domain.hid>
Date: Wed, 4 Jun 2008 15:40:29 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E025B28C5@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E025B28C5@domain.hid>
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
To: Markus Osterried <markus.osterried@domain.hid>
Cc: Xenomai-core@domain.hid

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
> On the other hand, if I call "ifconfig eth0 down" from a shell outside the
> Xenomai-application, it works also fine.
>
> I have reduced the whole application to only one pSOS-thread which only call
> system(), it crashes.
> If I call system() in the main() function before creating/starting the
> pSOS-thread, it works fine.
>
> Anybody any idea why this call to system() doesn't work from inside the
> application?

A similar issue has been fixed in recent I-pipe patches. Could you try
a more recent I-pipe patch ?

-- 
 Gilles

