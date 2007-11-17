Message-ID: <473EEB10.30704@domain.hid>
Date: Sat, 17 Nov 2007 14:22:24 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200711171224.15108.niklaus.giger@domain.hid>
In-Reply-To: <200711171224.15108.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Failure running
	prepare-kernel.sh	adeos-ipipe-2.6.23-powerpc-DENX-2.0-03.patch
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
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org


Hi Niklaus,

Niklaus Giger wrote:
> Hi
> 
> I get the attached errors when running
> $ xenomai-trunk/scripts/prepare-kernel.sh \
> --linux=linux-2.6-denx \
> --adeos=xenomai-trunk/ksrc/arch/powerpc/patches/\
> adeos-ipipe-2.6.23-powerpc-DENX-2.0-03.patch \
> --arch=powerpc 
> 
> The kernel directory is a git clone of 
> git://www.denx.de/git/linux-2.6-denx.git
> and was created with the following command
> git checkout -b sequoia-v2.6.23.1 v2.6.23.1
> xenomai-trunk is at Revision 3185
> 
> I get the same errors when running against v2.6.23.
> 
> Could you please indicate me against which kernel this patch
> was built against?
> 

This patch is based on a snapshot from DENX's tree taken on 2007-10-12,
against commit #3e44e7de644b521c5301c806d90da6feb99158d5. I guess we
need this info in the README file -- wil fix, thanks.

-- 
Philippe.

