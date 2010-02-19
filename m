From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <e325d111002190050m12ac3028h5775b5fa2c390070@domain.hid>
References: <e325d111002190050m12ac3028h5775b5fa2c390070@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 19 Feb 2010 11:11:17 +0100
Message-ID: <1266574277.26785.112.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] incompatible feature set
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kim Chuan Lim <lim.kim.chuan@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2010-02-19 at 16:50 +0800, Kim Chuan Lim wrote:
> Dear all,
> 
> i recevied the following error while trying to execute an example
> program provided by xenomai.
> 
> user@domain.hid$ ./trivial-periodic
> Xenomai: incompatible feature set
> (userland requires "tsc", kernel provides "sep fastsynch smp", missing="tsc").
> 
> may i know how can i config my kernel to provide this tsc flag?
> 

2.4.4 dates back to June 2006. Maybe it's time for an upgrade, to 2.5.1.

In case you are using the default kernel config file shipped with your
distro as a starting point, do not leave it un-tuned, this will not fit
any serious real-time usage. See there: 
http://www.xenomai.org/index.php/FAQs#Tips_and_tricks_setting_up_your_x86_kernel

> Regards,
> Kim Chuan.
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



