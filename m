Message-ID: <4E9F0E83.7080408@domain.hid>
Date: Wed, 19 Oct 2011 19:53:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CACFV95+U15KiANkoO71oB-i92FrZfso95o0w5k0dtSDg0S92=g@domain.hid>
In-Reply-To: <CACFV95+U15KiANkoO71oB-i92FrZfso95o0w5k0dtSDg0S92=g@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Driver for Rtserial
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Siva kumar Balasubramanian <sivakumar.bs@domain.hid>
Cc: xenomai@xenomai.org

On 10/19/2011 01:24 PM, Siva kumar Balasubramanian wrote:
> Hi all,
> 
> How to enable Rtserial for other than 16550A-Compatible Devices.
> I am having mini2440 development board has 3232CBNZ RS-232
> Transmitters/Receivers.

You need to write a driver for this device, using the RTDM skin,
following the serial driver profile defined by the 16550A driver.

-- 
                                                                Gilles.

