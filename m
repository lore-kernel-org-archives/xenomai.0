Message-ID: <48ABE013.8020306@domain.hid>
Date: Wed, 20 Aug 2008 11:12:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48AB4256.6050200@domain.hid> <48ABDD08.8060707@domain.hid>
In-Reply-To: <48ABDD08.8060707@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Clean up XNWAKEN / wwake tracking
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-core@domain.hid

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> +	/* We are awake, no one must steal our lock anymore. */
>> +	thread->wwake = NULL;
>> +
> 
> This is wrong, whether or not no one must steal our lock anymore will be
> decided at the "redo" label, when we "test and set", the synch owner.
> 

Ok. This was not the latest patch, sorry for the noise.

-- 
                                                 Gilles.

