Date: Mon, 14 Dec 2015 23:32:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151214223224.GC16627@hermes.click-hack.org>
References: <uilidxdi7i7s3a3vwg8fck63.1450082790936@email.android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <uilidxdi7i7s3a3vwg8fck63.1450082790936@email.android.com>
Subject: Re: [Xenomai] Question on linux+xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Guoquan Hu <flyingfox_hu@163.com>
Cc: xenomai@xenomai.org

On Mon, Dec 14, 2015 at 04:52:11PM +0800, Guoquan Hu wrote:
> Hi, Xenomai maintainers, I am a Xenomai user from china, my
> environment is: linux(2.6.32)+xenomai(2.5.4).

This is really old. Linux 2.6.32 was released in december 2009 (6
years ago), and Xenomai 2.5.4 was released in august 2010 (5 years
ago).

Chances are the bugs you can have with this version have been fixed
a long time ago.

> I meet several
> problems on my debug environment, and I want to ask for advice to
> some questions about xenomei, would you please give some respond?
> My questions: 1.When CPU is high working load (near 100%) or
> nearly no memory left, the real time thread is killed. What is the
> mechanism behind and how to avoid it?

The mechanism is the Xenomai watchdog (option named
CONFIG_XENO_OPT_WATCHDOG in 2.6, not sure it had the same name in
2.5). But you probably do not want to disable it: starving Linux
from its timer interrupt may result in an unstable system.

> 
> 2.Under this environment, if OS is kernel crashed or real time communication（e.g
>  Pipe or MsgQueue） is blocked, how to debug or trace? Any system log indicate such kinds of things happened?  Any kernel dump mechanism is available for offline
>  analysis? 

What you want is the I-pipe tracer, but you have to add the trace
points manually, or use the CONFIG_IPIPE_TRACE_MCOUNT option to get
all the kernel functions traced.

> 3.Whether “Disk is set to read-only” related to real time thread usage? For example, if we use real time thread to write files on disk with high data rate, whether it
>  would cause system unstable or “disk read-only”? 

a real time thread can not really write to disk, it will switch to
secondary mode when doing so. And no, it should not result in the
filesystem being remounted read-only. A reason for remounting the
system read-only, however is an unclean filesystem, without a
journal and with the machine being rebooted without cleanly
unmounting it. After an unclean reboot, you should run fsck on all
file systems without a journal (fat, ext2, etc...). The problem may
also be due to the old versions you are using.


> 4.If we want to get technical support or consultant service, any
> company or person can provide such service?Thank!  

I am sure there are several companies on this mailing list offering
such services, I trust they will have answered you privately.

-- 
					    Gilles.
https://click-hack.org

