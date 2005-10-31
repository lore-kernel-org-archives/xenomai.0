Message-ID: <43668C11.9080306@domain.hid>
Date: Mon, 31 Oct 2005 22:26:41 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] kernel screen dump: "scheduling while atomic:
 "
References: <312725565956E84DBB7C760BA4052BB583528A@diablo.Cadillac.Genmarkinc.com>
In-Reply-To: <312725565956E84DBB7C760BA4052BB583528A@diablo.Cadillac.Genmarkinc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: GeorgyS@GenmarkAutomation.com
Cc: xenomai@xenomai.org

GeorgyS@GenmarkAutomation.com wrote:
> Hi,
>  
> I have a user space real-time application that uses fusion/xenomai 0.9.1 
> native API on linux kernel 2.6.11 and uClibc-0.9.28.

Which architecture are you running on?

> Everything seems to work fine, but after the application has run for 
> some time (10 to 20 minutes), the following screen dumps begin to appear 
> on the console:
>  
>      scheduling while atomic: <my_real-time_func_name>/0x00000002/276
>  
> followed by a call stack dump.
> My application continues to run normally, the scheduling of my real time 
> func seems ok too, but I wonder,
> why this screen dump appears and can in be disabled?

It's the sign of a bug, either in your application, in Xenomai, or maybe in the 
kernel itself. Please send the complete stack dump so that we can figure out 
what's happening.

>  
> Thanks,
> Georgi Stoykov
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 

Philippe.

