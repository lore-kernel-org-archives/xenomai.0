MIME-Version: 1.0
References: <CAFLxGvwUEfbNtAnx31vUOo0BwR8ZMpstO1=t=bZpa-jpjTUh4A@mail.gmail.com>
In-Reply-To: <CAFLxGvwUEfbNtAnx31vUOo0BwR8ZMpstO1=t=bZpa-jpjTUh4A@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 31 Aug 2018 11:13:36 +0200
Message-ID: <CAFLxGvwJx2-37mgD10VkpuR2WHnNCVcu6W8x6w+Yx2JXG_B7TQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Problem with read-only mmap'ed vmalloc area
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Thu, Aug 30, 2018 at 1:35 PM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
> I think the problem is related on how Xenomai tries to pre-fault pages.
> As soon I remove the call to xnarch_fault_range() from
> rtdm_mmap_buffer(), the mapping works correctly
> and my test passes.

After reading more xenomai code I found something interesting.
In mach_arm_prefault() you set FAULT_FLAG_WRITE if VM_MAYWRITE
is present.
IMHO this is wrong and should check for VM_WRITE.
Otherwise a write fault is simulated even for read-only mappings.

In fact, when I apply this change, my test passes.

-- 
Thanks,
//richard

