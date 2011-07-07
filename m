Message-ID: <4E16296B.4080209@domain.hid>
Date: Thu, 07 Jul 2011 23:47:23 +0200
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Problems with gcc 4.6.0 (rt_task_shadow fails with
	ENOSYS)
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

When compiling kernel 2.6.37.3 and xenomai 2.5.6 with "gcc version 4.6.0 
20110530 (Red Hat 4.6.0-9) (GCC)", programs fail with -ENOSYS in 
rt_task_shadow. If compiled with "gcc version 4.5.1 20100924 (Red Hat 
4.5.1-4) (GCC)" everything works as expected.

Regards

Anders Blomdell


-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden


