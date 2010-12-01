Date: Wed, 1 Dec 2010 19:35:18 +0100
From: inflo <inflo@domain.hid>
Message-Id: <20101201193518.7c2ed21c.inflo@domain.hid>
In-Reply-To: <4CF40D43.2070200@domain.hid>
References: <20101129195014.b79eb9be.inflo@domain.hid>
	<4CF40D43.2070200@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: inflo@domain.hid
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
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

hi,
the code compiles without errors. I got it once compiled, but after replaying what i have done, it wont work again :(

The prepare-kernel.sh script i can call from whereever i am, i mean, i could go to e.g. /tmp and could call

/usr/src/xenomai-2.5.5.2/scripts/prepare-kernel.sh --arch=powerpc --adeos=/usr/src/xenomai-2.5.5.2/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.35.7-ppc-1.5-*.patch --linux=/usr/src/linux-2.6.35.7

then i could go 
cd /usr/src/linux-2.6.35.7 and configure and build the kernel from within this directory ? whats with this linux/ shadow copy ?

After building patched kernel, i need to configure xenomai user libs. This is done from whereever i want? i mean, i could go to e.g. /tmp and call

/usr/src/xenomai-2.5.5.2/configure --host=powerpc-linux-gnu
and then also call inside this dir

make

to build xenomai libs?

The user libs build fails mostly with the same procedure
deleting linux/
copying linux source to linux/
hanging

my cross tools are prefixed with powerpc-linux-gnu- like powerpc-linux-gnu-gcc

thanks for help
flo




On Mon, 29 Nov 2010 21:29:55 +0100
Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:

> inflo wrote:
> > hi, i wanna build xenomai user libs for powerpc 40x (405GP) cpu. The
> > patching (preparing) of the linux kernel (2.6.36.7) works with the
> > adeos patch.
> > 
> > But when i want to build the user libs, i get the error that e.g.
> > linux/errno.h could not be found. linux/errno.h is in
> > /usr/src/linux-2.6.35.7/include/linux/errno.h so it must be a false
> > setup path i think, but i dont know where i should do that?
> 
> No, linux/errno.h is supposed to be found in the toolchain installation
> directory. If it is not installed there, then your toolchain is not
> correctly installed.
> 
> You can check this without trying and compiling Xenomai:
> 
> If the following program:
> 
> #include <stdio.h>
> #include <errno.h>
> 
> int main(void)
> {
> 	printf("%d\n", EINVAL);
> 	return 0;
> }
> 
> Does not compile correctly with your toolchain, then your toolchain is
> not correctly installed.
> 
> 
> -- 
>                                                                 Gilles.


-- 
inflo <inflo@domain.hid>

