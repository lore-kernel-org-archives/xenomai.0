Message-ID: <50498C3C.50003@xenomai.org>
Date: Fri, 07 Sep 2012 07:55:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50498592.3090204@vareka.com>
In-Reply-To: <50498592.3090204@vareka.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Problem with MALLOC_CHECK_
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Bill Vareka <bill@vareka.com>
Cc: xenomai@xenomai.org

On 09/07/2012 07:26 AM, Bill Vareka wrote:

>    We've discovered a weird problem.  Basically, when using the xenomai 
> posix skin and allocating and releasing large amounts of memory in a 
> secondary mode thread, the application corrupts the entire system 
> (kernel and all) *if* the MALLOC_CHECK_ macro is disabled.  Attached is 
> a simple c++ demo program showing this problem (compile with gcc).  If 
> you compile using standard posix it works no matter what.  If you 
> compile using the xenomai posix skin, then if the environment variable 
> MALLOC_CHECK_=3 then the program runs fine with no problems.  However, 
> if you run with MALLOC_CHECK_=0 then the program appears to corrupt 
> system memory.   After running this program, less, cat, and other 
> standard programs now segfault and won't run.  Also in our case, we see 
> that the output of ifconfig is also corrupted (shows table data rather 
> than normal format).  The kernel is completely unstable.
> We have encountered the problem before without identifying the source.  
> Currently this affected us because our application ran fine under a 
> login shell when testing (since it automatically defined the env var) 
> but when we added a launch script to sysVinit to automatically launch it 
> at startup, it failed because the environmental variables were much 
> different there and did not define this variable.
> 
> Again, our app is C++ and this test is with stl strings but I strongly 
> suspect the same behavior can be generated using a standard C program 
> and malloc/free.
> 
> Our setup:
> 
> architecture x86 32-bit
> Linux 2.6.38.8
> adeos ipipe 2.11-01


Could you check the I-pipe patch for Linux 3.2? It has this commit:
http://git.denx.de/?p=ipipe.git;a=commit;h=c9f834f80257c4e7c2c01a3c6d34f5485af2be51

Which 2.6.38 does not appear to have.

-- 
                                                                Gilles.

