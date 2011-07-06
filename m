MIME-Version: 1.0
In-Reply-To: <4E144591.6010906@domain.hid>
References: <CAOiXNkDLimRNcf1xwnJoMCx=Q3a87Pp9=_bsuN5DizKoGs7Xzg@domain.hid>
	<4E144591.6010906@domain.hid>
Date: Wed, 6 Jul 2011 13:42:45 +0200
Message-ID: <CAOiXNkARoeBWpSRQtkh8OLye3AYGtX8qcD1-K-zNO8ooPW0sBA@mail.gmail.com>
From: Andrey Nechypurenko <andreynech@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

Thanks Gilles for the quick response!

> You can use mutexes with priority inheritance to avoid this issue. But
> Xenomai has ready made queues for rt/non-rt communication, the rtipcs:
>
> http://www.xenomai.org/documentation/xenomai-head/html/api/group__rtipc.html

What makes me worry here is the IPC abbreviation - I have just one
process with multiple threads. So would not real IPC mechanism be the
overkill in this scenario? Or am I just misinterpret what IPC means
here?

> A lockless solution for this (one consumer, one producer) is the good
> old fifo.

I have one producer, but do not want to limit myself with just one
consumer (although currently there is only one). In addition, here I
am probably again confused by the terminology, but does not fifo you
mentioned here is another IPC mechanism? What I am seeking is the way
to communicate between two threads and benefit from the fact that they
share the same process memory.


Thanks,
Andrey.

