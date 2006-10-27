Subject: Re: [Xenomai-help] Xenomai & Xen
From: Alessio Igor Bogani <abogani@domain.hid>
In-Reply-To: <4540DEA8.4090006@domain.hid>
References: <1161874282.7650.7.camel@domain.hid>  <4540DEA8.4090006@domain.hid>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 10:06:03 +0200
Message-Id: <1161936364.5241.33.camel@domain.hid>
Mime-Version: 1.0
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "Xenomai (help)" <xenomai@xenomai.org>

Hi,

[...]
> > Can Xenomai cohabit with Xen in the same kernel?
> > Someone have already tried?
> 
> As paravirtualised host of Xen or by driving Xen in real-time via
Xenomai?

The second one:

HW -> Adeos-ipipe -> Xen-Domai0 ---> Xen unprivileged domain A
                                |--> Xen unprivileged domain B
                                |--> ....
                                ---> Xen unprivileged domain N

It is possible?
Thanks in advance!

Ciao,
Alessio



