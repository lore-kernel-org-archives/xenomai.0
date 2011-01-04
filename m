Message-ID: <4D237F1A.6010608@domain.hid>
Date: Tue, 04 Jan 2011 21:12:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4D233AB4.5070702@domain.hid>
	<4D2352C9.9050006@domain.hid>	<4D2377B5.1040807@domain.hid>	<4D23785B.5050108@domain.hid>
	<4D2379EF.5@domain.hid> <4D237A89.3010205@domain.hid>
	<4D237B33.7080100@domain.hid> <4D237D5B.7080301@domain.hid>
In-Reply-To: <4D237D5B.7080301@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai failure
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tamas Szklenar <tszklenar@domain.hid>
Cc: xenomai@xenomai.org

Tamas Szklenar wrote:
> Hi
> 
> Here are the sections from the log:

You are kidding me, right? "Full kernel logs", means that we do not want
to see any subsection of the log, we want to see it fully, all the way
from the early boot message up to the but at insmod time. Anyway, the
other mail you sent was almost right, it only lacked the early boot
messages.

As also said in the link Stefan pointed you to, the best way to get
these messages is to use a serial console, or netconsole if your PC has
no serial port (which starts being really common, I admit).

I wonder: how could we have made the "request for information" page
clear enough so that you would have understood it right away?

-- 
                                                                Gilles.

