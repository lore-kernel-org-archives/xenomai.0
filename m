Message-ID: <4741B106.2070709@domain.hid>
Date: Mon, 19 Nov 2007 16:51:34 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4b7912400711172140p3e5e04feiacd53b66669942bb@domain.hid>
	<4b7912400711172205s2c086e8dp4f228fdf70f0cd1d@domain.hid>
In-Reply-To: <4b7912400711172205s2c086e8dp4f228fdf70f0cd1d@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] problem of xeno_hal
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: zhangwei zhang <linda.zhangwei@domain.hid>
Cc: xenomai@xenomai.org

zhangwei zhang wrote:
> Hello, I have some problem of instalingl xenomai on ppc. I use the
> linux-2.6.19 and xenomai-2.3.4, I want to get the xeno_hal.ko for emc
> porting. But it seems that it can be only compiled in to the
> kernel,not as module. What can I do to implement it?

Do you happen to confuse the EMC HAL with that hal, Xenomai provides?
Both target different purposes and abstraction levels.

Maybe Paul can comment on the requirements of an EMC2(?) port over
Xenomai as he already worked in this domain.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

