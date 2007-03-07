Subject: Re: [Xenomai-core] --includedir ignored
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200703051548.12008.paul_c@domain.hid>
References: <200703051548.12008.paul_c@domain.hid>
Content-Type: text/plain
Date: Thu, 08 Mar 2007 00:15:02 +0100
Message-Id: <1173309302.5059.49.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
To: Paul <paul_c@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Mon, 2007-03-05 at 15:48 +0000, Paul wrote:
> Exploring some of the configure options with the view to generating a Debian 
> rule and I noticed a bug (?) in the make files - Passing an --includedir 
> option to configure, during the install phase, the given directory path is 
> ignored and make eventually bombs out when trying to create an asm/ symlink.
> 
>  Checking the include/ Makefile.am and it's siblings, I note includedir is 
> overridden by $(prefix)/include/<skin> and $(prefix)/include/asm-<arch>, yet 
> include/Makefile.am honours the $(includedir) config variable when attempting 
> to create the symlink.
> 
>  Also noted that include/compat/ headers don't get installed - Is this, and 
> the $(includedir) issue an oversight ?

include/compat is not installed on purpose, since what goes to
$(prefix)/include is aimed at compiling user-space code only, and files
under the compat/ root are placeholders for compiling Xenomai-enabled
2.4 kernels.

However, the includedir issue is clearly a bug of mine.

> 
> 
> Regards, Paul.
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



