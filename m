Message-ID: <4F0C57A3.9030304@domain.hid>
Date: Tue, 10 Jan 2012 16:22:11 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <BLU166-W84625BB37F4B5F9C29FB6C4990@domain.hid>
In-Reply-To: <BLU166-W84625BB37F4B5F9C29FB6C4990@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Synchronization of shared memory with mutexes
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan-Erik Lange <jan0385@domain.hid>
Cc: xenomai@xenomai.org

On 01/10/2012 04:04 PM, Jan-Erik Lange wrote:
>
> Hello,
>
> I have a question about basics of the synchronization of shared memory
> with mutexes.
>
> The situation: The Sender is a RT task (primary domain) and the
> recipient is a non-RT task (usually in the secondary domain). Namely,
> the receiver is used to interact with a Web server. He calls to syscalls
> and stuff and because of that he's usually in the secondary mode.
>
> Suppose the sender has written something to the shared memory: He uses
> mutex for synchronization, so he calls the rt_mutex_release() function.
>
> The receiver will now get time to work from the scheduler. He calls
> rt_mutex_acquire() function to lock the shared memory. Then a context
> switch occurs from the secondary mode in the primary mode. He has now
> the resource for himself.
>
> Now the scheduler lets sender-task to work and it wants to write
> something. So it calls rt_mutex_acquire() function. And now comes my
> question: Provides rt_mutex_acquire() a mechanism to signal the cheduler
> to immediately continue with the recipient-task? If so, how does the
> rt_mutex_acquire() function tells the scheduler that?

There are two tasks controlled by the same (Xenomai) scheduler. One is 
trying to grab a mutex the other one holds, so it is put to sleep on 
that mutex. The scheduler will simply switch to the next ready-to-run 
task since the sender task cannot run anymore, and that next task may be 
the receiver task. There is no special signaling magic required.

>
> I came out because I in the documention I read the term "Rescheduling:
> always".
>

The documentation for rt_mutex_acquire is "Rescheduling: always unless 
the request is immediately satisfied or
timeout specifies a non-blocking operation.".

> Best regards
> Jan
>
>
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
Philippe.

