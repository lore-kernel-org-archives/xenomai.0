Message-ID: <50E1CE62.9010806@xenomai.org>
Date: Mon, 31 Dec 2012 18:41:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50e1cc2fb40c67.12589971@wp.pl>
In-Reply-To: <50e1cc2fb40c67.12589971@wp.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] SIGXCPU with rt_mutex_release
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mariusz Janiak <mariuszjaniak@wp.pl>
Cc: Xenomai <xenomai@xenomai.org>

On 12/31/2012 06:32 PM, Mariusz Janiak wrote:

> Hi,
> 
> I have met problem when I run OROCOS helloWord example. Xenomai
> generate SIGXCPU signal when rt_mutex_release(...) is called. I have
> installed signal handler for each realtime thread created by OROCOS
> and I get following result
> 
> SIGDEBUG received, reason 4: affected by priority inversion


There is a problem in your application, namely a mutex owned by a thread
running with the SCHED_OTHER scheduling policy, released while Xenomai
did not notice that the same thread had taken the mutex. This could
happen if for instance you change the scheduling policy while holding a
mutex.

Please try reducing the error to a simple testcase which will allow us
to investigate this issue.

> There is much bigger mess during exiting from application. I am not
> pretty sure this is a Xenomai problem, if not sorry for bothering. I
> haven check it with previous Xenomai release yet.


We need facts to start working, again, please write a simple test case
to help investigating the issue.

-- 
                                                                Gilles.

