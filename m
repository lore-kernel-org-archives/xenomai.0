From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44D74EC4.3010806@domain.hid>
References: <44CF6EB1.1010808@domain.hid> <44D36389.3030706@domain.hid>
	<44D4A0E4.5070703@domain.hid> <44D4CAE9.9000800@domain.hid>
	<44D4E38D.9060007@domain.hid> <44D4FF53.8000904@domain.hid>
	<44D74B93.9070905@domain.hid>  <44D74EC4.3010806@domain.hid>
Content-Type: text/plain
Date: Mon, 07 Aug 2006 17:43:13 +0200
Message-Id: <1154965394.4322.38.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Xenomai-help] [ANNOUNCE] RTDM driver for CAN
	devices
Reply-To: rpm@xenomai.org
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

On Mon, 2006-08-07 at 16:31 +0200, Jan Kiszka wrote:
> > 
> > I just realized another issue. Where to put README and CREDITS file? The
> > README should go into doc/txt/can-driver.txt. Should I add the credits
> > to this file as well?
> 
> I would maintain that file under drivers/can. Who knows if it doesn't
> grow noticeably over the time...

Yes, thinking a bit more about this, this would be even better than
maintaining it in the doc section, so that the CAN driver could be
easily extracted from the Xenomai stack without having to chase each and
every bit of documentation throughout the tree.

-- 
Philippe.



