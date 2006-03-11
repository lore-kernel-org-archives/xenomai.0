Message-ID: <4412B8CE.5080609@domain.hid>
Date: Sat, 11 Mar 2006 12:47:26 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <b647ffbd0603110244y64ff4495t@domain.hid>
In-Reply-To: <b647ffbd0603110244y64ff4495t@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [PATCH] shirq correction
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Dmitry Adamushko wrote:
> 
> Hello,
> 
> I overlooked that the logic of decrementing the interrupt nesting count 
> has been changed recently and
> both xnintr_shirq_handler() and xnintr_edge_shirq_handler() behave wrong 
> in this respect.
> 
> The attached patch fixes this misbehavior.
> 

Applied, thanks.

> -- 
> Best regards,
> Dmitry Adamushko
> 


-- 

Philippe.

