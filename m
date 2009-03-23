Message-ID: <49C79148.2090408@domain.hid>
Date: Mon, 23 Mar 2009 14:40:24 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <b131c9f0903230100x1b2aa2fet9e2b0efe68a7a77f@domain.hid>
	<1237813956.3576.13.camel@domain.hid>
In-Reply-To: <1237813956.3576.13.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai LTTng support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andreas Glatz <andreasglatz@domain.hid>
Cc: xenomai@xenomai.org

Andreas Glatz wrote:
> Hi,
> 
> On Fr. I got lttng (without Jan's patch) working 
> for my HW/SW-Configuration:
> 
> Linux: (Debian) Kernel 2.6.26
> Xenomai: 2.4.4
> Target: powerpc
> lttng kernel patch: patch-2.6.26.1-0.15.tar.bz2
> ltt control: ltt-control-0.50-17072008.tar.gz
> lttv: lttv-0.10.0-pre14-17072008.tar.gz
> 
> Configuration steps:
> 1) Applied Xenomai patch
> 2) Applied a bunch of other patches required to control our HW
> 3) Applied lttng patch
> 4) Configured and build the Kernel (see attached config file)
> 5) Build ltt-control for our target (powerpc) and lttv for my host (x86)
> 
> After installing the kernel and ltt-control I booted the 
> Kernel followed by:
> 
> 1) ltt-armall
> 2) lttctl -n trace -d -l /sys/kernel/debug/ltt -t /root/huhu
> 3) Started our Xenomai user-space application...
> 4) lttctl -n trace -R # Stops tracing
> 5) Transferred /root/huhu to my host and visualized it with lttv
> 
> Next step will be that I'll try to apply Jan's patch... although I
> haven't yet figured out why I would need it exactly...

The major issue are RT safe markers (so that you can also use them over
Xenomai tasks and interrupts). That depends a bit on the arch-specific
implementation (don't know the latest state /wrt PowerPC). See
http://git.kiszka.org/?p=ipipe-2.6.git;a=commitdiff;h=a3f9c39e4df84f0dd5976db1ab7ae6f14bf861ce
for what changes on x86 and what generic bits are required. The rest was
more or less mechanical conflict resolution.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

