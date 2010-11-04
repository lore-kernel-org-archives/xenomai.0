Message-ID: <4CD27A36.1020303@domain.hid>
Date: Thu, 04 Nov 2010 10:17:42 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4CC82C8D.3080808@domain.hid>	<4CC92902.4040904@domain.hid>	<4CC943A2.9020806@domain.hid>	<4CC94E0B.9070106@domain.hid>	<4CCEF104.7050409@domain.hid>	<4CD11AB1.8090407@domain.hid>	<4CD13A70.8040702@domain.hid>	<4CD14B1E.4000707@domain.hid>	<4CD14C92.90901@domain.hid>	<4CD14DBC.3060505@domain.hid>	<4CD1509A.3000908@domain.hid>	<4CD152F3.4080203@domain.hid>	<4CD16654.6080704@domain.hid>	<4CD18782.7090607@domain.hid>	<4CD191EE.7000604@domain.hid>	<4CD1936E.50203@domain.hid>	<4CD1BA29.9000303@domain.hid>	<1288816871.1842.84.camel@domain.hid>
	<4CD1DC1B.8060407@domain.hid>	<4CD1DE12.5010309@domain.hid>
	<4CD1E890.5010702@domain.hid> <4CD1EC2F.4040603@domain.hid>
	<4CD1ED16.8030103@domain.hid> <4CD1EDA8.10007@domain.hid>
	<4CD1F33C.5070208@domain.hid> <4CD1F3F5.5080505@domain.hid>
	<4CD1F4FE.9020908@domain.hid> <4CD1F69B.9070100@domain.hid>
	<4CD1F906.1070703@domain.hid> <4CD1FABD.1080301@domain.hid>
	<4CD2612C.2070507@domain.hid> <4CD272A1.70105@domain.hid>
In-Reply-To: <4CD272A1.70105@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Potential problem with rt_eepro100
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Anders Blomdell wrote:
> Probably being daft here; why not stop fiddling with remote CPU status 
> bits and always do a reschedule on IPI irq's?

That is what we had been doing for a long time, and stopped between
2.5.4 and 2.5.5, and this is what I say: maybe this was not such a good
idea.

-- 
                                                                Gilles.

