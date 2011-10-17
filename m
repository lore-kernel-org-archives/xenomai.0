Message-ID: <4E9C606B.2040406@domain.hid>
Date: Mon, 17 Oct 2011 11:05:47 -0600
From: Victor Alvidrez <v.alvidrez@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Using rtdm_irq_request from user-space.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello.

I am trying to a write simple program that can listen for interrupts 
produced by the keyboard in user-space.
At first I tried to do this using the native API, however I figured out 
that this functionality is turned off by default.  So I decided to use 
the rtdm API.

I wrote the code using the rtdm_irq_* related functions/variables and 
included the <rtdm/rtdm.h> header file.

However, upon trying to compile I get a bunch of undefined reference 
errors.  I read through the rtdm.h file and found that there are no 
definitions of rtdm_irq* related variables or function declarations.  
All of these things are defined in <rtdm/rtdm_driver.h>, which you 
cannot include in non-kernel code.

I guess it is pretty obvious that I cannot do this from user space... 
but maybe I am missing something?

The rtdm API manual includes a "Environments:This service can be called 
from:" section.  And the function "rtdm_irq_request" lists "User-space 
task (RT, non-RT)".  Doesn't this mean that it can be called from a 
user-space program?

Thanks for any info you can provide.

Running Ubuntu with Xenomai-2.5.5.2, linux kernel 2.6.32 .





