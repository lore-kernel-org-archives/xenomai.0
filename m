Message-ID: <45AD4144.1060006@domain.hid>
Date: Tue, 16 Jan 2007 15:19:00 -0600
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xeno_16550A and 8250.nr_uarts=0
References: <45A68383.3070203@domain.hid>
	<45A6CB80.9060306@domain.hid>	<45A802CD.8010606@domain.hid>
	<45AA3D26.2040409@domain.hid> <45AB8CC0.8020008@domain.hid>
In-Reply-To: <45AB8CC0.8020008@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Jan Kiszka wrote:
> Here is an untested variant of your patch, implementing my ideas. I
> currently don't have my hands on any hardware that is able to stress the
> code appropriately, and you have the ultimate test case anyway. So
> please let me know if it works for you. Note: You /should/ be able to
> leave the irq parameter open with this approach.

I applied the v2 patch and recompiled the kernel with xeno_16550A built in.  Everything seems to work fine for me with and without the irq parameter specified.

Thanks,

Jeff

