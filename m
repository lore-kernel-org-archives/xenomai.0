MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18432.60367.701502.520266@domain.hid>
Date: Sat, 12 Apr 2008 19:05:19 +0200
In-Reply-To: <4800DE84.5040200@domain.hid>
References: <47FFB7D3.3040000@domain.hid>
	<18432.49619.109362.265306@domain.hid>
	<4800DE84.5040200@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] waiting for multiple hardware interrupts
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tomas Kalibera <kalibera@domain.hid>
Cc: xenomai@xenomai.org

Tomas Kalibera wrote:
 > Hi Gilles,
 > 
 > thank you for the info. I have additional question: Is it possible to 
 > wait for multiple interrupts without specific kernel support (RTDM 
 > driver or kernel-space IRQ handlers or anything) ? I see that without 
 > kernel support, in native skin, one can in user-space wait for a 
 > specific hardware interrupt using "rt_intr_wait". I need to wait for 
 > multiple interrupts in user space. Do I have to create a dedicated 
 > thread to wait for each interrupt ?

No, there is currently no Xenomai features to allow you to wait for
multiple interrupts from a unique user-space thread without a kernel
module. That said, the rt_event solution could be implemented with
a really minimal kernel module.

-- 


					    Gilles.

