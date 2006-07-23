Message-ID: <44C3BEB5.2070001@domain.hid>
Date: Sun, 23 Jul 2006 20:23:49 +0200
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai v2.2
References: <1153227929.5029.25.camel@domain.hid>	<44BE8ECF.2050608@domain.hid>	<44BE943E.80302@domain.hid>	<44BEA974.40708@domain.hid>
	<44BFC5FA.6080608@domain.hid> <44BFFC62.8030601@domain.hid>
	<44C21AF8.3000906@domain.hid> <44C25DA7.6020302@domain.hid>
	<44C287C4.30209@domain.hid> <44C3AEB9.5070905@domain.hid>
In-Reply-To: <44C3AEB9.5070905@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Ciao Jan!

Jan Kiszka wrote:
[...]
> Please try "make clean" before rebuilding your 2.4 kernel with a

Indeed, make clean does a wonder :-)
BTW, is there any way to reconfigure the periodic timer ?
Not that I wanna use it - I'm fine with the more accurate aperiodic
timer, but just curious.

> This digging in 2.4 over x86 was "worthwhile": Two further corner-case
> bugs found, though not all fixed yet.

First, I'm sorry that I didn't consider make clean, but then this
issue led to find two previously unknown bugs.
 From your last email to the list I guess the TSC thingie is one,
what is the other one ? Anything serious ?

Thanks a lot,
Hannes.

