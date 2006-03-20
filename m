MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17438.44471.531201.154511@domain.hid>
Date: Mon, 20 Mar 2006 14:27:19 +0100
In-Reply-To: <441DD358.8010307@domain.hid>
References: <441DD358.8010307@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai-core] Re: 2.6.16-rc6 support
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
 > and a fix for a name collision in
 > posix/syscall.c (there are other mutex functions in the kernel now...).

Applied, thanks.

 > PS: Gilles, as a tiny cleanup, I would suggest converting all syscall
 > wrapper functions in posix/syscall.c into static ones. They are only
 > used in that file.

Done.

-- 


					    Gilles Chanteperdrix.

