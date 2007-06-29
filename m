Message-ID: <2ff1a98a0706290847n499a3ffdr346f5bd6d9c75754@domain.hid>
Date: Fri, 29 Jun 2007 17:47:32 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <op.tuom7dvpt06gyn@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <op.tuom7dvpt06gyn@domain.hid>
Subject: Re: [Xenomai-help] Kompiling an RT Kernel Module
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Axel Beierlein <belatronix@domain.hid>
Cc: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

On 6/29/07, Axel Beierlein <belatronix@domain.hid> wrote:
> I can=B4t use the output of xeno-config cause the rootfs on my target(ppc=
)
> is mounted over NFS from my development host(i386).

As said by others, xeno-config is not meant to be used for building
modules. However xeno-config is meant to be used in the
cross-compiling case: this is what its DESTDIR variable is for.

--=20
                                               Gilles Chanteperdrix

