From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <470DECC9.6010102@domain.hid>
References: <470DECC9.6010102@domain.hid>
Content-Type: text/plain
Date: Fri, 12 Oct 2007 17:52:07 +0200
Message-Id: <1192204327.6499.144.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core]
	[PATCH]	adeos-ipipe-2.6.23-powerpc-DENX-2.0-01.patch
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>


Hi Wolfgang,

On Thu, 2007-10-11 at 11:28 +0200, Wolfgang Grandegger wrote:
> Hello,
> 
> attached is a patch for "arch/powerpc" for the DENX GIT tree 
> linux-2.6-denx version 2.6.23. It should replace the patch 
> adeos-ipipe-2.6.23-rc5-powerpc-DENX-2.0-01.patch. It just needed 
> adaption for the renaming of head_4xx.S to head_40x.S in 
> arch/powerpc/kernel/.

Great, thanks. I'm going to merge the latest updates from the generic
I-pipe tree into your patch and roll the result out asap.

Btw, do you know if 2.6.23-DENX runs the PA-SEMI properly? Last time I
checked (a month ago actually), -rc5 had some issues booting an Electra
board due to upstream changes.

-- 
Philippe.



