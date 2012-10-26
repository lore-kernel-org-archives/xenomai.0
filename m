From: Wayne Warren <wwarren@emacinc.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 26 Oct 2012 10:41:39 -0500
Message-ID: <1351266099.5784.30.camel@ENG-09-LX.emacinc.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Question about Adeos I-pipe patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

I am looking at the ksrc/arch/arm/patches directory in the Xenomai git
repository for tags v2.6.0 and v2.6.1.

I notice in v2.6.1 there is an ipipe patch named
"ipipe-core-3.2.21-arm-1.patch" which differs from the others I have
seen which start with "adeos-ipipe".

Since I prefer to pull from the original ipipe tree directly rather than
applying the patch, does it matter if I choose "ipipe-core" or
"adeos-ipipe"? I would prefer the latest vanilla kernel version, so if
you could recommend a head/tag to checkout corresponding to this patch,
I would appreciate it. Right now I am looking at the "for-ipipe-3.2-arm"
head.

Thanks!

Wayne


