Message-ID: <54269F06.1000504@xenomai.org>
Date: Sat, 27 Sep 2014 13:27:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CALe7ZU3AWFPpFAuvYwEeehuG2Qg_mLDfuko2=Z4KKEaMC7FRmg@mail.gmail.com>
 <5425EA22.2080007@xenomai.org>
 <CALe7ZU1K9xr8V6SogAq4SAL9V2a2BSocaP8DjyL+WnVz0ocX6Q@mail.gmail.com>
In-Reply-To: <CALe7ZU1K9xr8V6SogAq4SAL9V2a2BSocaP8DjyL+WnVz0ocX6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Non-real time method using real time api
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: JAY KOTHARI <jaikothari10@gmail.com>, xenomai <xenomai@xenomai.org>

On 09/27/2014 05:53 AM, JAY KOTHARI wrote:
> On 9/27/14, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>> On 09/25/2014 01:57 PM, JAY KOTHARI wrote:
>>> Sir,
>>> How can I use real time api(or real time task) in non-real time method?
>>
>> The word real-time is overloaded, so, let us try to define some terms.
>>
>> A task or thread with a shadow is a user-space thread which can be
>> scheduled by Xenomai scheduler. Such a task is created with
>> rt_task_shadow or rt_task_create when using the native skin. When using
>> the posix skin, the main thread (the one which runs the "main" function)
>> is automatically shadowed during initialization, and all threads created
>> with the (wrapped) pthread_create service are shadowed.
>>
>> When a thread with a shadow is scheduled by Xenomai scheduler, this
>> user-space thread is said to run in primary mode. When this thread is
>> scheduled by Linux scheduler, it is said to run in secondary mode. A
>> task without a shadow, on the other hand, can only be scheduled by the
>> Linux scheduler.
>>
>> Most Xenomai services are only available to threads with a shadow. Some
>> services cause threads with a shadow to switch to primary mode, some
>> other services cause them to switch to secondary mode.
>>
>> Now that these terms are defined, could you explain us what you are
>> trying to do using them instead of the "real-time" word?
>>
>> --
>>                                                                 Gilles.
>>
> Thank you
> Actually I am trying to calculate scheduling jitter. Now to see the
> output I have to print it using printf which will make it to turn into
> secondary mode from primary. So I am trying to make a thread(by
> thread_create()) and getting into jitter value via real time pipe and
> printing in this thread. But it does not allow to call real time pipe
> in our thread.

A real-time pipe has two ends, one end for threads with a shadow, one
end for plain linux threads, so yes, you can use an rt_pipe for that.

> 
> In short my moto was to not disturb real time code so that in works on
> primary mode so that we get less jitter and call this jitter in
> secondary mode after all primary mode work is finished via a rt_pipe
> and print it there(i.e our thread created by thread_create()).

I do not know what thread_create() is, but if you mean pthread_create()
and if you are compiling for the posix skin, pthread_create creates
threads with a shadow.

Finally, for the printf thing, if you are compiling for the posix skin,
printf is wrapped to avoid causing its caller to switch to secondary
mode. If you are using the native skin, you can include rtdk.h and use
rt_printf.

-- 
                                                                Gilles.

