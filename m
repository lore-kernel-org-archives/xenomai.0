Message-ID: <4D9F2BCF.3080505@domain.hid>
Date: Fri, 08 Apr 2011 17:37:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20110407170855.GA22659@domain.hid>
	<4D9E0354.4010600@domain.hid> <4D9EAC97.4090307@domain.hid>
	<20110408065122.GB18160@domain.hid>
In-Reply-To: <20110408065122.GB18160@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Adeos-main] ARM IXP: ipipe regression from
 2.6.31 to .33 and .35
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Richard Cochran <richardcochran@domain.hid>
Cc: adeos-main@gna.org, Xenomai-core@domain.hid

Richard Cochran wrote:
> On Fri, Apr 08, 2011 at 08:35:03AM +0200, Gilles Chanteperdrix wrote:
> 
>> - the TSC emulation code is factored, so that when porting to a new
>> port, we avoid copy-pasting the TSC emulation;
> 
> The ARM porting page on the wiki is out of date with regards to this.

Yes, and about the GPIO demuxing too. I will update it when I am done
with the Panda port, which will allow me to document the SMP bits...

> 
>> - it is ready for multi-SOCs kernels (all the TSC emulations are
>> compiled-in, the one chosen is copied to the vectors page when the
>> ipipe_tsc_register function is called). This is the direction ARM linux
>> is going, if you followed the ARM wrestling on the linux-arm-kernel
>> mailing list.
> 
> Yes, that thread was really entertaining ;)
> 
> 
> Thanks for all your good work,

You are welcome, it is a pleasure to work with people who do not expect
us to do all the fixing on our own.

-- 
					    Gilles.

