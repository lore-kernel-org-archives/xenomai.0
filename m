Message-ID: <4EF5D57B.2080305@domain.hid>
Date: Sat, 24 Dec 2011 14:36:59 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CADwQ9Q51ze5gtxU9ObHqGxW8nJpM--eQhWvzmf5y2MhcxN0xXQ@mail.gmail.com>
In-Reply-To: <CADwQ9Q51ze5gtxU9ObHqGxW8nJpM--eQhWvzmf5y2MhcxN0xXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] How to Adapt ARM I-pipe patch to S3C6410
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?6ZmI5pmT?= <chenzl92@domain.hid>
Cc: xenomai@xenomai.org

On 12/24/2011 03:10 AM, =E9=99=88=E6=99=93 wrote:
> sorry for the mistake,my ipipe-patch is
> adeos-ipipe-2.6.37.6-arm-1.18-03   ,and where can I get the new
> "HowTo" as it maybe out of date.
> As I said,I add the printascii function in the begin of
> start_kernel(),but it didn't print out ,so I believe it didn't go to
> the start_kernel. I also add the printascii function to the
> arch/arm/kernel/head.S,I found when it run to "enable the mmu" it
> stopped. I believe the .config file works well before I patch the
> xenomai .I also believe the xenomai has nothing to do with the setup
> of hardware before the kernel startup.
>=20

There is no updated version of the howto. But the only wrong thing is
the part about multiplexed interrupts.

You should try printascii with a non-patched kernel to verify that
printascii works for the board you use.

As for using printascii around the place where the mmu is enabled, have
you read the following comment in the kernel sources:

/*
 * Enable the MMU.  This completely changes the structure of the visible
 * memory space.  You will not be able to trace execution through this.
 * If you have an enquiry about this, *please* check the linux-arm-kernel=

 * mailing list archives BEFORE sending another post to the list.

Anyway, as early in the boot process the I-pipe patch does not change
anything, so, your problem does not come from the I-pipe patch. Have you
tried the exact same config you use with the patched kernel with an
unpatched kernel?

--=20
                                                                Gilles.


