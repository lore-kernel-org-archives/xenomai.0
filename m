Subject: Re: [Xenomai-help] Xenomai v2.3-rc1
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200611061834.10486.thomas.necker@domain.hid>
References: <1162750381.7285.15.camel@domain.hid>
	<200611061834.10486.thomas.necker@domain.hid>
Content-Type: text/plain
Date: Sat, 11 Nov 2006 20:13:50 +0100
Message-Id: <1163272431.5765.308.camel@domain.hid>
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
To: Thomas Necker <thomas.necker@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-11-06 at 18:34 +0100, Thomas Necker wrote:
> > 	[uvm]
> >
> > 	* Feature removed.
> >
> 
> I see that there is no direct syscall interface for pSOS added.
> We had a discussion about that a while ago. We're still thinking
> about doing that ourselves but wanted to use the uvm for the
> prototype. Why is the uvm support removed without having
> an adequate substitute for the skins it still supports?

Because the UVM introduced a significant amount of issues and confusion
among users for all previous releases, which translated into way too
much maintenance pressure on me, only to work-around unfixable design
flaws. Keeping the UVM alive for the 2.3 series would be the wrong
signal to send, since more people would rely on it, albeit it has been
deprecated during the 2.2 series. In the same time, blocking the release
of the 2.3 series, until the user-space support for pSOS and uITRON
emulators is reinstated would be inconsequent, given the number of
improvements and long awaited features 2.3 provides, like RTCAN.

Sometimes, there is the need to pick a choice among two sub-optimal
options, and this is what I did. This does _not_ mean that the pSOS or
uITRON support in user-space are being withdrawn, only that we need to
deal with priorities, and balance them according to the workforce we
have to develop this project. In the absence of external contribution,
those emulators will be adapted to the direct syscall interface when
time allows.

>  This
> means that there will be no way of supporting pSOS programs
> in 2.3, right?
> 

No, this means that currently, the first -rc releases of the 2.3 series
only support kernel-based pSOS applications. As I told you recently, I'm
ok to provide some help to anyone willing to contribute the direct
syscall interface for pSOS, which would enable a much more reliable
user-space support for this skin, like the VxWorks and VRTX emulators
already benefit from. Doing so would raise the priority of this task on
my todo list. If this support comes early enough, it could even be
merged before 2.3 final is out, since this is a simple and
self-contained add-on with zero impact on the core system.

For the time being, you could still use the UVM support still available
from 2.2.5 for prototyping your application, provided you likely don't
depend on 2.3-specific features like RTCAN drivers, since they would not
mix well with a UVM environment anyway.

> Thomas
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



