MIME-Version: 1.0
In-Reply-To: <53976142.2070005@xenomai.org>
References: <CAKKWdtcgvyU+1MDS=aqKWaYeg6EK2ZexKvds2mHFzqhEv5E-Vw@mail.gmail.com>
 <53976142.2070005@xenomai.org>
Date: Wed, 11 Jun 2014 12:55:50 +0430
Message-ID: <CAKKWdtepxXzy+xy-hxJV8bXBsa=QC9Z_9YsDr7Y1z4nDN+6X0A@mail.gmail.com>
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
> On 06/10/2014 03:32 PM, ali hagigat wrote:
>> Regarding xenomai 2.6.3, how rtdm_task_init() can be used in user
>> space? and the types like rtdm_task_t. Compiling with rtdm/rtdm.h or
>> rtdm/rtdm_driver.h produces errors.
>
> RTDM is a kernel-space only skin.
>
>
> --
>                                                                 Gilles.
>

The RTDM documentation and the code comments report that
rtdm_task_init() can be used in user space.

