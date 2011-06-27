Message-ID: <4E085FFF.9020300@domain.hid>
Date: Mon, 27 Jun 2011 12:48:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTi=tRb1bZ=ZSkzhvps62xt8PMzNb3A@mail.gmail.com>
In-Reply-To: <BANLkTi=tRb1bZ=ZSkzhvps62xt8PMzNb3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai Unknown
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ashish Budhiraja <ashishmach@domain.hid>
Cc: xenomai@xenomai.org

On 06/27/2011 10:41 AM, Ashish Budhiraja wrote:
> Hello Everyone,
> 
> I am Ashish, very new to this group, I don't know anything about Xenomai but
> I want to have increased Real Time
> support for my Roboard-100. So as per the tutorial on this
> http://geonobot-wiki.toile-libre.org/doku.php?id=robotics:computing:xenomai_install_on_roboard
> link I did everything right now when I boot I get this message saying udevd:
> unknown 'Xenomai'  or something similar, and I can only boot to
> text console i.e. if I try to go for my gui my keyboard gets jammed.
> 
> I just want to know is there a possible way to check if Xenomai is perfectly
> installed or not though I looked carefully I didn't find any errors during
> the installation
> process but now it is showing 'Xenomai' unknown.
> 
> Please guide me how to proceed or tell me something to read.

In order to know whether Xenomai is working, try and run one of the
tests which come with Xenomai, "latency", for instance.

The issue with udev is probably that you miss a Xenomai group, and the
udev rules need one, if you want to run applications as an unprivileged
user as described here:

http://www.xenomai.org/index.php/Non-root_RT


-- 
                                                                Gilles.

