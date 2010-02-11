Message-ID: <4B742D5A.10105@domain.hid>
Date: Thu, 11 Feb 2010 17:16:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1NfBdX-0001ga-4b@domain.hid>
	<4B72A7E2.5020001@domain.hid>	<4B72A9DA.1090104@domain.hid>
	<4B730A04.9040908@domain.hid> <4B731608.6010803@domain.hid>
	<4B73180C.6070301@domain.hid> <4B73207C.6020400@domain.hid>
	<4B73218A.9080306@domain.hid> <4B7323D5.1040804@domain.hid>
	<4B732487.50103@domain.hid> <4B732679.4030306@domain.hid>
	<4B73278F.9050603@domain.hid> <4B73C214.3010107@domain.hid>
	<4B73C421.1020200@domain.hid> <4B73CFD9.6010904@domain.hid>
	<4B73D202.5050004@domain.hid> <4B73DDC9.2020906@domain.hid>
	<4B73E421.3050708@domain.hid> <4B7410BB.5010809@domain.hid>
	<4B742963.5010301@domain.hid> <4B742CAC.8040202@domain.hid>
In-Reply-To: <4B742CAC.8040202@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : Make
 xnarch_init_timeconv an uninlined weak function
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> And instantly - you forget about dlopen scenarios which triggered the
>>> bug in timeconv.
>> I do not see why dlopen would trigger a bug. Could you explain it?
> 
> If you dlopen, say, libnative and call a symbol that uses some timeconv
> constants, you have to make sure that the init code of libnative
> initializes those variables that are later used.

That is where I do not follow you. dlopen is called after the startup of
the other libs, so either it references its own variables, which are
initialized once its constructor has been called. Or it references the
variables of the posix lib (only native and posix use timeconv in
user-space) which is already initialized.

-- 
					    Gilles.

