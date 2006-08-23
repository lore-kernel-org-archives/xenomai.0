Subject: Re: [Xenomai-core] Problems building RTnet
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44ECB7EF.7050300@domain.hid>
References: <200608232058.36523.niklaus.giger@domain.hid>
	<44ECB384.8080000@domain.hid>  <44ECB7EF.7050300@domain.hid>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 22:49:34 +0200
Message-Id: <1156366174.4401.77.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: xenomai@xenomai.org

On Wed, 2006-08-23 at 22:17 +0200, Jan Kiszka wrote:
> Jan Kiszka wrote:
> > Niklaus Giger wrote:
> >> Hi 
> >>
> >> Since a few hours RTnet cannot even be configured, as the Xenomai version got
> >> bumped to 2.3-devel. See
> >> http://ngiger.dyndns.org/buildbot/tqm860/builds/8/step-cfg_RTnet/0
> >> Where it says:
> >>
> >> checking for Xenomai version... configure: error: *** Unsupported Xenomai 
> >> version 2.3-devel in /var/buildbot/slave/tqm860/linux
> > 
> > Fixed (for the next versions now as well...).
> > 
> >> This morning the buildbot complained like the following:
> >> powerpc-860-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I../../../config   -g -I. -I/usr/xenomai/include -g -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -Wall -pipe -I../../../stack/include -I../../../stack/include -g -MT 
> >> rtnet_ifs.o -MD -MP -MF ".deps/rtnet_ifs.Tpo" -c -o rtnet_ifs.o rtnet_ifs.c; 
> >> \
> >>         then mv -f ".deps/rtnet_ifs.Tpo" ".deps/rtnet_ifs.Po"; else 
> >> rm -f ".deps/rtnet_ifs.Tpo"; exit 1; fi
> >> In file included from rtnet_ifs.c:31:
> >> ../../../stack/include/rtnet.h:29:23: rtdm/rtdm.h: No such file or directory
> > 
> > There must be still something wrong with the xenomai user-space
> > installation. Check if the xeno-config handed to RTnet returns
> > reasonable paths and if those paths contain the files we need here.
> > 
> 
> Looks like a DESTDIR-or-not-DESTDIR question in the include (and lib?)
> paths xeno-config returns. Do we need two runs for the Xenomai lib
> installation, one for the target and one for the build host? Or is RTnet
> supposed to add DESTDIR to all paths returned by xeno-config? Tricky,
> too tricky for tonight.

$ DESTDIR=/foo xeno-config ...
would make xeno-config prepend the staging directory to the output paths
when appropriate.

> 
> Jan
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



