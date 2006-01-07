MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17344.12661.617476.541553@domain.hid>
Date: Sat, 7 Jan 2006 22:24:05 +0100
Subject: Re: [Xenomai-core] [rfc] Building Linux kernel in Xenomai tree.
In-Reply-To: <43C01D76.3090808@domain.hid>
References: <17343.42595.626357.181448@domain.hid>
	<17344.665.154004.811426@domain.hid>
	<43C00A97.4020404@domain.hid>
	<17344.5951.309397.423794@domain.hid>
	<43C01D76.3090808@domain.hid>
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
 > > If you let configure select the proper adeos patch, you are warned when
 > > the adeos patch changed in the source directory (after an svn update,
 > > for example), and just have to type: 
 > > rm linux/.xenomai-prepared (Ok, this step is a bit awkward, we may find
 > >                             something better)
 > > make install
 > > 
 > > And a new kernel will be built and installed, using the new adeos patch
 > > and the same .config.
 > > 
 > 
 > Hmm, what about this: Instead of leaving some (probably empty)
 > xenomai-prepared in the kernel tree, better create an xenomai-uninstall
 > script in the same place. It a) can serve as an indication for a
 > prepared kernel and b) can be used to upgrade that tree by first running
 > it and then applying the usual steps on the kernel again.
 > 
 > I often forget to save my old adeos patch before updating the xenomai
 > tree, thus I will then have to download the old patch again,
 > reverse-apply it, and can finally run the prepare script for the update.
 > Automating this would be REALLY, REALLY GREAT!

The current approach try and achieve a similar goal by first copying (it
is not a real copy, only symbolic links to the source tree, a bit like
lndir would do) an unpatched kernel in Xenomai build tree, and preparing
it there. This way, when compilation with a new patch is needed, there
is no need to "unprepare" the kernel, only erase, copy again and prepare
the fresh copy, using the new patch. And that is what the current patch
automates.

unpreparing seems harder.

-- 


					    Gilles Chanteperdrix.

