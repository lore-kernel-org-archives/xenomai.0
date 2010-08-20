From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTimcO45PW58j49aZPhjufkSi8dBs0t-wRzHVvEXp@domain.hid>
References: <AANLkTi=EDSiKDiHyvZ8LpqBC9AAHL+6i=goa4r-rZyJU@mail.gmail.com>
	<1282298341.1730.555.camel@domain.hid>
	<AANLkTimcO45PW58j49aZPhjufkSi8dBs0t-wRzHVvEXp@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 20 Aug 2010 14:17:08 +0200
Message-ID: <1282306628.1730.568.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread_make_periodic_np
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ramon costa <ramoncostacastello@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2010-08-20 at 12:45 +0200, ramon costa wrote:
> Hi,
> 
> 
> I needed to use 
> #include <pthread.h>
> #include <posix/pthread.h>
> 
> 
> Is it normal ? I would expect to need 
> 
> 
> #include <posix/pthread.h>
> 
> 
> only.
> 

Please keep the mailing list Cc'ed.

You only have to include <pthread.h>, this is what is expected by POSIX.
"xeno-config --skin=posix --cflags" outputs what is required for that
purpose.

> 
> 
> 
> From what I found in the manual page and in a Xenomai Makefile I have
> prepared the following Makefile
> for a posix skin user space application
> 
> 
> ------------------------------------------------------------------------------------------------------------
> ### List of applications to be build
> APPLICATIONS = p1_xn_parallel
> 
> 
> ###### USER SPACE BUILD (no change required normally) ######
> 
> 
> ### Default Xenomai installation path
> XENO ?= /usr/xenomai
> 
> 
> XENOCONFIG=$(shell PATH=$(XENO):$(XENO)/bin:$(PATH) which xeno-config
> 2>/dev/null)
> 
> 
> CC=$(shell $(XENOCONFIG) --skin=posix --cc)
> 
> 
> CFLAGS=$(shell $(XENOCONFIG) --skin=posix --cflags) $(MY_CFLAGS)
> 
> 
> LDFLAGS=$(shell $(XENOCONFIG) --skin=posix --ldflags) $(MY_LDFLAGS)

[snip]

> 
> It works. But I would like to know if it is formally correct. May I
> remove something from it ?
> 

If it works, then you should probably keep it this way, until you get
your feet wet with this environment.

-- 
Philippe.



