MIME-Version: 1.0
In-Reply-To: <20150420174623.GA456@hermes.click-hack.org>
References: <CAL5YyVZw6JttAzBnApqQyV-9o3ng9VG3Srv=E5bGfD1tRaZZ+g@mail.gmail.com>
 <20150420174623.GA456@hermes.click-hack.org>
Date: Wed, 22 Apr 2015 21:28:24 +0200
Message-ID: <CAPRPZsD==s4TZOAaEsroOtUCo_AzpPHi15QNyCE962Pb1JAwBg@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] X86 rebbot when i use latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: ACO31 <alain.cordat@gmail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

> Are you sure that the system is not simply experiencing a kernel
> oops and that your system is configured to reboot in that case?
>
> If that is the case, disable this, and run the latency test in text
> mode in order to see the oops text. Or capture it via serial console
> if you are lucky enough that your PC has a serial port.

In case it's useful: while hunting for the APEI interrupt bug, we're
using netconsole. The kernel command line in this case is:

BOOT_IMAGE=/boot/vmlinuz-3.16.7-cobalt
root=UUID=4cc8572b-8982-4cfe-9887-070196bd6827
 ro netconsole=6665@192.168.17.181/eth0,6666@192.168.17.180/62:54:04:a6:0a:a5
debug loglevel=7 systemd.log_level=de
bug systemd.log_target=kmsg softlockup_all_cpu_backtrace=1

>
> --
>                                             Gilles.
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai

