MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17597.14761.519778.677673@domain.hid>
Date: Tue, 18 Jul 2006 21:42:33 +0200
Subject: Re: [Xenomai-help] poor graphic performance
In-Reply-To: <e325d110607181105n58a6fb47o24d53b42ee92e2a3@domain.hid>
References: <e325d110607181030vd9753c4j12f45f8246503715@domain.hid>
	<17597.7768.14509.204472@domain.hid>
	<e325d110607181105n58a6fb47o24d53b42ee92e2a3@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kim Chuan Lim <lim.kim.chuan@domain.hid>
Cc: xenomai@xenomai.org

Kim Chuan Lim wrote:
 > > Do you get these results while a xenomai application is running or
 > > without xenomai running ?
 > There is no any rt_task running in my computer when i do the glxgears testing.
 > 
 > > If a xenomai application is running, then it needs cpu. If no xenomai
 > > application is running, maybe you disabled support for DRI for your
 > > graphic card in kernel configuration ?
 > CONFIG_DRM=m
 > CONFIG_DRM_TDFX=m
 > CONFIG_DRM_R128=m
 > CONFIG_DRM_RADEON=m
 > CONFIG_DRM_I810=m
 > CONFIG_DRM_I830=m
 > CONFIG_DRM_I915=m
 > CONFIG_DRM_MGA=m
 > CONFIG_DRM_SIS=m
 > CONFIG_DRM_VIA=m
 > CONFIG_DRM_SAVAGE=m
 > 
 > I'm using the proprietary driver provided by Ati from
 > https://a248.e.akamai.net/f/674/9206/0/www2.ati.com/drivers/linux/ati-driver-installer-8.26.18-x86.run

If this driver works like the nvidia driver, it ships with a kernel
module that you must compile instead of the drm module. Did not you
forget to rebuild this module for the ipipe kernel ?

 > 
 > The default driver provided by my linux distribuition can only give
 > upto 200FPS in my xenomai box.

200 FPS is better than 10. But, I do not think the ipipe alone can make
such a difference, I would bet there is something missing, check that
the proprietary module is loaded, the AGP module is loaded, and check
the X server logs.

-- 


					    Gilles Chanteperdrix.

