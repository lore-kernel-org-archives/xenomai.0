Date: Thu, 20 Nov 2014 21:06:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141120200639.GF4545@sisyphus.hd.free.fr>
References: <20141118192437.GB24110@csclub.uwaterloo.ca>
 <20141118192846.GE3177@sisyphus.hd.free.fr>
 <20141118202833.GH3177@sisyphus.hd.free.fr>
 <20141118205303.GD24110@csclub.uwaterloo.ca>
 <20141118205624.GK3177@sisyphus.hd.free.fr>
 <20141118211713.GL3177@sisyphus.hd.free.fr>
 <20141118213931.GE24110@csclub.uwaterloo.ca>
 <20141119171204.GI24110@csclub.uwaterloo.ca>
 <20141119223848.GF7011@sisyphus.hd.free.fr>
 <20141120200133.GN24110@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141120200133.GN24110@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] I-pipe error when requesting irq that is on omap gpio
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On Thu, Nov 20, 2014 at 03:01:33PM -0500, Lennart Sorensen wrote:
> On Wed, Nov 19, 2014 at 11:38:48PM +0100, Gilles Chanteperdrix wrote:
> > I do not know what to say. At software level, it is not really hard
> > to get the I-pipe code to trigger a write to a register when the
> > first RT irq is enabled in a bank and another write when the last RT
> > irq gets disabled, because we keep track of that in the
> > enable_irqdesc/disable_irqdesc callbacks.
> 
> Sure, but other power management calls to the hardware is allowed to
> change the register too at any time.

Then we have a problem, because once the irq has been enabled for
Xenomai, it is almost certainly wrong for a power management call to
change its register. So, probably power management should be
disabled like on x86.

>  By setting the flag I make sure
> the other calls will NEVER enable smartidle.  So making it a dtb option
> means the board maker gets to specify that they want smartidle off for
> a given piece of hardware.  I did want to make it only get changed when
> an IRQ was enabled but that was a mess given it is in a totally different
> part of the code.

Yes that I what I meant, getting back the pointer to the structure
needed by the hwmod layer is going to be hard, since this pointer is
well hidden under the carpet.

Anyway, if anyone wants a better solution, he will implement it, I
will merge your patch in the current version of the I-pipe patch
(3.16.0).

-- 
					    Gilles.

