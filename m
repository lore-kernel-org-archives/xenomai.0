Message-ID: <2862c2c80707222152t2037a987mca3f70d1da9865dd@domain.hid>
Date: Mon, 23 Jul 2007 12:52:52 +0800
From: "Yeoh Chun Yeow" <yeohchunyeow@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_101871_7762172.1185166372171"
Subject: [Xenomai-help] Xenomai Testsuite for AT91 - Illegal Instruction
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

------=_Part_101871_7762172.1185166372171
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear all,

Previous I had the problem with my ARM GNU toolchain with xenomai building
process.

I have donwloaded the ARM GNU toolchain from Code Sourcery. Both the Linux
kernel and the xenomai have compiled sucessfully.

However, whenever I run the testsuite in ./src directory. The test comes out
with the following results:

*
*
* Type ^C to stop this application.
*
*
Illegal instruction

What's go wrong? Is this something to do with generated executable not
compatible to AT91 architecture?

I have appended the CFLAGS=-march-armv4t for building the xenomai since the
arm-none-linux-gnueabi is default to ARM5 architecture.

Use the following for configure script:
CFLAGS="-march=armv4t" ./configure --build=i686-pc-linux-gnu
--host=arm-none-linux-gnueabi CC=arm-none-linux-gnueabi-gcc
CXX=arm-none-linux-gnueabi-gcc AR=arm-none-linux-gnueabi-ar
LD=arm-none-linux-gnueabi-ld --enable-arm-mach=at91

Please advice. Thanks

regards,
chun yeow

------=_Part_101871_7762172.1185166372171
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear all,<br><br>Previous I had the problem with my ARM GNU toolchain with xenomai building process. <br><br>I have donwloaded the ARM GNU toolchain from Code Sourcery. Both the Linux kernel and the xenomai have compiled sucessfully.
<br><br>However, whenever I run the testsuite in ./src directory. The test comes out with the following results:<br><br><span style="color: rgb(255, 0, 0);">*</span><br style="color: rgb(255, 0, 0);"><span style="color: rgb(255, 0, 0);">
*</span><br style="color: rgb(255, 0, 0);"><span style="color: rgb(255, 0, 0);">* Type ^C to stop this application.</span><br style="color: rgb(255, 0, 0);"><span style="color: rgb(255, 0, 0);">*</span><br style="color: rgb(255, 0, 0);">
<span style="color: rgb(255, 0, 0);">*</span><br style="color: rgb(255, 0, 0);"><span style="color: rgb(255, 0, 0);">Illegal instruction</span><br><br>What&#39;s go wrong? Is this something to do with generated executable not compatible to AT91 architecture?
<br><br>I have appended the CFLAGS=-march-armv4t for building the xenomai since the arm-none-linux-gnueabi is default to ARM5 architecture.<br><br>Use the following for configure script:<br>CFLAGS=&quot;-march=armv4t&quot; ./configure --build=i686-pc-linux-gnu --host=arm-none-linux-gnueabi CC=arm-none-linux-gnueabi-gcc CXX=arm-none-linux-gnueabi-gcc AR=arm-none-linux-gnueabi-ar LD=arm-none-linux-gnueabi-ld --enable-arm-mach=at91
<br><br>Please advice. Thanks<br><br>
regards,<br>chun yeow<br><br><br>

------=_Part_101871_7762172.1185166372171--

