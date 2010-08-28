Message-ID: <4C78DA1C.9050602@domain.hid>
Date: Sat, 28 Aug 2010 11:42:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20100828044534.21096@domain.hid>
In-Reply-To: <20100828044534.21096@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Ubuntu packages
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: C Robinson <starknight__@domain.hid>
Cc: xenomai@xenomai.org

C Robinson wrote:
> Hi,
> 
> I'm seeking some clarification on a few points.   The background is
> that I have some software I need to install which requires Xenomai on
> Ubuntu.   Being fairly recent on the Linux scene, following the
> installation guide for Xenomai has been something of a voyage of
> exploration, as yet unfinished - and somewhat more complicated as I'm
> doing this on a bootable usb key.
> 
> In any case, a colleague mentioned there was an easier way using the
> available packages in the Ubuntu repositories, i.e. the
> xenomai-runtime and associated packages.  It was implied that with a
> straight-forward 'aptitude install xenomai-runtime' and voila I have
> a RTOS ready to use.   Given the descriptions of these packages (and
> no mention of patching of the kernel for example), I don't think that
> this is their purpose, particularly when I tried downloading the
> xenomai examples where the second step is :
> 
> make XENO=<xenomai-installation-path> KSRC=<xenomai-kernel-source>
> 
> Could someone confirm (or refute) this suspicion (that the packages
> do not provide access to a RTOS) and perhaps explain the intended use
> of the xenomai packages available on the ubuntu repositories - I've
> not seen any detailed reference as to why one would download and
> install these packages (say, in addition to having already gone
> through the long process of kernel patching + compilation + user
> space setup).
> 
> Thanks for any assistance, Charles

See:
http://www.xenomai.org/index.php/Building_Debian_packages

Please pay attention to the version of the packages available on Ubuntu.
As far as I understood, they are outdated, so, you would probably better
use the Debian package and install them on Ubuntu.

-- 
					    Gilles.

