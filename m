Date: Fri, 27 Feb 2015 21:24:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150227202453.GK434@hermes.click-hack.org>
References: <54F0CF9E.1040707@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54F0CF9E.1040707@siemens.com>
Subject: Re: [Xenomai] [RFC] Consolidated exception prologue/epiloge for x86
 and ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On Fri, Feb 27, 2015 at 09:12:14PM +0100, Jan Kiszka wrote:
> Hi,
> 
> just pushed a first implementation of the general model that I proposed
> for exception handling. You can find it at
> 
> http://git.xenomai.org/ipipe-jki.git/log/?h=queues/trap-rework

NACK. The ARM implementation is broken, re-enabling hardware irqs
before stalling root is wrong.

Besides, I find that


if (foo) {
   bar;
} else {
  qux;
}

When there is nothing after adds useless indentation.

if (foo) {
   bar;
   return;
}

qux;

is much clearer.

Both thins were handled correctly in the implementation I proposed.
Also, reading your implementation as patches makes things uselessly
hard to read.

Simply posting the prologue and epilogue code would have made things
simpler.


> 
> I can also relay the patches to the list if desired.
> 
> Besides the issue that Gilles remarked, I found no further problems
> while implementing and testing this approach on both x86-64 and ARMv7.
> 
> I also added support for hardware breakpoint handling on ARM at this
> chance but I didn't test that particular path yet.

As you had been warned, your tests were useless since I disagree
with your implementation.

-- 
					    Gilles.

