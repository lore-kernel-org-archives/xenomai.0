Message-ID: <4E1452E3.4010107@domain.hid>
Date: Wed, 06 Jul 2011 14:19:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAOiXNkDLimRNcf1xwnJoMCx=Q3a87Pp9=_bsuN5DizKoGs7Xzg@domain.hid>	<4E144591.6010906@domain.hid>
	<CAOiXNkARoeBWpSRQtkh8OLye3AYGtX8qcD1-K-zNO8ooPW0sBA@mail.gmail.com>
In-Reply-To: <CAOiXNkARoeBWpSRQtkh8OLye3AYGtX8qcD1-K-zNO8ooPW0sBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Communication between RT and non-RT thread
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andrey Nechypurenko <andreynech@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 07/06/2011 01:42 PM, Andrey Nechypurenko wrote:
> Thanks Gilles for the quick response!
> 
>> You can use mutexes with priority inheritance to avoid this issue. But
>> Xenomai has ready made queues for rt/non-rt communication, the rtipcs:
>>
>> http://www.xenomai.org/documentation/xenomai-head/html/api/group__rtipc.html
> 
> What makes me worry here is the IPC abbreviation - I have just one
> process with multiple threads. So would not real IPC mechanism be the
> overkill in this scenario? Or am I just misinterpret what IPC means
> here?

Not really overkill. Data will be copied from and to an intermediate
buffer. But if you send pointers to data, these copies will simply
involve copying the pointer twice.

I would say it is lockless mechanism which are overkill. Because
usually, lockless mechanisms have a much more complicated
implementation, and so are much more prone to bugs. All this for what?
To avoid a small critical section?

> 
>> A lockless solution for this (one consumer, one producer) is the good
>> old fifo.
> 
> I have one producer, but do not want to limit myself with just one
> consumer (although currently there is only one). In addition, here I
> am probably again confused by the terminology, but does not fifo you
> mentioned here is another IPC mechanism? What I am seeking is the way
> to communicate between two threads and benefit from the fact that they
> share the same process memory.

I am talking about the ring buffer thing with head and tail pointers
where each thread (consumer, producer), moves only one pointer. I would
call this a "lockless fifo", though I do not know what the official name
is, but you get the idea. Again, you can send pointers through an IPC
instead of sending the data themselves, and you will benefit from the
fact that the two threads are running in the same memory space.

-- 
					    Gilles.

