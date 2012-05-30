From: Wolfgang Denk <wd@denx.de>
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <CAM1yFZ-1YCqe6NdGKWtCSEAwqCnRqn1=1-5GrGWy-qEmPOZCHg@mail.gmail.com>
References: <CAM1yFZ-1YCqe6NdGKWtCSEAwqCnRqn1=1-5GrGWy-qEmPOZCHg@mail.gmail.com>
Date: Wed, 30 May 2012 09:32:33 +0200
Message-Id: <20120530073233.92A6A2064A6@gemini.denx.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] ARM9 TS-7800 Xenomai support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Anisha Kaul <born.rebel.83@gmail.com>
Cc: xenomai@xenomai.org

Dear Anisha,

In message <CAM1yFZ-1YCqe6NdGKWtCSEAwqCnRqn1=3D1-5GrGWy-qEmPOZCHg@mail.gm=
ail.com> you wrote:
>=20
> I looked for the ARM9 board titled TS-7800 in the Embedded hardware
> list of Xenomai here:
> http://www.xenomai.org/index.php/Embedded_Device_Support#ARM
> but couldn't find it.
>=20
> I am talking about this ARM9 board:
> http://www.embeddedarm.com/products/arm-sbc.php#ts-7800-500mhz-series
>=20
> Is it there under some other name which I probably missed?

It is difficult or even impossible to make any statement about if a
specific system is supported, or how much work would be needed to add
such support, when there is no information available about such
fundamental things like which exact SoC it uses, and which exact Linux
kernel version it is running.

The link you quote provides only very vague information like "using a
Marvell 500MHz ARM9 SoC" (which can be anything) or "use a recent
Linux kernel 2.6" (which means they are plain OLD - recent means v3.4
or later).  This may be sufficient for marketing material, but not for
answering technical questions.

Do you have more details?

Also, is it correct to assume that support for this board has never
been pushed upstream, i. e. it is unsupported in mainline and all you
can get is an out-of-tree vendor port?  [eventually also with a
non-standard vendor tool chain?]

Best regards,

Wolfgang Denk

--=20
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Real programmers don't comment their code. It was hard to  write,  it
should be hard to understand.

