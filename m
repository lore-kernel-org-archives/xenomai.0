Message-ID: <4B0D4238.2050503@domain.hid>
Date: Wed, 25 Nov 2009 15:42:00 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B0D41B4.201@domain.hid>
In-Reply-To: <4B0D41B4.201@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with xenomai installation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Shumway <sshumway@domain.hid>
Cc: xenomai@xenomai.org

Steve Shumway wrote:
> Hello;
> 
> I've been through the installation process about 4 times now, and I 
> don't seem to be able to get it right.
> 
> List of problems:
> 
> In my running system (post installation) there is no /proc/xenomai 
> directory.
> 
> Efforts to run any of the example programs end with:
> Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
> (modprobe xeno_native?)
> 
> I'm using a vanilla kernel: 2.6.30.8
> 
> The Xenomai version I'm using is: xenomai-2.4.10
> 
> The Adeos patch is: adeos-ipipe-2.6.30.8-x86-2.4-06.patch
> 
> The resulting kernel does boot. I can look into /proc/config.gz and see 
> that the realtime extensions have been configured into the kernel. What 
> few modules there are, are all in 
> /lib/modules/2.6.30.8-adeos-ipipe-2.6.30.8-x86-2.4-06/... just as one 
> would expect.
> 
> What am I doing wrong?
> 
> Any help would be appreciated.

Show us the kernel logs.

-- 
                                          Gilles


