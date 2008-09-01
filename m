Message-ID: <48BBBD6F.2030308@domain.hid>
Date: Mon, 01 Sep 2008 12:01:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48BBA9E6.5070400@domain.hid> <48BBB213.1090502@domain.hid>
In-Reply-To: <48BBB213.1090502@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC][PATCH 7/9] Switch POSIX mutexes
	to	XNSYNCH_FWDROB
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
> Switch POSIX over to XNSYNCH_FWDROB, demonstrating the use of this flag
> (and aligning the implementation for following native version). This can
> save the syscall so far required on releasing a stolen mutex.

Nak.

-- 
                                                 Gilles.

