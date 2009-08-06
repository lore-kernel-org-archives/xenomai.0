From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1249586110.8905.9.camel@domain.hid>
References: <1249509063.4762.84.camel@domain.hid>
	<1249578204.3809.221.camel@domain.hid> <1249586110.8905.9.camel@domain.hid>
Content-Type: text/plain
Date: Thu, 06 Aug 2009 23:24:32 +0200
Message-Id: <1249593872.3809.242.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Alignment exception on powerpc
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andreas Glatz <andreasglatz@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On Thu, 2009-08-06 at 15:15 -0400, Andreas Glatz wrote:
> Hi Philippe,
> 
> 
> > > Is there a way to execute the exception handler from primary mode 
> > > to prevent the tasks to switch to secondary mode?
> > 
> > I have absolutely no freaking idea whether the following patch will
> > work, but you are welcome to feel lucky:
> > 
> 
> The patch seems to work. I even put a printk inside the if(fixed == 1) 
> clause inside of the patched function alignment_exception() 
> to check if things really get fixed... and they do!
> 
> I just noticed that u sent out another patch. Do u want me to test that
> one too? 
> 

Yes please. If that works for you, I will probably merge those bits in
the next pipeline release, after some additional testing. 83xx may take
various sorts of alignment traps, and there is no reason to suffer
secondary mode switches for basic instruction emulation followed by a
simple IP fixup.

#2 should definitely be better in some cases, for instance when the
cause of the alignment trap requires FP emulation.

> Of course, now I have the problem that I don't know which one is
> better... :p

Well, in terms of voodoo programming, the latest one is simply better
because it changes more lines of code, which gives much more
opportunities to break things. Ok, let's look cool and jaunty: let's
pick #2.

> 
> Andreas
-- 
Philippe.



