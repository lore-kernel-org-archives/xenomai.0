Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <4B3169C1.7020106@domain.hid>
Date: Wed, 23 Dec 2009 01:52:17 +0100
From: Alexis Berlemont <berlemont.hauw@domain.hid>
MIME-Version: 1.0
References: <36718863-7B28-4FD1-8FE4-1F710EB9E7E4@domain.hid>
In-Reply-To: <36718863-7B28-4FD1-8FE4-1F710EB9E7E4@domain.hid>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] cmd_write
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Schaal <sschaal@domain.hid>
Cc: xenomai@xenomai.org

Hi,

Stefan Schaal wrote:
> Hi,
> 
>   I have been trying to test the functionality of the analogy_ni_pcimio driver on a NI6259 board. I am using a linux kernel 2.6.29.5 with the xenomai-head (rc5). Doing an a4l_sync_write to an analog output channel works fine. Now I am trying to use the cmd structure for writing to the same analog output channel, as done in the cmd_write progam (whose source I found in <xenomai_root>/src/util/analogy/cmd_write.c .
> 
> But I am getting the error as indicated below. Any idea why this happens? My own programming gets the same error.
> 
> Thanks a lot!
> 
> -Stefan
> 
> 
> unix> /usr/xenomai/bin/cmd_write -v -d analogy0 -s 1 -c 0 -S 1
> 
> cmd_write: device analogy0 opened (fd=0)
> cmd_write: basic descriptor retrieved
> 	 subdevices count = 14
> 	 read subdevice index = 0
> 	 write subdevice index = 1
> cmd_write: complex descriptor retrieved
> cmd_write: channel 0
> 	 ranges count = 3
> 	 range's size = 16 (bits)
> cmd_write: scan size = 2
> cmd_write: size to write  = 2
> cmd_write: command successfully sent
> cmd_write: triggering failed (ret=-32)
> 
Is there any kernel error messages ? Could you give us the last few 
lines of `dmesg` ?
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 
Alexis.

