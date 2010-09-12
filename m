Message-ID: <b27850ecc2bdaf543a87d017cd0a195f.squirrel@domain.hid>
In-Reply-To: <4C8BE5E0.7050808@domain.hid>
References: <7301cc886b22b37fcbc8cda61c515d07.squirrel@domain.hid>
	<4C8BE5E0.7050808@domain.hid>
Date: Sat, 11 Sep 2010 21:49:27 -0500 (CDT)
From: "Travis Stratman" <tstratman@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] Bottom half task scheduling
Reply-To: tstratman@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


> You can use a kernel thread, created with rtdm_task_init:
> http://www.xenomai.org/documentation/xenomai-2.5/html/api/group__rtdmtask.html#g44b0701b6c28fa8035711f800fdcd371

Thanks Gilles. That's what I needed, I just couldn't find any verification
that this could be called from the interrupt handler.

TAS




