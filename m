Message-ID: <4A535784.5000804@domain.hid>
Date: Tue, 07 Jul 2009 16:11:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <558095.42393.qm@domain.hid>
In-Reply-To: <558095.42393.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread_create memory size
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yigal Goldberger <yigal_gold@domain.hid>
Cc: xenomai@xenomai.org

Yigal Goldberger wrote:
> Hi all,
> I'm using xenomai  on kernel 2.6.29 on a powerpc based board.
> I see that when I call : 
> cat proc/meminfo
> before pthread_create and after it there is a difference of 2MB in free memory , indicating that the thread is being allocated 2MB of ram (?) .
> 
> before :
> MemTotal:       256868 kB
> MemFree:        227624 kB
> 
> After :
> MemTotal:       256868 kB
> MemFree:        225632 kB
> 
> I am calling pthread_attr_setstacksize(&attr,8192)
> before calling pthread_create so it shouldn't be the stack size .
> Is this the expected memory consuption per thread ? 
> if not, how can I reduce this ?

That is explained in the TROUBLESHOOTING guide, use ulimit -s. In fact,
I suspect the behaviour depends on the version of the glibc you use. A
better indicator of your process memory map is /proc/pid/maps.

Note that a stacksize of 8K is a bit low, such simple functions as
printf will cause stack overflows with this stack size.

-- 
                                          Gilles


