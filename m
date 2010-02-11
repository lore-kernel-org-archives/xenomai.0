MIME-Version: 1.0
In-Reply-To: <4B73BC00.5030807@domain.hid>
References: <e325d111002110009x3d586e04h40487b06847237ce@domain.hid>
	<4B73BC00.5030807@domain.hid>
Date: Thu, 11 Feb 2010 16:31:45 +0800
Message-ID: <e325d111002110031y62a47914gb8d8788150dc3e1c@domain.hid>
From: Kim Chuan Lim <lim.kim.chuan@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] CONFIG_NR_CPUS is too large, please lower it.
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

google site:https://mail.gna.org/public/xenomai-help CONFIG_NR_CPUS

from the first result
https://mail.gna.org/public/xenomai-help/2009-09/msg00098.html

"Hello,

I finally had the time to investigate more and traced back the error
to a variable related to the number of IRQs on the system.  I should
have previously mentioned that this is a 64-bit system by the way, so
I found several related #ifdefs in irq_vector.h and apicnum.h.

Anyways, I got the kernel to compile properly after disabling the flag
CONFIG_SPARSE_IRQ.  This made the CONFIG_NR_CPUS error go away, even
after setting it back to 64.  Also, it booted successfully, so I am on
to the next stage of my project.

Although, admittedly I have no idea what the potential consequences of
turning off CONFIG_SPARSE_IRQ could be.

thanks,
Steve"


On Thu, Feb 11, 2010 at 4:12 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
>
> Kim Chuan Lim wrote:
> > May i know how to solve the following problem?
>
> Browse the mailing list archives.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.

