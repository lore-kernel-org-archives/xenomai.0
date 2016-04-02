Date: Sat, 2 Apr 2016 17:38:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160402153812.GM22286@hermes.click-hack.org>
References: <CAJ=MaHrS2fBum0_YXj9Cussd9zpqiFa5o425j-5voggnzkd++Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ=MaHrS2fBum0_YXj9Cussd9zpqiFa5o425j-5voggnzkd++Q@mail.gmail.com>
Subject: Re: [Xenomai] Xenomai 3 on BBB or Raspi
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andrew Eliasz <andrew.eliasz@gmail.com>
Cc: xenomai@xenomai.org

On Sat, Apr 02, 2016 at 04:03:20PM +0100, Andrew Eliasz wrote:
> Apologies for taking up your valuable time.
> I have been able to get Xenomai 2 running on a Beagle Bone Black ...
> I have not been able to find any detailed instructions for getting Xenomai
> 3 to run on either a Beagle Bone Black or a Raspberry Pi.
> Has anyone, to your knowledge, been able to do this successfully please ?
> If not is there some other reference board for which Xenomai 3 build and
> install details are available so that I can carefully work through the
> steps involved and at least master those before attempting to get Xenomai 3
> to run on either a RaspberryPi or a Beagle Bone Black.
> Many thanks

Hi,

this question starts being asked a lot, so I am going to give a
longer answer than usual, for future reference.

Installing Xenomai is largely a process which does not depend on
distributions or board details, and is documented here:
https://xenomai.org/installing-xenomai-3-x/

I am giving here a summary of the information found there, supposing
you want to compile Xenomai with the cobalt core.

You first need to prepare kernel sources by running a shell script
(named prepare-kernel.sh) which applies an I-pipe patch (either
taken from Xenomai sources, or downloaded following instructions
here https://xenomai.org/getting-the-i-pipe-patch/, downloading the
I-pipe patch ensures that you can have a more recent version than
the one released with Xenomai), and sets up some symbolic links in
the kernel sources to compile Xenomai kernel-space support while
compiling the kernel.

For the specific case of boards not using mainline kernels, you may
have to apply some pre- and post- patches around the I-pipe patch,
these patches are found in Xenomai sources.
Alternatively, in the case of the Rpi, a branch may be found in the
I-pipe git repository, which you may use as base for running the
prepare-kernel.sh script: the script does not try and apply an
I-pipe patch if the sources are already patched.

Once you have done that, you have to configure the kernel. This is
the hard part, as the configuration is dependent on your board, but
you must also pay attention to not enable some options (listed
here:
https://xenomai.org//troubleshooting-a-dual-kernel-configuration/#kconf)

Finally, you can cross-compile your kernel "as usual". If you are
not comfortable with compiling kernels, you may find some
instructions specific to your board somewhere (but again, this is
largely independent of any board or distribution details), the fact
that the kernel is patched with Xenomai does not change anything to
the compilation and installation process.

The second step is to cross-compile Xenomai user-space support.
Xenomai uses the autotools, so is compiled by running configure,
make and make install (with some arguments when cross-compiling), in
any case, compiling packages using the autotools is also largely
documented on the web.

Regards.

-- 
					    Gilles.
https://click-hack.org

