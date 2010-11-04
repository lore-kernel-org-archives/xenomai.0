Message-ID: <4CD32EF1.7000202@domain.hid>
Date: Thu, 04 Nov 2010 23:08:49 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4CC82C8D.3080808@domain.hid>	<4CD14C92.90901@domain.hid>	<4CD14DBC.3060505@domain.hid>	<4CD1509A.3000908@domain.hid>	<4CD152F3.4080203@domain.hid>	<4CD16654.6080704@domain.hid>	<4CD18782.7090607@domain.hid>	<4CD191EE.7000604@domain.hid>	<4CD1936E.50203@domain.hid>	<4CD1BA29.9000303@domain.hid>	<1288816871.1842.84.camel@domain.hid>
	<4CD1DC1B.8060407@domain.hid>	<4CD1DE12.5010309@domain.hid>
	<4CD1E890.5010702@domain.hid> <4CD1EC2F.4040603@domain.hid>
	<4CD1ED16.8030103@domain.hid> <4CD1EDA8.10007@domain.hid>
	<4CD1F33C.5070208@domain.hid> <4CD1F3F5.5080505@domain.hid>
	<4CD1F4FE.9020908@domain.hid> <4CD1F69B.9070100@domain.hid>
	<4CD1F906.1070703@domain.hid> <4CD1FABD.1080301@domain.hid>
	<4CD2612C.2070507@domain.hid> <4CD279F7.7070502@domain.hid>
	<4CD27C46.8010302@domain.hid> <4CD27DC2.7060607@domain.hid>
	<4CD2A96B.3080001@domain.hid> <4CD2B2A7.9010900@domain.hid>
	<4CD2C50F.1090604@domain.hid> <4CD2C8E2.9090608@domain.hid>
	<4CD2D25D.6000604@domain.hid>
In-Reply-To: <4CD2D25D.6000604@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Jan Kiszka wrote:
> rework. Safer for now is likely to revert 56ff4329ff, keeping nucleus
> debugging off.

That is not enough. This commit was followed by several others to "fix
the fix". You know how things are, someone proposes a fix, which fixes
things for him, but it breaks in the other people configurations (one of
the fallouts was a complete revamp of include/asm-arm/atomic.h for
instance).

-- 
                                                                Gilles.

