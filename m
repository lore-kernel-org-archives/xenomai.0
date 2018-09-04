References: <CAFLxGvwYj_Yf210DV+GHv_bNuuR4uo0cC=7b37ZztQj4Y+cQPA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <294b1675-ed0a-8018-fcfd-79c691209884@xenomai.org>
Date: Tue, 4 Sep 2018 10:33:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAFLxGvwYj_Yf210DV+GHv_bNuuR4uo0cC=7b37ZztQj4Y+cQPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Question on internal_get_unmapped_area()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard.weinberger@gmail.com>, xenomai@xenomai.org

On 09/04/2018 09:56 AM, Richard Weinberger wrote:
> Hi!
> 
> In kernel/cobalt/rtdm/drvlib.c your internal_get_unmapped_area() just
> returns the requested virtual address. Shouldn't it at least check for
> the address being aligned to PAGE_SIZE?

Out of laziness, I believe that we expect get_unmapped_area() to check
for this (!offset_in_page(addr)).

> And much more important, on VIVT systems it has to enforce alignment to SHMLBA.
> 

Although Xenomai used to support platforms with VIVT caches for years,
we practically stopped doing so a year ago or so. The reason for this
move is that VIVT is just not usable for low-latency systems unless we
mitigate the impact of the cache invalidation it requires on every
context switch.

We used to do that with an extension called FCSE [1], available with the
interrupt pipeline for ARM, but that code became orphan many moons ago
[2]. Since armv4/v5 lost all traction among the user base, we just
stopped caring, focusing on v7/v8 instead.

[1]
https://www.denx.de/en/pub/News/Xum2009AbstractsAndPresentations/The_ARM_Fast_Context_Switch_Extension_for_Linux.pdf
[2] git://archive.xenomai.org/ipipe-gch.git

-- 
Philippe.

