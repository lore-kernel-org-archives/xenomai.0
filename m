MIME-Version: 1.0
From: Andreas Glatz <andi.glatz@gmail.com>
Date: Fri, 8 Dec 2017 11:03:04 +0000
Message-ID: <CAKJ14NcT45L6bT2b1jND1y1W-=uD8R1oQ18O62PN3E7YdNDKoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] RTnet fixes - testers needed (Philippe Gerum)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

>
> I pushed a pile of RTnet fixes in a WIP branch of the official repo
> (wip/rtnet-fixes). Most of them address invalid direct references to
> user memory from kernel space (instead of properly copying back and
> forth via the copy_from/to_user interface), which are badly wrong at any
> rate, even breaking the kernel on SMAP-enabled x86 platforms.
>
> Most I/O calls were affected, ioctl, sendmsg and recvmsg. I'm still in
> the early process of testing the changes gradually, which involves
> running tests for all socket levels (RAW, DGRAM) and protocols (INET,
> PACKET) enabled.

I think that's exactly what I was seeing when running 4.9 Linux +
Xenomai 3 + RTnet on i.MX6.

>
> If you depend on RTnet and want to help with testing, you may want to
> give this branch a try. Any help with reviewing the changes would be
> beneficial to the project too.
>

I shall try and give it a spin this weekend.

Thanks.

A.

