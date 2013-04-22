MIME-Version: 1.0
In-Reply-To: <5174F4E3.8030603@grandegger.com>
References: <CAD1EtognG+9J_Bbo3x6AsBCJ4eU4SLrXQz=wDvJtFw0vCSZ8NQ@mail.gmail.com>
	<516BA7C4.1050403@grandegger.com>
	<CADVgf9nD4Qkaz54ba1PuKx0h1WkSkhPYQM9C0RU2LkE7aE96nQ@mail.gmail.com>
	<516E336C.1060509@xenomai.org>
	<CADVgf9=CJ0MQEpsub3g=bDZvxk3U3G1tDDvjvFm1jZRmke35fg@mail.gmail.com>
	<CAD1EtoiQm8rZtkDTjZK8Tq3xeDKHULjc7V6Stg=bZ9XpEp5o7w@mail.gmail.com>
	<516F9E87.6020002@grandegger.com> <516FA077.20400@grandegger.com>
	<CAD1EtoiZ05S5HXEvdq2+Sg6-1XbxHwMUpcVMrpYA6gv0JgLqJw@mail.gmail.com>
	<5171069C.3020909@grandegger.com>
	<CAMsuG6pte10W8AbABnwAzLnVKF6kTRv+M5m2o=JE6z6oT_Qc4g@mail.gmail.com>
	<5171A299.60905@grandegger.com>
	<CAD1Etoi3iFSyWA_z4ex9T9=mbtHQyCkd0zR4Yq3Lf6e1NCu+0g@mail.gmail.com>
	<5174F4E3.8030603@grandegger.com>
Date: Mon, 22 Apr 2013 09:40:17 -0400
Message-ID: <CAD1EtoiMu-XmrSXy=fJ58Bz=2g6P07CPkJ=9JdU-N_0Agx=QRg@mail.gmail.com>
From: "Daniel M. Drucker, Ph.D." <dmd@interactive-motion.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] patch to src/utils/can/rtcansend.c to support data
 from a file
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: xenomai@xenomai.org

> I still prefer a simple ascii base syntax describing the complete message.

Ok. What would you suggest? I'm not super-familiar with some of the
CAN stuff (like extended messages), so I'm not sure what would best
make sense.

> You want to change the delay between messages as well?

Yes, because often there are certain messages in the sequence that
cause the slave to stop listening for several milliseconds.

Daniel

