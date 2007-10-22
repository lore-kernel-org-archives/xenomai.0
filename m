Message-Id: <200710221638.l9MGcGH8007758@domain.hid>
From: "Patrick" <kpa_info@domain.hid>
Date: Mon, 22 Oct 2007 18:38:10 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <2ff1a98a0710120614o2a96aba0uf78adab3b2f712a1@domain.hid>
Subject: [Xenomai-core] Xenomai on Xscale (Linux 2.6.20)
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

I am trying to found the bug in xenomai for PXA270 machine (xenomai 2.3.4,
ipipe 1.7-06 and kernel 2.6.20).

I have localised than when rt_task_create call __ipipe_restore_pipeline_head


