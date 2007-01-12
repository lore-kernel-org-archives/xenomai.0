Subject: Re: [Xenomai-core] [BUG?] registry usage + module removal causes
	kernel	oops (xenomai native)
In-Reply-To: <45A6C97A.4090406@domain.hid>
References: <OF4D873F49.344BC96D-ONC1257260.005DC836-C1257260.00617F2A@retarus.de>
	<45A67C77.3070006@domain.hid>  <45A6C97A.4090406@domain.hid>
Content-Type: text/plain
Date: Fri, 12 Jan 2007 10:11:38 +0100
Message-Id: <1168593099.31022.18.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Thomas Wiedemann <Thomas.Wiedemann@domain.hid>, xenomai@xenomai.org

On Fri, 2007-01-12 at 00:34 +0100, Jan Kiszka wrote:
> Jan Kiszka wrote:
> > Thomas Wiedemann wrote:
> >> Another bug appeared for objects registered at the registry. When
> >> using xeno-native and xeno-rtdm, the order of removal seems to be
> >> important. I appended a small code sample to register a mutex at
> >> the registry. After the program exits, the modules can not be unloaded
> >> in the order
> >>   1) xeno-native
> >>   2) xeno-rtdm,
> >> but the other way around works fine. Instead, rmmod ends up with a
> >> segmentation fault, dmesg output appended.
> >>
> >> I tested this on xenomai 2.3.0/linux 2.6.19 and 2.2.5-svn/linux2.6.17.14.
> >>
> > 
> > Looks like it's related to the left-over mutex in the registry. Probably
> > the other order just papers the issue. $Someone should give your code a
> > try, maybe I can check later with a debugger.
> 
> Yet another reason to address auto-cleanup soon: I thought to remember
> the native skin keeps track of resources in a global list and kills them
> on rmmod, but that's only true for a few.
> 
> Instead stalled named resources are kept in the registry. On
> unregistration of the last skin xnregistry_cleanup() is called. It tries
> to kill the stalled entries from proc but their roots may have already
> been removed (here: the native skin's proc root).
> 
> Philippe, this makes the sweep loop in xnregistry_cleanup rather fragile
> and of questionable use.

It has never been meant as something skins should rely on or "use".
Interfaces that do not cleanup their place before leaving are just ugly
examples of unleashed procrastination, and it happens that I wrote one
of them. The cleanup loop in the registry unload code is solely a best
effort that may, or may not work depending on the setup (i.e. modular vs
static), this is _not_ an exported or exportable "feature".

>  I guess all skins have to handle this on their
> own, and we should just bark loudly here if something remained.

Yes. The registry has to maintain the basic information and likely
provide a simple mechanism over that which would allow the skins to
cleanup properly, but the skins would have to trigger this cleanup on
their own. I'm working on this.

-- 
Philippe.



