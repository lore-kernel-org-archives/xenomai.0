Message-ID: <e325d110608040715v5c200f04l4632837bca7a15a4@domain.hid>
Date: Fri, 4 Aug 2006 15:15:59 +0100
From: "Kim Chuan Lim" <lim.kim.chuan@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] building xenomai integrated drivers
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi ya,

The following is my .config..

#
# Drivers
#
CONFIG_XENO_DRIVERS_16550A=y
CONFIG_XENO_DRIVERS_TIMERBENCH=y
CONFIG_XENO_DRIVERS_IRQBENCH=y
CONFIG_XENO_DRIVERS_SWITCHTEST=y


I try to look for xeno_16550A.ko in my computer but i cannot get it.
There is nothing such folder namely "xenomai "in my
/lib/modules/2.6.17-default/kernel/drivers/

May i know how could i build it manually?

Regards,
Kim Chuan.

