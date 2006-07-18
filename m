From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17597.8389.101648.999117@domain.hid>
Date: Tue, 18 Jul 2006 19:56:21 +0200
Subject: Re: [Xenomai-help] poor graphic performance
In-Reply-To: <17597.7768.14509.204472@domain.hid>
References: <e325d110607181030vd9753c4j12f45f8246503715@domain.hid>
	<17597.7768.14509.204472@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kim Chuan Lim <lim.kim.chuan@domain.hid>, xenomai@xenomai.org

Gilles Chanteperdrix wrote:
 > Kim Chuan Lim wrote:
 >  > Hi all,
 >  > 
 >  > The following is my glxgears result..
 >  > glxgears
 >  > 6693 frames in 5.0 seconds = 1338.519 FPS
 >  > 1069 frames in 5.0 seconds = 211.973 FPS
 >  > 50 frames in 5.0 seconds =  9.975 FPS
 >  > 567 frames in 5.1 seconds = 111.257 FPS
 >  > 50 frames in 5.0 seconds =  9.967 FPS
 >  > 388 frames in 5.1 seconds = 76.194 FPS
 >  > 50 frames in 5.0 seconds =  9.975 FPS
 >  > 50 frames in 5.0 seconds =  9.975 FPS
 >  > 282 frames in 5.1 seconds = 55.465 FPS
 >  > 353 frames in 5.0 seconds = 70.147 FPS
 >  > 
 >  > 10FPS is really low!!
 >  > 
 >  > May i know what is the reason it is so slow? I manage to get 2000FPS
 >  > in my normal linux box.
 > 
 > Do you get these results while a xenomai application is running or
 > without xenomai running ? 
 > If a xenomai application is running, then it needs cpu. If no xenomai
 > application is running, maybe you disabled support for DRI for your
 > graphic card in kernel configuration ?

It is DRM, not DRI. A more complete answer, check that the following
items are configured in your kernel configuration:
- in the menu "Processor type and features", check that MTRR is enabled;
- in the menu "Device drivers/Character devices", check that
  /dev/agpgart is enabled for your chipset;
- in the same menu, check that Direct Rendering Manager is enabled for
  your graphic card.

-- 


					    Gilles Chanteperdrix.

