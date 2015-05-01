From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Fri, 1 May 2015 10:20:42 -0400
Message-ID: <20150501142042.GG24389@csclub.uwaterloo.ca>
References: <CAKC9m6fXKqNhwy3sZ9zqzoAu=Xb7TUSxceogpE7xxB9-J=11wQ@mail.gmail.com>
 <20150430183147.GZ1993@hermes.click-hack.org>
 <CAKC9m6cXp+ZQdZG2qCQA5+J2m0W-2hnLniL0wswfSu5aD32wwg@mail.gmail.com>
 <20150430201409.GA1993@hermes.click-hack.org>
 <20150430212151.GD24389@csclub.uwaterloo.ca>
 <20150430213404.GC1993@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150430213404.GC1993@hermes.click-hack.org>
Subject: Re: [Xenomai] Ipipe-core patched kernel fails to start when certain
 platform drivers are enabled
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

On Thu, Apr 30, 2015 at 11:34:04PM +0200, Gilles Chanteperdrix wrote:
> I had tested architected timers on omap5432, and I believe the
> counter frequency was something like 5 MHz, and a high latency, this
> looks like a serious regression when omap4 had the global timer
> running at 500 MHz and a 22ns latency in user-space (including the
> time to jump to the kernel helper), which is better than the latency
> I have on an atom N230 where reading the tsc is a dedicated
> instruction (like architected timers actually).

Well the omap5 uses the A15 architecture timer.  The omap4 does not
since the A9 didn't have one.

Now they do have lots of other timers in the chip that can be programmed.
I wonder if that could be used to make something much better.

I am pretty sure the omap5432 uses 6.144 MHz just like the am572x was
supposed to (if it wasn't for the errata that makes it 6.147541 MHz instead).

Looking at the manual for the am572x it looks like the general purpose
timers are only 32 bit and can run at either 32.768 KHz or system clock
(usually 20 MHz).  That's not much help.

-- 
Len Sorensen

