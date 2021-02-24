MIME-Version: 1.0
From: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Date: Wed, 24 Feb 2021 15:50:33 +0200
Message-ID: <CAPm8-H544EFyF+LwuyXoSp7+VmKBoHmD_DDWxT+tJA6eoszY=Q@mail.gmail.com>
Subject: Question: trace_printk() in xenomai?
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Dear friends,

  Is it safe to use trace_printk() in xenomai
or it does a domain switch?
Until now I have used only rtdm_printk() and raw_printk().

  Another question: is raw_printk() only on arm (and not on arm64, nor x86_64)?

Thank you,
L-C.

