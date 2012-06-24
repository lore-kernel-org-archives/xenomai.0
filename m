Message-ID: <4FE6F616.1010900@antcom.de>
Date: Sun, 24 Jun 2012 13:12:22 +0200
From: Roland Stigge <stigge@antcom.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Debian Bug#678695: Xenomai posix skin : bug with
 pthread_mutex_trylock function
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Hi,

I'm forwarding an issue reported to Debian, see below. For further
questions, just ask, and see also:

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=678695

Thanks,

Roland


=================================================================
Original Report (the report at the above link contains the example file):

Package: xenomai
Version: 2.6.0

Kernel:2.6.38.8 - Xenomai:2.6.0
arch:i686 i386 GNU/Linux

Hi,

The attached code shows a malfunction of the pthread_mutex_trylock function.


Description of test.c:
The main task takes the mutex during 1second while the 't1' task tries
to take this mutex from 0.5sc.
We can notice that with the posix skin of xenomai, t1 never succeeded to
take the mutex, which is not the case without the posix skin of xenomai.



Duchesne Alexandre
duch.alexandre@gmail.com

