Message-ID: <4D5D4AFF.8080808@domain.hid>
Date: Thu, 17 Feb 2011 17:21:19 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <426689.33631.qm@domain.hid>
In-Reply-To: <426689.33631.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Kernel or Module
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Franz Engel <franz_lambert_engel@domain.hid>
Cc: xenomai@xenomai.org

Franz Engel wrote:
> Hi,
> 
> Does it make any difference if I build the linux kernel with the
> posix skin inside or as a module. Currently I build all
> Realtime-Options in the kernel. So I load no modules and with lsmod
> there are no xeno* modules? Is it correct?

>From a performance point of view, there may be a very little advantage
for in-kernel builds over module builds, on very low end machines. The
major difference is that you do not have to insmod anything before
launching your application. I do not see other differences, in fact. The
module build appears to me mostly as a legacy thing, because in the
past, Xenomai was built outside the kernel tree, and could only be build
as module.

-- 
					    Gilles.

