Message-ID: <46127166.9040503@domain.hid>
Date: Tue, 03 Apr 2007 17:23:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] large latencies on a Dell D620 dual core laptop
References: <20070403143122.4ac4ffaf@domain.hid>	<46124C61.3070107@domain.hid>	<20070403162752.2d4a1ae6@domain.hid>	<46126603.1050007@domain.hid>	<20070403170416.6c3f7ded@domain.hid>	<46126DC3.8070905@domain.hid>
	<20070403171828.2da9c6fa@domain.hid>
In-Reply-To: <20070403171828.2da9c6fa@domain.hid>
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
> On Tue, 03 Apr 2007 17:07:47 +0200
> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> 
> 
>>Setting the nucleus as a module should be enough to get everything as
>>module.
> 
> 
> it is compiled like that, the xeno_nucleus is a module, and anyway disabling
> XENO_HW_SMI_APMC prevents the kernel from booting for some unknown reason...
> 

If Xenomai module is not loaded at boot time, the option
CONFIG_XENO_HW_SMI_APMC has no effect.

-- 
                                                 Gilles Chanteperdrix

