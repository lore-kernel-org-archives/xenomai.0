Date: Fri, 25 Sep 2020 23:57:28 +0300
From: Vitaly Chikunov <vt@altlinux.org>
Subject: Compiling demo/alchemy/altency.c for Cobalt core
Message-ID: <20200925205728.rg7flyazoxyf7xz5@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

While making Xenomai packages for ALT Linux I try to test various use
cases, but found some troubles:

There is `demo/alchemy/altency.c` source. It compiles OK for Mercury,
but fails for Cobalt.

Page

    https://gitlab.denx.de/Xenomai/xenomai/-/wikis/Building_Applications_For_Xenomai_3

implies that it's enough to pass xeno-config output as gcc args. So, I try:

  demo/alchemy# gcc altency.c `/usr/lib/xenomai/cobalt/bin/xeno-config --posix --alchemy --cflags --ldflags` -lpthread -lrt -lm
  altency.c:447:10: fatal error: cobalt/uapi/syscall.h: No such file or directory
    447 | #include <cobalt/uapi/syscall.h>
	|          ^~~~~~~~~~~~~~~~~~~~~~~
  compilation terminated.

`cobalt/uapi/syscall.h` looks like it belongs kernel headers. But, I
don't find anywhere that kernel headers should be used for cobalt
applications. (If I add to the gcc:

  -I/usr/src/linux-4.19.140-xenomai-alt1.cip33.14/include/xenomai

the demo compiles OK.)

If kernel headers they are required - shouldn't xeno-config pass them?
Or this is documented somewhere I missed?

Thanks,


