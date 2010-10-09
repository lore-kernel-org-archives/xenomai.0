Message-ID: <4CB06FB8.4020106@domain.hid>
Date: Sat, 09 Oct 2010 15:35:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4CB06CE9.9090204@domain.hid> <4CB06E2F.7070209@domain.hid>
	<4CB06E7F.7070402@domain.hid>
In-Reply-To: <4CB06E7F.7070402@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [forge] irqbench removal
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
> Am 09.10.2010 15:29, Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Philippe,
>>>
>>> irqbench does not inherently depend on a third I-pipe domain.
>> Yes, but it inherently depends on x86 too.
> 
> Not by design, just by missing contributions to add a few more I/O bindings.

Currently it does not compile on anything else than x86. Denx has a
"gpioirqbench":
http://git.denx.de/?p=gpioirqbench.git;a=summary

Maybe it is time to find some common ground and have atlast a bench
which can run an all architectures ?

-- 
                                                                Gilles.

