Message-ID: <50F8C6D6.8070209@zultron.com>
Date: Thu, 17 Jan 2013 21:51:50 -0600
From: John Morris <john@zultron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] mmap() segfaults
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi list,

The linux 3.5.7/i-ipipe ipipe-gch for-core-3.5.7/xenomai master packages
haven't been tested much yet, but both el6 and deb packages seem to be
working great.  Those will be available in the next day or so.

For the use of others, I prefer the linux 3.5.3/xenomai 2.6.2
combination, since it has undergone more testing.  There's a problem
mixing the 3.5.3 kernel with xenomai-2.6.git master.  The mprotect
regression is failing again, but in a different way.

Details follow, but the thing I've lost track of is which version of
Xenomai the kernel was prepared with, 2.6.2 (/proc/xenomai/version says
2.6.2) or git master.  Is it a rule that the kernel must be prepared
from the same Xenomai source tree as the installed runtime tools?  In
that case, the packages must be modified with the proper dependency
information.  Otherwise, here's the report:

First run:

++ /usr/lib64/xenomai/regression/posix/mprotect
memory read
memory write after exec enable
memory write after write enable
memory read/write after access enable
FAILURE main:102: read zero returned 255 instead of 0

Second and subsequent runs slightly different:

++ /usr/lib64/xenomai/regression/posix/mprotect
memory read
FAILURE main:69: read mem returned 255 instead of 0

Then curiously, some non-xenomai applications that work fine before the
regression test begin to segfault in mmap() when run after the test; a
simple example is 'git fetch'.  Nothing funny in dmesg; kernel .config
and strace linked below.

After a reboot, everything is normal again until the regression test is
rerun.

The released 2.6.2 tools work fine with the same kernel, and the i-pipe

    John



http://www.zultron.com/static/2013/01/xenomai/3.5.3-mmap-segfault/kernel.config.txt

http://www.zultron.com/static/2013/01/xenomai/3.5.3-mmap-segfault/strace.log


