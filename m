Message-ID: <4CD859C4.7040602@domain.hid>
Date: Mon, 08 Nov 2010 21:12:52 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1289211836.298721730@domain.hid>
In-Reply-To: <1289211836.298721730@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Supported cPCI systems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: edward.robbins@domain.hid
Cc: xenomai@xenomai.org

edward.robbins@domain.hid wrote:
> Hello,
> 
> since I have been unsuccessful getting Xenomai to work on our MEN
> F19P and F17 systems, I would like to hear from anyone who has had
> success with other cPCI based systems - preferably x86 with dual
> processor support, but failing that anything will do at this point.
> Thanks,

I lost track. Did you finally manage to add the PCI ID of your LPC
bridge to arch/x86/hal/smi.c in order to try the SMI workaround?

-- 
                                                                Gilles.

