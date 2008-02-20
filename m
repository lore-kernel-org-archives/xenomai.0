Message-ID: <8616.62.39.72.60.1203528542.squirrel@domain.hid>
In-Reply-To: <18363.24363.926803.782361@domain.hid>
References: <15295.81.252.86.91.1203350819.squirrel@domain.hid>
	<2ff1a98a0802180813t5e2dcd98sc0af6db3f8f3439a@domain.hid>
	<3453.62.39.72.60.1203416373.squirrel@domain.hid>
	<18363.24363.926803.782361@domain.hid>
Date: Wed, 20 Feb 2008 18:29:02 +0100 (CET)
From: "Fabien MAHOT" <fabien.mahot@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Problem of thread creation with Xenomai Posix 2
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> I can reproduce the issue you have if I disable the "priority coupling"
> option in kernel configuration menu. With this option enabled, the
> scheduler works as you expect, even without the latest posix skin fixes=
.
>
> For more information on priority coupling, read the help in kernel
> configuration menu.
>
> --
>
>
> 					    Gilles Chanteperdrix.
>

Thanks a lot, my program works correctly now. There is just the preemptio=
n
problem during pthread_create. Nonce, I use mutex but I can't add it for
all the parts of my application.


