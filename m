Message-ID: <4CF40D43.2070200@domain.hid>
Date: Mon, 29 Nov 2010 21:29:55 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20101129195014.b79eb9be.inflo@domain.hid>
In-Reply-To: <20101129195014.b79eb9be.inflo@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai user lib build error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: inflo <inflo@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

inflo wrote:
> hi, i wanna build xenomai user libs for powerpc 40x (405GP) cpu. The
> patching (preparing) of the linux kernel (2.6.36.7) works with the
> adeos patch.
> 
> But when i want to build the user libs, i get the error that e.g.
> linux/errno.h could not be found. linux/errno.h is in
> /usr/src/linux-2.6.35.7/include/linux/errno.h so it must be a false
> setup path i think, but i dont know where i should do that?

No, linux/errno.h is supposed to be found in the toolchain installation
directory. If it is not installed there, then your toolchain is not
correctly installed.

You can check this without trying and compiling Xenomai:

If the following program:

#include <stdio.h>
#include <errno.h>

int main(void)
{
	printf("%d\n", EINVAL);
	return 0;
}

Does not compile correctly with your toolchain, then your toolchain is
not correctly installed.


-- 
                                                                Gilles.

