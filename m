From: Paul <paul_c@domain.hid>
Subject: Re: [Xenomai-help] patching continues
Date: Tue, 20 Feb 2007 11:00:17 +0000
References: <45D9F759.7020006@domain.hid>
	<cbe23c50702192323h370cd65fg3490d82fea34cd33@domain.hid>
	<45DAC3A8.2000707@domain.hid>
In-Reply-To: <45DAC3A8.2000707@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200702201100.17480.paul_c@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org, rolandtollenaar@domain.hid

On Tuesday 20 February 2007 09:47, Roland Tollenaar wrote:
> 7-cp /usr/src/linux-2.6.16-ipipe/somewhere/defconfig
> /usr/src/linux-2.6.16-ipipe/.config

Make sure CONFIG_SYSFS, CONFIG_TMPFS, and CONFIG_RAMFS are all enabled (all 
under Psuedo filesystems). The latter is required for initrd support ad 
should be built in rather than compiled as a module.. As has been pointed out 
elsewhere, it is usually better to start with the config from a known, 
working kernel - Usually found in /boot/config-`uname -r` and/or sometimes 
under /proc/config.gz.


Regards, Paul.

