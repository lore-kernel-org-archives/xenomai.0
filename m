MIME-Version: 1.0
Date: Thu, 6 Jun 2013 20:28:02 -0500
Message-ID: <CAGqv1CgCsZbpe668VG7_+p1BT1Gs43HmH=uLe_GYZ92OXrZqgQ@mail.gmail.com>
From: Travis Llado <travisllado@utexas.edu>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Conflict with Ubuntu 13.04
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,
I'm new to xenomai and I just installed it with Ubuntu 13.04 and kernel
3.5.7. As soon as I booted 3.5.7 with xenomai, the Unity GUI stopped
working. It looks like the problem is in compiz, a plugin for Unity. Unity
can't run without it. I'm getting the exact same problem on Ubuntu 13.04 on
a macbook and a Dell desktop. Has anyone else run across this problem? I
can still run xenomai code through the terminal and I can run graphics
applications, but if I try to load compiz the whole system freezes. It
looks like compiz is persistently broken, because when I reboot into the
3.8.0 kernel that comes with Ubuntu 13.04, Unity/compiz are still broken.
Any thoughts?
Thanks

-- 
Travis Llado
University of Texas at Austin
Undergraduate Mechanical Engineering
travisllado@utexas.edu
512-740-8990
