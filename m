References: <DB6PR0701MB24567885F171F1129C2FCE61B57D0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
 <b7c66b27-ccc4-d1d0-56ed-1925514868b0@xenomai.org>
 <DB6PR0701MB2456EC4E9CD10826927A4E8EB57D0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <7961ee61-6d95-0c79-4839-2e611fbaa1c0@xenomai.org>
Date: Mon, 2 Oct 2017 16:45:42 +0200
MIME-Version: 1.0
In-Reply-To: <DB6PR0701MB2456EC4E9CD10826927A4E8EB57D0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] The task calling pthread_cond_signal() has to own the
 lock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/02/2017 04:25 PM, Giulio Moro wrote:
>> libcobalt enforces the requirement to hold the lock so that optimizing
>> the wake up process is possible - under the assumption that the caller
>> owns the lock. There is no hack around this.
> 
> Then I would suggest that pthread_cond_signal() should return an error code if the caller does not own the mutex. Currently it returns 0 (success), which is pretty confusing. I am happy to help bringing the documentation up to date once this is done.

I don't think so. Success here means nobody owns the mutex, including
the caller; you could have another thread owning that mutex, preventing
libcobalt to take the fast path (by returning 0 immediately).

At any rate, if the application does not care for serializing accesses
to condvars, accepting a fundamentally racy behavior, the kernel is
entitled to tell such app that everything was fine.

> 
> Am I right to say that the waiting thread will only be unblocked after the lock has been released from the calling thread, thus avoiding a potential deadlock situation?
> 

I don't see any deadlock situation in that case, but yes, libcobalt only
resumes a convar waiter when the lock covering it is released, to
prevent a double context switch, would the waiter had a higher priority
than the thread signaling the condvar.

-- 
Philippe.

