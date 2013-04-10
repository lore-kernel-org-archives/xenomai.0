Message-ID: <5165C463.4090600@xenomai.org>
Date: Wed, 10 Apr 2013 21:58:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5165C158.7060005@gmail.com>
In-Reply-To: <5165C158.7060005@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Kernel space task VS User space task latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marco Guerri <gmarco.dev@gmail.com>
Cc: xenomai@xenomai.org

On 04/10/2013 09:45 PM, Marco Guerri wrote:

> Hi everyone,
> 
> I was wondering if there is anyone who can help me clarify some very 
> basic doubts I have regarding Xenomai internals.
> I am working with Xenomai 2.6.2.1 on a 2.6.31 kernel on an i.MX35 
> processor (thus, ARM arch).
> 
> Using the latency test program, I get the following results for User 
> space and Kernel space tasks.
> 
> *** IDLE ***
> User space --> Mean: ~7us
> Kernel space --> Mean: ~4us
> 
> *** HEAVY LOAD (dohell) ***
> User space --> Mean: ~34us
> Kernel space --> Mean: ~18us
> 
> Could you give me some hints on how to explain this great difference, 
> expecially with the system under load?
> What are the factors that could worsen the latency in IDLE conditions?
> What are the factors that can explain a value of latency doubled in case 
> of a system under load?


These results are completely expected. The code executed between the
time an interrupt happens and a kernel thread is woken up is simply
shorter than the code executed between the time an interrupt happens and
a user-space thread is woken up. On a loaded system, the difference in
time is even greater due to cache effects.

The latency in idle conditions is meaningless. The average latency is
meaningless.

Now the choice between kernel-space and user-space:
- should not be an all-or-nothing choice, you can do some performance
critical things in kernel-space by writing a driver using the RTDM skin,
and have it communicate with user-space tasks which should remain the
master;
- should not be governed by latencies measurement only (especially not
measurement on an idle system and measurement of average values),
programming in kernel-space is hard, takes time, and some habit, it
better be worth it.

-- 
                                                                Gilles.

