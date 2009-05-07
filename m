Message-ID: <4A02A38C.4040203@domain.hid>
Date: Thu, 07 May 2009 11:02:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OFAD630900.6B7052D5-ONC12575AF.003134DD-C12575AF.003171E4@domain.hid>
In-Reply-To: <OFAD630900.6B7052D5-ONC12575AF.003134DD-C12575AF.003171E4@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] gatekeeper/0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: henning.richter@domain.hid
Cc: xenomai@xenomai.org

henning.richter@domain.hid wrote:
> Outputs of the switchtest:
> 
> == FPU check routines: OK!.
> switchtest: Unabale to open switchtest device.
> (modprobe xeno_switchtest ? )
> 
> modeprobe xeno_switchtest leads to FATAL: Module xeno_switchtest not found.

I do not see anything in this message related to the number of CPUs in
your system. You should simply enable the switchtest module in Xenomai
configuration (in the kernel configuration menus).

-- 
                                                 Gilles.

