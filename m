MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17344.5951.309397.423794@domain.hid>
Date: Sat, 7 Jan 2006 20:32:15 +0100
Subject: Re: [Xenomai-core] [rfc] Building Linux kernel in Xenomai tree.
In-Reply-To: <43C00A97.4020404@domain.hid>
References: <17343.42595.626357.181448@domain.hid>
	<17344.665.154004.811426@domain.hid>
	<43C00A97.4020404@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > > The previous patch was also incorrect when trying to cross-compile the
 > > Linux kernel or building it for ppc. The attached patch fixes these
 > > issues.
 > > 
 > 
 > Regarding your general idea, I'm just trying to imagine the new build
 > process: you prepare and build the kernel + the userspace stuff again in
 > one step?. But you still have to configure both parts separately.
 > 
 > The question for me is now if this simplifies the situation expecially
 > for beginners. So far, the separation was clearly visible, now it /may/
 > become blurred (but I'm not a beginner...).
 > 
 > Can you provide a rough comparision of the workflows? Sorry, but I'm too
 > lazy, I mean busy to give it a try.

configure --enable-linux-build
make xconfig
make install

If you already have a .config file, the "make xconfig" step becomes
optional.

Note that the --enable-linux-build flag is optional too.

The simplification is mainly for developping xenomai itself, not for its
users. Because with the current scheme, after some modifications, you
have to recompile and reinstall both the kernel-space modules and
user-space libraries.

If you let configure select the proper adeos patch, you are warned when
the adeos patch changed in the source directory (after an svn update,
for example), and just have to type: 
rm linux/.xenomai-prepared (Ok, this step is a bit awkward, we may find
                            something better)
make install

And a new kernel will be built and installed, using the new adeos patch
and the same .config.

-- 


					    Gilles Chanteperdrix.

