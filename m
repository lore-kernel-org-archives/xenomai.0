Message-ID: <4614E886.1070508@domain.hid>
Date: Thu, 05 Apr 2007 14:16:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] large latencies on a Dell D620 dual core laptop
References: <20070403143122.4ac4ffaf@domain.hid>	<46124C61.3070107@domain.hid>	<20070403162752.2d4a1ae6@domain.hid>	<46126603.1050007@domain.hid>	<20070403170416.6c3f7ded@domain.hid>	<46126DC3.8070905@domain.hid>	<20070403171828.2da9c6fa@domain.hid>	<46127166.9040503@domain.hid>	<20070403175535.7340cc06@domain.hid>	<46127DD8.8060502@domain.hid>	<20070404181558.0ba333da@domain.hid>	<4613D7CC.2040703@domain.hid>	<20070405092815.15bd1af1@domain.hid>	<20070405101200.10084177@domain.hid>	<4614BA29.3010609@domain.hid>	<20070405113420.0d2cc0ae@domain.hid>	<1175766886.7594.12.camel@domain.hid>
	<20070405121249.0b2a3861@domain.hid>
In-Reply-To: <20070405121249.0b2a3861@domain.hid>
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
> On Thu, 05 Apr 2007 11:54:45 +0200
> Philippe Gerum <rpm@xenomai.org> wrote:
> 
> 
>>With your current kernel configuration, try preventing the yenta module
>>from being loaded.
> 
> 
> how can I do that without recompiling the kernel? I cannot unload it 
> (ERROR: Module yenta_socket is in use)
> 
> no more time today for testing, I'll try your suggestions to morrow...
> 
> 	Daniel
> 

The yenta module is for PCMCIA, you probably have a user-space daemon
using it. Try something like /etc/init.d/pcmcia stop

-- 
                                                 Gilles Chanteperdrix

