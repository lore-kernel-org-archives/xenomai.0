Message-ID: <4614BA29.3010609@domain.hid>
Date: Thu, 05 Apr 2007 10:58:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] large latencies on a Dell D620 dual core laptop
References: <20070403143122.4ac4ffaf@domain.hid>	<46124C61.3070107@domain.hid>	<20070403162752.2d4a1ae6@domain.hid>	<46126603.1050007@domain.hid>	<20070403170416.6c3f7ded@domain.hid>	<46126DC3.8070905@domain.hid>	<20070403171828.2da9c6fa@domain.hid>	<46127166.9040503@domain.hid>	<20070403175535.7340cc06@domain.hid>	<46127DD8.8060502@domain.hid>	<20070404181558.0ba333da@domain.hid>	<4613D7CC.2040703@domain.hid>	<20070405092815.15bd1af1@domain.hid>
	<20070405101200.10084177@domain.hid>
In-Reply-To: <20070405101200.10084177@domain.hid>
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
> On Thu, 5 Apr 2007 09:28:15 +0200
> Daniel Simon <Daniel.Simon@domain.hid> wrote:
> 
> 
>>>What is the difference between runlevel 1 and runlevel 3 ?  
> 
> 1 - Basic Single-user mode 
> 2 - Multi-user mode (without NFS but the network interface is up) 
> the basic xeno-tests seem to work normally also in level 2

Does it still run correctly if there is some traffic on the network ?
You could try to ping flood the box for instance ?

> 
> 3 - Multi-user mode with NFS
> 5 - full Multi-user mode with X and NFS
> 
>>Usually, X should only induce high latencies.  
> 
> Inded the behaviour is now very similar in these two runlevels.:
> I loose most of the control: the mouse pointer and
> windows move, I can still switch back and forth between already logged-in
> consoles and X, bust most shell commands do not respond ,e,.g. ls, ps,
> lsmod, rmmod, do not respond (and hence as I cannot rmmod the loaded
> xeno_modules the system does not totally hang :) , CtrlC gives control back.

What does "date" and /proc/interrupt say ? Is the system timer still
ticking ?

> Stangely I still can cd to my remotely nfs mounted homedir, but cannot list its
> content;
> reboot still starts, properly unmount nfs and finally fails to stop eth0.
> 
> However, it seems that problems begin when NFS is up, whatever there are
> remote mounts or not (also happens after a standalone boot)

Could you send us your .config ?

-- 
                                                 Gilles Chanteperdrix

