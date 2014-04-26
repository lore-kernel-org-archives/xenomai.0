Message-ID: <535B8B43.1000109@xenomai.org>
Date: Sat, 26 Apr 2014 12:32:35 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1398502711.53016.YahooMailNeo@web171601.mail.ir2.yahoo.com>
In-Reply-To: <1398502711.53016.YahooMailNeo@web171601.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Issue in notifier_callback while threadobj_lock is
 being held (forge/mercury)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/26/2014 10:58 AM, Matthias Schneider wrote:
> Hi all,
>
> when threadobj_lock is being held and a thread suspension triggers a call of
> notifier_callback, I am experiencing some issues. The scenario in my case
> was a thread being started waiting on threadobj_wait_start()/wait_on_barrier()
> while a thread suspension was already triggered. (In case the started thread is
> of lower priority than the starting thread, threadobj_start() will not wait
> for it).
>
> The problem I was experiencing (due to timing) was that threadobj_lock()
> was called in notifier_callback(), failed because the mutex was already held
> (by wait_on_barrier()) and thus did not set the threadobj->status variable,
> however, wait_on_barrier() had already unset the status variable before actually
> unlocking the mutex in pthread_cond_wait().
>
> This caused threadobj_lock() in notifier_callback() return -EDEADLK and not
> doing anything, and threadobj_unlock() to assert on __threadobj_tag_unlocked(thobj)
> due status not reflecting the locked state.
>
> Additionally I see problems in notifier_callback() in general since it will
> leave the threadobj unlocked on return regardless of its previos state.
> I am not sure how to address this issue, I have helped myself by blocking
> SIGNOTIFY in wait_on_barrier(), but that is obviously an incomplete fix
> (if it is any at all). Probably there are other situtions as well that could
> cause this behavior.
>
> Any ideas on what to do about that?

There is a single sane option: no code running on top of the SIGNOTIFY 
handler should attempt to grab any lock. notifier_callback() is simply 
wrong in acquiring a lock, only to set the suspend bit in the status. 
There is a better option for reflecting the current state locklessly.

I'll issue a fix.

-- 
Philippe.

