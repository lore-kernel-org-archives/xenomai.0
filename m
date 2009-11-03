Message-ID: <4AF060ED.4090707@domain.hid>
Date: Tue, 03 Nov 2009 17:57:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <26207882.954331257266888498.JavaMail.defaultUser@domain.hid>
In-Reply-To: <26207882.954331257266888498.JavaMail.defaultUser@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] BUG: scheduling while atomic
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "cagnulein@domain.hid" <cagnulein@domain.hid>
Cc: xenomai@xenomai.org

cagnulein@domain.hid wrote:
> Hi, i've got a system running kernel 2.6.22 on a ARM9 / Freescale i.MX27
> The system running well, but every time i run latency it hangs.
> It occurs with rtprint too.
> Could you help me?

See:
https://mail.gna.org/public/xenomai-core/2009-08/msg00021.html

And you can not run latency with a 100us period on ARM.

-- 
                                          Gilles


