Message-ID: <49301EEB.70401@domain.hid>
Date: Fri, 28 Nov 2008 17:40:11 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20081127175234.163sujmgcgcgs4gk@domain.hid>	<492EF786.4040303@domain.hid>	<20081128181906.mnv2mvjgo44wgoc0@domain.hid>	<49301B0B.9010208@domain.hid>
	<20081128182944.qp8yhwpk6cw8cwss@domain.hid>
In-Reply-To: <20081128182944.qp8yhwpk6cw8cwss@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Zombie user tasks
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mehmet Alphan Ulusoy <alphan@domain.hid>
Cc: xenomai@xenomai.org

Mehmet Alphan Ulusoy wrote:
> ps aux says Task's state is "Zl+" and it's there for over 6 hours now,  
> is init's mentioned behavior standard or somewhat optional?

Could you try sysrq+T to see if the task cleanup could be blocked in a
xenomai cleanup handler ?


-- 
                                                 Gilles.

