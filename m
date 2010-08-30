Message-ID: <4C7BD3B5.1010904@domain.hid>
Date: Mon, 30 Aug 2010 17:52:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C7783C9.5090501@domain.hid> <4C7788A5.2020307@domain.hid>	
	<4C77B054.8080609@domain.hid> <4C77B208.5090802@domain.hid>	
	<4C77F142.4030103@domain.hid> <4C77F5EF.3010701@domain.hid>	
	<4C77F65E.5000208@domain.hid> <4C77FB05.4090301@domain.hid>	
	<4C77FD89.5040100@domain.hid> <4C77FF51.4000801@domain.hid>	
	<1283013623.1709.226.camel@domain.hid>	
	<4C7B70F9.1090903@domain.hid>
	<1283181064.1709.1827.camel@domain.hid>
In-Reply-To: <1283181064.1709.1827.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] False positive XENO_BUGON(NUCLEUS,
 need_resched == 0)?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Ok, Gilles did not grumble at you, so I'm daring the following patch,
> since I agree with you here. Totally untested, not even compiled, just
> for the fun of getting lockups and/or threads in limbos. Nah, just
> kidding, your shiny SMP box should be bricked even before that:

We wrote that code many years ago. I have no idea what we had in mind. I
guess we wanted the resched bit never to be set from a distant cpu. The
debug check had been disabled the whole time since we introduced
XENO_DEBUG, and started working again only recently.

Anyway, I have nothing against a bit of cleanup.

-- 
					    Gilles.

