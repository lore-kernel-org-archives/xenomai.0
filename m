From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4662C02D.4010307@domain.hid>
References: <4662C02D.4010307@domain.hid>
Content-Type: text/plain
Date: Sun, 03 Jun 2007 16:21:10 +0200
Message-Id: <1180880470.5013.8.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Kill nkpod?
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
Cc: xenomai-core <xenomai@xenomai.org>

On Sun, 2007-06-03 at 15:20 +0200, Jan Kiszka wrote:
> Hi Philippe,
> 
> if I got your latest refactoring correctly, there can now only be one
> kind of pod registered: nkpod_struct. In that case, wouldn't it be
> consequent to remove the nkpod indirection from Xenomai as well? There
> are quite a few occurrences, I know...

Yeah, but consistency is indeed worth the burden, I agree. Actually, I
somehow killed it in my local repo, where nkpod is now defined as
(&nkpod_struct), and a special init bit has been added to the pod flags
to represent the former nkpod == NULL case.

-- 
Philippe.



