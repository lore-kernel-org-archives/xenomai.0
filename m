Message-ID: <e325d110607181105n58a6fb47o24d53b42ee92e2a3@domain.hid>
Date: Tue, 18 Jul 2006 19:05:58 +0100
From: "Kim Chuan Lim" <lim.kim.chuan@domain.hid>
Subject: Re: [Xenomai-help] poor graphic performance
In-Reply-To: <17597.7768.14509.204472@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> Do you get these results while a xenomai application is running or
> without xenomai running ?
There is no any rt_task running in my computer when i do the glxgears testing.

> If a xenomai application is running, then it needs cpu. If no xenomai
> application is running, maybe you disabled support for DRI for your
> graphic card in kernel configuration ?
CONFIG_DRM=m
CONFIG_DRM_TDFX=m
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m
CONFIG_DRM_I810=m
CONFIG_DRM_I830=m
CONFIG_DRM_I915=m
CONFIG_DRM_MGA=m
CONFIG_DRM_SIS=m
CONFIG_DRM_VIA=m
CONFIG_DRM_SAVAGE=m

I'm using the proprietary driver provided by Ati from
https://a248.e.akamai.net/f/674/9206/0/www2.ati.com/drivers/linux/ati-driver-installer-8.26.18-x86.run

The default driver provided by my linux distribuition can only give
upto 200FPS in my xenomai box.

Regards,
Kim Chuan.

