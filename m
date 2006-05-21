From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Xenomai v2.2-rc2
Date: Sun, 21 May 2006 16:42:40 +0200
References: <446F852B.7090400@domain.hid>
In-Reply-To: <446F852B.7090400@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605211642.40509.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
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

Am Samstag, 20. Mai 2006 23:07 schrieb Philippe Gerum:
> Here is the second release candidate for the v2.2 branch. Short log
> follows:
Could you please apply the patch below to make xeno-test send e-mails to 
xenomai-data@domain.hid.

I am unsure whether setting sentby='xenotest.sender@domain.hid' is a good 
idea. Or is this a way to accept e-mails from unkown senders? In any way I 
think it would be nice if one could accept xeno-test messages from 
unsubscribed senders.

I really would like to collect some real data.

Thanks in advance.

Niklaus Giger

Index: scripts/xeno-test.in
===================================================================
--- scripts/xeno-test.in        (Revision 1135)
+++ scripts/xeno-test.in        (Arbeitskopie)
@@ -19,7 +19,7 @@
                name can be full or relative pathname
   -v           verbose
   -M <email>   sends output to given addr
-  -m           sends output to xenotest.output@domain.hid
+  -m           sends output to xenomai-data@domain.hid
   -U <url>     uploads output to given URL

   # following options are passed thru to latency
@@ -167,7 +167,7 @@
 logprefix=/tmp/        # someplace usually there
 prepost=       # command to run pre, and post test (ex ntpq -p)

-email='xenotest.output@domain.hid'      # until formalized
+email='xenomai-data@domain.hid'
 sentby='xenotest.sender@domain.hid'
 url=
 sendit=                # send it by m-mail, u-url

