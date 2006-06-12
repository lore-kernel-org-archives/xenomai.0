MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17549.52124.344294.89351@domain.hid>
Date: Mon, 12 Jun 2006 22:16:28 +0200
Subject: Re: [Xenomai-help] Compaq nc6120 timer frequency
In-Reply-To: <20060612200701.54795.qmail@domain.hid>
References: <17549.35340.963162.868247@domain.hid>
	<20060612200701.54795.qmail@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Cedric Herreman <glocker50@domain.hid>
Cc: xenomai@xenomai.org

Cedric Herreman wrote:
 > I disabled CPU Frequency Scaling and recompiled kernel + modules, but the problem remains.
 >  

If it is not done, please also disable CONFIG_ACPI_PROCESSOR.

Do you observe the same behaviour with the latency test ? If yes, could
you send us your .config, if not, could you show us a minimal piece of
code which has a problem ?

-- 


					    Gilles Chanteperdrix.

