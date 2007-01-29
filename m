Message-ID: <b647ffbd0701290832n61458b91v51e48d88a0cfd473@domain.hid>
Date: Mon, 29 Jan 2007 17:32:59 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] BUG: unable to handle kernel paging request
In-Reply-To: <1170087442.24120.6.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1169811995.462.13.camel@domain.hid>
	<1169827668.3346.61.camel@domain.hid>
	<b647ffbd0701261046m52172774lf5a7b4d08e090583@domain.hid>
	<1170087442.24120.6.camel@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Victor Shulyak <V.I.Shulyak@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Victor,

Philippe suggested the following patch. Have you applied it /
recompiled / installed a new kernel ? So, please, give us a yes/no
answer on whether it helps to solve the problem.


--- arch/i386/kernel/entry.S~   2006-12-16 13:32:29.000000000 +0100
+++ arch/i386/kernel/entry.S    2007-01-26 23:44:59.000000000 +0100
@@ -1032,7 +1032,7 @@
       RING0_INT_FRAME
       pushl $0                        # no error code
       CFI_ADJUST_CFA_OFFSET 4
-       pushl $do_divide_error
+       PUSH_XCODE(do_divide_error)
       CFI_ADJUST_CFA_OFFSET 4
       jmp error_code
       CFI_ENDPROC


-- 
Best regards,
Dmitry Adamushko

