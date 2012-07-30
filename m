MIME-Version: 1.0
Sender: madjsw@gmail.com
Date: Mon, 30 Jul 2012 14:17:29 -0500
Message-ID: <CAAvA3H80xn1UcLPASUwu1L3RqEceJiXWQBuGXs=LfAQmDTDq=g@mail.gmail.com>
From: Jeff Weber <jwamsc@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] __rtdm_muxid symbol multipy defined in static libs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai Mailing List <xenomai@xenomai.org>

When I attempt to statically link my application, the linker complains the
symbol
__rtdm_muxid is multiply defined.:

c++  -o myapp myobjects  mylibs -static -lsqlite3 -lrtdm -L/usr/xenomai/lib
-lpthread_rt -lxenomai -lpthread -lrt -ldl
/usr/xenomai/lib/libpthread_rt.a(libpthread_rt_la-init.o):(.data+0x4):
multiple definition of `__rtdm_muxid'
/usr/xenomai/lib/librtdm.a(librtdm_la-init.o):(.data+0x0): first defined
here

(I have pre-linked a subset of object files with the posix.wrappers script
so I can control which application posix calls
bind to the Xenomai __wrap_ calls.)

Use of "nm" shows what the linker is complaining about:

 # nm --defined -o /usr/xenomai/lib/*.a | grep __rtdm_muxid
/usr/xenomai/lib/libpthread_rt.a:libpthread_rt_la-init.o:00000004 D
__rtdm_muxid
/usr/xenomai/lib/librtdm.a:librtdm_la-init.o:00000000 D __rtdm_muxid

I have no link errors when dynamically linking my application.

Am I statically linking incorrectly, or is this a bug?

my config:
architecture: x86 32-bit
Xenomai-2.6.1

Thanks,
Jeff
