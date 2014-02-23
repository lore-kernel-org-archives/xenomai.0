Message-ID: <530A2265.30600@xenomai.org>
Date: Sun, 23 Feb 2014 17:31:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5308C79B.30708@athel.de>
In-Reply-To: <5308C79B.30708@athel.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] changing priority and policy VS unblocking
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Le 22/02/2014 16:51, Christian Göbeler a écrit :
> One question regarding xenomai best practices.
> 
> I have to modify an application running user defined code in worker
> threads (POSIX threads).
> 
> Performance-wise is it better to create designated RT-Threads waiting
> for a condition to be signaled and then continue to run in primary mode
> whatever code the user passed in or would it be just as fast and
> reliable to promote an already running worker thread by changing its
> priority to let's say 99 for example and its sched-policy to FIFO?

It depends on where originates the event which triggers the thread. If
it originates from linux domain, there is no point waiting in primary
mode, if it originates from Xenomai domain, the priority change will
trigger a switch to secondary mode, so, you will loose the determinism
of the response to the event.


-- 
Gilles.

