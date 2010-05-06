Message-ID: <4BE27AA7.2070302@domain.hid>
Date: Thu, 06 May 2010 10:15:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <o2hcfed72901005060052o40bcc542gf42d45e3488c43f1@domain.hid>
In-Reply-To: <o2hcfed72901005060052o40bcc542gf42d45e3488c43f1@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Problem getting the time with a kernel patched
 with	xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Divi Oillo <divi.oillo@domain.hid>
Cc: xenomai@xenomai.org

Divi Oillo wrote:
> Hi, I post this message because I need a little help.

Hi,

> (...)
>                 gettimeofday(&timestamp_sav,NULL);
>                 nanosleep(&req,&req);
>                 gettimeofday(&timestamp,NULL);
> (...)

Note that your application does not benefit from any improvements made
by Xenomai, it is using Linux services.


> Why do I have +10010 =C2=B5s or +10011 =C2=B5s between each dating with=
 my xenomai
> kernel and approximately +300 =C2=B5s with my non-patched kernel?
> Thanks.

To obtain such results, you are probably running your test on an idle
system. But anyway, the problem is probably that the vanilla
configuration probably has high resolutions timers running, whereas the
Xenomai patched kernel has not.

Whether high resolution timers are enabled is both a question of
kernel-configuration (CONFIG_HIGHRES_TIMERS, CONFIG_X86_LOCAL_APIC,
CONFIG_HPET have an influence), and a question of run-time decisions.
You should find some hints in the kernel messages.

Regards.

--=20
					    Gilles.


