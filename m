From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 23 Sep 2015 11:34:13 -0400
Message-ID: <20150923153413.GN15616@csclub.uwaterloo.ca>
References: <5600F8DE.30705@xenomai.org>
 <CAFkYNwaW5+nnDmumwt_zFFn01oWY5CsS5Fbmj1wB0aPF7om-4w@mail.gmail.com>
 <20150922174455.GA13976@hermes.click-hack.org>
 <CAFkYNwa-XGD+JM-5w6EGepO8XG2Ki9Tt+ocqgcd_zNmPCngdyA@mail.gmail.com>
 <20150923053843.GD13976@hermes.click-hack.org>
 <20150923070615.GI13976@hermes.click-hack.org>
 <CAFkYNwYta4TDofpKcGfkH4xUB0udKg8Q721T97LTD6ua_5MWjg@mail.gmail.com>
 <20150923115911.GB28513@hermes.click-hack.org>
 <CAFkYNwZoEEiezx1Ny+s2WXgx5xP471A1BrVEnJJ9hukjyEv4-Q@mail.gmail.com>
 <CAFkYNwbRx9ZK10_F7XfcP7U0uNBafY=xA7H_TbxbBj7CxpETrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFkYNwbRx9ZK10_F7XfcP7U0uNBafY=xA7H_TbxbBj7CxpETrQ@mail.gmail.com>
Subject: Re: [Xenomai] Xenomai tests
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: vibnwis <vibnwis@gmail.com>
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

On Thu, Sep 24, 2015 at 01:26:31AM +1200, vibnwis wrote:
> To do a quick test if these CONFIG_LOCKDEP_SUPPORT
> CONFIG_TRACE_IRQFLAGS_SUPPORT ever able to be changed. I simply turn off
> everything in make menuconfig. I mean everything and these two flags are
> still there unchanged.
> FYI, I had the .config opened in a editor. Whenever changes were made, it
> would prompt in the editor to reload the contents.

Certainly looking at lib/Kconfig.debug, nowhere else can turn on
CONFIG_LOCKDEP except stuff in there.  Doing a search in make menuconfig
for LOCKDEP should show you that symbol and even explain (at least
usually it seems to) why the setting is what it is.

Here is what I see on 3.14 where I do have LOCKDEP disabled and
ipipe/xenomai in use:

 .config - Linux/arm 3.14.51 Kernel Configuration
 > Search (LOCKDEP) -----------------------------------------------------------
  +---------------------------- Search Results -----------------------------+
  | Symbol: LOCKDEP [=n]                                                    |  
  | Type  : boolean                                                         |  
  |   Defined at lib/Kconfig.debug:928                                      |  
  |   Depends on: DEBUG_KERNEL [=y] && TRACE_IRQFLAGS_SUPPORT [=y] &&       |
  |               STACKTRACE_SUPPORT [=y] && LOCKDEP_SUPPORT [=y]           |                                                           
  |   Selects: STACKTRACE [=y] && FRAME_POINTER [=n] && KALLSYMS [=y] &&    |
  |            KALLSYMS_ALL [=y]                                            |                                          
  |   Selected by: DEBUG_LOCK_ALLOC [=n] && DEBUG_KERNEL [=y] &&            |
  |                TRACE_IRQFLAGS_SUPPORT [=y] && STACKTRACE_SUPPORT [=y] &&| 
  |                LOCKDEP_SUPPORT [=y] || PROVE_LOCKING [=n] &&            |
  |                DEBUG_KERNEL [=y] && TRACE_IRQFLAGS_SUPPORT [=y] &&      | 
  |                STACKTRACE_SUPPORT [=y] && LOCKDEP_SUPPORT [=y           |
  |                                                                         |
  |                                                                         |  
  | Symbol: DEBUG_LOCKDEP [=n]                                              |  
  | Type  : boolean                                                         |  
  | Prompt: Lock dependency engine debugging                                |  
  |   Location:                                                             |  
  |     -> Kernel hacking                                                   |
  | (1)   -> Lock Debugging (spinlocks, mutexes, etc...)                    |  
  |   Defined at lib/Kconfig.debug:957                                      |  
  |   Depends on: DEBUG_KERNEL [=y] && LOCKDEP [=n]                         |  
  |                                                                         |  
  |                                                                         |  
  | Symbol: LOCKDEP_SUPPORT [=y]                                            |  
  | Type  : boolean                                                         |  
  |   Defined at arch/arm/Kconfig:169                                       |  
  |                                                                         |
  +-----------------------------------------------------------------(100%)--+
  |                                < Exit >                                 |  
  +-------------------------------------------------------------------------+

So in this case since the 'Selected by' says DEBUG_LOCK_ALLOC is off,
then the first block (up to ||) is false, and PROVE_LOCKING is off,
so the next block is false, which means all selectors of LOCKDEP are
false and it is itself false.

-- 
Len Sorensen

