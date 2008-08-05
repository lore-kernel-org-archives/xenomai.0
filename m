In-Reply-To: <48971838.40202@domain.hid>
From: stefano.franzoni@domain.hid
Date: Tue, 5 Aug 2008 17:02:21 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Message-Id: <20080805150222.1E6FD1C066@domain.hid>
Subject: Re: [Xenomai-help] xenomai version 2.4.4 with linux kernel
 2.6.25.11 under ubuntu problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hello Gilles,

The problem is solved, it was exactly the Enhanced IDE/MFM option.

Many thanks

Stefano



                                                                           
             Gilles                                                        
             Chanteperdrix                                                 
             <gilles.chanteper                                          To 
             drix@domain.hid>         stefano.franzoni@domain.hid        
                                                                        cc 
             04/08/2008 16:54          xenomai@xenomai.org                
                                                                   Subject 
                                       Re: [Xenomai-help] xenomai version  
                                       2.4.4 with linux kernel 2.6.25.11   
                                       under ubuntu problem                
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           




stefano.franzoni@domain.hid wrote:
> - I have also included in the kernel, not as module, the
> ATA/ATAPI/MFM/RLL Support -> Enhanced IDE/MFM
>
> Any suggestions?

You also need to enable the actual IDE controller used by your computer
(the Enhanced IDE/MFM setting is just an option that will make the IDE
controllers visible, but as such it does not cause any
controller-specific code to be compiled). If in doubt, enable all IDE
controllers, boot, read the logs, then only keep the controller which
you really use.

Note that if you have a sufficiently recent hardware, your IDE
controller will in fact be a SATA controller, and your root partition
will become /dev/sda3, this requires a few changes in /etc/fstab that
are unfortunately incompatible with a previous installation.

--
                                                 Gilles.



