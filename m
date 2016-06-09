References: <f7021dcb136f405a82d01c1768bdf96a@AM3PR48MB0130.041d.mgd.msft.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <1a101f5a-4fb7-b303-e2e8-b5d2dc656dc2@xenomai.org>
Date: Thu, 9 Jun 2016 18:39:29 +0200
MIME-Version: 1.0
In-Reply-To: <f7021dcb136f405a82d01c1768bdf96a@AM3PR48MB0130.041d.mgd.msft.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai/Cobalt on ARM64
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: BREGARDIS Cedric <cedric.bregardis@transport.alstom.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/09/2016 06:25 PM, BREGARDIS Cedric wrote:
> Hi,
> 
> I'm studying the possibility to use xenomai/colbalt 3.x for arm64.  It
> seems arm64 port of xenomai is not yet released and only available in
> "next" branch. In this branch it is indicated (in file
> kernel/cobalt/arch/arm64/patches/README) that the ipipe patch is
> available in this repository:
> 
> git://git.xenomai.org/ipipe.git, branch devel/ipipe-3.18-linaro-arm64.
> 
> However it seems this repository does not provide this branch. Do you
> know what version of ipipe should be used for arm64?

This branch should be used: ipipe-4.1.y.

> 
> Furthermore do you have an idea of the stability of xenomai for arm64

The architecture passes all Xenomai tests, but that won't mean much
until we have some perspective from production systems.

> and when it could be expected to be released as a stable version?
> 

The arm64 port will be part of the Xenomai 3.1 release, for which there
is no ETA yet.

-- 
Philippe.

