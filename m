Message-ID: <488EF504.7010802@domain.hid>
Date: Tue, 29 Jul 2008 12:46:28 +0200
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <2b490f270807240731u1ec67bc5y9d456c7e801f1c98@domain.hid>	
	<48889483.4070009@domain.hid>
	<2b490f270807290207i567e1037r4623e89f2d6a1d4e@domain.hid>
In-Reply-To: <2b490f270807290207i567e1037r4623e89f2d6a1d4e@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai: native skin or
 CONFIG_XENO_OPT_PERVASIVE disabled.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dehann Fourie <dehann.fourie@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Dehann Fourie wrote:
> Thanks for the reply. I'm not sure if you mean excluded in the kernel
> configuration?
> I did add these options in the kernel, however I suspect that the machine
> I'm using
> does not have APIC support...
> 
> dmesg | grep apic - returns APIC disabled or absent.

Please send us your kernel config. Which architecture and CPU do you have?

> 
> I know there is a way to emulate the APIC timer events? Can anyone help me
> pls?

If you want anyone other than me to answer then don't drop the mailing 
list from CC in the future ...

-- 
Sebastian

