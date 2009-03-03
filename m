Message-ID: <49AD5340.6090606@domain.hid>
Date: Tue, 03 Mar 2009 16:56:48 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF2344306C.C261A830-ON6525756E.003F50BB-6525756E.003E8F43@domain.hid>	<f48df4840903030338r6c10d610i5b6a6cddc7e9163b@domain.hid>	<OFEBB322C4.DB1D01E7-ON6525756E.00403279-6525756E.003FD3E1@domain.hid>
	<f48df4840903030621r74920230oa2b292631ce6db33@domain.hid>
In-Reply-To: <f48df4840903030621r74920230oa2b292631ce6db33@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Xenomai-core] (no subject)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bruno Rouchouse <brouchouse@domain.hid>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>, Vandana Sasidharan <vandana.sasidharan@domain.hid>

Bruno Rouchouse wrote:
> Hi,
> 
> the simulator README tells you how to build it:
> 
> Building the simulator
> 
> You will need the libelf, libpng, tcl8.x/tk8.x and tix41 _development
> packages_ in order to build the simulator and its companion tools.
> [...]
> Since v2.1, the simulator is available as a separate tarball, distinct
> from the main Xenomai archive. To build the simulator, you will also
> need the latter; the simulator archive should be extracted in
> Xenomai's main source tree under the sim/ sub-directory. The following
> steps should be followed in order to build and install the simulation
> system:
> 
> # $xenomai_tar: Main Xenomai tarball
> # $xenosim_tar: Simulator tarball
> # $xenomai_src: Root of Xenomai's source tree after extraction
> # $sim_builddir: Build root for the simulator
> # $sim_installdir: Installation directory for the simulator;
> # (usually, the same place than used for Xenomai's main system).
> # gcc_tarball: Path to a GCC 2.95.3 source archive.

Please note that gcc 2.95 will not compile on x86_64, so, if you are
running an x86_64, you should pass -m32 to gcc CFLAGS.

-- 
                                                 Gilles.

