Message-ID: <2ff1a98a0708090622n7e9ca37bya6409b4abd1ccb7b@domain.hid>
Date: Thu, 9 Aug 2007 15:22:45 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <54803.194.114.62.34.1186665301.squirrel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <54803.194.114.62.34.1186665301.squirrel@domain.hid>
Subject: Re: [Xenomai-help] Xenomai kernel panic
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nadym Salem <Kaiman@domain.hid>
Cc: Xenomai-help@domain.hid

On 8/9/07, Nadym Salem <Kaiman@domain.hid> wrote:
> Hi Jan,
>
> as I wanted to get the new patch for Xenomai (as discussed in rtnet
> mailing list for the rt_dev_close() issue) I had to install Xenomai 2.4.
> Xenomai 2.3.2 with Rtnet 0.9.9 didn't make any trouble.
> Since I installed 2.4 with Kernel 2.6.20 the Kernel doesn't start anymore=
.
> We used the same config and the same kernel but now the kernel doesn't
> find the hard-disc anymore (waiting f=FCr /sys/block/sda/dev: no such fil=
e
> or directory).
> Any idea  ?

The configuration of the SATA discs changed in recent kernel, be sure
to enable your sata controller in the new menu (Serial ATA (prod) and
Parallel AT (experimental) drivers)
--=20
                                               Gilles Chanteperdrix

