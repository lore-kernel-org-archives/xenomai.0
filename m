Date: Thu, 4 Aug 2016 14:17:44 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20160804141744.3adbe573@md1em3qc>
In-Reply-To: <web-9034838@tuebingen.mpg.de>
References: <web-9034838@tuebingen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] tsc not monotonic
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Vincent Berenz <vincent.berenz@tuebingen.mpg.de>
Cc: xenomai@xenomai.org

Am Wed, 3 Aug 2016 12:12:51 +0200
schrieb Vincent Berenz <vincent.berenz@tuebingen.mpg.de>:

> Hi,
> 
> After using for years xenomai 2.5.6 on ubuntu 12.04, we decided to
> upgrade to ubuntu 14.04 and a newer machine. I installed xenomai
> 2.6.4 and kernel 3.14.39. The installation boots correctly, the
> latency is low and our software seems to work ok.
> 
> But the system has "frequency surge" (I could not find better
> wording). For example:
> 
> - sometime when typing on the keyboard, the pressed key is printed
> many times ('aaaaaaaa' instead of 'a')
> 
> - 'glxgears' has change in frame rates, the gears can be seen as
> sometime changing speed. For example:
> 
> ---
> 1141 frames in 5.0 seconds = 228.186 FPS
> 1024 frames in 5.0 seconds = 204.787 FPS
> 506 frames in 5.0 seconds = 101.194 FPS
> 482 frames in 5.0 seconds = 96.317 FPS
> 1416 frames in 5.0 seconds = 283.182 FPS
> 2614 frames in 5.0 seconds = 521.100 FPS
> 2618 frames in 5.0 seconds = 522.314 FPS
> 3073 frames in 5.0 seconds = 614.562 FPS
> ---
> 
> All the tests run fine (as far as I could tell) with the notable
> exception of tsc which sometimes (not always) terminates with
> something like:
> 
> ---
> tsc not monotonic after 7430687798 ticks, jumped back 49567650 tick
> ---
> 
> I could find this in the syslog:
> 
> -------
> [    0.092932] TSC deadline timer enabled
> [    0.092941] Performance Events: PEBS fmt2+, 16-deep LBR, Haswell
> events, full-width counters, Intel PMU driver. [    0.092961] ...
> version:                3 [    0.092962] ... bit width:
> 48 [    0.092963] ... generic registers:      4
> [    0.092964] ... value mask:             0000ffffffffffff
> [    0.092965] ... max period:             0000ffffffffffff
> [    0.092965] ... fixed-purpose events:   3
> [    0.092966] ... event mask:             000000070000000f
> [    0.094914] x86: Booting SMP configuration:
> [    0.094916] .... node  #0, CPUs:        #1
> [    0.109150] TSC synchronization [CPU#0 -> CPU#1]:
> [    0.109157] Measured 25802382 cycles TSC warp between CPUs,
> turning off TSC clock. [    0.109161] tsc: Marking TSC unstable due
> to check_tsc_sync_source failed ---------

I have seen this message before, but with smaller numbers.

I assume you have not changed the Hardware, which versions of Xenomai
and the Kernel did you use before? Trying to find out whether these
checks did not trigger before because they did not exist or where
different in your old setup.

> Best
> 
> Vincent
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: config
> Type: application/octet-stream
> Size: 162268 bytes
> Desc: not available
> URL:
> <http://xenomai.org/pipermail/xenomai/attachments/20160803/26bc2e90/attachment.obj>
> -------------- next part -------------- An embedded and
> charset-unspecified text was scrubbed... Name: dmesg_xeno.txt
> URL:
> <http://xenomai.org/pipermail/xenomai/attachments/20160803/26bc2e90/attachment.txt>
> _______________________________________________ Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


