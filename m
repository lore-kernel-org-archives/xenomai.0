MIME-Version: 1.0
Date: Wed, 18 Feb 2015 13:45:06 -0600
Message-ID: <CA+C+_XS5KxwQ=YKXD6YZ_T41+xdh8q+ag4Xh-Me6EoHLHJ3-Dg@mail.gmail.com>
From: Mathew Benson <mathew.benson@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Remote debugging problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I converted my code from pthreads to real time Xenomai threads.  My code
works perfectly, as far as I can tell, but I can't use the remote debugger.


Host
-  Fedora 21, 3.18.6-200.fc21.x86_64
-  Eclipse 4.4.1
-  g++ 4.9.2
-  gdb 4.9.2

Target
-  Beaglebone Black, 3.8.13
-  Xenomai 2.6.3
-  gdbserver 2.6.3

Before I put more details up, is there anything with the configuration
above that stands out as being a problem?  Specifically, the gdb and
gdbserver versions?
