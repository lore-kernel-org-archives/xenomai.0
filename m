Message-ID: <45411147.1070205@domain.hid>
Date: Thu, 26 Oct 2006 14:49:27 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] switchtest and Xenomai 2.2.4
References: <1160947939.4962.27.camel@domain.hid> <453FC4C0.5070105@domain.hid>
	<454078AD.5000907@domain.hid> <4540DE60.40209@domain.hid>
	<4540E1AB.2040200@domain.hid> <4540EABD.10403@domain.hid>
	<4540ECA6.5000604@domain.hid>
In-Reply-To: <4540ECA6.5000604@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Xenomai help <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> In the file ksrc/drivers/testing/switchtest.c, try commenting the calls
> to try_module_get and module_put. You will need to recompile kernel
> space support. I am afraid the module counter is decreased several times 
> when close is called several times, so we basically screw it up.
> 
> The attached patch also closes the file descriptors only once the 
> threads are joined.

It looks like this did the trick.  After commenting out the try_module_get/module_put calls and applying your latest patch to switchtest.c, switchtest appears to be working properly once again.

Thanks,

Jeff

