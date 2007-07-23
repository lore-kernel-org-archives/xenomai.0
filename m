MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18084.23878.661537.272573@domain.hid>
Date: Mon, 23 Jul 2007 09:48:22 +0200
In-Reply-To: <2862c2c80707222152t2037a987mca3f70d1da9865dd@domain.hid>
References: <2862c2c80707222152t2037a987mca3f70d1da9865dd@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Xenomai Testsuite for AT91 - Illegal Instruction
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yeoh Chun Yeow <yeohchunyeow@domain.hid>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

Yeoh Chun Yeow wrote:
 > Dear all,
 > 
 > Previous I had the problem with my ARM GNU toolchain with xenomai building
 > process.
 > 
 > I have donwloaded the ARM GNU toolchain from Code Sourcery. Both the Linux
 > kernel and the xenomai have compiled sucessfully.
 > 
 > However, whenever I run the testsuite in ./src directory. The test comes out
 > with the following results:
 > 
 > *
 > *
 > * Type ^C to stop this application.
 > *
 > *
 > Illegal instruction
 > 
 > What's go wrong? Is this something to do with generated executable not
 > compatible to AT91 architecture?
 > 
 > I have appended the CFLAGS=-march-armv4t for building the xenomai since the
 > arm-none-linux-gnueabi is default to ARM5 architecture.
 > 
 > Use the following for configure script:
 > CFLAGS="-march=armv4t" ./configure --build=i686-pc-linux-gnu
 > --host=arm-none-linux-gnueabi CC=arm-none-linux-gnueabi-gcc
 > CXX=arm-none-linux-gnueabi-gcc AR=arm-none-linux-gnueabi-ar
 > LD=arm-none-linux-gnueabi-ld --enable-arm-mach=at91
 > 
 > Please advice. Thanks

Try compiling with -msoft-float.

-- 


					    Gilles Chanteperdrix.

