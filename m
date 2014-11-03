Date: Mon, 3 Nov 2014 17:02:23 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141103160223.GE9327@sisyphus.hd.free.fr>
References: <314E5ECDAA86314791309FA670550F89C6762243@SINTEFEXMBX05.sintef.no>
 <20141103122602.GB7705@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C67627E4@SINTEFEXMBX05.sintef.no>
 <20141103153617.GD9327@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C6762872@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C6762872@SINTEFEXMBX05.sintef.no>
Subject: Re: [Xenomai] Xenoma 2.6.4 missing posix/xeno_config.h ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Terje =?utf-8?Q?Fr=C3=B8ysa?= <Terje.Froysa@sintef.no>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Nov 03, 2014 at 04:00:03PM +0000, Terje Frøysa wrote:
> Thanks again!
> 
> As far as I understand I have glibc v2.13 installed:
> 
> debian@beaglebone:/lib$ ldd --version
> ldd (Debian EGLIBC 2.13-38+deb7u6) 2.13
> Copyright (C) 2011 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> Written by Roland McGrath and Ulrich Drepper.
> 
> Do I need to install anything more than this?

Yes, you have glibc installed, otherwise your system would not boot,
but this does not garantee that you have glibc _headers_ installed.
glibc headers include such files as /usr/include/stdio.h or
/usr/include/stdlib.h and are mandatory for compiling programs using
the glibc. glibc itself is only needed to run such programs.

-- 
					    Gilles.

