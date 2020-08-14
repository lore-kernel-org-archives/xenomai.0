MIME-Version: 1.0
References: <1596218699-15537-1-git-send-email-pintu@codeaurora.org>
 <7a76268b-84f6-0073-7830-54a317106c7d@siemens.com>
 <fc87600a-0797-849d-2d35-f2d32d1a7a90@siemens.com>
 <CAAvDm6a2VPs_0uqZZChXc=mhnx7c4Z1sPstbbMRNGceYKZg7_Q@mail.gmail.com>
 <65a89852-1f02-663a-3d08-6e0ad2716044@siemens.com>
 <CAAvDm6b8DoYYz47K0VDoAzedk9y3w5kv3UA-4TzLipHxkX=z2Q@mail.gmail.com>
 <CAOuPNLhPejZsUwCrjOWm=kT_JLJipcV7WXt6TgiAA6UDXpOmvg@mail.gmail.com>
 <108d1c6f-5ae5-788a-e8ce-5e649c9b3642@siemens.com>
 <CAOuPNLixxP7+RkW716PZ97mq1dNNdzsMMdX_LAZ4+_DYkmREUw@mail.gmail.com>
 <45246226-b3ca-a00a-5729-9a28e558dda5@siemens.com>
 <CAOuPNLjozRbNL_S8d8qNR9feSjcbiT+vbhLVM4K+AMAhrJy=TQ@mail.gmail.com>
In-Reply-To: <CAOuPNLjozRbNL_S8d8qNR9feSjcbiT+vbhLVM4K+AMAhrJy=TQ@mail.gmail.com>
From: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date: Fri, 14 Aug 2020 08:52:33 +0800
Message-ID: <CAAvDm6YbUCvMB3gtMoOBs-QyjTcgqQQ+5pBmNjDYvP_4jORy4A@mail.gmail.com>
Subject: Re: [PATCH] kernel:cobalt:heap: replace kzalloc with kvzalloc
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pintu Agarwal <pintu.ping@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Pintu Kumar <pintu@codeaurora.org>, xenomai <xenomai@xenomai.org>

>Can we just use vmalloc ?
>I think this is just an init code and it should not cause much impact
>with performance as in any case we are using GFP_KERNEL flag itself.
>Yes, I know the over-head about page-table and all with vmalloc

As what said in the last email, kvmalloc may be a better way than vmalloc:
kvmalloc(sizeof(struct xnheap_pgentry) * nrpages,
+                               GFP_KERNEL | __GFP_ZERO);

Besides, the kernel does implement kzvmalloc() in this way(which is
seen on https://elixir.bootlin.com/linux/latest/source/include/linux/mm.h#L759).
For your convenience, here is the related code snippet:
static inline void *kvzalloc(size_t size, gfp_t flags)
{
return kvmalloc(size, flags | __GFP_ZERO);
}

On Fri, Aug 14, 2020 at 1:49 AM Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> On Thu, 13 Aug 2020 at 16:01, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >
> > On 13.08.20 04:26, Pintu Agarwal wrote:
> > > On Wed, 12 Aug 2020 at 21:22, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> > >>
> > >> On 11.08.20 13:44, Pintu Agarwal wrote:
> > >>> Oh sorry about this.
> > >>> I can send a new patch set with kvmalloc that can work on all kernel versions.
> > >>>
> > >>
> > >> Yes, please do so to avoid that things become to messy when trying to
> > >> create that manually.
> > >>
> > >
> > > Thank you so much for your confirmation.
> > > Yes I am preparing a patch-set v2 and will send it soon.
> > > But is there a way to use both kvzalloc and kvmalloc depending on
> > > kernel version ?
> > > I see that checking using below is also not valid any more in higher
> > > kernel version:
> > > #if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 9, 0)
> > >
> >
> > This pattern still works, also in 5.x.
> >
> Yes, but it seems illegal to use in latest kernel version.
> The checkpatch.pl script in kernel catches these and that is why I see
> these pattern is no more used.
> scripts/checkpatch.pl:4157:# avoid LINUX_VERSION_CODE
> scripts/checkpatch.pl:4158:             if ($line =~ /\bLINUX_VERSION_CODE\b/) {
> scripts/checkpatch.pl:4159:                     WARN("LINUX_VERSION_CODE",
> scripts/checkpatch.pl:4160:
> "LINUX_VERSION_CODE should be avoided, code should be for the version
> to which it is merged\n" . $herecurr);
>
>
> Can we just use vmalloc ?
> I think this is just an init code and it should not cause much impact
> with performance as in any case we are using GFP_KERNEL flag itself.
> Yes, I know the over-head about page-table and all with vmalloc
>
> Anyways, I am exploring more what could be the best way.
>
> Thanks,
> Pintu

