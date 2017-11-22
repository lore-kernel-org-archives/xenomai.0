References: <CADYdroNdJwaHru0_T6PQQ2jo=XyP_KBMJojEgmHrghogpMZ=ng@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <c74bd1b9-331f-7d2a-6171-31fbe392b6e0@xenomai.org>
Date: Wed, 22 Nov 2017 18:09:11 +0100
MIME-Version: 1.0
In-Reply-To: <CADYdroNdJwaHru0_T6PQQ2jo=XyP_KBMJojEgmHrghogpMZ=ng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RFC] RTnet, Analogy and the elephant in the room
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Norbert Lange <nolange79@gmail.com>, Xenomai <xenomai@xenomai.org>

On 11/22/2017 11:06 AM, Norbert Lange wrote:
> Hi,
> 
> not really happy to hear that, but this was already my impression.
> There is alot of knowledge of kernel, hardware and bootloader
> knowledge necessary to be able to maintain the ipipe patch, as
> newcomer to most of these I am just helpless. Unless someone is
> dedicated to that,
> there is not chance to keep up.
> 
> What you could do is to automate as much as possible, saving some of
> the regular grinding work.
> The way realtime is used with minimal configurations, FTB errors will
> show up late,
> and changes in kernel APIs are only carried over in actively used drivers.
> 
> ie.
> -   automated builds with several kernel configs

Agreed. We used to have that, until last year. We need this back.

> -   potential some tests under qemu with the above.
> 
> Buildroot does something similar, and this is very low maintenance
> cost once its setup,
> could automatically report issues or non-working config-switches.

Do you mean buildroot-CI?

> Nowadays you can let providers like Gitlab take care of keeping the
> servers running,
> as I understand it you have no limits to build-time unless the project
> is private.
> You get some good issue tracking on top of it, patches can be
> automatically checked in form of merge-requests.
> (In the unlikely case they go bust or get unfriendly, you can still
> tun an older Gitlab version on your own server)
> 
> 
> I really don`t see the advantage in separating the subprojects,
> its already complicated enough to piece everything together,
> and with automated builds you could atleast catch build-errors or fails-to-boot.
> I take unmaintained, but buildable code in-tree over unmaintained code
> in a separate project everyday.

Moving to Gitlab is definitely an option on the table.

> 
> Publicity
> 
> Dont know how to takle this, but its very easy to get a full IDE and
> start programming some embedded CPUs.
> Commercial OSes have a huge advantage there, cause it doesnt take much
> to get example code running (youre only going to hit walls as your
> problems get bigger than their ecosystem). First impressions count,
> and being able to debug through code gets you firsthand knowledge
> faster than any other approach.
> 
> In that respect some known-to-work hardware with known-to-work
> dual-kernel with a pre-setup dev environment would go a long way to
> ease the first steps and might gather some new interested users.
> Some cheap, high-volume, jtag-debugable SBC would do.
> 
> Otherwise theres some architecture-, bios- and ever changing
> kernel-magic involved just to get a plain system running.

Agreed, the idea of, e.g. a live image booting Xenomai to lower the
barrier on entry is a nice way to attract new users. This said, the
discussion I would like to see first is about fixing the existing issues
in the development and maintenance processes so that current users have
their investment in Xenomai kept safe.

-- 
Philippe.

