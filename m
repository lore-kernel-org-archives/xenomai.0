MIME-Version: 1.0
In-Reply-To: <CAJ2oMhL_wa5vNe=ujt7GDUM1q3GOmWsCUGv6t_pVfH+oJZkX7A@mail.gmail.com>
References: <CAJ2oMhL_wa5vNe=ujt7GDUM1q3GOmWsCUGv6t_pVfH+oJZkX7A@mail.gmail.com>
Date: Thu, 28 Apr 2016 08:37:17 +0300
Message-ID: <CAJ2oMh+1yKWqQXWHoQELsD731xDGWWjiYvWNSXv5Nc=1Ky5xSQ@mail.gmail.com>
From: Ran Shalit <ranshalit@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Communication between RT-kernel to non-RT kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Thu, Apr 28, 2016 at 7:44 AM, Ran Shalit <ranshalit@gmail.com> wrote:
> Hello,
>
> I am new with xenomai.
>
> I've made a lot of reading in the documentation which is very helpful.
> But I haven't found how to communicate between rt kernel to non-rt
> kernel on same machine,
> Is there any example or documantation which explains this ?
>
> Best Regards,
> Ran

I guess that there is actually no need for such example or documentation.
In userland 2 applications, one using xenomai kernel and the other
linux kernel can commuicate
in any method available in Linux between processes (pipes, shared
memeory, etc) . Right?

Regards,
Ran

