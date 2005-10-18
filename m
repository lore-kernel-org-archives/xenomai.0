From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17236.44759.217634.762329@domain.hid>
Date: Tue, 18 Oct 2005 10:14:15 +0200
Subject: Re: [Xenomai-help] compiling xenomai on x86_64
In-Reply-To: <4354AD5A.7010305@domain.hid>
References: <4353F109.7000707@domain.hid>
	<4353F411.4000500@domain.hid>
	<4353F896.1040508@domain.hid>
	<435402B4.5060004@domain.hid> <435403C8.80400@domain.hid>
	<43540531.8050304@domain.hid>
	<435406E0.8020405@domain.hid> <435408E5.8020007@domain.hid>
	<435419B0.8030004@domain.hid>
	<4354AD5A.7010305@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > Jan Kiszka wrote:
 > I just analysed this further: the problem disappears when I manually
 > remove any "-I<path-to-kernel-includes>" from the makefiles. Seems to be
 > the well-known user space include issue again... ;)

This is wrong, the include files that should be used are those from the
Adeos/I-pipe patched 2.6 kernel you are compiling for, not those which
come from your distribution.

-- 


					    Gilles Chanteperdrix.

