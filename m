Message-ID: <462F355D.5010201@domain.hid>
Date: Wed, 25 Apr 2007 13:02:53 +0200
MIME-Version: 1.0
References: <45F68258.5040603@domain.hid>
	<45F6A44A.2030000@domain.hid>	<45F6A73C.8030301@domain.hid>
	<45F6AA11.40707@domain.hid>	<bc4264770703281005v17fc4802v53728cda11cb6b17@domain.hid>	<460AB8FF.5060904@domain.hid>
	<460B21C0.7090200@domain.hid>	<460B7FDF.8030100@domain.hid>
	<460BECFD.2030003@domain.hid>	<460C0C7D.7000001@domain.hid>
	<bc4264770704230809i9f9c554k14d67007b828971d@domain.hid>
	<462F1994.1040405@domain.hid>
In-Reply-To: <462F1994.1040405@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: Re: [Xenomai-help] Latencies due to RT-Socket-CAN register accesses
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@domain.hid>
Cc: Xenomai-help@domain.hid

Hi Stephane,

Thanks for the useful tips. Will work on them.

> I only made a look at your xeno config.
> 
> 
> looks like you used make config, try make menuconfig or make xconfig to
> setup your kernel, more confortable...
Strange, I do use menuconfig.


> 
> 
> I think your kernel config would need better and fine tuning,here are
> some tips :
> Disable swap in kernel config
Will do.

> 
> lot of unuseful drivers are modules compiled. Setup only and only what
> is present in your computer and may be used.
> Furthermore, this will permit you to compile the kernel in a faster way.
I know this but I am using a USB loaded linux with the intention of 
being able to run this system off many PC's without having to worry 
about drivers.


> 
> I strongly advice disabling i2o too.
Will do. What does it do by the way?

> 
> If you do not need pcmcia, turn it off too.
Will do.

> 
> setup power managament off
It is off!! Where did you see that it was on? Which setting?

> 
> CONFIG_M486 is settted up ? I read you had a 3GHz processor a few mails
> before !!!!  ? Setup the right processor !!!!!
I am afraid here you are right. Unfortunately this implies rebuilding 
all the drivers too (I tried and they are not compatible with 486 
kernels) and this USB bootable distribution makes changing the modules, 
well not impossible but pretty damn nearly impossible. IT does mean I do 
not have TSC support which I am aware, makes a big difference.

Thanks again.

Roland.


> 
> 
> Best Regards
> Steph
> 

