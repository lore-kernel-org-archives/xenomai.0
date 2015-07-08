Date: Tue, 07 Jul 2015 22:45:05 -0400
From: Glen Wernersbach <glen@jetsoftdev.com>
Message-ID: <D1C206F1.39ADA%glen@jetsoftdev.com>
Mime-version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Xemomai 3 - posix demo programs don't seem to be loading
 the right socket program.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi All,

Fooling around with Xenomai 3 RC4. I can get the TestSuite to work but when
I run any of the standard posix demo examples I get the following error:
./bufp-readwrite=20
socket 1: Address family not supported by protocol
socket 2: Address family not supported by protocol

Looking on the web this would indicate that the wrapper instruction is not
in the linker flags but it is. I tried building my own copy just to make
sure the wrapper was included but got the same error.
make
gcc -o RsConMain RsConMain.c -I/usr/xenomai/include/cobalt
-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__COBALT__
-Wl,@/usr/xenomai/lib/cobalt.wrappers   -L/usr/xenomai/lib -lcobalt
-lpthread -lrt  =20

Any ideas?


Glen
--=20
Glen Wernersbach View Profile <http://www.linkedin.com/in/GlenWernersbach>
Business, Innovation and Technical Consultant;
President and CEO
Jetsoft Development Co.


629 Old St Rt. 74 =AD Suite 210
Cincinnati, Oh 45244
513-240-9929
glen@jetsoftdev.com


