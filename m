Message-ID: <465EE3BC.7020905@domain.hid>
Date: Thu, 31 May 2007 17:03:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid>	<7289437c0705300051i2634264avc5f2db1fcdb91da8@domain.hid>	<465D664E.3040700@domain.hid>
	<465E8FA8.4030507@domain.hid>	<DD39B5C3F4963040ADC9768BE7E430CB01F54FE7@domain.hid>	<7289437c0705310558y6e1b4f8fue26c640d863ae041@domain.hid>	<465EC7C1.5080300@domain.hid>
	<465ECDEC.1030109@domain.hid>	<465ECFCA.1070801@domain.hid>
	<465ED806.2060608@domain.hid>
	<7289437c0705310758o3512e5e5x4c1a6d1df444be63@domain.hid>
In-Reply-To: <7289437c0705310758o3512e5e5x4c1a6d1df444be63@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] =?iso-8859-1?q?Xenomai_with_=B5Clibc?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Perrine Martignoni wrote:
>>Same program as you posted earlier?
> Yes. it's the same.
>  
>>Can you confirm the issue with this procedure? Also make sure that your
>>rebuild and re-installed the Xenomai user space part cleanly ("make
>>clean; make install").
>  
> I installed cleanly Xenomai.
>  
> I compiled too with :
> arm-linux-gcc `.../xeno-config --posix-cflags --posix-ldflags` -o
> essai_mutex_rt essai_mutex.c

try putting essai_mutex.c before the flags, as in:

arm-linux-gcc -o essai_mutex_rt essai_mutex.c `xeno-config
--posix-cflags --posix-ldflags`

-- 
                                                 Gilles Chanteperdrix

