References: <CAAXf6LUGJPnZk7wtU5u0nthkrSiPbOKzsVuMQzfU+AqhL-OCcw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55DC796F.1020404@xenomai.org>
Date: Tue, 25 Aug 2015 16:19:27 +0200
MIME-Version: 1.0
In-Reply-To: <CAAXf6LUGJPnZk7wtU5u0nthkrSiPbOKzsVuMQzfU+AqhL-OCcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] minimum xenomai stack size (mercury)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thomas De Schampheleire <patrickdepinguin+xenomai@gmail.com>, xenomai@xenomai.org, Jan Kiszka <jan.kiszka@siemens.com>, Ronny Meeus <Ronny.Meeus@gmail.com>

On 07/24/2015 02:48 PM, Thomas De Schampheleire wrote:
> Hi,
> 
> With Xenomai Mercury (specifically the PSOS skin, but that doesn't
> matter for this question), the minimal stack size applied is
> PTHREAD_STACK_MIN * 4, even if the caller requested a smaller one.
> 
> On MIPS, and some other architectures, PTHREAD_STACK_MIN is already 128K:
> (<glibc>/ports/sysdeps/unix/sysv/linux/mips/nptl/bits/local_lim.h)
> 
> /* Minimum size for a thread. At least two pages with 64k pages. */
> #define PTHREAD_STACK_MIN 131072
> 
> With Xenomai multiplying this with 4, every thread has half a megabyte
> of stack, which is way too much for systems with a large number of
> threads.
> It is possible to limit this in other ways, by setting 'ulimit -s 128'
> for example, but it is a dirty workaround in my opinion.
> 
> What is the real minimum stack requirement for Xenomai? I cannot
> imagine that this is in the order of 512K.
> 
> With PTHREAD_STACK_MIN varying so much on different platforms, what
> about code like:
> 
> minimum_stacksize = MAX(XENOMAI_STACK_MIN, PTHREAD_STACK_MIN);
> 
> if (stacksize < minimum_stacksize) {
>     stacksize = minimum_stacksize;
> }
> 
> where XENOMAI_STACK_MIN is a value that is not calculated based on
> PTHREAD_STACK_MIN?
> 

At the end of the day, your suggestion is the best option, at least the
one that won't cause regression. I tried the other one on a couple of
large applications (expecting users to do the right thing and pass a
reasonable stack size), and the result wasn't pretty, given the sheer
number of threads created with default attribute settings, but running
stack-hungry code.

Fixed in -next, thanks.

-- 
Philippe.

