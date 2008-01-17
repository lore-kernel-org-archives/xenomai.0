Message-ID: <2ff1a98a0801170816k6eb1fd93i2c798d3ae82b0638@domain.hid>
Date: Thu, 17 Jan 2008 17:16:22 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d3f72a390801170758p64ea9816ra0d8c43917ab9a3@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d3f72a390801170758p64ea9816ra0d8c43917ab9a3@domain.hid>
Subject: Re: [Xenomai-core] INFO ON TSC ep9315
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: axel axel <softaxel@domain.hid>
Cc: xenomai@xenomai.org

On Jan 17, 2008 4:58 PM, axel axel <softaxel@domain.hid> wrote:
> HI,
>
> i copied RTAI on kernel 2.4.21 cirrus for hardware example, but
>
> how can i test if all the functionality of Xenomai are OK?

Run Xenomai testsuite.

>
> Also i have some questions:
>
>  1. Which are the link and the meaning between the
> ipipe_mach_set_dec,ipipe_mach_get_dec  and the ipipe_mach_get_tsc ?

In a previous mail, I sent you an link to Xenomai wiki: please click
on the link and read what you find there.

>
> 2. How ipipe calculates the wait time for a running periodic task ( if it
> uses tsc, dec, other ) ?

This is irrelevant when porting I-pipe, you should not have to care
about that. What is your real problem ?

-- 
                                               Gilles Chanteperdrix

