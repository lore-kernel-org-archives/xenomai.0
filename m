Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <4B4278B6.1080205@domain.hid>
Date: Tue, 05 Jan 2010 00:24:38 +0100
From: Alexis Berlemont <berlemont.hauw@domain.hid>
MIME-Version: 1.0
References: <4B421E02.6060006@domain.hid>
In-Reply-To: <4B421E02.6060006@domain.hid>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] enable  __a4l_dbg
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Alessio Margan @ IIT" <alessio.margan@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

Alessio Margan @ IIT wrote:
> Hi,
> 
> Where is defined #ifdef CONFIG_XENO_DRIVERS_A4L_DEBUG to enable __a4l_dbg
> I can not found
That was a bug which was fixed before the 2.5 release:

commit e75f87874d126289007c4c69db4606a34ad759a7
Author: Alexis Berlemont <alexis.berlemont@domain.hid>
Date: Tue Dec 29 00:14:31 2009 +0100

analogy: fix a bug in the configuration of the debug trace system

In the kernel configuration menu, go to the Analogy drivers sub-menu and
set the options "Analogy debug trace", "Analogy core debug level
threshold" and "Analogy driver debug level threshold".

> 
> TIA
> 
> Alessio

Alexis.

