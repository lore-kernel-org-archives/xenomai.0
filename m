Message-ID: <2ff1a98a0801280241s2cf15284j4608b3a7791ac333@domain.hid>
Date: Mon, 28 Jan 2008 11:41:31 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <479DAE31.5070108@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <479DAA2E.7000307@domain.hid>
	<2ff1a98a0801280221h7cf2cb4cl84c696bfb51887a5@domain.hid>
	<479DAE31.5070108@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] consistent xeno-config output
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-core@domain.hid

On Jan 28, 2008 11:28 AM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Gilles Chanteperdrix wrote:
> > On Jan 28, 2008 11:10 AM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> >> I received some complaint that xeno-config [--verbose] does not match
> >> xeno-config --posix-ldflags. Here is a fix.
> >
> > Useless use of cat detected ! When parsing posix.wrappers, we could
> > redirect input from posix.wrappers instead of using cat.
> >
>
> OK. Is this one better?

I would say there is still a useless use of backticks, why use:
echo `posix_ldflags`
instead of simply:
posix_ldflags
echo

?

-- 
                                               Gilles Chanteperdrix

