From: Stephan Zimmermann <s.zimmermann@domain.hid>
Date: Fri, 9 Dec 2005 16:58:39 +0100
References: <439995C0.6030006@domain.hid>
In-Reply-To: <439995C0.6030006@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512091658.39610.s.zimmermann@domain.hid>
Subject: [Xenomai-help] Boot problem V2.0.1 with Kernel 2.6.12
Reply-To: s.zimmermann@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello all,
I am facing a Problem with Xenomai 2.0.1 on Kernel 2.6.12. Based on my working 
config, I have patched the Kernel and recompiled. Now the System hangs at 
startup. There is no errormessage or so.

---snip---
Starting hotplug subsystem
	pci
---snap---

It is a Debian 3.1 system, running on a Centrino Notebook. 

I tried to disable PCI Hotplugging, but it gives me the same result. Disabling 
ADEOS Support gives me back my working System. 
And there is also something confusing the kernel build system, since patching 
it always recompiles every single file, making debugging not much fun :(

Are there any suggestions on tracking this down?


Have a nice Weekend,
Stephan



