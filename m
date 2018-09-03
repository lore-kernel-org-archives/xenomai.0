MIME-Version: 1.0
References: <CAFLxGvwUEfbNtAnx31vUOo0BwR8ZMpstO1=t=bZpa-jpjTUh4A@mail.gmail.com>
 <CAFLxGvwJx2-37mgD10VkpuR2WHnNCVcu6W8x6w+Yx2JXG_B7TQ@mail.gmail.com>
 <5bb68a54-d174-e4ca-1bad-ce148440cbc9@xenomai.org>
 <CAFLxGvycjSkQrKTMYwrQyaB6OktzHATyG+22J56hMk2a+78EtA@mail.gmail.com>
In-Reply-To: <CAFLxGvycjSkQrKTMYwrQyaB6OktzHATyG+22J56hMk2a+78EtA@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 3 Sep 2018 20:31:29 +0200
Message-ID: <CAFLxGvz-Sjm5HCTAfq=-QU9izp8HjVc--8S=50hN8o21mKpEUw@mail.gmail.com>
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

On Fri, Aug 31, 2018 at 10:27 PM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> On Fri, Aug 31, 2018 at 12:03 PM Philippe Gerum <rpm@xenomai.org> wrote:
> >
> > On 08/31/2018 11:13 AM, Richard Weinberger wrote:
> > > On Thu, Aug 30, 2018 at 1:35 PM Richard Weinberger
> > > <richard.weinberger@gmail.com> wrote:
> > >> I think the problem is related on how Xenomai tries to pre-fault pages.
> > >> As soon I remove the call to xnarch_fault_range() from
> > >> rtdm_mmap_buffer(), the mapping works correctly
> > >> and my test passes.
> > >
> > > After reading more xenomai code I found something interesting.
> > > In mach_arm_prefault() you set FAULT_FLAG_WRITE if VM_MAYWRITE
> > > is present.
> > > IMHO this is wrong and should check for VM_WRITE.
> > > Otherwise a write fault is simulated even for read-only mappings.
> > >
> > > In fact, when I apply this change, my test passes.
> > >
> >
> > I suspect that the original intent might have been to address the issue
> > of COW mappings (i.e.  (flags & (VM_SHARED | VM_MAYWRITE)) ==
> > VM_MAYWRITE), force-breaking them.
> >
> > This said, this particular issue may have been addressed earlier when
> > mlocking the process address space with MCL_FUTURE, and further enforced
> > by the call to disable_ondemand_memory() when installing the Cobalt
> > thread which is going to map that memory into the current address space
> > (cobalt_map_user()).
> >
> > IOW, why would we need more prefaulting here?
>
> Good point. It is also interesting that arm is the only machine where
> the .prefault
> handler is set. So, I guess this latency code which can be removed.

BTW: Do you want me to send a patch?

-- 
Thanks,
//richard

