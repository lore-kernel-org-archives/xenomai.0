Message-ID: <4582E6DA.8050309@domain.hid>
Date: Fri, 15 Dec 2006 19:18:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] user space interrupt
References: <162080.20532.qm@domain.hid>
In-Reply-To: <162080.20532.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: mani bhatti <imranbashirbhatti@domain.hid>
Cc: xenomai@xenomai.org

mani bhatti wrote:
> Thanks a lot
> The error with "iopl" is fixed after i have acquired the root right but
> now problem is that
> rt_intr_create(&intr_desc,"MyIrq",IRQ_NUMBER,I_NOAUTOENA);
> 
> returns -22 which i dont understand  what it means.my code is extremely
> simple  .i have attached the code also please guide me how can i solve
> this problem.thanks again.

-22 is -EINVAL. It is not documented, but if you look at the code, you
will see that it may happen if the mode is invalid. I_NOAUTOENA should
be a valid mode, so I have no idea of what may be wrong.

-- 
                                                 Gilles Chanteperdrix

