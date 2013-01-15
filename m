Message-ID: <50F5025E.1040500@zultron.com>
Date: Tue, 15 Jan 2013 01:16:46 -0600
From: John Morris <john@zultron.com>
MIME-Version: 1.0
References: <50F19CE1.5080106@zultron.com> <50F19DE4.4030805@xenomai.org>
	<50F239E1.40400@zultron.com> <50F2A59D.5050600@xenomai.org>
	<50F30781.3050302@zultron.com> <50F30DE5.7030007@xenomai.org>
	<50F38DD5.5010105@zultron.com> <50F3F2C6.2040900@xenomai.org>
	<50F3F359.9020502@siemens.com> <50F409C0.7050701@siemens.com>
	<50F46FF8.5050100@zultron.com> <50F48CBB.7080605@xenomai.org>
In-Reply-To: <50F48CBB.7080605@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] 3.5.7 posix/mprotect fixed;
 (Was:  posix/mprotect failure)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>



On 01/14/2013 04:54 PM, Gilles Chanteperdrix wrote:
> On 01/14/2013 09:52 PM, John Morris wrote:
>> http://www.zultron.com/static/2013/01/xenomai/3.5.7-test/foo-gdb-posix-mprotect-3.5.7-test.log
> 
> 
> So, you are compiling with _FORTIFY_SOURCE, that is the difference with
> how we are compiling. Is it easy for you to set _FORTIFY_SOURCE to 0?

Wow, you picked that out instantly.  That fixes it.  RH-like distros
define _FORTIFY_SOURCE in the default CFLAGS, worthy of a wiki note:

http://fedoraproject.org/wiki/Security/Features#Compile_Time_Buffer_Checks_.28FORTIFY_SOURCE.29

I'm guessing that Xenomai-enabled applications won't have to worry about
this, because they'll only be compiling header files.  Is that about
right, or should there be a notice in the -devel package?


Here's the latest xeno-regression-test run:

http://www.zultron.com/static/2013/01/xenomai/3.5.7-test/foo-xeno-regression-test-3.5.7-test.log

The latest xeno-regression-test run still has a few small problems:

1)  "xddp_test" fails:  "...IPCPROTO_XDDP): Address family not supported
by protocol".  DRIVERS_RTIPC_XDDP is enabled in the config.  Doesn't
look like others have experienced this before.  LinuxCNC doesn't use
XDDP, but it should be fixed for the general audience.

2)  "clocktest -C 42 -T 30" fails; apparently expected in some
circumstances ('... || :').  Does anything need to be fixed here?  The
test system switched to acpi_pm, and the TSCs on the dual-core are
unsynched.  We don't know if the end-user's application will lock the
process to a single CPU, so CLOCK_HOST_REALTIME isn't the best choice,
even if it were somehow available.

3)  "Warning: Linux is compiled to use FPU in kernel-space" in dmesg:
Ignoring:  disabling (at least) software RAID breaks the
'one-size-fits-all' goal, and Gilles states this is harmless:
http://www.xenomai.org/pipermail/xenomai/2009-May/016743.html

	John


current status:
xenomai-2.6 master 851281e5 (Sun Jan 13 13:51:22 2013 +0100)
ipipe-gch for-core-3.5.7 fde77b2e (Wed Jan 9 12:14:54 2013 +0100)

kernel .config
http://www.zultron.com/static/2013/01/xenomai/3.5.7-test/foo-kernel-config-3.5.7-test.txt

dmesg
http://www.zultron.com/static/2013/01/xenomai/3.5.7-test/foo-dmesg-3.5.7-test.log

regression test
http://www.zultron.com/static/2013/01/xenomai/3.5.7-test/foo-xeno-regression-test-3.5.7-test.log

