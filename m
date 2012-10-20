MIME-Version: 1.0
Date: Sat, 20 Oct 2012 17:02:33 -0400
Message-ID: <CAD0gx3ij+c4m4N9gJXd5HGK2Mu1H24jR+zJtwMhSqDBE40hWnQ@mail.gmail.com>
From: Bill Smith <shoozboot@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Questions about latest kernel rev supported for Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello all,

I am getting started with Xenomai on the BeagleBone, and I have a few
questions about the best route to take with cross compiling a kernel with
the most recent support.

So far I can't seem to find any reference to the most recent kernel
revision that is supported by Xenomai 2.6.2; right now with the most recent
A6 image, this is the output from uname -a:

Linux beaglebone 3.2.30 #1 Tue Sep 11 13:08:30 CEST 2012 armv7l GNU/Linux

So if I wanted to integrate Xenomai with this image, what would the best
plan be for that in terms of kernel sources and a cross compilation
environment?  And would this recent A6 image on the BeagleBone be
compatible with Xenomai 2.6.2?

Thanks in advance
