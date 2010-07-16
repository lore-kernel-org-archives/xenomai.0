Resent-To: Xenomai help <xenomai@xenomai.org>
Resent-Message-Id: <4C400E47.1000306@domain.hid>
Message-ID: <4C40015E.3030805@domain.hid>
Date: Fri, 16 Jul 2010 08:51:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinwyQgI26INSzLlvgyP2hlAmuziK7V3iNCVa8Nd@domain.hid>	<4C3EFB0B.7050801@domain.hid>	<AANLkTinH0vj7gAxa8LscV_-Hvmggo9LigQkp30nIUcz6@domain.hid>	<4C3F192A.8080203@domain.hid>	<AANLkTinJaCoe5nfcUuC25_0eOLJid1hk582uFdzRZT1_@domain.hid>
	<4C3F471F.4030002@domain.hid>
In-Reply-To: <4C3F471F.4030002@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [RTnet-users] Alignment problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Cyril Wallois <walloiscyril@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Cyril Wallois wrote:
>> I try show_stack(NULL,NULL)  after the Xenomai error message, but I have
>> a lock up (the Xenomai code is not printing).
> 
> Ok. Try adding a call to xnarch_trace_panic_freeze() before the call to
> show_stack.

Sorry, I meant rthal_emergency_console()

-- 
					    Gilles.


