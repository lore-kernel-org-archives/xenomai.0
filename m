Message-ID: <53FDBF06.4000502@xenomai.org>
Date: Wed, 27 Aug 2014 13:20:38 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4F6C25B906613147991AA0B688C61D1F41FAFB78@SRVEXCHANGE.ona-electroerosion.com>
In-Reply-To: <4F6C25B906613147991AA0B688C61D1F41FAFB78@SRVEXCHANGE.ona-electroerosion.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Migrating from Xenomai to PREEMPT_RT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Asier Tamayo <asier.tamayo@onaedm.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/27/2014 10:45 AM, Asier Tamayo wrote:

> Full story:
> I have been using Xenomai for some time and must say I am really happy with the results (latencies, ease of programming, clear separation between the RT and non-RT parts...). My board is an Atom N270 based one, and runs a kernel 2.6.34 compiled with Sysgo's ELinOS 5.2 tool. I have mainly used the native skin, as well as some RTDM drivers.
> 
> Now, I have to start using a new AMD G-Series T52R based board, and kernel 2.6.34 shows some problems with it. Therefore, I have to update the kernel to a newer one, but ELinOS has dropped the Xenomai support. As far as I can think, I now have three options: try to install Xenomai in ELinOS by myself, start using another tool or leave Xenomai and use the PREEMPT_RT patch. The first option may be very error prone (in fact, I have already updated once the Xenomai version in ELinOS, but the tool had Xenomai support integrated previously in it). The second solution would surely put me in the Yocto path, which I think can be the correct one, but the learning step might require too much time from me.
>

Actually, updating your Elinos base to Xenomai 2.6.x would likely be
much less error prone than any other option, although I agree that
moving to Yocto is likely the best long term option.

Looking at the involved components:

- moving to Yocto means changing the whole environment, unless you go
for Denx's ELDK, which is Yocto-based _and_ Xenomai-enabled, in which
case you would not have to port your application.

- moving to straight preempt-rt means changing your programming model
from dual kernel to single kernel, porting your application from
Xenomai's "native" API to POSIX, and porting your drivers to a single
kernel system. A native incarnation of RTDM does exist, but we did not
receive any feedback since it was released (many) years ago, so rough
edges may exist.

- upgrading Elinos to Xenomai 2.6.x means updating your kernel - which
is something you have to do for other reasons anyway - and building a
drop in replacement of the Xenomai libraries and tools in user-space,
for replacing the legacy ones shipped with Elinos. Kernel-wise, the
requirement is to have an I-pipe patch available for your kernel version
of choice. The upcoming Xenomai 2.6.4 supports kernel 3.14.

> So, maybe the right solution would be to leave Xenomai and embrace the PREEMPT_RT patch, which is already supported by ELinOS. Has anyone got any experience with it? Which difficulties should I expect to find in the migration process? Any special problems with RTDM, shared memory...?
> 
> Has anyone got information about latencies and performance comparison between Xenomai and PREEMPT_RT patch? I have found some in https://www.osadl.org/fileadmin/dam/rtlws/12/Brown.pdf, but would like to have as much as possible to make the choice.
>  
> Is Xenomai 3 changing my situation in any way? Maybe using the Mercury architecture, in which I do not need to patch the kernel?

Mercury (i.e. single kernel Xenomai 3 configuration) would allow you to
move to preempt-rt without having to switch APIs from Xenomai 2.x
"native" to POSIX.

> 
> What do you think about the issue?
> 
> [From Xenomai 3 FAQ - http://xenomai.org/introducing-xenomai-3/: 
>     Q: I can run POSIX based applications directly over a PREEMPT_RT kernel on my target system, so what is the point of running Xenomai 3?
>     A: If your application is already fully POSIXish, and the performances requirements are met, then there is likely no point.(...)]
> 

This is fairly straightforward:

Xenomai 3 can either supplement the host kernel with a small co-kernel
for delivering real-time performances (aka "Cobalt" configuration), or
fully rely on the underlying kernel if it is deemed real-time already
(aka "Mercury").

In the latter case, if preempt-rt is available on your hardware/kernel
combo, meets your real-time performance requirements, then you do not
need Xenomai 3 to write POSIX apps, since the glibc provides for this API.

However, if your app is not POSIXish but based on an API Xenomai
emulates/implements, then you may want to use Xenomai 3 compared to
converting this app to POSIX, which is quite often an error prone
process. Xenomai 2.x "native" API is available with Xenomai 3, including
for a single kernel configuration (e.g. preempt-rt).

-- 
Philippe.

