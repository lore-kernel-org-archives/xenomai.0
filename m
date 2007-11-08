From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18227.38764.158695.121660@domain.hid>
Date: Fri, 9 Nov 2007 00:10:36 +0100
Subject: [Xenomai-core] ipipe_pin_range_globally.
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


Hi,

In the process of updating the I-pipe patch for ARM, I have written
ipipe_pin_range_globally. But now that I look at the place where
ipipe_pin_range_globally is called, I see that it is called only upon
memory mapping in the vmalloc area, should not it be called also when
memory is unmapped ? Or maybe we should add an
ipipe_unpin_range_globally ?

It would allow me to remove this check_kvm_seq stuff in the middle of
switch_mm when CONFIG_IPIPE is enabled.

-- 


					    Gilles Chanteperdrix.

