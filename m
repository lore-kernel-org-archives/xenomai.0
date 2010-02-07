Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <4C2CF9F5.7000408@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
MIME-Version: 1.0
References: <bcc5a9cc1002071243i27ed36a9k38152e5d29034ad4@domain.hid>
In-Reply-To: <bcc5a9cc1002071243i27ed36a9k38152e5d29034ad4@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Analogy vs Comedi
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Date: Sun, 07 Feb 2010 21:27:49 -0000
To: Jaryn Sepesi <jaryn.sepesi@domain.hid>
Cc: xenomai@xenomai.org

Hi,

Jaryn Sepesi wrote:
> Hi everyone!
> 
> I'm designing a real-time system based on Xenomai and NI 6259 DAQ board. 
> Analogy contains a driver for my card, but there is one little problem. 
> I have some experience using this card with normal non-RT linux + 
> Comedi, so I know It needs to be calibrated via tools like 
> comedi_soft_calibrate. I didn't find any suitable equivalent of this 
> tool in Xenomai documentation.
You are right. This tool has not yet been developed.

> 
> My question is - Is it possible to use Comedi tools (like mentioned 
> comedi_soft_calibrate) together with analogy driver? 
I am afraid you can't. But this task is planned (among many others). I
am still struggling with some other tasks but I could start it quite soon.

And if not, can I
> use comedi driver combined with Xenomai? I mean for RT applications. 
> (Yes, I know this is definitely not a clean approach, but still better 
> than use different RTOS)
Your real-time task will be able to use the comedi driver. However, I
think you already have in mind that your task will leave the primary
domain. You will be in charge to make it switch back.

Anyway, a smooth transition from comedi to analogy should be easy, once
the calibration feature will be available. Thus, you will get a better
determinism for your whole application.

> 
> Thank you very much!
> 
> BR,
> Jaryn Sepesi
> 

Alexis.

> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


