From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 20 Nov 2014 15:01:33 -0500
Message-ID: <20141120200133.GN24110@csclub.uwaterloo.ca>
References: <20141118190014.GC3177@sisyphus.hd.free.fr>
 <20141118192437.GB24110@csclub.uwaterloo.ca>
 <20141118192846.GE3177@sisyphus.hd.free.fr>
 <20141118202833.GH3177@sisyphus.hd.free.fr>
 <20141118205303.GD24110@csclub.uwaterloo.ca>
 <20141118205624.GK3177@sisyphus.hd.free.fr>
 <20141118211713.GL3177@sisyphus.hd.free.fr>
 <20141118213931.GE24110@csclub.uwaterloo.ca>
 <20141119171204.GI24110@csclub.uwaterloo.ca>
 <20141119223848.GF7011@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141119223848.GF7011@sisyphus.hd.free.fr>
Subject: Re: [Xenomai] I-pipe error when requesting irq that is on omap gpio
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

On Wed, Nov 19, 2014 at 11:38:48PM +0100, Gilles Chanteperdrix wrote:
> I do not know what to say. At software level, it is not really hard
> to get the I-pipe code to trigger a write to a register when the
> first RT irq is enabled in a bank and another write when the last RT
> irq gets disabled, because we keep track of that in the
> enable_irqdesc/disable_irqdesc callbacks.

Sure, but other power management calls to the hardware is allowed to
change the register too at any time.  By setting the flag I make sure
the other calls will NEVER enable smartidle.  So making it a dtb option
means the board maker gets to specify that they want smartidle off for
a given piece of hardware.  I did want to make it only get changed when
an IRQ was enabled but that was a mess given it is in a totally different
part of the code.

> Now, I suspect hwmod is made to be transparent, and called when
> initializing the bank, way before an irq is enabled, so the
> behaviour can not really be influenced from enable_irqdesc/disable_irqdesc.

That is certainly true.  It is called when the hardware is probed.

-- 
Len Sorensen

