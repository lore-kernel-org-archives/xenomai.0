Message-ID: <4777770F.8060403@domain.hid>
Date: Sun, 30 Dec 2007 11:46:39 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4776D47C.5090005@domain.hid>
In-Reply-To: <4776D47C.5090005@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] [PATCH 3/5] avoid naming conflict around
	__ipipe_irq_handler
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
> There is already a definition of __ipipe_irq_handler. So, we either need
> to more the real ipipe_irq_handler_t into ipipe_base.h, or rename this
> local variant to __ipipe_irq_handler_t, or simple drop this refactoring.
> This patch starts with applying the latter - the easiest one :->
> 

There is no naming conflict, since they describe the same type with
different even if close names on purpose. __ipipe_irq_handler is only a
local short-hand to reduce visual pollution; as a matter of fact, the
assembly code itself depends on the handler prototype, despite it cannot
rely on any C-defined type, so the problem - if any - starts even before
this local definition, and if you happen to change ipipe_irq_handler_t,
then you could just not miss fixing __ipipe_irq_handler in the same move.

The only sane way to avoid defining this short-hand is indeed to move
ipipe_irq_handler_t to linux/ipipe_base.h.

-- 
Philippe.


