Message-ID: <4B4D9AF5.2050005@domain.hid>
Date: Wed, 13 Jan 2010 11:05:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <725957.56219.qm@domain.hid>	<4303dd241001080943v2d279019s1164a5b2aa34790a@domain.hid>	<4303dd241001081002y8d7ef2fmcb7654d84dfd462f@domain.hid>	<4B477495.6010009@domain.hid>	<4303dd241001081127u217e916ax9c20352b7d7efe49@domain.hid>	<4B478825.9000006@domain.hid>	<4303dd241001081142q37797dcjb25fd9103f7e497e@domain.hid>	<4B478B6E.1050400@domain.hid>	<4303dd241001081354tc22e226j761564dea565ac89@domain.hid>	<4B47B0FE.8060000@domain.hid>
	<4303dd241001130050r1f5dad13xe12d4f9cb92d0e2c@domain.hid>
In-Reply-To: <4303dd241001130050r1f5dad13xe12d4f9cb92d0e2c@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Porting I-Pipe for new ARM board
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Flavio de Castro Alves Filho <flavio.alves@domain.hid>
Cc: xenomai@xenomai.org

Flavio de Castro Alves Filho wrote:
> Hello Gilles,
> 
> First of all, really thank you for you revision. It was really helpful.
> 
> And ... about the changes. I implemented the corrections as you
> suggested and it is still not working. It is blocking allways at the
> same place.
> 
> I'm still working to find out a solution.

Ok. Do you know if the error happens around a multiplexed interrupt?

If that was the case, please try to get __ipipe_irq_mux_p to return
always 0, and modify Linux demuxer to call __ipipe_handle_irq instead of
handle_irq when CONFIG_IPIPE is on.

-- 
					    Gilles.

