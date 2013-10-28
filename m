From: Jan Jaap Kempenaar <janjaapkempenaar@gmail.com>
Message-Id: <C0EBEDB7-2439-4083-AF21-4896462E5B7E@gmail.com>
Date: Mon, 28 Oct 2013 10:44:42 +0100
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Static linking fails for global mutex variable(c++ class)
	on embedded system
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

For our projects we developed a multiplatform library which is used to create our applications. We are now porting this to Xenomai.
Because we compile for embedded targets, in this case an ARM board, we use static linking as it might occur that dynamic libraries are not available.

In one of our test cases we compile a global class containing a mutex. This class gets initiated before the main function. The test compiles fine in both static and non-static linking, however when running the executable which was staticly linked, the following error occurs:
pthread_mutex_init() returns an ENOSYS, indicating it is not implemented.

A gdb backtrace also indicates that this function is not called before the main function -> initiating global variables?


The particular self-test was subtracted from the library and is added as a self-contained use-case in the attachments. In addition the configuration used to for the kernel of the target is included.

The question is, why does the particular function fail when using static linking. Does this have to do with the fact that it is a global class, calling the function?
What could be done in order to fix this, due to the targets being embedded systems, using non-static linking is not an option.

Below is a summary of the systems used to run and compile the particular test.
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: kernel-configuration.txt
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20131028/e9350a87/attachment.txt>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: SingletonTest.tar.bz2
Type: application/x-bzip2
Size: 9907 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20131028/e9350a87/attachment.bin>
-------------- next part --------------


Build system information:
uname -a:
Linux 3.5.0-40-generic #62-Ubuntu SMP (date) x86_64 x86_64 x86_64 GNU/Linux

arm-linux-gnueabi-g++ ?version:
(Ubuntu/Linaro 4.6.3-8ubuntu1) 4.6.3 20120624 (prerelease)

Xenomai:
version: 2.6.3
.configurate settings:
$xenomai_root/configure CFLAGS="-march=armv7-a -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp -ftree-vectorize -ftree-vectorizer-verbose=3 -fdump-tree-vect" LDFLAGS="-march=armv7-a -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp -ftree-vectorize -ftree-vectorizer-verbose=3 -fdump-tree-vect" --build=x86_64-linux-gnu --host=arm-linux-gnueabi

Target system:
Gumstix Overo Fire (arm-cortex-a8 computer on module)
Tobi baseboard and costum base board.

Software:
Linux 3.2.21
Adeos version: ipipe-core-3.2.21-arm-4.patch
Xenomai version 2.6.3

Thanks in advance.
Regards,
Jan Jaap Kempenaar

