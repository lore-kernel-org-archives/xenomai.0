MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18251.57085.191543.603085@domain.hid>
Date: Tue, 27 Nov 2007 10:10:21 +0100
In-Reply-To: <474ADEDB.3040700@domain.hid>
References: <474ADEDB.3040700@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] Xenomai v2.4-rc7
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-help <xenomai@xenomai.org>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
 > 	[arm]
 > 
 > 	Upgrade Adeos support to the 1.8 series.

A few more words about this: in this new patch, the boards specific code
was adapted to the new "flat log", which concretely means that all
boards now have to account for lost linux timer interrupts. This new
patch also contains a new ARM sub-architecture, the IMX. And finally,
Xenomai 2.4-rc7 contains a fix for the issue with context switches with
iwmmxt fpu. 

Please give it a try if you can.

-- 


					    Gilles Chanteperdrix.

