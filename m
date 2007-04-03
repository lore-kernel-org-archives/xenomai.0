Message-ID: <46127DD8.8060502@domain.hid>
Date: Tue, 03 Apr 2007 18:16:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] large latencies on a Dell D620 dual core laptop
References: <20070403143122.4ac4ffaf@domain.hid>	<46124C61.3070107@domain.hid>	<20070403162752.2d4a1ae6@domain.hid>	<46126603.1050007@domain.hid>	<20070403170416.6c3f7ded@domain.hid>	<46126DC3.8070905@domain.hid>	<20070403171828.2da9c6fa@domain.hid>	<46127166.9040503@domain.hid>
	<20070403175535.7340cc06@domain.hid>
In-Reply-To: <20070403175535.7340cc06@domain.hid>
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
> On Tue, 03 Apr 2007 17:23:18 +0200
> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> 
> 
>>If Xenomai module is not loaded at boot time
> 
> 
> I removed the xeno_irqbench module from the config file, now no xeno modules
> are loaded at boot time and the system boots with SMI globally disabled
> (in fact xeno_irqbench was inserted at boot time  in
> the /etc/sysconfig/hwconfig file)
>  ... 
> and as soon as I modprobe xeno_native (before launching any test) the system
> hangs ...
> 

Maybe there is a way to disable legacy power management at BIOS level ?

-- 
                                                 Gilles Chanteperdrix

