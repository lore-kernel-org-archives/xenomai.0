Message-ID: <482193F0.6000401@domain.hid>
Date: Wed, 07 May 2008 13:35:12 +0200
From: "Hillier, Gernot" <gernot.hillier@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [patch] prevent endless loop in prepare-kernel.sh
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

Hi there!

Just noted that prepare-kernel.sh ends up in an endless loop when you 
use "--default" together with an invalid "--arch" parameter.

Here's a small patch. Please apply. TIA!

Index: scripts/prepare-kernel.sh
===================================================================
--- scripts/prepare-kernel.sh	(Revision 3753)
+++ scripts/prepare-kernel.sh	(Arbeitskopie)
@@ -327,6 +327,7 @@
     *)
        echo "$me: unsupported architecture: $linux_arch" >&2
        linux_arch=
+      usedefault=
        ;;
     esac
     if test \! x$linux_arch = x; then
@@ -384,6 +385,7 @@
        fi
        if test \! -r "$adeos_patch"; then
           echo "$me: cannot read Adeos patch from $adeos_patch" >&2
+         usedefault=
           adeos_patch=
        fi
     done

-- 
With kind regards,
Gernot Hillier

Siemens AG, CT SE 2
Corporate Competence Center Embedded Linux

