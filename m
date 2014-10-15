Message-ID: <543E9BAE.2010808@xenomai.org>
Date: Wed, 15 Oct 2014 18:07:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CABaOOZ2YOda_cUS-tskNxDZ6sNekMqnPnbu6p8Qp4kvjRzDMyA@mail.gmail.com>
In-Reply-To: <CABaOOZ2YOda_cUS-tskNxDZ6sNekMqnPnbu6p8Qp4kvjRzDMyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Manual context switch from userspace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stratiyenko Roman <picoworm@gmail.com>, xenomai@xenomai.org

On 10/15/2014 05:42 PM, Stratiyenko Roman wrote:
> hello,
> 
> Can anyone suggest how to solve next problem?
> 
> I need to use the context switch (ucontext.h glibc function) in xenomai
> task. But the problem is the swapcontext() make a kernel call that switches
> system to secondary mode, so I can't achive hard real time.
> 
> What can I do to switch context without switch to secondary mode?

I would understand the need for using context switches if they were not
going through kernel mode, but if they go through kernel mode, there is
absolutely nothing to gain, you can use threads directly, this will have
the same overhead.

Besides, with such context switches you have risks of interrupting
threads at the wrong time, and cause deadlocks.

-- 
                                                                Gilles.

