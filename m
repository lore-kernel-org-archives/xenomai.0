Message-ID: <b647ffbd0706201404r256038b7sbb9318cdc1746b7c@domain.hid>
Date: Wed, 20 Jun 2007 23:04:50 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <46782305.4080501@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <46782305.4080501@domain.hid>
Subject: Re: [Xenomai-core] [RFC][PATCH] shirq locking rework
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

Hello Jan,

> Well, I hate nested locks when it comes to real-time, but in this case I
> really found no simpler approach. There is the risk of deadlocks via
>
> IRQ:            xnintr_shirq::lock -> handler -> nklock vs.
> Application:    nklock -> xnintr_attach/detach -> xnintr_shirq::lock,

it's also relevant for the current code - xnintr_attach/detach() must
not be called while holding the 'nklock'.

I think, your approach should work as well.. provided we have only a
single reader vs. a single writter contention case, which seems to be
the case here ('intrlock' is responsible for synchronization between
xnintr_attach/detach()).. your approach does increase a worst case
length of the lock(&intrlock) --> unlock(&intrlock) section... but
that's unlikely to be critical.

I think, the patch I sent before addresses a reported earlier case
with xnintr_edge_shirq_handler().. but your approach does make code
shorter (and likely simpler), right? I don't see any problems it would
possibly cause (maybe I'm missing smth yet :)


-- 
Best regards,
Dmitry Adamushko

