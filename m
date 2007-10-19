Message-ID: <2ff1a98a0710190320w527bd477jc6860c14d52407de@domain.hid>
Date: Fri, 19 Oct 2007 12:20:05 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <op.t0fvtdsnt06gyn@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <op.t0fvtdsnt06gyn@domain.hid>
Subject: Re: [Xenomai-help] array declaration of double values causes seg
	faults
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

On 10/19/07, Axel Beierlein <belatronix@domain.hid> wrote:
> Hello,
>
> i try to use a simple function inside of an RT-Task in Userspace. Inside
> of this function i only declare three array=B4s of doubles with 5000 valu=
es
> in it.
> When i run the program a seg fault was shown. When i replace the array
> declaration with an printf the seg fault is away.
>
> Do i have memory limitations inside of an RT-Task?
>
> I use Xeno 2.3.1 with an 2.4.25 Kernel

When declaring variables in a function, memory is reserved on the
stack. So, if you get a segfault, you probably exhausted the RT-task
stack.

--=20
                                               Gilles Chanteperdrix

