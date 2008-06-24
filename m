Message-ID: <48611E40.5010000@domain.hid>
Date: Tue, 24 Jun 2008 18:18:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <001801c8d614$6ddb55c0$9601a8c0@domain.hid>
In-Reply-To: <001801c8d614$6ddb55c0$9601a8c0@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] soft lockup after 11s
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rob@domain.hid
Cc: xenomai@xenomai.org

Robert McCullough wrote:
> Hi,
> 
>  
> 
> I am using Linux 2.6.23.14 and Xenomai 2.4.2 on a MPC5200.
> 
>  
> 
> My problem is this:
> 
>  
> 
> My RTDM driver communicates to a slave device via a dual-ported RAM (DPR)
> interface.  In my module_init() I have to give the slave a SAVE command via
> the DPR.
> 
> The SAVE command stores the slave's parameters to a non-volatile memory
> (FLASH or EEPROM).  I then wait in a loop for a flag in the DPR to be set
> stating the command is complete.
> 
> The SAVE command takes about 22 seconds to complete.  Before the command
> completes I get a "BUG:  soft lock-up - CPU#0 stuck for 11s!" message.
> 
> How would I solve this problem?

Since module_init() is a non real-time context, you can safely call
schedule() in the loop.

> Is there a way to increase this 11 second timeout?

You can disable the soft-lockup detector feature, a driver which loops
for 22 seconds without yielding to the OS is a bit hard for the OS, to
say the least.

-- 
                                                 Gilles.

