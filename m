Message-ID: <49F026AF.3030906@domain.hid>
Date: Thu, 23 Apr 2009 10:28:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1388082696.3997731240471520688.JavaMail.root@domain.hid>
In-Reply-To: <1388082696.3997731240471520688.JavaMail.root@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem of freeze
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: btirefort@domain.hid
Cc: xenomai-help <xenomai@xenomai.org>

btirefort@domain.hid wrote:
> Hello
> 
> I'am rookie in xenomai and i have a problem.
> 
> Here my configuration :
> 
> Linux base : CentOS v5.3 (with gnome)
> kernel : linux-2.6.28.7
> xenomai : 2.4.7
> processor cpu familly  : 6
>               type : 14 (Intel Core Duo T2500 2Ghz)
> memory : 1 GB
> HDD : SCSI with Adaptec AIC-7892B card
> 
> I have installed xenomai with no problem.
> All options of ACPI, APM and CPU frequency scaling are disabled.

This is wrong. You should enable ACPI, and only disable ACPI_PROCESSOR.
Disabling ACPI is known to cause bugs with Linux on some machines.

-- 
					    Gilles.

