From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 9 Nov 2015 14:57:24 -0500
Message-ID: <20151109195724.GW21923@csclub.uwaterloo.ca>
References: <20151105161902.GO21923@csclub.uwaterloo.ca>
 <20151105162514.GF16314@hermes.click-hack.org>
 <20151105165750.GP21923@csclub.uwaterloo.ca>
 <20151105171419.GG16314@hermes.click-hack.org>
 <20151105172452.GQ21923@csclub.uwaterloo.ca>
 <20151105175225.GR21923@csclub.uwaterloo.ca>
 <20151105214042.GE31487@hermes.click-hack.org>
 <20151105220851.GU21923@csclub.uwaterloo.ca>
 <20151106192557.GV21923@csclub.uwaterloo.ca>
 <20151107221303.GE1798@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151107221303.GE1798@hermes.click-hack.org>
Subject: Re: [Xenomai] ARM bus error due to alignment
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Sat, Nov 07, 2015 at 11:13:03PM +0100, Gilles Chanteperdrix wrote:
> Well, mapping the same piece of RAM with cacheable and non-cacheable
> mappings on ARM is "undefined behaviour" territory. If you want to
> map some RAM with H_NONCACHED, you should reserve it with something
> like the CMA allocator so that the kernel does not map it in any
> other way. That is one possible reason.
> 
> H_NONCACHED is routinely used on armv4/armv5 (actually, I mixed
> H_DMA with H_NONCACHED, Xenomai core never sets H_DMA, it sets
> H_NONCACHED for shared user/kernel mappings for armv4/armv5, because
> this is required with these architectures). So, it works. However,
> that maybe an issue with LPAE, that would be a second possible reason.

Sounds plausible.  Well I am not going to worry about it, since after
removing the unneeded flags (all of them), things work great.

-- 
Len Sorensen

