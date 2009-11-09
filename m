MIME-Version: 1.0
Date: Mon, 9 Nov 2009 14:59:18 +0530
Message-ID: <200911091459.18335.anisha.kaul@domain.hid>
From: Anisha Kaul <anisha.kaul@domain.hid>
content-type: text/plain; charset=us-ascii
content-transfer-encoding: 7bit
content-disposition: inline
Subject: [Xenomai-core] Function for writing to serial port through Xenomai
	API
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Dear all,

I know that outb() being a linux system call can be used to write to the 
serial/parallel ports. Currently I am working on a real time operating system 
with Xenomai and a micro kernel. If I use outb() for port access, control 
will shift to the soft-real time linux which I don't want. Is there any way I 
can access ports using (Xenomai) functions rather than the linux system 
calls ?

Thanking you in anticipation,
Anisha Kaul

-------------------------------------
Hi-Tech Gears Limited, Gurgaon, India





