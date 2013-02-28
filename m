Message-ID: <512FB7B0.1040003@xenomai.org>
Date: Thu, 28 Feb 2013 21:01:52 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20130228094644.5CCB8C91@centrum.cz>
In-Reply-To: <20130228094644.5CCB8C91@centrum.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] mutex problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Petr Cervenka <grugh@centrum.cz>
Cc: Xenomai <xenomai@xenomai.org>

On 02/28/2013 09:46 AM, Petr Cervenka wrote:

> Hello.
> 
> I have a problem with a mutex shared by 3 real-time user tasks. Once in a while (~hours) the mutex get locked with the first task as owner and the other two tasks are fronzen on rt_mutex_aquire calls. But I have double checked, that every "acquire" of that mutex is followed by "release".
> 
> Typical example:
> Lets call those tasks REG, SEND, RECEIVE
> 
> RECV: acquire
> RECV: release
> 
> RECV: acquire
> RECV: release
> 
> RECV: acquire - FREEZE
> 
> REG: acquire
> REG: release
> 
> REG: acquire
> REG: release
> 
> REG: acquire
> REG: release
> 
> SEND: acquire - FREEZE
> 
> There are also other threads, sync. objects, network sockets, ... in the system, but the threads are frozen by this particular mutex.
> rt_task_unblock call unblocks the tasks, return value of rt_mutex_acquire is -4 (-EINTR), as expected.
> Used version of Xenomai 2.5.6, skin native. Was there any known issue similar to that behavior?
> Also it seems that rt_mutex_create is called before mlockall call? Could it be a problem?


It is a bit old to recall. Could you try and reproduce the problem with
2.6.2.1 ?

-- 
                                                                Gilles.

