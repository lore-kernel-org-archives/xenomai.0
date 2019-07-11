Subject: Re: Question on deleting a locked RT_MUTEX
References: <CAFLxGvyW2aXNScNQb6rCQtS5AXd_NYYrw+qcjax_H_xiByL8WQ@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <2f90e818-0e5e-d06f-1cec-2491ffe01ba1@xenomai.org>
Date: Thu, 11 Jul 2019 16:30:11 +0200
MIME-Version: 1.0
In-Reply-To: <CAFLxGvyW2aXNScNQb6rCQtS5AXd_NYYrw+qcjax_H_xiByL8WQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard.weinberger@gmail.com>, xenomai@xenomai.org

On 7/11/19 10:15 AM, Richard Weinberger via Xenomai wrote:
> Hi!
> 
> doc/asciidoc/MIGRATION.adoc states:
> - For consistency with the standard glibc implementation, deleting a
>   RT_MUTEX object in locked state is no longer a valid operation.
> 
> I'm not sure how this affects my Xenomai 2 application which is being
> ported to Xenomai 3.
> 
> If I have a mutex m1 and a misbehaving RT_TASK rt1 which exits right after
> acquiring mutex m1, what is the recommended way to get the lock back into a
> well defined state?
> 

Unfortunately, I see no option other than leaking the orphaned mutex and
re-creating a new one on the same descriptor with rt_mutex_create().

-- 
Philippe.

