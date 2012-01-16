Message-ID: <4F14B067.8010601@domain.hid>
Date: Mon, 16 Jan 2012 18:19:03 -0500
From: Andrew Tannenbaum <trb@domain.hid>
MIME-Version: 1.0
References: <4EF27CD5.4060603@domain.hid>
	<4EF8FBB6.4060107@domain.hid> <4EF8FD8D.2090306@domain.hid>
	<4EFB696E.8000508@domain.hid>
	<4EFC4E21.3000804@domain.hid> <4EFC677B.20500@domain.hid>
	<CAJPpvENavHPfvhuS-Ugsje738V=3kko+7dnvv6_AS3F09pbF4w@domain.hid>
	<4EFC887D.3070205@domain.hid>
	<4F0393A2.2000703@domain.hid>
	<4F0C7A60.10203@domain.hid>
	<4F0C7F68.1060402@domain.hid>
	<4F0DB7C0.3040405@domain.hid>
In-Reply-To: <4F0DB7C0.3040405@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] problem with Debian Xenomai build,
 was Re:  hang in rtcansend
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

I found a problem with 2.6.0 and Gilles Chanteperdrix posted some fixes
to the Git tree, and I want to test them.  These are discussed in the
thread:  [Xenomai-help] hang in rtcansend

I have been having trouble building 2.6.0 with latest git tree.  I'm
trying to follow the instructions here:

http://www.xenomai.org/index.php/Building_Debian_packages

I am building 2.6.0 rather than 2.5.0.  When I try to build, the base
2.6.0 build from the git tree builds correctly.  But when I merge the
latest changes with

git merge origin/master

I get build errors.  I posted notes about this here:

https://mail.gna.org/public/xenomai-help/2012-01/msg00057.html

but I have received no solution.  Gilles helped me with the Xenomai
problem I found, but he is not familiar with the Debian build system, so
he suggested that I re-post with Debian in the subject line.

So I would like help building the latest 2.6.0 from the git repository.

-Andy

