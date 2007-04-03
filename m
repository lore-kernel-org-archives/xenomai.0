Message-ID: <46126DC3.8070905@domain.hid>
Date: Tue, 03 Apr 2007 17:07:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] large latencies on a Dell D620 dual core laptop
References: <20070403143122.4ac4ffaf@domain.hid>	<46124C61.3070107@domain.hid>	<20070403162752.2d4a1ae6@domain.hid>	<46126603.1050007@domain.hid>
	<20070403170416.6c3f7ded@domain.hid>
In-Reply-To: <20070403170416.6c3f7ded@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Daniel Simon <Daniel.Simon@domain.hid>
Cc: xenomai@xenomai.org

Daniel Simon wrote:
> On Tue, 03 Apr 2007 16:34:43 +0200
> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> 
> 
>>If you compile Xenomai as a module, then Xenomai will not be started at
>>boot time. And later, when loading Xenomai modules, even if
>>CONFIG_XENO_HW_SMI_APMC is disabled, since the system has booted,
>>starting Xenomai should not prevent the system from booting.
> 
> 
> I can compile Xenomai_nucleus as a module (which is already done), but I  it
> seems that CONFIG_XENOMAI must be set to y or n, "m" is not allowed
> (or is there a way to bypass the config script?) 

Setting the nucleus as a module should be enough to get everything as
module.

-- 
                                                 Gilles Chanteperdrix

