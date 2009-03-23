From: Andreas Glatz <andreasglatz@domain.hid>
In-Reply-To: <b131c9f0903230100x1b2aa2fet9e2b0efe68a7a77f@domain.hid>
References: <b131c9f0903230100x1b2aa2fet9e2b0efe68a7a77f@domain.hid>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 23 Mar 2009 09:12:36 -0400
Message-Id: <1237813956.3576.13.camel@domain.hid>
Mime-Version: 1.0
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
To: vikesh rambaran <vikesh.rambaran@domain.hid>
Cc: xenomai@xenomai.org

Hi,

On Fr. I got lttng (without Jan's patch) working 
for my HW/SW-Configuration:

Linux: (Debian) Kernel 2.6.26
Xenomai: 2.4.4
Target: powerpc
lttng kernel patch: patch-2.6.26.1-0.15.tar.bz2
ltt control: ltt-control-0.50-17072008.tar.gz
lttv: lttv-0.10.0-pre14-17072008.tar.gz

Configuration steps:
1) Applied Xenomai patch
2) Applied a bunch of other patches required to control our HW
3) Applied lttng patch
4) Configured and build the Kernel (see attached config file)
5) Build ltt-control for our target (powerpc) and lttv for my host (x86)

After installing the kernel and ltt-control I booted the 
Kernel followed by:

1) ltt-armall
2) lttctl -n trace -d -l /sys/kernel/debug/ltt -t /root/huhu
3) Started our Xenomai user-space application...
4) lttctl -n trace -R # Stops tracing
5) Transferred /root/huhu to my host and visualized it with lttv

Next step will be that I'll try to apply Jan's patch... although I
haven't yet figured out why I would need it exactly...

Andreas


On Mon, 2009-03-23 at 10:00 +0200, vikesh rambaran wrote:
> Hi
> 
> I'm trying to get LTTng support for Xenomai 2.4.7 with Linux 2.6.28.7
> running.
> With regards the mailing list, the latest one seems to be
> 
> [ date    Tue, Feb 24, 2009 at 8:30 PM
>   subject    [Xenomai-help] [ANNOUNCE] LTTng-over-I-pipe git tree
> ]
> 
> My understanding of the sequence is :
> (please correct as necessary)
> 
> 1. Get the tree which already has LTTng and ipipe patched in
> 2. Apply trace_mark channel event patch to xenomai 2.4.7
> 3. Apply xenomai patches to kernel
> 4. Build and install
> 
> However, I am having trouble with the following and would appreciate
> help
> 
> a) "git clone git://git.kiszka.org/ipipe-2.6.git lttng/2.6.28-x86"
> as per the email, results in the 2.6.29-rc6. What should the command
> be
> to access the 2.6.28 tree ?
> 
> Note : downloading ipipe-2.6.28.7-x86-2.2-06 from 
> http://git.kiszka.org/?p=ipipe-2.6.git;a=commit;h=7abbb32f691345126d96cb6b48c587e145b8ef20
> using the web interface gives the 2.6.28.7 tree. Is this ok to use ?
> 
> b) The LTTng manual mentions that there should be a kernel option 
> Linux Trace Toolkit Next Generation (LTTng) under General settings.
> This seems to be
> unavailable for both the above trees. What must be done to enable this
> feature ?
> 
> c) Applying the xenomai instrumentation patch from
> [http://permalink.gmane.org/gmane.linux.real-time.xenomai.devel/6009]
> to the xenomai 2.4.7 
> tree using patch -p1 < "filename",  results in numerous hunks. What am
> i doing wrong ?
> 
> 
> Thanx for any help
> Vicki
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

