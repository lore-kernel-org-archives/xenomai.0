Message-ID: <482BEC05.1050404@domain.hid>
Date: Thu, 15 May 2008 09:53:41 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4821B345.5070001@domain.hid>
In-Reply-To: <4821B345.5070001@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [patch] disallow includedir /usr/include
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
To: "Hillier, Gernot" <gernot.hillier@domain.hid>
Cc: Xenomai-core@domain.hid

Hillier, Gernot wrote:
> Hi again!
> 
> Current SVN head fails to do "make install" when you use --prefix=/usr
> resulting in the includedir /usr/include:
> 
> --- SNIP ---
> make[2]: Entering directory `/home/gernot/xenomai/include'
> make[3]: Entering directory `/home/gernot/xenomai/include'
> make[3]: Nothing to be done for `install-exec-am'.
> rm -f /usr/include/asm
> rm: cannot remove `/usr/include/asm': Is a directory
> make[3]: *** [install-data-local] Error 1
> --- SNAP ---
> 
> As far as I understood Jan, using /usr/include is a bad idea, so I
> created a patch telling the user what went wrong in a nicer way.
> 
> Please apply if you consider it to be the right fix (tm).
>

That makes sense, especially since that would prevent people from inadvertently
trashing their local header space. People who really want to play this game
should use DESTDIR explicitly instead. Merged, thanks.

> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
Philippe.

