MIME-Version: 1.0
In-Reply-To: <53989D82.3090903@xenomai.org>
References: <CAKKWdtcgvyU+1MDS=aqKWaYeg6EK2ZexKvds2mHFzqhEv5E-Vw@mail.gmail.com>
 <53976142.2070005@xenomai.org>
 <CAKKWdtepxXzy+xy-hxJV8bXBsa=QC9Z_9YsDr7Y1z4nDN+6X0A@mail.gmail.com>
 <53989D82.3090903@xenomai.org>
Date: Sun, 15 Jun 2014 18:12:08 +0430
Message-ID: <CAKKWdtfp5XzXHX1MsuqxZH_or_+4yxiTp0s3zc0r+oqHAjw9GA@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] creating a user space task by RTDM library
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>

On 6/11/14, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> On 06/11/2014 10:25 AM, ali hagigat wrote:
>> On 6/11/14, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>> wrote:
>>> On 06/10/2014 03:32 PM, ali hagigat wrote:
>>>> Regarding xenomai 2.6.3, how rtdm_task_init() can be used in user
>>>> space? and the types like rtdm_task_t. Compiling with rtdm/rtdm.h or
>>>> rtdm/rtdm_driver.h produces errors.
>>>
>>> RTDM is a kernel-space only skin.
>>>
>>>
>>> --
>>>                                                                 Gilles.
>>>
>>
>> The RTDM documentation and the code comments report that
>> rtdm_task_init() can be used in user space.
>>
> The documentation says that a "User space task" is a valid context to
> call rtdm_task_init, but this means that a user-space task, currently
> executing kernel code, is a valid context, not that the function may be
> called from user-space. Really, RTDM is an API for writing drivers
> residing in kernel-space, it makes no sense to use it in user-space.
>
> --
>                                                                 Gilles.
>

How a user-space task can execute kernel code? I wonder if you could
write a short example. Thank you. (besides when a kernel code executes
the context is not user any more, the context is kernel)

