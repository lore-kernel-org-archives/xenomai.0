Message-ID: <4777839E.90401@domain.hid>
Date: Sun, 30 Dec 2007 12:40:14 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4776D46A.7080500@domain.hid>
In-Reply-To: <4776D46A.7080500@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] [PATCH 2/5] x86_64:inline root irq thunks
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

Jan Kiszka wrote:
> Align x86_64 with x86_32 by inlining the xirq and virq trampolines. This
> saves a few bytes of text and avoids holes in the function backtraces
> you see with the tracer.
> 

Ok, the same kind of changes from the last patch series badly broke the
kernel at boot time for both 32/64 archs, so this patch is held until
the needed time can be dedicated to test it extensively.

-- 
Philippe.



