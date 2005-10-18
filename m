From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17237.12533.38471.80992@domain.hid>
Date: Tue, 18 Oct 2005 19:29:25 +0200
Subject: Re: [Xenomai-core] Cosmetic changes to script xeno-config + man page
In-Reply-To: <200510181759.22534.rlenglet@domain.hid>
References: <200510170157.58507.rlenglet@domain.hid>
	<200510180217.41806.rlenglet@domain.hid>
	<17236.37957.919219.175800@domain.hid>
	<200510181759.22534.rlenglet@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Romain Lenglet <rlenglet@domain.hid>
Cc: xenomai@xenomai.org

Romain Lenglet wrote:
 > > In order to compare Xenomai with other Debian packagees, I
 > > checked gtk-config, and I have a few remarks on xeno-config
 > > and its manpage.
 > [...]
 > 
 > I merely documented xeno-config as it is now, and made the 
 > printed usage consistent. If you modify it, I will update the 
 > manpage accordingly.

Sorry for the digression then. But the point about DESTDIR still holds,
from my point of view.

 > 
 > 
 > Another item to add to the looOOong-term wishlist: I would like 
 > to have ready-to-use autoconf rules, to use instead of 
 > xeno-config.
 > 
 > If someone ever writes such rules, e.g. in a "xenomai.m4" file, 
 > it would only be necessary, at Xenomai install time:
 > 1- to copy xenomai.m4 into /usr/share/autoconf/autoconf/
 > 2- to add the following line into autoconf.m4:
 > m4_include([autoconf/xenomai.m4])
 > 2- to regenerate autoconf.m4f by running:
 > cd /usr/share/autoconf/autoconf
 > autom4te --language=autoconf --freeze --output=autoconf.m4f
 > 
 > A simpler solution would be to ship a xenomai.m4 to be used as a 
 > acinclude.m4 in every project using Xenomai. But I have had very 
 > bad experiences with aclocal in that use case. aclocal is quite 
 > buggy. And it would be more confortable for projects it is were 
 > immediately available after installing Xenomai.

Yes, this was the original plan, but there are still many things on our
todo list before that.

 > 
 > 
 > > Now, about the manpage itself, unless I am wrong, the DESTDIR
 > > feature is not documented, it is very useful when compiling
 > > for a target.
 > 
 > DESTDIR is a feature of makefiles generated through Automake, not 
 > of xeno-config. Why would you like to document this is in 
 > xeno-config's manpage?

DESTDIR is used by xeno-config the same way it is used by
Makefiles. When you compiled Xenomai for a target and installed it with
DESTDIR=/home/romain/target, you have to set DESTDIR in xeno-config
environment  so that it outputs
-I/home/romain/target/usr/realtime/include and
-L/home/romain/target/usr/realtimeLib.

Since it is a rather obscure functionality, it probably deserves an
explanation.

-- 


					    Gilles Chanteperdrix.

