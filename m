Message-ID: <4BAB1948.8080701@domain.hid>
Date: Thu, 25 Mar 2010 09:05:28 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <289790.83729.qm@domain.hid>
In-Reply-To: <289790.83729.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] dm9000 doesn't work well with
	the	adeos-ipipe-2.6.28.10-arm-1.12-06.patch
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?5p2wIHpoYW8=?= <zhjunjie2007@domain.hid>
Cc: xenomai@xenomai.org

=E6=9D=B0 zhao wrote:
> Hi all,
> I have compiled a kernel 2.6.28.10 +  xenomai2.5.1 and successfully
> booted on s3c2440 based board with DM9000, but ethernet comunication
> doesn't work and I see the following messagge; when i remove the Kernel=

> Features->interrupt pipeline support, the ethernet work well.Can someon=
e
> help me?

First, an unrelated question: does 2.6.30 boot? We received two reports
about people not being able to boot an I-pipe patched kernel on s3c24xx,
so, I am curious to know whether it could be a problem with the I-pipe
patch, or something else.

Now, about your issue, could you try and run:
cat /proc/interrupts
after observing the bug? What you should be looking for is whether the
ethernet driver interrupts counter increments or not.

--=20
					    Gilles.


