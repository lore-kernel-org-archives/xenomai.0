From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Sun, 24 Aug 2014 22:27:58 -0400
Message-ID: <20140825022758.GR17765@csclub.uwaterloo.ca>
References: <20140822213159.GQ17765@csclub.uwaterloo.ca>
 <53F7B7E1.80009@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53F7B7E1.80009@xenomai.org>
Subject: Re: [Xenomai] Any idea how to fix ipipe failing to compile with ARM
 LPAE enabled?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, Aug 22, 2014 at 11:36:33PM +0200, Gilles Chanteperdrix wrote:
> On 08/22/2014 11:31 PM, Lennart Sorensen wrote:
> > Any idea how to fix ipipe to not cause a linking error when LPAE is enabled on arm?
> > 
> > I see the function __ipipe_pin_range_globally is inside an ifdef block that says essentially:
> > 
> > #if !IPIPE
> > define __ipipe_pin_range_globally as do nothing
> > #else
> > #if !LPAE
> > define __ipipe_pin_range_globally function
> > #endif
> > #endif
> > 
> > So if IPIPE and LPAE are both true, then the function is never defined.
> > 
> > This is in arch/arm/mm/fault.c
> > 
> I do not believe this is intentional. That being said, the Linux code in
> the #ifdef is not reassuring: exception handlers are not registered when
> the kernel is compiled with LPAE, which could mean that exceptions are
> used for LPAE when compiled with LPAE. If this is the case, then LPAE
> should not be enabled, otherwise your applications will not stay in
> primary mode when these faults happen. How much RAM do you have, can you
> really test LPAE ?

LPAE is required on arm to enable KVM, which we want to experiment with.
Don't need it for the ram quantity.

-- 
Len Sorensen

