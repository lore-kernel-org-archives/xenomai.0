From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Subject: Re: [Xenomai-core] [pipe.c] hairy synchronization -> "flush the
	output queue upon closure"
Date: Fri, 18 Nov 2005 12:53:03 +0100
References: <OFC82948A5.5D809872-ONC12570BD.0030CA81-C12570BD.003576C6@domain.hid>
In-Reply-To: <OFC82948A5.5D809872-ONC12570BD.0030CA81-C12570BD.003576C6@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511181253.04123.Sebastian.Smolorz@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

> Hi,
>
> I failed to find the original message from Sebastian that led to the
> following change:
>
> -----
> 2005-11-09  Philippe Gerum  <rpm@xenomai.org>
>
>         * nucleus/pipe.c (xnpipe_disconnect): Flush the output queue
>         upon closure. Issue spotted by Sebastian Smolorz.
>         (xnpipe_release): Flush the input queue upon closure.
> -----

https://mail.gna.org/public/xenomai-core/2005-11/msg00058.html

The problem was here that after a RT task and a Linux user space program had 
closed both ends of the pipe the contents remained in the pipe. So when the 
pipe was opened again the old content was read.

Sebastian

