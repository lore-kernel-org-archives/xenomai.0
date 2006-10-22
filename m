Message-ID: <453B4816.4010007@domain.hid>
Date: Sun, 22 Oct 2006 12:29:42 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] switchtest FPU register error on PPC 2.6.18 
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hello,

I just realized the error message:

   Error after context switch from task 8(rtup-8) to task
   10(rtup_ufpp-10), FPU registers were set to 1000 (maybe task
   sleeper_ufps-0)

when running "switchtest" on an PPC under Linux 2.6.18 with Xenomai head 
of SVN. I have attached the full output log. Can some tell me what went 
exactly wrong and where I should start looking at?

Thanks.

Wolfgang.



