Date: Fri, 28 Jun 2019 15:48:17 +0200
From: Henning Schild <henning.schild@siemens.com>
Subject: Re: Preview: 4.19-x86 support
Message-ID: <20190628154817.3824469d@md1za8fc.ad001.siemens.net>
In-Reply-To: <e6a51d68-e544-c5bf-ae8a-b0f98b083ee9@siemens.com>
References: <4a035faa-d1f8-d2ed-9351-192cea2d79eb@siemens.com>
 <20190621180432.483ea4a0@md1za8fc.ad001.siemens.net>
 <7b7ff8c9-0faa-2a9b-5347-ee5361a978d0@siemens.com>
 <20190624131858.41860152@md1za8fc.ad001.siemens.net>
 <ced098bf-d5fc-6dc0-cc82-05a5eec1c45b@siemens.com>
 <20190627155612.32bfc242@md1za8fc.ad001.siemens.net>
 <018eeba9-c186-89d6-b152-ba12959c3a9f@siemens.com>
 <20190628144849.1a811ffb@md1za8fc.ad001.siemens.net>
 <e6a51d68-e544-c5bf-ae8a-b0f98b083ee9@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

Am Fri, 28 Jun 2019 15:06:39 +0200
schrieb Jan Kiszka <jan.kiszka@siemens.com>:

> On 28.06.19 14:48, Henning Schild wrote:
> >> BTW, regarding the failing smokey gdb test: Check if gdb is
> >> available on the target. That is now a precondition.  
> > 
> > Yes it is. The $ N does not make any sense. It came from running a
> > local copy without "make install". That is currently not supported
> > by the gdb test, which should be fixed. People might want to test
> > before installing, if just working on one machine.  
> 
> This works fine here:
> 
> $ xenomai/build/testsuite/smokey/smokey --run=gdb
> gdb OK

Running local, in a rootfs not containing an old version? The problem
is launching smokey again from gdb. In my case the old smokey did not
even know about "gdb".

> > 
> > After that i run into  
> >>> FAILURE run_gdb:290: checking expression "primary_mode", expected
> >>> "1", found "0  
> >   
> 
> Can't reproduce. And given that line 290 in master does not contain
> any code, I strongly suspect your build is inconsistent.

Off by two debug printfs that did not cause the problem. 288 in a clean
copy ... a "make install" was required to get rid of the 290.

Henning

> Jan
> 


