From: Saverio Labozzetta <saverio.labozzetta@domain.hid>
In-Reply-To: <22619.80.59.183.97.1161252139.squirrel@domain.hid>
References: <22619.80.59.183.97.1161252139.squirrel@domain.hid>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 12:57:09 +0200
Message-Id: <1161255429.16347.30.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: Terminology and versions
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: javiroman@domain.hid, rtai <rtai@domain.hid>, xenomai@xenomai.org
Cc: rtai <rtai@domain.hid>


On Thu, 2006-10-19 at 06:02 -0400, javiroman@domain.hid wrote:
> Hi all,
> 
> I'm looking for help with a lot of terminology and version numbering which
> I don't understand. The following is a summary of my knowledge about RTAI,
> Fusion, Xenomai, ADEOS terms.
> 
> There was two lines of development:
> 
> 1. RTAI/Classic:
>         Etna: 24.1.11 [closed branch]
>         Stromboli: 24.1.12, 24.1.13 [closed branch]
>         Kilauea: 3.0 (3.0r2, 3.0r3, 3.0r4, 3.0r5) [closed branch]
>         Vesuvio: 3.1 (3.1r2) [closed branch]
>         Vulcano: 3.2 (first support of Linux kernels 2.4.x and 2.6.x series)
>                  3.3
>                  3.4 [current stable version]
> 
>         Magma: every RTAI classic development version will be named magma
> until it is released. So it is the current cvs latest release. 3.4
> with new  (3.5 version??)
> 
> 2. RTAI/Fusion: it is RTAI using ADEOS as hardware abstraction layer, and
> provides hard real-time support in user-space like LXRT sub-system in
> RTAI/Classic approach.
> 

AFAIK fusion was using the linux domain priority boosting scheme 
caming from the Xenomai project, the LXRT real time scheduler generating
the helper tasks is RTAI bound and it was not used in Fusion.

>         RTAI/Fusion v0.8 (first productive testing version)
>         ...
> 
>         RTAI/Fusion v0.9.1 (last version joined to DIAPM's project)
> 
> 
> The second line of development was gave up supporting from DIAPM.
> Nevertheless:
> 
> Xenomai environment: Absorbed the development of RTAI/Fusion as an
> independent project. Xenomai 2.0 was RTAI/Fusion 1.0.
> 
AFAIK Fusion was a project where the experience of the RTAI project and
of the Xenomai project did melt for a while, then different views on how
was better to continue the development makes the people following
Xenomai project going by their way;
so they use again the name they were using before the merge was
attempted. 
  Saverio
> 
> Is this information correct?
> Please, can anybody help me to complete/correct this terms and versions?
> 
> Thanks in advance and best regards.
> 
> --
> Javi Roman
> 
> _______________________________________________
> RTAI mailing list
> RTAI@rtai.org
> https://mail.rtai.org/cgi-bin/mailman/listinfo/rtai


This message contains information that may be privileged or confidential and is the property of the Capgemini Group. It is intended only for the person to whom it is addressed. If you are not the intended recipient,  you are not authorized to read, print, retain, copy, disseminate,  distribute, or use this message or any part thereof. If you receive this  message in error, please notify the sender immediately and delete all  copies of this message.


