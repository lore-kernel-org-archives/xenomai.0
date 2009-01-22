Message-ID: <49789ECA.4010905@domain.hid>
Date: Thu, 22 Jan 2009 16:28:58 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1232641398.13734.110.camel@domain.hid>
In-Reply-To: <1232641398.13734.110.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Compiler Errors with User Space Tools for 2.4.6.1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Greg Bentley <gbentley@domain.hid>
Cc: xenomai@xenomai.org

Greg Bentley wrote:
> Hello,
> 
> I am working on getting Xenomai 2.4.6.1 working on a custom board with
> an Atmel AT91SAM9260 processor. The IPIPE patch I used was
> adeos-ipipe-2.6.25-arm-1.9-02.patch. My kernel patches, compiles, and
> runs on the board.
> 
> However, when compiling the user space tools, make fails when it gets
> the pSOS+ skin with an error of PTHREAD_STACK_MIN being undeclared.
> PTHREAD_STACK_MIN is not defined as the include/posix/pthread.h does not
> appear correctly included in the path for the src/ programs.
> 
> This are the configure and make commands I used:
> 
> configure CC="arm-linux-gnueabi-gcc -v" CXX=arm-linux-gnueabi-gcc
> AR=arm-linux-gnueabi-ar LD=arm-linux-gnueabi-ld \
>         --build=i686-pc-linux-gnu \
>         --host=arm-linux \
>         --enable-arm-mach=at91sam926x \
>         --enable-arm-eabi \
>         --enable-arm-tsc
> make DESTDIR=/projects/som9260/xenomai/_install install
> 
> These options worked correctly with Xenomai 2.4.3 and I did not see any
> changes from the current configure help or from README.INSTALL. If
> someone could point out what I am doing wrong here, I would appreciate
> the assistance.

I already had this bug, and it turned out to be a toolchain bug.
PTHREAD_STACK_MIN was defined in /usr/local/arm-linux/include/limits.h,
whereas the toolchain found the limits.h from its system includes before
this header. The cure was to add a -I/usr/local/arm-linux/include to the
CPPFLAGS.

-- 
                                                 Gilles.

