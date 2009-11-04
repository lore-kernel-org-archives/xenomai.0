Message-ID: <4AF20D2B.30508@domain.hid>
Date: Thu, 05 Nov 2009 00:24:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BB99A6BA28709744BF22A68E6D7EB51F03310307D6@domain.hid>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F03310307D6@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Sharing Semaphores in Kernel and User Space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jonathan Haws <Jonathan.Haws@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Jonathan Haws wrote:
> All,
> 
> I am writing a driver that needs to wake up a user space thread on a
> hardware interrupt.  I am reading about the Xenomai APIs semaphores
> and want to know if I create a semaphore in my kernel module with a
> given name using rt_sem_create, can I call rt_sem_bind in user space
> to bind to that same semaphore?
> 
> I am sure hoping the answer is yes!

The answer is yes, but...
this programming model is deprecated. You should be implementing a
driver using the RTDM API, as you would do with Linux.

-- 
					    Gilles.

