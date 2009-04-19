Message-ID: <49EB75A2.6040904@domain.hid>
Date: Sun, 19 Apr 2009 21:04:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <b131c9f0904191152i16953fe1k3f035d19a7c606e4@domain.hid>
In-Reply-To: <b131c9f0904191152i16953fe1k3f035d19a7c606e4@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai v2.5-rc1 feedback
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: vikesh rambaran <vikesh.rambaran@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

vikesh rambaran wrote:
> hi
> 
> Thanx for v2.5-rc1. Here are some minor observations
> 
> 1. The prepare-kernel script requires --arch=x86 for an x86 32 bit platform.
> 
> --arch=i386 as per README.INSTALL section 2.1 does not seem to be allowed
> anymore
> 
> (README.INSTALL updates required ?)
> 
> 2. With Xenomai v2.4.x echoing the xenomai group id to
> /sys/module/xeno_nucleus/parameters/xenomai_gid
> allowed a Xenomai application to be run without having to type 'sudo'. Does
> not work with v2.5-rc1.
> Get the following message :
> 
> Xenomai: open: Permission denied
> Xenomai: mmap(local sem heap): Permission denied
> 
> [Application runs normally if sudo is used]
> 
> Has this feature been removed ?
> 
> 3. When running the latency test in a console window within X and the window
> is maximised/minimized
> the following message appears :
> 
> Not SIGSHADOW !

This message means that the application received a SIGWINCH not
originating from Xenomai. This is essentially a debug message which can
be removed.

-- 
					    Gilles.

