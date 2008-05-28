Message-ID: <483D190F.4000408@domain.hid>
Date: Wed, 28 May 2008 10:34:23 +0200
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <000501c8c06c$adb72100$2201a8c0@domain.hid>
	<483D172B.1070604@domain.hid>
In-Reply-To: <483D172B.1070604@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] General questions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Urs.Eichholzer" <urs.eichholzer@domain.hid>
Cc: xenomai@xenomai.org

Sebastian Smolorz wrote:
> You have to distinguish two cases:
> 1. The CAN hardware is immediately ready to accept the message that an 
> application wants to send. In this case the registers of the hardware 
> are filled appropriately and the hardware is instructed to send the CAN 
> message. Without waiting for completion of writing the message to the 
> CAN bus the rt_dev_send function returns.
> 
> 2. If the CAN hardware is in the process of sending an message and 
> another rt_dev_send call is executed for the same CAN bus rt_dev_send 
> blocks as long as the hardware reports that is is ready to accept a new 
> message.
To be correct, replace "as long as" with "until".

-- 
Sebastian


