From: Arnout Vandecappelle <arnout@domain.hid>
Date: Wed, 21 Dec 2011 15:26:08 +0100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201112211526.08983.arnout@domain.hid>
Subject: [Xenomai-help] Xenomai and SMP load balancing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

 [Please keep me in CC]

 Hoi all,

 I have a Xenomai application that I run on an SMP processor (i3 or i5).  
It takes about 90% load on one of the cores (cpu0).  The rest of the system 
is usually idle, except for occasional runs of some compute-intensive batch 
processes (that run in the non-RT Linux domain).

 The problem is that the Linux load balancer doesn't know about the
Xenomai thread.  It therefore tends to select cpu0 as well for the
batch processes.  That means that the batch processes take much longer
then needed.

 I can solve this by reserving one complete core for the Xenomai thread
(by setting /proc/xenomai/affinity to 1 and giving the isolcpus=0 at boot
time).  But this makes it difficult to move to a non-SMT platform, or
to run several Xenomai applications on different cores.

 Is there a better way to let the Linux load balancer take into account
the load of the Xenomai threads?

 Regards,
 Arnout

-- 
Arnout Vandecappelle                               arnout at mind be
Senior Embedded Software Architect                 +32-16-286540
Essensium/Mind                                     http://www.mind.be
G.Geenslaan 9, 3001 Leuven, Belgium                BE 872 984 063 RPR Leuven
LinkedIn profile: http://www.linkedin.com/in/arnoutvandecappelle
GPG fingerprint:  7CB5 E4CC 6C2E EFD4 6E3D A754 F963 ECAB 2450 2F1F

