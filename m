Message-ID: <51B22F1B.9090806@xenomai.org>
Date: Fri, 07 Jun 2013 21:06:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAGqv1CgCsZbpe668VG7_+p1BT1Gs43HmH=uLe_GYZ92OXrZqgQ@mail.gmail.com>
In-Reply-To: <CAGqv1CgCsZbpe668VG7_+p1BT1Gs43HmH=uLe_GYZ92OXrZqgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Conflict with Ubuntu 13.04
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Travis Llado <travisllado@utexas.edu>
Cc: xenomai@xenomai.org

On 06/07/2013 03:28 AM, Travis Llado wrote:

> Hi,
> I'm new to xenomai and I just installed it with Ubuntu 13.04 and kernel
> 3.5.7. As soon as I booted 3.5.7 with xenomai, the Unity GUI stopped
> working. It looks like the problem is in compiz, a plugin for Unity. Unity
> can't run without it. I'm getting the exact same problem on Ubuntu 13.04 on
> a macbook and a Dell desktop. Has anyone else run across this problem? I
> can still run xenomai code through the terminal and I can run graphics
> applications, but if I try to load compiz the whole system freezes. It
> looks like compiz is persistently broken, because when I reboot into the
> 3.8.0 kernel that comes with Ubuntu 13.04, Unity/compiz are still broken.
> Any thoughts?


Does Unity work with the exact same kernel configuration, only without
CONFIG_IPIPE and CONFIG_XENOMAI?

-- 
                                                                Gilles.

