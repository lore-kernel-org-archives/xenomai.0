Subject: Re: Question on deleting a locked RT_MUTEX
References: <CAFLxGvyW2aXNScNQb6rCQtS5AXd_NYYrw+qcjax_H_xiByL8WQ@mail.gmail.com>
 <2f90e818-0e5e-d06f-1cec-2491ffe01ba1@xenomai.org>
 <CAFLxGvySPtkN0+VSWO2zbQ7F0-+bsQR69_S8pi3Dxhx5oX9CUg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <4b96440d-785a-c1cb-f2e5-061980d204f7@xenomai.org>
Date: Thu, 11 Jul 2019 17:47:09 +0200
MIME-Version: 1.0
In-Reply-To: <CAFLxGvySPtkN0+VSWO2zbQ7F0-+bsQR69_S8pi3Dxhx5oX9CUg@mail.gmail.com>
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
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: xenomai@xenomai.org

On 7/11/19 5:34 PM, Richard Weinberger wrote:
> Philippe,
> 
> On Thu, Jul 11, 2019 at 4:30 PM Philippe Gerum <rpm@xenomai.org> wrote:
>>> If I have a mutex m1 and a misbehaving RT_TASK rt1 which exits right after
>>> acquiring mutex m1, what is the recommended way to get the lock back into a
>>> well defined state?
>>>
>>
>> Unfortunately, I see no option other than leaking the orphaned mutex and
>> re-creating a new one on the same descriptor with rt_mutex_create().
> 
> Will it leak on the kernel side or "just" in the userspace process?
> As long the application does not badly deadlock I think we can recover somehow.
> 

It will leak on both sides.

-- 
Philippe.

