Message-ID: <49CBF29D.5020500@domain.hid>
Date: Thu, 26 Mar 2009 22:24:45 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <49CBB6C5.5000407@domain.hid> <49CBBD4B.7070800@domain.hid>
	<49CBEDE2.5040106@domain.hid>
In-Reply-To: <49CBEDE2.5040106@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Keyboard IRQ
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Antoine Nourry <nourry@domain.hid>
Cc: xenomai@xenomai.org

Antoine Nourry wrote:
> Sorry for my blurred question, i just wanted to point out the fact that 
> i managed to use most of Xenomai API functionalities when i was working 
> on an RTDM USB driver. However during my scattered tests i never managed 
> to catch properly IRQ 1 (i use a standard keyboard here). The goal is to 
> measure time reaction from the moment an image appears to the keypress 
> event.  Several months ago i asked you how to achieve this and wasn't 
> aware at all of the domain switching when calling non realtime functions 
> while being in RT mode. Thus i mixed non realtime and realtime functions 
> in the same realtime task... and among them there were different 
> keyboard event catch functions whichever are all non RT. I want a 
> deterministic program that could rely on Xenomai source clock and on its 
> IRQ handling in order to know when to take the measure.
> 
> I first want to know if this could be a good way to do so or if i'm 
> totally wrong.

I think I already told you that, but using Xenomai to do that is
completely overkill.

> 
> Secondly, i just made some new tests from the irq user example and 
> rt_intr_wait returns -38 (is it ENOSYS = function not implemented ?) Do 
> i have to compile some functionality in the kernel or during Xenomai 
> install ?

Yes, handling interrupts in user-space with the native and posix skins
is discouraged. You should be using the RTDM skin. But if you absolutely
want to use these services, you have to enable them in the kernel
configuration.


-- 
					    Gilles.

