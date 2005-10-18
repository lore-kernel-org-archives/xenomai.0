From: Romain Lenglet <rlenglet@domain.hid>
Subject: Re: [Xenomai-core] Cosmetic changes to script xeno-config + man page
Date: Tue, 18 Oct 2005 17:59:22 +0900
References: <200510170157.58507.rlenglet@domain.hid>
	<200510180217.41806.rlenglet@domain.hid>
	<17236.37957.919219.175800@domain.hid>
In-Reply-To: <17236.37957.919219.175800@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510181759.22534.rlenglet@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

> In order to compare Xenomai with other Debian packagees, I
> checked gtk-config, and I have a few remarks on xeno-config
> and its manpage.
[...]

I merely documented xeno-config as it is now, and made the 
printed usage consistent. If you modify it, I will update the 
manpage accordingly.


Another item to add to the looOOong-term wishlist: I would like 
to have ready-to-use autoconf rules, to use instead of 
xeno-config.

If someone ever writes such rules, e.g. in a "xenomai.m4" file, 
it would only be necessary, at Xenomai install time:
1- to copy xenomai.m4 into /usr/share/autoconf/autoconf/
2- to add the following line into autoconf.m4:
m4_include([autoconf/xenomai.m4])
2- to regenerate autoconf.m4f by running:
cd /usr/share/autoconf/autoconf
autom4te --language=autoconf --freeze --output=autoconf.m4f

A simpler solution would be to ship a xenomai.m4 to be used as a 
acinclude.m4 in every project using Xenomai. But I have had very 
bad experiences with aclocal in that use case. aclocal is quite 
buggy. And it would be more confortable for projects it is were 
immediately available after installing Xenomai.


> Now, about the manpage itself, unless I am wrong, the DESTDIR
> feature is not documented, it is very useful when compiling
> for a target.

DESTDIR is a feature of makefiles generated through Automake, not 
of xeno-config. Why would you like to document this is in 
xeno-config's manpage?

-- 
Romain Lenglet

