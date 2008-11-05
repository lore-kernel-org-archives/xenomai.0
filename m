Message-ID: <67b6b3430811050947i32c9fb95i91fa9207229cf254@domain.hid>
Date: Wed, 5 Nov 2008 09:47:24 -0800
From: "Mark Saiia" <mark.saiia@domain.hid>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D5332F3@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_4314_12784806.1225907244650"
References: <51CAD0CE1504444DBE77CBBE51A0135D533259@domain.hid>
	<490ECE11.208@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D53325A@slcmail.slc.mew.int>
	<490F2F23.2080307@domain.hid>
	<67b6b3430811031237v4cfba0c9sf63e40a697f3da58@domain.hid>
	<49101BFF.3060908@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D5332B4@domain.hid>
	<49109BFC.3080000@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D5332F3@domain.hid>
Subject: Re: [Xenomai-help] fpu context switch issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_4314_12784806.1225907244650
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I modified the example to use pthreads instead of Xenomai and did not
observe the erroneous behavior.  I kept the same Makefile so all the same
libraries were linked in, the only alteration was in the code.  (I was using
the same Xenomai patched kernel).  Furthermore, I did not observe any error
messages in the kernel log when FPU was disabled.

Thanks,

Mark

------=_Part_4314_12784806.1225907244650
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>I modified the example to use pthreads instead of Xenomai and did not observe the erroneous behavior.&nbsp; I kept the same Makefile so all the same libraries were linked in, the only alteration was in the code.&nbsp; (I was using the same Xenomai patched kernel).&nbsp; Furthermore, I did not observe any error messages in the kernel log when FPU was disabled.<br>
<br>Thanks,<br><br>Mark<br><br>

------=_Part_4314_12784806.1225907244650--

