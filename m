From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17616.39458.198050.680268@domain.hid>
Date: Wed, 2 Aug 2006 14:27:14 +0200
Subject: Re: [Xenomai-help] Reading Memory Mapped IO
In-Reply-To: <353F6272FE0A6544AA97D47F761F486B01707FDF@ples506a.stcl.siemens.co.uk>
References: <353F6272FE0A6544AA97D47F761F486B01707FDF@ples506a.stcl.siemens.co.uk>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Doyle, Alan" <alan.doyle@domain.hid>
Cc: xenomai@xenomai.org

Doyle, Alan wrote:
 > 
 > Hi,
 > 
 > I have an application where I need to read four contiguous memory mapped
 > data registers in response to an interrupt. As its real time critical I
 > intend to implement the read in Xenomai. Having read and processed the
 > data it later needs to be passed to a Linux domain application, I am
 > hoping to use a Posix message queue for this purpose.
 > 
 > I seem to have two options as to how to implement this, I could register
 > the interrupt in a Xenomai user space thread and mmap the data registers
 > so that on receiving the interrupt the registers could be read.
 > Alternatively I could write a Xenomai RTDM driver to read the registers
 > on interrupt and use the driver read call from the Xenomai user space
 > thread to access register data. In each case the data would then be
 > passed to the Linux domain via a message to a Posix queue - after some
 > further processing that is not real time critical.
 > 
 > Could you enlighten me as to the pros and cons of each approach,

The advantage of the "all in user-space" approach is that you will be
able to get rapidly something that works, because debugging in
user-space is much easier than in kernel-space. On the other
hand, writing a driver using RTDM will result in a clear separation
between application code and driver code that will be easier to maintain
on the long run. Imagine what will happen in the two cases when the
hardware changes.

-- 


					    Gilles Chanteperdrix.

