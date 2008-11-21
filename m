From: Henry Bausley <hbausley@domain.hid>
Content-Type: text/plain
Date: Thu, 20 Nov 2008 16:16:44 -0800
Message-Id: <1227226604.13217.13.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] shared memory mlockall error w/ mono interpreter?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

We have an application that uses shared memory to communicate from our
kernel driver to user space.  In our own standard C applications we can
issue an mlockall and we can use multiple threads without a problem.

However, we are also using the mono .NET interpreter which links to a
shared library that links to the xenomai shared memory and issues a
mlockall.  Whenever we run programs using the mono interpreter we get
the error message Xenomai: process memory not locked (mlockall).  mono
is a .NET virtual machine w/ garbage collection like java.

We tried --enable-posix-auto-mlockall but the third party apps running
under mono still crashes with the mlockall


Any suggestions would be greatly appreciated!!!!



