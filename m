Message-ID: <4D4D6BF8.7020804@domain.hid>
Date: Sat, 05 Feb 2011 16:25:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <256347.90512.qm@domain.hid>
In-Reply-To: <256347.90512.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Need Help Xenomai and Labjack
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rafa Ahnaf <xrafax2000@domain.hid>
Cc: xenomai@xenomai.org

Rafa Ahnaf wrote:
> Haloo..
>> I am rizki, i want to make aplication that accordance with Labjack dan Xenomai. 
>> I am making controller of "The Ball and Beam". Could you help me, how to acces 
>> labjack in the xenomai?
>> I've installed xenomai-2.4.9.1 , kernel 2.6.27.27, libusb and labjack driver. In 
>> normal linux(without xenomai), i can  run labjack and control "The Ball and 
>> Beam" with success. 
>>
>>
>> link:
>> http://labjack.com/support/linux-and-mac-os-x-drivers

It really looks like labjack is something for Linux, not Xenomai. So,
there is no way you can make it work with Xenomai other than porting the
drivers to Xenomai RTDM skin and the USB4RT driver stack.

-- 
                                                                Gilles.

