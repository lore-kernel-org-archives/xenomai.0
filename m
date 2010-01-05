Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <4B43BE72.6040101@domain.hid>
Date: Tue, 05 Jan 2010 23:34:26 +0100
From: Alexis Berlemont <berlemont.hauw@domain.hid>
MIME-Version: 1.0
References: <4bed572e0911221135s64fc4726x1cd7235f116e11a4@domain.hid>	
	<72cf3fb0911260134m36c1d5b0s9b24843b11610455@domain.hid>	
	<4bed572e0911261538m787ec9c9qf2a76d8e892f2d48@domain.hid>	
	<4B12FD90.30804@domain.hid>	
	<4bed572e0911300041k5bb51bf6nbe83b2a9233d76b0@domain.hid>	
	<4B16F674.5090200@domain.hid>	
	<4bed572e0912150741l37bea514t773c71f645fbeba5@domain.hid>	
	<4B28208B.7000305@domain.hid>	
	<4bed572e0912160458i32834958q9512476f1603979d@domain.hid>	
	<4B2BF4D9.6000503@domain.hid>
	<4bed572e1001051015l21e71e8eyaec207701c2e21ad@domain.hid>
In-Reply-To: <4bed572e1001051015l21e71e8eyaec207701c2e21ad@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Help on analogy_ni_pcimio (Alexis Berlemont?)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ettore Pedretti <epedrett@domain.hid>
Cc: xenomai@xenomai.org

Hi,

Ettore Pedretti wrote:
> Hi
> 
> I have installed Xenomai 2.5.0 and tried to attach the module:
> analogy_config analogy0 analogy_ni_pcimio
> 
> The error trace is attached as a text file
I do not see any analogy debug traces. In your kernel configuration,
have you configured the following options like this:
CONFIG_XENO_DRIVERS_ANALOGY_DEBUG=y
CONFIG_XENO_DRIVERS_ANALOGY_DEBUG_LEVEL=1
CONFIG_XENO_DRIVERS_ANALOGY_DRIVER_DEBUG_LEVEL=1

> Regards
> Ettore
> 
Alexis.

