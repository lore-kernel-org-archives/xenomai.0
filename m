Message-ID: <475C13C6.8080508@domain.hid>
Date: Sun, 09 Dec 2007 17:11:50 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <b054e88e0711290957v17aac9b1vf30cd76c171bc1ac@domain.hid>
In-Reply-To: <b054e88e0711290957v17aac9b1vf30cd76c171bc1ac@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] BUG while modprobing nucleus - no SMI workaround
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Giammarco Zacheo <g.zacheo@domain.hid>
Cc: xenomai@xenomai.org

Giammarco Zacheo wrote:
> Just installed kernel 2.6.23.9 with Xenomai 2.4-rc7 on my quad-core
> machine, and I got this on the console:
> 
...
> 
> I-pipe: Domain Xenomai registered.
> Xenomai: hal/x86_64 started.
> Xenomai: real-time nucleus v2.4-rc7 (Bells Of Lal) loaded.
> Xenomai: SMI-enabled chipset found
> Xenomai: SMI workaround failed!

And that's a different story, likely. Can you post your lspci -nn?

Jan


