Message-ID: <4E9C8584.6050708@domain.hid>
Date: Mon, 17 Oct 2011 21:44:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E9C606B.2040406@domain.hid>
In-Reply-To: <4E9C606B.2040406@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Using rtdm_irq_request from user-space.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Victor Alvidrez <v.alvidrez@domain.hid>
Cc: xenomai@xenomai.org

On 10/17/2011 07:05 PM, Victor Alvidrez wrote:
> Hello.
> 
> I am trying to a write simple program that can listen for interrupts 
> produced by the keyboard in user-space.
> At first I tried to do this using the native API, however I figured out 
> that this functionality is turned off by default.  So I decided to use 
> the rtdm API.
> 
> I wrote the code using the rtdm_irq_* related functions/variables and 
> included the <rtdm/rtdm.h> header file.
> 
> However, upon trying to compile I get a bunch of undefined reference 
> errors.  I read through the rtdm.h file and found that there are no 
> definitions of rtdm_irq* related variables or function declarations.  
> All of these things are defined in <rtdm/rtdm_driver.h>, which you 
> cannot include in non-kernel code.
> 
> I guess it is pretty obvious that I cannot do this from user space... 
> but maybe I am missing something?


Yes.

> 
> The rtdm API manual includes a "Environments:This service can be called 
> from:" section.  And the function "rtdm_irq_request" lists "User-space 
> task (RT, non-RT)".  Doesn't this mean that it can be called from a 
> user-space program?
> 
> Thanks for any info you can provide.

This means that it can be called from the context of an ioctl emitted by
a user-space task (either RT or non RT). The RTDM skin is a kernel-only
skin.

-- 
                                                                Gilles.

