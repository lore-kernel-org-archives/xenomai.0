Message-ID: <4C4D9171.5000202@domain.hid>
Date: Mon, 26 Jul 2010 15:45:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTilWSsSuCKRxQg0NIkeeR28eqpdJfaVm_CiemnqF@mail.gmail.com>	<4C46D49F.6030102@domain.hid>	<AANLkTikJgzkkxQyM8DQqVz17ovJmPiIkdZMIFJImExIE@mail.gmail.com>	<4C46F0D9.4030906@domain.hid>	<AANLkTilP98GMfCx1rcgWto9eBmnDwtuavBteD8inFM6V@mail.gmail.com>	<4C47F932.3060400@domain.hid>	<AANLkTilP1f217jN3krm_Cdqu4LaYwpUMu6mMnLiUJq2f@domain.hid>	<4C4823DC.4050500@domain.hid>	<AANLkTi=GuZADaU-CedYiqBU1Bj_Li+EAQ_7ZJKXA_qRR@mail.gmail.com>	<4C4D7B8E.4000309@domain.hid>
	<AANLkTim4ZHVhPbzwX5skDWujFcA2d8ceUgUoEvs_R5S1@domain.hid>
In-Reply-To: <AANLkTim4ZHVhPbzwX5skDWujFcA2d8ceUgUoEvs_R5S1@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Unexpected preemption of highest priority thread
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stephen Bryant <sbxenomai@domain.hid>
Cc: xenomai@xenomai.org

Stephen Bryant wrote:
> Do you mean enabling / disabling the individual options in the SMI
> Workaround section of the kernel config file, or are you suggesting
> something lower level / something else?

The options in the SMI workaround section of the kernel config file
actually disable some bits in some SMI registers, so they are already
low level. Anyway, yes, it is what I ask you to do.


-- 
					    Gilles.

