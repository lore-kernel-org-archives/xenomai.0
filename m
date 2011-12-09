Message-ID: <4EE1E283.709@domain.hid>
Date: Fri, 09 Dec 2011 11:27:15 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <4ED66FD7.4010403@domain.hid> <4ED79747.10809@domain.hid>
	<CAMesUR5gouRy88TV3YZqnuZ-OFVpO5uTSFergNuuvQaC=1MGVQ@mail.gmail.com>
	<4EDF1C8D.90704@domain.hid> <4EE0E3A2.2070302@domain.hid>
In-Reply-To: <4EE0E3A2.2070302@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Analogy/mite
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <alexis.berlemont@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 12/08/2011 05:19 PM, Anders Blomdell wrote:
> On 12/07/2011 08:58 AM, Anders Blomdell wrote:
>> On 12/06/2011 11:47 PM, Alexis Berlemont wrote:
>>> Hi
>>>
>>> On Thu, Dec 1, 2011 at 4:03 PM, Anders Blomdell
>>> <anders.blomdell@domain.hid> wrote:
>>>> On 11/30/2011 07:03 PM, Anders Blomdell wrote:
>>>>>
>>>>> Hi, just found that
>>>>>
>>>>> echo 0000:06:01.0> /sys/bus/pci/drivers/analogy_mite/unbind
>>>>>
>>>>> does not do the same thing as
>>>>>
>>>>> analogy_config -r analogyN
>>>>>
>>>>> in fact it leaves the system in a state where using the driver results
>>>>> in a kernel OOPS.
>>>>>
>>>>> Will try to look into it further tomorrow...
>>>>
>>>> OK seems like we have some interrupt cleanup problem, the following
>>>> command
>>>> sequence:
>>>>
>>>
>>> OK thank you for the report. I did not have time to look at it yet but
>>> that will be done soon.
>>>
>>> Is it blocking for you?
>> Yes, and even worse is this problem:
>>
>> # /usr/local/sbin/analogy_config analogy0 analogy_ni_pcimio 6,1
>> # /usr/local/sbin/analogy_config -r analogy0
>> # cat /proc/xenomai/irq
>> Killed
>>
>> I was looking into it last week, but is a workshop since monday, will
>> get back at this tomorrow.
> Seems like somebody is stomping out
> dev->transfer.irq_desc.rtdm_desc.flags between attach and detach (flags
> and all fields in its vicinity is zeroed out), hence the interrupt is
> never removed from the interrupt handler tables wreaking havoc with the
> entire kernel.

Found the guilty party: a4l_cleanup_transfer, which zeroes out all the 
interrupt data, just before the interrupt should be detached. Somebody 
is being overzealous about keeping memory shiningly clean. We need to 
keep the useful dirt.

--- xenomai-2.6.0/ksrc/drivers/analogy/transfer.c.orig	2011-12-09 
11:22:06.961999598 +0100
+++ xenomai-2.6.0/ksrc/drivers/analogy/transfer.c	2011-12-09 
11:22:29.723999243 +0100
@@ -92,8 +92,6 @@
  		rtdm_free(tsf->subds);
  	}

-	memset(tsf, 0, sizeof(a4l_trf_t));
-
  	return 0;
  }


/Anders


-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden


