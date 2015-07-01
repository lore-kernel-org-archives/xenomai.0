Date: Wed, 1 Jul 2015 17:45:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150701154521.GC13256@hermes.click-hack.org>
References: <00e901d0b413$83853d70$8a8fb850$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00e901d0b413$83853d70$8a8fb850$@gmail.com>
Subject: Re: [Xenomai] Have you ever used the Linux Test Project (LTP)
 realtime testsuite with Xenomai?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giorgio Buffa <giorgiobuffa.work@gmail.com>
Cc: xenomai@xenomai.org

On Wed, Jul 01, 2015 at 05:35:08PM +0200, Giorgio Buffa wrote:
> Hello list!
> I'm having a look at the Linux Test project
> (https://github.com/linux-test-project/ltp), which provides a collection of
> tools for testing the Linux kernel and related features. It also provides a
> real-time test suite that has been written to test functionality of the
> PREEMPT_RT patch.
> 
> This real-time test suite uses the POSIX API, so I'm thinking to use it to
> further benchmark my Xenomai installations (both single- and dual- kernel).
> Have you ever used this realtime testsuite with Xenomai? Or do you only
> rely on the testsuite provided by Xenomai itself?

LTP is regularly used with Xenomai, but as part of the dohell
script, generating Linux load.

What you want to do, I guess, is to recompile the rt-tests for the
Xenomai POSIX API. In that case, you should not underestimate what
this task means, it means more than just recompiling with the
xeno-config flags, see:
https://xenomai.org/2014/08/porting-a-linux-application-to-xenomai-dual-kernel/

-- 
					    Gilles.
https://click-hack.org

