From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15789.41232.811477.590348@domain.hid>
Date: Wed, 16 Oct 2002 19:25:36 +0200
Subject: [Adeos-main] Candidate patches 2.5r2c4 & 2.4r5c4
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: <adeos-main.nongnu.org>
List-Unsubscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.nongnu.org/pipermail/adeos-main/>
To: adeos-main@gna.org

Candidate patches 2.5r2c4 (for 2.5.41) and 2.4r5c4 (for 2.4.19) are
available in the CVS (*).

Focus made on reducing interrupt latency (UP/SMP) and fixing races in
multi-domain SMP.

(*) See the documentation for a small change in the adattr_t struct
passed to adeos_register_domain() ("entry" parameter). The example
code has been updated accordingly.

Regards,

Philippe.


