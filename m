Message-ID: <45AE7D81.9050007@domain.hid>
Date: Wed, 17 Jan 2007 13:48:17 -0600
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Compiling Linux+Xenomai 32bits kernel
	on	FC6	x86_64?
References: <cbe23c50701170051r46cadf4cha5b144d17df2ec77@domain.hid>	<45ADE724.3010800@domain.hid>
	<45AE3ED4.7040506@domain.hid> <45AE68CF.5080200@domain.hid>
In-Reply-To: <45AE68CF.5080200@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Hmm, that tickles my fantasy once again: Could we derive generic .specs
> from your files to include them in the Xenomai distribution? Then some
> additional Makefile rules could provide a "make rpm" that generates
> packages for kernel and userland (when given some kernel.tar.bz2).
> Basically, your steps generalised and automated.

That would be great.  I started with the 'mkspec' script from the vanilla kernel tree, and added a few things that make the resulting RPMs work better with Fedora.  I'm not sure how other distributions handle things like creating an initrd, etc.  Maybe someone could post a kernel.spec file for the latest version of SuSE.  I can look at it and see how it differs from what I'm doing on Fedora.

Right now, my spec file also creates a HUGE kernel-source RPM that contains the whole compiled source tree.  I really need to understand how the Fedora spec file creates kernel-devel RPMs that have just the stuff needed for compiling kernel modules.  This would be a lot better than having the huge kernel-source RPM that I generate now.

> This would help us to provide, e.g., an i386 pre-built package with
> reasonable default config, something I still consider useful. But, of
> course, it must not cost any effort :). Automated rpm generation would
> be a big step in that direction.

I think that would be very useful to many folks.
 
> BTW, have you seen my Xenomai.spec for the SuSE packages I once posted?
> Attached is an updated version. It splits the Xenomai userland in
> several sub-packages to allow selective installation.

No, I hadn't looked at it.  That is probably a better approach.  I can test this on Fedora when I get a chance.

-Jeff


