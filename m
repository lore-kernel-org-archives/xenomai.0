Message-ID: <4CF6D56C.4040203@domain.hid>
Date: Thu, 02 Dec 2010 00:08:28 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20101129195014.b79eb9be.inflo@domain.hid>	<4CF40D43.2070200@domain.hid>
	<20101201193518.7c2ed21c.inflo@domain.hid>
In-Reply-To: <20101201193518.7c2ed21c.inflo@domain.hid>
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
> hi, the code compiles without errors. I got it once compiled, but
> after replaying what i have done, it wont work again :(

Ok. Send me the result of this code compiled with
powerpc-linux-gnu-gcc -E.

> 
> The prepare-kernel.sh script i can call from whereever i am, i mean,
> i could go to e.g. /tmp and could call
> 
> /usr/src/xenomai-2.5.5.2/scripts/prepare-kernel.sh --arch=powerpc
> --adeos=/usr/src/xenomai-2.5.5.2/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.35.7-ppc-1.5-*.patch
> --linux=/usr/src/linux-2.6.35.7
> 
> then i could go cd /usr/src/linux-2.6.35.7 and configure and build
> the kernel from within this directory ? whats with this linux/ shadow
> copy ?

prepare-kernel does not make a shadow copy, it modifies
/usr/src/linux-2.6.35.7 in place. So, if you have linux/ it comes from
somewhere else.

> 
> After building patched kernel, i need to configure xenomai user libs.
> This is done from whereever i want? i mean, i could go to e.g. /tmp
> and call
> 
> /usr/src/xenomai-2.5.5.2/configure --host=powerpc-linux-gnu and then
> also call inside this dir
> 
> make
> 
> to build xenomai libs?

Yes, you can do that, though I would recommend to do it in something like
/tmp/xenomai-build in order to avoid polluting /tmp with the compilation
files.

> 
> The user libs build fails mostly with the same procedure deleting
> linux/ copying linux source to linux/ hanging
> 
> my cross tools are prefixed with powerpc-linux-gnu- like
> powerpc-linux-gnu-gcc

Yes, and this compilation failure probably has other reasons than
installation directories names. This is a problem of what Xenomai source
expects and the way your toolchain/libc headers are made.

If in the program I asked you to compile you replace #include <errno.h>
with #include <linux/errno.h>, does it still compile?

-- 
                                                                Gilles.

