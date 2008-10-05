Message-ID: <48E8E17B.3020601@domain.hid>
Date: Sun, 05 Oct 2008 17:47:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1KmEP8-0003wS-5y@domain.hid>
	<48E8AFB4.4040208@domain.hid>	<48E8B29D.5040705@domain.hid>
	<48E8B704.8030403@domain.hid> <48E8B91B.1060502@domain.hid>
	<48E8BF4A.2030409@domain.hid> <48E8C1BC.3050800@domain.hid>
	<48E8C270.4080208@domain.hid> <48E8C406.2040104@domain.hid>
In-Reply-To: <48E8C406.2040104@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-commits] r4210 - in /trunk:	ChangeLog
 src/skins/native/task.c
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

Jan Kiszka wrote:
> Well, both the current change as well as a potential signal-based prio
> update would be 2.5 material IMHO. So ABI breakage is not an issue. I
> wouldn't touch 2.4 unless there is a transparent fix feasible (which I
> doubt as well).

The current change does not break the ABIT, it just breaks already
broken applications...

-- 
					    Gilles.

