Message-ID: <4B7FBBB8.1010806@domain.hid>
Date: Sat, 20 Feb 2010 11:38:48 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <181804936ABC2349BE503168465576460DD4DE8B@exchserver.basler.com>
	<181804936ABC2349BE503168465576460DDA2F4F@exchserver.basler.com>
	<181804936ABC2349BE503168465576460DE4CCFC@exchserver.basler.com>
In-Reply-To: <181804936ABC2349BE503168465576460DE4CCFC@exchserver.basler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Supported I-pipe versions?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Deiters <SteveDeiters@domain.hid>
Cc: xenomai@xenomai.org

Steve Deiters wrote:
> Sorry to keep bringing this up, but does anybody know if there are
> compatibility issues with Xenomai 2.5.1, PowerPC Linux 2.6.24.6, and the
> following adeos patch:
> http://download.gna.org/adeos/patches/v2.6/powerpc/older/adeos-ipipe-2.6
> .24.6-powerpc-DENX-2.4-03.patch?

2.6.24 has a bug which has only be fixed with recent patches. So, even
if you use it with an older Xenomai version, and it seems to work, in
fact it does not.

-- 
					    Gilles.

