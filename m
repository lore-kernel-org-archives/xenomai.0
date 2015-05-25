Date: Mon, 25 May 2015 17:22:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150525152238.GJ27570@hermes.click-hack.org>
References: <245D3361-0412-466A-BFA1-22F2EDDC18B6@gatech.edu>
 <55617756.4080307@web.de> <5563280B.2040301@gatech.edu>
 <CAPRPZsB59=0nQfZ7pAa-f4g5sG-myA4Z99phWwdmE_XH0cOFUw@mail.gmail.com>
 <55633A71.5090405@gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55633A71.5090405@gatech.edu>
Subject: Re: [Xenomai] 3.14.17 patch initial ram disk hangup
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yogi A. Patel" <yapatel@gatech.edu>
Cc: Jan Kiszka <jan.kiszka@web.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, May 25, 2015 at 11:06:25AM -0400, Yogi A. Patel wrote:
> 
> On 05/25/2015 10:23 AM, Jeroen Van den Keybus wrote:
> >>I read around online about interrupt remapping - and I can't seem to find
> >>anything that hints at why this turning it off would cause the latencies to
> >>be all over the place.
> >It shouldn't. There may be other reasons. But beware, in our tests the
> >Core i5/i7 showed about 29 us max. latency (running dohell), but
> >depending on the load, that can go up to 70 us (running a handbrake
> >video encoding session). What you see might actually be the best you
> >can get.
> I've been using "stress" to put a load on the system while running the
> xenomai latency test.
> 
> >>Any thoughts/guidance appreciated!
> >You seem to be running a desktop distribution. Try leaving desktop
> >mode (kill the window manager / X). Check you're not running binary
> >graphics drivers. Unload as many drivers as you can.
> You are correct. It looks like if I blacklist the radeon module (which I
> compiled with the kernel as a module, not using a binary), the latencies
> drop to 8-10us. I

The information that would be interesting would be whether you are
running the proprietary module. Even though proprietary modules
seem like being compiled, they in fact compile a small glue over a
big binary blob. Obviously, the I-pipe patch can not patch that
binary blob, so, you can only hope that the glue compiles what the
I-pipe patch would want to patch.

Anyway, this log message:
> [    0.880890] drm: module has bad taint, not creating trace events
Suggests that you are running the proprietary blob.

Also, something to note, once again, is that if you care about
performances, you should not have a kernel with everything enabled.
Notably not any form of tracing or debugging.

On the other hand, this message:
> [   21.886328] kvm: module has bad taint, not creating trace events
would suggest that you have rather a module/kernel mismatch. This
too can be detrimental to performances if you are running plain
linux modules with an I-pipe patched kernel.

However, looking at all this, I do not find any evidence that
disabling irq remapping created any performance issue, and I really
do not understand the logic that lead you to this weird conclusion.

-- 
					    Gilles.

