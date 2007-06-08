Message-ID: <305035a40706081335v5d49fde2i96dd8b2b0a22fb50@domain.hid>
Date: Fri, 8 Jun 2007 22:35:22 +0200
From: "Gregory CLEMENT" <gclement00@domain.hid>
In-Reply-To: <18025.37833.610273.790254@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <403B28AE6257B548B66BB88414AC78330174BC34@domain.hid>
	<18025.37833.610273.790254@domain.hid>
Subject: Re: [Xenomai-core] [Adeos-main]  AT91 patch duplicated code ...
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org, xenomai@xenomai.org

2007/6/8, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> BOUIN Alexandre wrote:
>  >
>  > > When we released our last version of adeos-ipipe-2.6.19-arm-AT91.patch, we suggested to merge code for at91rm9200 and at91sam926x.
>  > > These 2 code are split but quite similar, so we think it could be a good idea. Are you OK for removing duplicated code ?
>
> If I have to choose between duplicating some Linux code in I-pipe code
> and have some duplication in the I-pipe patch, I choose duplication in
> the I-pipe patch. If you duplicate Linux code, you will have to avoid
> forgetting to update this duplicate code when Linux code evolves.
>

Well the first mail wasn't very clear. I am going to explain what we
have in mind.

In Linux code for AT91 timer there are two files: at91sam926x_time.c
and at91rm9200_time.c because AT91RM9200 and AT91SAM926x have
different system timer: AT91RM9200 use AT91_ST peripheral and
AT91SAM926x use AT91_PIT peripheral.
But with i-pipe we use TC (timer counter) in both case, and code is
the same (the only difference are in the name of internal function).
When CONFIG_IPIPE is defined, original Linux code is no more used and
it is new i-pipe code which is used.
I suggest to add a new file in i-pipe patch, let's call it
"at91ipipe_time.c". In this file we will find the common ipipe code.
This file will be compiled in place of at91sam926x_time.c and
at91rm9200_time.c. For doing this we just have to change Makefile with
something like this:

# CPU-specific support
obj-$(CONFIG_ARCH_AT91RM9200)	+= at91rm9200.o at91rm9200_devices.o
obj-$(CONFIG_ARCH_AT91SAM9260)	+= at91sam9260.o at91sam9260_devices.o
obj-$(CONFIG_ARCH_AT91SAM9261)	+= at91sam9261.o at91sam9261_devices.o

ifeq ($(CONFIG_IPIPE),y)
obj-$(CONFIG_ARCH_AT91RM9200)	+= at91ipipe_time.o
obj-$(CONFIG_ARCH_AT91SAM9260)	+= at91ipipe_time.o
obj-$(CONFIG_ARCH_AT91SAM9261)	+= at91ipipe_time.o at91sam9261_devices.o
else
obj-$(CONFIG_ARCH_AT91RM9200)	+= at91rm9200_time.o
obj-$(CONFIG_ARCH_AT91SAM9260)	+= at91sam926x_time.o
obj-$(CONFIG_ARCH_AT91SAM9261)	+= at91sam926x_time.o
endif


-- 
Gregory CLEMENT
Adeneo
2, chemin du Ruisseau - BP21
69136 Ecully Cedex
France
Tel : +33-4 72 18 08 40

