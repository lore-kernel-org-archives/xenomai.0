Message-ID: <49757B25.8020500@domain.hid>
Date: Tue, 20 Jan 2009 08:20:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D533F9A@slcmail.slc.mew.int>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D533F9A@slcmail.slc.mew.int>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] fpu issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> Guys, the FPU issue I've been having with a Geode GX1 and an AMD Geode
> LX800 still persists. It seems that we have always had this bug, and
> it's timing related. I am pretty sure that the issue revolves around the
> fact that xenomai doesn't initialize the FPU in a userspace created
> thread until the FPU is actually used. I realize there is a performance
> gain to be had here by not having to switch it every time, but to
> confirm I would like to make a patch that initializes the FPU when a
> thread is created. Can someone please point me in the right direction?
> 
>  
> 
> Thanks,
> 
> Steven
> 
>  
> 
> PS - Sorry to Gilles for all the bother. J

No problem, really, the only reason why I did not answer is that I was
busy. But having this discussion on the list is better anyway.

I suggest you use the code I sent you to dump the FPU state in various
places. The first place to try is before the initialization of the two
volatile double variables in the user-space real-time thread. At this
point you should have a clean fpu state, if it is not the case, then you
will have to start dumping the FPU state in kernel-space.

-- 
					    Gilles.

