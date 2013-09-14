Message-ID: <52346905.1030401@xenomai.org>
Date: Sat, 14 Sep 2013 15:47:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <a61ffb56.00001e48.00000008@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
	<52337BA2.4080106@xenomai.org>
	<fcac2f91.00001e70.00000001@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
	<86e45894.00001e70.0000000c@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
	<52338808.4060404@xenomai.org>
	<024b1d5a.00001e70.00000015@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
In-Reply-To: <024b1d5a.00001e70.00000015@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] psos t_delete causing a SIGSEGV in suspended task.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Daniel Merrill <daniel.merrill@psware.com>
Cc: xenomai@xenomai.org

On 09/14/2013 01:23 AM, Daniel Merrill wrote:
> Alright I think you solved it! We are actually calling the t_suspend from 
> Ada, which had an exception block around the call. For some reason that is 
> trying to catch the cancel signal and causes the SIGSEGV. When I remove that 
> exception handling block the delete appears to work. Thanks for pointing me 
> in the right direction.

>From what I understand, unwinding on pthread_cancel is a feature which
allows automatic destruction of all the objects created on the thread
stack in C++ (and other languages implementing exceptions apparently)
upon pthread_cancel, this way, pthread_cleanup_push and pthread_cleanup
pop are simply handled as C++ objects constructors/destructors when used
in C++ code.

-- 
                                                                Gilles.

