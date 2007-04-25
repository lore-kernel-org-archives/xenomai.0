Message-ID: <462F1994.1040405@domain.hid>
Date: Wed, 25 Apr 2007 09:04:20 +0000
From: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@domain.hid>
MIME-Version: 1.0
References: <45F68258.5040603@domain.hid>
	<45F6A44A.2030000@domain.hid>	<45F6A73C.8030301@domain.hid>
	<45F6AA11.40707@domain.hid>	<bc4264770703281005v17fc4802v53728cda11cb6b17@domain.hid>	<460AB8FF.5060904@domain.hid>
	<460B21C0.7090200@domain.hid>	<460B7FDF.8030100@domain.hid>
	<460BECFD.2030003@domain.hid>	<460C0C7D.7000001@domain.hid>
	<bc4264770704230809i9f9c554k14d67007b828971d@domain.hid>
In-Reply-To: <bc4264770704230809i9f9c554k14d67007b828971d@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Latencies due to RT-Socket-CAN register accesses
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: Xenomai-help@domain.hid

Hi Roland,

I only made a look at your xeno config.


looks like you used make config, try make menuconfig or make xconfig to
setup your kernel, more confortable...


I think your kernel config would need better and fine tuning,here are
some tips :
Disable swap in kernel config

lot of unuseful drivers are modules compiled. Setup only and only what
is present in your computer and may be used.
Furthermore, this will permit you to compile the kernel in a faster way.

I strongly advice disabling i2o too.

If you do not need pcmcia, turn it off too.

setup power managament off

CONFIG_M486 is settted up ? I read you had a 3GHz processor a few mails
before !!!!  ? Setup the right processor !!!!!


Best Regards
Steph

