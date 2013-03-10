Message-ID: <513CE48D.60304@web.de>
Date: Sun, 10 Mar 2013 20:52:45 +0100
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <513CDF10.8000305@xenomai.org>
In-Reply-To: <513CDF10.8000305@xenomai.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] recursive dependency
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

On 2013-03-10 20:29, Gilles Chanteperdrix wrote:
> =

> Hi,
> =

> I get this warning when compiling Xenomai based on Linux 3.8 for ARM:
> =

> kernel/ipipe/Kconfig:1:error: recursive dependency detected!
> kernel/ipipe/Kconfig:1: symbol IPIPE is selected by XENOMAI
> init/Kconfig:1763:      symbol XENOMAI depends on IPIPE_CORE
> kernel/ipipe/Kconfig:16:        symbol IPIPE_CORE depends on IPIPE
> =

> Any idea how to avoid this?

Did you try my Xenomai upstream queue for 3.8? This should resolve the
cyclic dependency:
http://git.xenomai.org/?p=3Dxenomai-jki.git;a=3Dcommitdiff;h=3Dba0fcc1736c4=
e3ad05389b74ffbef50f7096a1df

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130310/100c435=
3/attachment.pgp>
