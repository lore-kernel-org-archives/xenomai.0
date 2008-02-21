MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18365.64767.425993.592610@domain.hid>
Date: Thu, 21 Feb 2008 23:36:47 +0100
In-Reply-To: <47BDA1710200000100192821@domain.hid>
References: <47BDA1710200000100192821@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Non RT PCI device driver vs interrupts (almost
	ok)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Hubert Talbot <Hubert.Talbot@domain.hid>
Cc: xenomai@xenomai.org

Hubert Talbot wrote:
 > 
 > First of all, I am studying xenomai to show to my manager that this framework 
 > can do the expected job for our realtime applications (me, I believe!). I have to prove
 > that with a concrete application (alike the ones we do in general), where the
 > need to test xenomai with pci card.
 > 
 > The first step I decided to do is capture interrupt. Eventually, I will want
 > to translate driver to rtdm.
 > 
 > I had some difficulties to catch interrupt from realtime task but with
 > your confirmation, it is ok now.
 > 
 > However, it seems to be not as precise as expected 
 > (in milliseconds order instead of microsecs).
 > 
 > 
 > Within a demo application...
 > 
 > 
 > The main function is as:
 > 
 > - opens board (specifying ISR)
 > - enables capturing of digital IO events
 > - enables interrupt requests in response to captured DIO edges
 > - enables interrupts
 > - reads counter
 > - disables interrupts
 > - closes board
 > 
 > 
 > And the ISR is as:
 > 
 > - gets interrupts status
 > - updates count
 > - resets DIO event capture flags
 > - enables interrupts
 > 
 > 
 > 
 > Doing like that in realtime application, I succeeded to catch interrupts
 > but with imprecision.
 > 
 > In rt_task, I have the following:
 > 
 > - rt_intr_wait()
 > - gets interrupts status (1)
 > - reads counter 
 > - resets DIO event capture flags (2)
 > - enables interrupts (3)
 > 
 > 
 > Can (1) (2) (3) api calls cause the imprecision (primary/secondary mode)?
 > 
 > Should it be better if device driver would be implemented with xenomai-rtdm?

If you see milliseconds, then there is a problem somewhere. If you kept
the Linux driver running, it maybe this driver which disturbs your
real-time activities, for instance by clearing the interrupt bit by
reading interrupt status at an unwanted time.

About the rtdm vs user-space question. In my opinion, if you want to get
results rapidly, you can go for user-space, there you have better debug
tools. However, if the driver you write is expected to have a longer
life than a proof-of-concept, then you should go for RTDM.

P.S: I get error messages from your mail system telling me that
messages I send to you can not be delivered.

-- 


					    Gilles Chanteperdrix.

