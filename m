Message-ID: <507C2940.7000005@gmail.com>
Date: Mon, 15 Oct 2012 16:18:24 +0100
From: Stefan Videv <videvstefan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Problem Compiling/Building UserSpace Support for ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello!

I've been trying to compile the user-space support for the latest 
version of Xenomai for ARM but failing.

After downloading the source files, and running

./configure --build=i686-pc-linux-gnu --host=arm-linux-gnueabi 
CFLAGS="-march=armv7-a -mfpu=vfp3" LDFLAGS="-march=armv7-a"

followed by

make

I get the following error:

{standard input}: Assembler messages:
{standard input}:254: Error: thumb conditional instruction should be in 
IT block -- `strexeq r0,r1,[r3]'
{standard input}:601: Error: thumb conditional instruction should be in 
IT block -- `strexeq r0,r1,[r3]'
make[3]: *** [libxenomai_la-rt_print.lo] Error 1
make[3]: Leaving directory 
`/home/svidev/beaglebone/xenomai-2.6.1/src/skins/common'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/home/svidev/beaglebone/xenomai-2.6.1/src/skins'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/svidev/beaglebone/xenomai-2.6.1/src'
make: *** [all-recursive] Error 1


What am I doing wrong? I've already compiled a couple of kernels with 
this toolchain so it should work (albeit I haven't had the time to test 
those kernels).

Thanks in advance,

Kind Regards,
Stefan

