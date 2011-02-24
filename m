Message-ID: <4D665105.8040107@domain.hid>
Date: Thu, 24 Feb 2011 13:37:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <274381298405447@domain.hid> <4D641ADF.1070802@domain.hid>
	<437861298457092@domain.hid> <4D64E2A4.7080105@domain.hid>
	<661661298458316@domain.hid> <4D64E810.4040005@domain.hid>
	<549401298459119@domain.hid> <4D64F94E.5040407@domain.hid>
	<41131298550043@domain.hid>
In-Reply-To: <41131298550043@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Interrupt handling problem on Compulab EM-X270.
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Nazarov Sergey <s-nazarov@domain.hid>
Cc: Adeos <adeos-main@gna.org>

Nazarov Sergey wrote:
> Test:
> non-RT load: dd if=/dev/zero of=/dev/null + ping flud from another host,
> RT-load: 3 latency tests (user, kernel and timer task) + switchtest,
> worked for 1 hour without visible problems (0% of ping packets lost).
>    Sergey.

Ok. The problem is that on some machines, we get a lockup when using the
edge handler, because the edge handler does not mask the interrupt line,
and so the interrupt triggers again. I guess this must happens with
devices having a level semantic.

But anyway, I prefer some non real-time interrupts lost, than a complete
lockup, so, the code will stay the way it is, I suggest you modify the
board/driver code to change the flow handler of only the line you use.
This change could be integrated into the I-pipe patch.

-- 
                                                                Gilles.

