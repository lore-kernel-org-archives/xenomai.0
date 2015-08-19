References: <CAAXf6LUGJPnZk7wtU5u0nthkrSiPbOKzsVuMQzfU+AqhL-OCcw@mail.gmail.com>
 <CAAXf6LUQ3wbLxQqoD79ZORUNZyn+Q6FXF6Wc8bOxP7FKiG0Fmg@mail.gmail.com>
 <55D499B3.9000300@xenomai.org>
 <CAAXf6LUX3Mr-q1=urd+rv_cuke+n_nTGVFsHYqHz1d=G2tRpjQ@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55D4A231.3050804@xenomai.org>
Date: Wed, 19 Aug 2015 17:35:13 +0200
MIME-Version: 1.0
In-Reply-To: <CAAXf6LUX3Mr-q1=urd+rv_cuke+n_nTGVFsHYqHz1d=G2tRpjQ@mail.gmail.com>
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
To: Thomas De Schampheleire <patrickdepinguin@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 08/19/2015 05:12 PM, Thomas De Schampheleire wrote:
> On Wed, Aug 19, 2015 at 4:58 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>> On 08/19/2015 01:03 PM, Thomas De Schampheleire wrote:
>>> On Fri, Jul 24, 2015 at 2:48 PM, Thomas De Schampheleire
>>> <patrickdepinguin+xenomai@gmail.com> wrote:
>>>> Hi,
>>>>
>>>> With Xenomai Mercury (specifically the PSOS skin, but that doesn't
>>>> matter for this question), the minimal stack size applied is
>>>> PTHREAD_STACK_MIN * 4, even if the caller requested a smaller one.
>>>>
>>>> On MIPS, and some other architectures, PTHREAD_STACK_MIN is already 128K:
>>>> (<glibc>/ports/sysdeps/unix/sysv/linux/mips/nptl/bits/local_lim.h)
>>>>
>>>> /* Minimum size for a thread. At least two pages with 64k pages. */
>>>> #define PTHREAD_STACK_MIN 131072
>>>>
>>>> With Xenomai multiplying this with 4, every thread has half a megabyte
>>>> of stack, which is way too much for systems with a large number of
>>>> threads.
>>>> It is possible to limit this in other ways, by setting 'ulimit -s 128'
>>>> for example, but it is a dirty workaround in my opinion.
>>>>
>>>> What is the real minimum stack requirement for Xenomai? I cannot
>>>> imagine that this is in the order of 512K.
>>>>
>>>> With PTHREAD_STACK_MIN varying so much on different platforms, what
>>>> about code like:
>>>>
>>>> minimum_stacksize = MAX(XENOMAI_STACK_MIN, PTHREAD_STACK_MIN);
>>>>
>>>> if (stacksize < minimum_stacksize) {
>>>>     stacksize = minimum_stacksize;
>>>> }
>>>>
>>>> where XENOMAI_STACK_MIN is a value that is not calculated based on
>>>> PTHREAD_STACK_MIN?
>>>>
>>>> With this approach, systems with 16K PTHREAD_STACK_MIN could still get
>>>> 64K minimum stack in case the xenomai minimum stack size is 64K, while
>>>> not negatively impacting systems that have 128K PTHREAD_STACK_MIN.
>>>>
>>>> (Note that for systems with 4K/8K pages, the PTHREAD_STACK_MIN of 128K
>>>> (two 'pages' taken for 64K) is already very exaggerated)
>>>>
>>>
>>> Ping?
>>>
>>
>> Since there is no reliable way to define XENOMAI_STACK_MIN, the most
>> flexible approach would be to use PTHREAD_STACK_MIN as the default value
>> (instead of x 4), expecting the code creating threads to specify the
>> stack size they need (e.g. the ustack parameter to t_create() with the
>> pSOS emulator).
>>
> 
> But it was my understanding that PTHREAD_STACK_MIN could be too small
> in some systems for Xenomai to function properly, and hence x 4 was
> added.

Exactly (x86* calling stdio routines typically).

> If that history is correct, then there should be a way to determine a
> maximum to XENOMAI_STACK_MIN: it is the value of PTHREAD_STACK_MIN * 4
> for that system, supposedly a small page system.
> 

No, this figure was just picked out of trial and error on a failing test
case a long time ago on x86. This is why it looks overkill on ppc and
elsewhere with a 128k stack min. There is absolutely no guarantee that
it would fit all possible cases, not even all common paths when
traversing Xenomai code. Besides, the Xenomai libs are running on behalf
of applications, not on their own.

So only the application can figure this out, this is the reason why
relying on a default value provided by the Xenomai core libs is wrong by
design. The same way, PTHREAD_STACK_MIN is only a minimum value matching
architecture-specific requirements for stacks, regardless of whether
using such size would actually work in practice with the common software
environment.

> Just dropping the multiplication by 4 of PTHREAD_STACK_MIN would be
> fine for my use case, but I'm not sure if it will be fine for others.
> I added Jan in this thread because I saw in the commit history that he
> has been involved in such code before.
> 

I'm leaning toward providing --psos-stack-size instead (and equivalent
elsewhere) for setting the default pSOS stack size, for applications
that insist on omitting the ustack parameter in t_create() calls. That
would be logically better than forcing a default value different from
PTHREAD_STACK_MIN in the core libs, which don't know anything about the
potential stack consumption.

-- 
Philippe.

