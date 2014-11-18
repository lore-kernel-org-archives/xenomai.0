From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Tue, 18 Nov 2014 17:31:23 -0500
Message-ID: <20141118223123.GH24110@csclub.uwaterloo.ca>
References: <20141118185657.GA24110@csclub.uwaterloo.ca>
 <20141118190014.GC3177@sisyphus.hd.free.fr>
 <20141118192437.GB24110@csclub.uwaterloo.ca>
 <20141118192846.GE3177@sisyphus.hd.free.fr>
 <20141118202833.GH3177@sisyphus.hd.free.fr>
 <20141118205303.GD24110@csclub.uwaterloo.ca>
 <20141118205624.GK3177@sisyphus.hd.free.fr>
 <20141118211713.GL3177@sisyphus.hd.free.fr>
 <20141118213931.GE24110@csclub.uwaterloo.ca>
 <20141118220521.GN3177@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141118220521.GN3177@sisyphus.hd.free.fr>
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

On Tue, Nov 18, 2014 at 11:05:21PM +0100, Gilles Chanteperdrix wrote:
> From what I was told by someone who knew  someone who talked to
> someone, this was actually actually a two step process (I do not
> know whether this changed).
> 
> An team did the work that went into the kernel fork that was
> delivered to customers, with rapid delivery date as the priority
> goal.
> 
> Then in a second time, a different team started writing the code
> that went into mainline, I am not even sure it used the code of the
> first team.

Well there is also the question of whether it is the network group or
automotive group doing it (sometimes even for the same chip).

It does appear that the code is getting reused from the bits I have seen
getting mainlines, although at least some of it has needed some cleanups.

> I did that. And I prefer explicit bit numbers, because they match
> the datasheet, which is the ultimate reference.
> 
> With code relying on defines, you have to trust the define names to
> match what you think they do. And I have learned to never trust
> identifier names, so I want to check the datasheet anyway, and the
> defines do not help, because now instead of having just 4 fields to
> check from the same line of code in the documentation of one
> register, you have to find the 4 fields definitions in the
> middle of a whole bunch of definitions in a separate header file,
> and move back and forth.
> 
> So, the bottom line is, while I understand the values of defines to
> provide the same name to the same bit, when used in several places,
> as would be the case for software bitfield, I do not see the value
> of it for register values.

If you don't remember which bit is which, having names for them helps you
remember what the code does.  Or at least put a comment saying "Disabling
idle and enabling wakeup, etc".

Magic numbers with no explanation are terrible when reading the code.

-- 
Len Sorensen

