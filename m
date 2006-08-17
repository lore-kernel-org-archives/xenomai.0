Subject: Re: [Xenomai-help] problem with installation
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <33646.155.98.4.150.1155767832.squirrel@domain.hid>
References: <20060816190510.20935.qmail@domain.hid>
	<44E36F6A.7060004@domain.hid> <200608162137.09103.nicola17@domain.hid>
	<44E37823.8080407@domain.hid>
	<33646.155.98.4.150.1155767832.squirrel@domain.hid>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 10:25:45 +0200
Message-Id: <1155803145.4356.33.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Brandt Erickson <brandt@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2006-08-16 at 16:37 -0600, Brandt Erickson wrote:
> So, perhaps I spoke too soon.  The system does boot, but I just looked in
> the syslog and found this:
> 
> 16 16:08:49 dewback kernel: [4294670.201000] I-pipe: Domain Xenomai
> registered.
> Aug 16 16:08:49 dewback kernel: [4294670.201000] Xenomai: hal/x86 started.
> Aug 16 16:08:49 dewback kernel: [4294670.231000] Xenomai: real-time
> nucleus v2.2 (Engines Of Creation) loaded.
> Aug 16 16:08:49 dewback kernel: [4294670.232000] Xenomai: starting native
> API services.
> Aug 16 16:08:49 dewback kernel: [4294670.232000] Xenomai: starting POSIX
> services.
> Aug 16 16:08:49 dewback kernel: [4294670.232000] Xenomai: starting RTDM
> services.
> Aug 16 16:08:49 dewback kernel: [4294670.232000] Xenomai: incompatible
> timer mode (aperiodic found, need periodic).
> Aug 16 16:08:49 dewback kernel: [4294670.232000] Xenomai: VxWorks skin
> init failed, code -16.
> 
> my .config is attached.  As far as I can tell, my timer is periodic and
> not aperiodic.  My kernel is 2.6.16 patched with xenomai-2.2.0 from the
> download page and not the trunk.

You need to build the native and POSIX skins as modules, so that they do
not override the timing mode (they both request aperiodic mode to the
nucleus, which conflicts with the VxWorks skin initializing after them).

> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



