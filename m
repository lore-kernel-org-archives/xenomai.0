MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mZaok/xqUy"
Content-Transfer-Encoding: 7bit
Message-ID: <17615.21395.514226.428141@domain.hid>
Date: Tue, 1 Aug 2006 15:13:55 +0200
Subject: Re: [Xenomai-help] Beginner's question / testsuite / latency
In-Reply-To: <200607312249.09615.bidsonux@domain.hid>
References: <442248c90607201417m24729b7cs23a8b82b719ff1cc@domain.hid>
	<17613.60380.820599.627459@domain.hid>
	<1154355564.5015.12.camel@domain.hid>
	<200607312249.09615.bidsonux@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Julien Heyman <bidsonux@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>


--mZaok/xqUy
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Julien Heyman wrote:
 > Some good news from my side :
 > I did the same on my EPIA box (added Option "NoAccel" in the Device section 
 > referring to the Trident video driver) and since then the latency test works 
 > like a charm. Zero overrun, and a stable max value (around 50 microseconds), 
 > even when I launch multiple heavy applications at the same time.
 > Display performance has obviously taken a bit hit, but this is not my main 
 > concern for now.
 > Thanks for the tip, there is no way I would have figured that one out by 
 > myself ;)

Maybe this tip deserves an entry in the TROUBLESHOOTING file?
-- 


					    Gilles Chanteperdrix.

--mZaok/xqUy
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-x-noaccel.diff"
Content-Transfer-Encoding: 7bit

Index: TROUBLESHOOTING
===================================================================
--- TROUBLESHOOTING	(revision 1403)
+++ TROUBLESHOOTING	(working copy)
@@ -218,6 +218,17 @@
 
 ______________________________________________________________________
 
+Q: I am seeing high latency spots when running under X-window, what 
+   can I do?
+
+A: Try disabling hardware acceleration in the X-window server 
+   configuration file; in the "Device" section of /etc/X11/XF86Config-4,
+   add the following line:
+
+   Option "NoAccel"
+
+______________________________________________________________________
+
 Q: Xenomai HAL's initialization fails with error: -1 no such device
 
 A: Dumping the kernel message log using "dmesg" will likely give you

--mZaok/xqUy--

