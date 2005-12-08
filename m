Message-ID: <439826C4.5010009@domain.hid>
Date: Thu, 08 Dec 2005 14:27:48 +0200
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: FW: [Xenomai-help] insmod: error inserting './xeno_posix.ko':
	-1	Unknown symbol in module
References: <000201c5fbec$8732bc70$0200000a@domain.hid>
In-Reply-To: <000201c5fbec$8732bc70$0200000a@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Martijn Hazenberg (GOVA)" <martijn@domain.hid>
Cc: xenomai@xenomai.org

Martijn Hazenberg (GOVA) kirjoitti:
> Hi,
> 
> Thanks for all reactions Ulrich, Heikki and Gilles....
> 
> Ok i got it running. The loading of xeno_hal goes ok.
> Lsmod gives the module correctly, I can also unload it and reload it. So no
> problems there.
> 
> Loading the other modules still give the error -1 Unknown symbol. The dmesg
> output is as described in the text output I attached earlier.
> 
> What module is used for what and when ? or where can I find that info ? Do
> all of the modules have to be loaded ? or just a few ? or only 1 ? Or
> depending on application ?

xeno_hal provides the basic, most low-level services mostly coming from 
i-pipe/adeos. xeno_nucleus provides the RTOS services for the RTOS 
skins. xeno_native/posix/rtdm are skins that use nucleus' services to 
provide RTOS APIs - are driver APIs in case of rtdm.

> Is the order in which the modules are loaded defined or can they be loaded
> at random order ?

Not random. First hal, then nucleus, then any of the skins. I have no 
experience with the 16550 serial module, though, and don't remember 
whether it was converted to use RTDM or not. If it wasn't, it'll 
probably come after hal, if you need it.

-- Heikki Lindholm

