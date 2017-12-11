Date: Mon, 11 Dec 2017 14:52:22 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20171211145222.7c8adbf3@md1em3qc>
In-Reply-To: <E6D54D1B-1536-4F5F-9E7B-C8F856F5E3EC@korgrd.com>
References: <E6D54D1B-1536-4F5F-9E7B-C8F856F5E3EC@korgrd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] matching patch version to kernel version
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve Pavao <stevep@korgrd.com>
Cc: xenomai@xenomai.org

Am Wed, 29 Nov 2017 16:53:49 -0500
schrieb Steve Pavao <stevep@korgrd.com>:

> Hi all,
> 
> I am building Yocto poky linux for an Intel board at head in Master
> branch in Yocto poky, which currently results in a kernel version
> 4.9.61.

Well if Xenomai/Ipipe is your priority you should probably just write a
kernel recipe for exactly such a kernel.

So in case of 4.9 you could just base your build on the last tag on
ipipe-4.9.y.
in case of x86:
http://git.xenomai.org/ipipe.git/tag/?h=ipipe-core-4.9.51-x86-4

> I see that the latest patch file in the xenomai download area is
> ipipe-core-4.9.51-x86-4.patch.
> 
> Will this patch work OK with the 4.9.61 kernel version, or should I
> use a different approach to ensure a better match?

You will have to try and if you get conflicts you will have to merge.

For the long running branches like ipipe-4.4.y and 4.9.y you could
also bring that topic up and we can discuss merging upsteam changes
into the ipipe branches.

On ARM you might be stuck with a non-mainline kernel and will have to
merge. When merging you can either merge ipipe into yourkernel, or
merge it the other way around. Which direction is easier depends on the
size of the diff. Merging the ipipe-patchset into another kernel is
hard, because that set contains a few very big commits.

Because funny BSPs cause problems all over the place, do not buy from
suppliers that do not do mainline, in case you have a say in that ;).

Henning
 
> Steve Pavao
> Korg R&D
> 
> 
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


