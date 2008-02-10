Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 10 Feb 2008 08:32:58 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D376ACD@slcmail.slc.mew.int>
In-Reply-To: <18349.43717.622653.136257@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D376AB6@domain.hid>
	<18349.43717.622653.136257@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] fpu issue
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

 > An idea is to disassemble the kernel task code and the function it
calls
> to see if FPU is really never used.
>=20
> If this task really never calls any function using FPU, it would be
nice
> if you could (as we always ask, you may have noticed) reduce your test
> case to a simple code where only FPU operations and every thing which
> causes task switches (blocking calls, and calls waking up other tasks)
> is kept.

My application has 12 threads most of which wait on queues. How am I
going to reduce this to a simple case? Most of my threads are userspace
except for 2.=20

I guess I'll see what I can do. I'll try the disassembler, too.

Steven=20

