Message-ID: <47777383.7080006@domain.hid>
Date: Sun, 30 Dec 2007 11:31:31 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4776D45C.80207@domain.hid>
In-Reply-To: <4776D45C.80207@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] [PATCH 1/5] x86: optimize access to
	__ipipe_tick_regs
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
> By intention, the compiler is not able to fold succeeding accesses to
> via __raw_get_cpu_var & friends into a single one. As we are in an
> atomic section in __ipipe_handle_irq, let's help him with a temporary
> variable, saving some text size in this hotpath.
>

Will merge, thanks.

-- 
Philippe.


