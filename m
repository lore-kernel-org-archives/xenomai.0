MIME-Version: 1.0
In-Reply-To: <E6D54D1B-1536-4F5F-9E7B-C8F856F5E3EC@korgrd.com>
References: <E6D54D1B-1536-4F5F-9E7B-C8F856F5E3EC@korgrd.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 29 Nov 2017 17:01:58 -0500
Message-ID: <CALLqZ8TqWgWkP6FTeeuNFraNn3hMDKfCs8ZBgWak7bprx=1moQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] matching patch version to kernel version
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,
  In my experience I usually try to get the patch that is the closest
match to my kernel version.  So I would try
ipipe-core-4.9.51-x86-4.patch, you will probably have to do some hand
fixes to resolve any conflicts if the patch doesn't apply cleanly.
That's usually how I approach it.  There could be better ways but for
me that's the most straight forward.

Hope this helps,

Greg

On Wed, Nov 29, 2017 at 4:53 PM, Steve Pavao <stevep@korgrd.com> wrote:
> Hi all,
>
> I am building Yocto poky linux for an Intel board at head in Master branch in Yocto poky, which currently results in a kernel version 4.9.61.
>
> I see that the latest patch file in the xenomai download area is ipipe-core-4.9.51-x86-4.patch.
>
> Will this patch work OK with the 4.9.61 kernel version, or should I use a different approach to ensure a better match?
>
> Steve Pavao
> Korg R&D
>
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

