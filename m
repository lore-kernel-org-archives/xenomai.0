Date: Mon, 23 Feb 2015 13:38:49 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150223123849.GA16040@hermes.click-hack.org>
References: <CANWkrRPBG=3+k4GkcrMEO4fBb=tmvn+XKRR6t8S+p+r_ffm6vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANWkrRPBG=3+k4GkcrMEO4fBb=tmvn+XKRR6t8S+p+r_ffm6vg@mail.gmail.com>
Subject: Re: [Xenomai] Failed testsuite/latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Smith <2michael.smith@gmail.com>
Cc: xenomai@xenomai.org

On Mon, Feb 23, 2015 at 02:30:42PM +0200, Michael Smith wrote:
> Hi.
> I'm getting an error when trying to run the latency test in Xenomai 3.0.
> All the other tests seems fine.
> 
> My output:
> 
> == Sampling period: 100 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> warming up...
> latency: failed to set periodic, code 9
> 
> My architechture is Intel iCore 5.
> The GIT revision: 52fb91e..
> Linux kernel: 3.14.28
> The kernel have been built for architecture i686.

Any error on the kernel console ?

-- 
					    Gilles.

