References: <946ea421-b654-bd7d-62ab-6131ae80dc7d@gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <9acc1de8-9a6b-32c0-a1e7-521601cd84d7@xenomai.org>
Date: Sat, 15 Apr 2017 17:08:10 +0200
MIME-Version: 1.0
In-Reply-To: <946ea421-b654-bd7d-62ab-6131ae80dc7d@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] obstack support with uClibc-ng >= 1.0.21
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Romain Naour <romain.naour@gmail.com>, xenomai@xenomai.org
Cc: Waldemar Brodkorb <wbx@openadk.org>, Pawel Sikora <sikor6@gmail.com>

On 04/14/2017 03:48 PM, Romain Naour wrote:
> Hi all,
> 
> Xenomai 3 doesn't build with recent uClibc-ng (since 1.0.21 release) since the
> obstack support has been removed [1].
> 
> I proposed a patch [2] disabling this feature unconditionally but I don't really
> understand how obstack support work with Xenomai and why it's required.
> 
> Do we need to add a requirement on Glibc system as suggested in [3] ?
> 

obstacks are used internally by helpers from our fuse-based registry
system (lib/copperplate/registry.c). No rocket-science in there, but not
a wheel that should be reinvented either, so the obstack support was
pulled from a gcc-based libiberty copy IIRC. Fact is that the code
assessing the opportunity to elide that code is terminally broken, as
you found out.

I pushed a commit [1] aimed at addressing the issue, by detecting
whether the underlying libc provides for native obstack support, only
building our replacement code if not, with some cleanups. This as been
tested against uClibc 1.0.22, and common glibc releases.

PS: I pushed some changes toward supporting musl to the stable branch as
well, but since the latter hides linux-specific ABI bits such as
SIGEV_THREAD_ID, full support requires more effort. So musl support is
still not there yet.

[1]
http://git.xenomai.org/xenomai-3.git/commit/?h=stable-3.0.x&id=4c593544d2ff39ba6631cc3fa0b91493973674d4

-- 
Philippe.

