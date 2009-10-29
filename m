Message-ID: <4AE9A1DB.1060506@domain.hid>
Date: Thu, 29 Oct 2009 15:08:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1B242B31-29DB-4363-8B08-8E77B2928C34@domain.hid>
In-Reply-To: <1B242B31-29DB-4363-8B08-8E77B2928C34@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] analog output device with comedi/analogy --
 suddenly threads don't work anymore
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Schaal <sschaal@domain.hid>
Cc: xenomai@xenomai.org, Peter Pastor Sampedro <pastorsa@domain.hid>

Stefan Schaal wrote:
> Hi,
> 
>    this is following up on an installation of Alex's Xenomai tree on  
> Ubuntu 9.04 running the 2.6.29.5 kernel. While we managed to talk to  
> the  NI data acquisition board we have with this tree, we suddenly  
> discovered that some of our other software doesn't work anymore, in  
> particular threads. Below is a tiny program to run a thread, and the  
> compile statement we use. The thread never starts running. Does  
> anybody know what is going wrong here?
> 
> Thanks  a lot for any hint!

Ok, you have been hit by a combo of two bugs:
- you are compiling with static libraries because dynamic libraries are
temporarily disabled (due to a bug in configure.in for which Jan has
provided the fix just today);
- the --wrap mechanism used by the Xenomai posix skin has a known issue
with static libraries.

Fortunately, we recently implemented a fix for this second bug: use the
wrap-link.sh script on the compilation command line.

As in:

/usr/xenomai/bin/wrap-link.sh gcc -o xtest xeno_thread_test.c
-I/Network/Servers/duerer/clmc/prog/
include -I/usr/xenomai/include -I/usr/xenomai/include/posix -
D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__ -Wl,@/usr/xenomai/lib/
posix.wrappers -L/usr/xenomai/lib -lpthread_rt -lpthread -lrt

Please tell us if it still does not work.

-- 
                                          Gilles


