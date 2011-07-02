Message-ID: <4E0F7C03.20304@domain.hid>
Date: Sat, 02 Jul 2011 22:13:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201106301212.47433.carlosnov@domain.hid>	<4E0D7DE7.50803@domain.hid>
	<201107011423.18553.carlosnov@domain.hid>
In-Reply-To: <201107011423.18553.carlosnov@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Writing a new driver, Skin differences.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Carlos Eduardo de Brito Novaes <carlosnov@domain.hid>
Cc: xenomai@xenomai.org

On 07/01/2011 07:23 PM, Carlos Eduardo de Brito Novaes wrote:
> Hello,
> 
> I think I the question on using memory mapped are solved. Now I was wondering 
> and cant find a big difference over the four skins, at least for a new project 
> with no previous code written on the past. Is there any advantage in using the 
> rtdm skin over the navive one?

The RTDM is meant for writing drivers in kernel-space and continuity
will be ensured in Xenomai 3.x, whereas the other kernel-space skins
will no longer be available in Xenomai 3.x. Writing drivers in
kernel-space with either the native or the posix skin is deprecated.

-- 
                                                                Gilles.

