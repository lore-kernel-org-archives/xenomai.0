Message-ID: <4409E37A.6090300@domain.hid>
Date: Sat, 04 Mar 2006 19:59:06 +0100
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] v2.1-rc4 RTDM bug
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

Ciao Jan!

It doesn't seem to make a difference if one uses
RTDM_IRQ_NONE or RTDM_IRQ_HANDLED.
With RTDM_IRQ_NONE the IRQ should be passed to linux,
right ? But it doesn't seem to happen - this brought
up the "top" problem I've posted a few days ago.

Best regards,
Hannes.

