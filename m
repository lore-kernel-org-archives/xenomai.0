Message-ID: <4B9532EA.4070300@domain.hid>
Date: Mon, 08 Mar 2010 18:24:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B9530B5.60809@domain.hid>
In-Reply-To: <4B9530B5.60809@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] First loop iteration increased latency
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org

Daniele Nicolodi wrote:
> Hello. I'm obtaining quite nice results with Xernomai in my data
> acquisition program. However I observe an unexpected behaviour.
> 
> My test application works as follow: one process puts a data frame into
> a shared memory region and increments a semaphore. Another process waits
> on the semaphore, takes the data frame from the shared memory and
> processes it. I also place in the shared memory the time (obtained from
> clock_gettime(CLOCK_REALTIME, &ts)) the time at which I increment the
> semaphore. In the consumer process I look at the time difference between
> the stored time and the time at which I read the frame from the shared
> memory. In this way I hope to obtain a measurement of the inter process
> communication latency.

You should be using clock_gettime(CLOCK_MONOTONIC), it has a lower overhead.

> 
> I obtain a quite satisfactory latency, in the 20-30 usec range. However
> the latency for receving the first frame is always much larger: in the
> order of 8-10 msec! What can be the cause of such latency?

Either you have a bug in your protocol, or something else happens, such
as a cache effect. What is the size of the frame, what is the platform
you are using? Could you send us the test program, which would allow us
to reproduce the issue?

> 
> I'm monitoring xenomai mode switches with pthread_set_mode_np(0,
> PTHREAD_WARNSW) and I observe none of those. I thought that maybe I'm
> encountering page faults when reading for the first time the shared
> memory segment and I tried to "initialize" the memory reading from it in
> a very stupid loop:
> 
> int i;
> char c;
> from (i = 0; i < SIZE; i++)
> 	c = ((char *)shm)[i];
> 
> but it can be that the compiler is smarter than me and is optimizing the
> loop away. What is a better way to issue the page faults in a non
> critical section of my code? It would be nice if xenomai would support
> MAP_POPULATE mmap() flag.

It is not necessary. A conforming xenomai application should use
mlockall, so there is no way a mapping may not be populated.

> 
> How can I track the source of this increased latency?

Use the I-pipe tracer.

-- 
					    Gilles.

