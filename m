Message-ID: <4B477495.6010009@domain.hid>
Date: Fri, 08 Jan 2010 19:08:21 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <725957.56219.qm@domain.hid>	<4303dd241001060338w7876debaxa9e290b89d79a143@domain.hid>	<4B4497BE.7040605@domain.hid>	<4303dd241001061116q40315012v3b0459c3b245efa@domain.hid>	<4B44E349.1000305@domain.hid>	<4303dd241001080611t6ab0dafch785bcf967572e69a@domain.hid>	<4B4742B7.5010306@domain.hid>	<4303dd241001080658q224a43feqafa77aedd694b41c@domain.hid>	<4B4750E1.20703@domain.hid>	<4303dd241001080943v2d279019s1164a5b2aa34790a@domain.hid>
	<4303dd241001081002y8d7ef2fmcb7654d84dfd462f@domain.hid>
In-Reply-To: <4303dd241001081002y8d7ef2fmcb7654d84dfd462f@domain.hid>
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
> Another interesting information: when I remove the Xenomai from the
> compilation options, and still letting the i-pipe compilation, the boot
> starts correctly.
> 
> Is it correct?

It means that there is something wrong when Xenomai takes over the timer
management. And thinking more about it, the problem you have is probably
the one described in tips and tricks number 4.

http://www.xenomai.org/index.php/I-pipe:ArmPorting#Tips_and_tricks.

-- 
					    Gilles.

