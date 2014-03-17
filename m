From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 17 Mar 2014 11:59:12 -0400
Message-ID: <20140317155912.GC17765@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] xenomai 2.6.3 build failure on armhf
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I saw armhf had been added to debian/control in the xenomai-2.6 tree,
and since I am trying to get it running there I figured it was worth
pulling that version.  Unfortunately it fails to build with the same
error as 2.6.3 does.

So any idea what this error means:

assert_context.c: In function 'assert_nrt_inner':
assert_context.c:43:1: error: r7 cannot be used in asm here

I am compiling on Debian wheezy armhf.

The command line it used appears to be:
/bin/bash ../../../libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I../../../src/include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -Werror-implicit-function-declaration -pipe -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../../include -D_FORTIFY_SOURCE=2  -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -fno-omit-frame-pointer -MT libxenomai_la-assert_context.lo -MD -MP -MF .deps/libxenomai_la-assert_context.Tpo -c -o libxenomai_la-assert_context.lo `test -f 'assert_context.c' || echo './'`assert_context.c

Debian armhf uses thumb2 mode by default targeting armv7 with VFP3-D16,
in case that is relevant.

-- 
Len Sorensen

