Message-ID: <47FCC966.5090100@domain.hid>
Date: Wed, 09 Apr 2008 15:49:26 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <20080409202347.zr3fs5i3kk0ococ4@domain.hid>
In-Reply-To: <20080409202347.zr3fs5i3kk0ococ4@domain.hid>
Content-Type: multipart/mixed; boundary="------------070308070002080908010100"
Subject: Re: [Xenomai-help] CAN
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Urs Eichholzer <urs.eichholzer@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------070308070002080908010100
Content-Type: text/plain; charset=TIS-620
Content-Transfer-Encoding: 7bit

Urs Eichholzer wrote:
> Hi
> 
> We are using Linux 2.6.19.2 and Xenomai 2.3.0

Xenomai 2.3.0 is quite old and I recommand to  update to 2.3.5., at lreast

> The problem disapeared when we not changed the baudrate (we try to scan the
> bus..). What shoult be the time between changing the baudrate?

Ah, I see. Does the attached patch help?

Wolfgang.


> Thank's
> 
> Urs
> 
> From: Wolfgang Grandegger [wg@domain.hid]
> Sent: Wednesday, April 09, 2008 12:19 AM
> To: Urs Eichholzer
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] CAN Probleme
> 
> Hi Urs,
> 
> Urs Eichholzer wrote:
>> Hello
>>
>> We are just start to use the setup...
>> We try to read parameters from a device true the CAN. From some
>> parameters we get proper replay and with other parameters we get the
>> following message:
>> rtcan0: btr0=0x05 btr1=0x4f
>> rtcan0: btr0=0x0a btr1=0x6f
>> rtcan_mscan_start_xmit: TX buffer not empty
> 
> Hm, this message is pretty fatal. What version of Linux and Xenomai do you use?
> What type of parameters do you read when the error message shows up. Can you
> reproduce the problem with a little example program?
> 
> Thanks,
> 
> 
> ----------------------------------------------------------------
> This message was sent using Samart Web Mail 2005.
> 
> 


--------------070308070002080908010100
Content-Type: text/x-patch;
 name="xenomai-rtcan-mscan.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-rtcan-mscan.patch"

Index: rtcan_mscan.c
===================================================================
--- rtcan_mscan.c	(revision 3454)
+++ rtcan_mscan.c	(working copy)
@@ -358,6 +358,10 @@ static int rtcan_mscan_mode_stop(struct 
     if (!CAN_STATE_OPERATING(state))
         goto out;
 
+    regs->canrier = 0;
+    if (!(regs->cantflg & MSCAN_TXE0))
+	    regs->cantarq = MSCAN_TXE0;
+
     /* Switch to sleep mode */
     regs->canctl0 |= MSCAN_SLPRQ;
     regs->canctl0 |= MSCAN_INITRQ;

--------------070308070002080908010100--

