Message-ID: <2b490f270809260610w4573446x507ef059d4b3ca0b@domain.hid>
Date: Fri, 26 Sep 2008 15:10:35 +0200
From: "Dehann Fourie" <dehann.fourie@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_16343_18422410.1222434635287"
Subject: [Xenomai-help] Segmentation Fault
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_16343_18422410.1222434635287
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I'm having trouble with a segmentation fault in my real-time application.
The problem seems to occur when I use large amounts of memory. The
application works fine when I don't try to populate the large arrays.

I have tried changing parameters in the real time create call, but this
didn't work. The error message is:

Xenomai: Switching nav to secondary mode after exception #14 from user-space
at 0x804ad13 (pid 1938)
nav [1938]; segfault at 26756e50 eip 0804ad13 esp b762ac28 error 6
Segmentation fault

This is from text mode.

Thanks in advance
Dehann

------=_Part_16343_18422410.1222434635287
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi,<br><br>I&#39;m having trouble with a segmentation fault in my real-time application. The problem seems to occur when I use large amounts of memory. The application works fine when I don&#39;t try to populate the large arrays.<br>
<br>I have tried changing parameters in the real time create call, but this didn&#39;t work. The error message is:<br><br>Xenomai: Switching nav to secondary mode after exception #14 from user-space at 0x804ad13 (pid 1938)<br>
nav [1938]; segfault at 26756e50 eip 0804ad13 esp b762ac28 error 6<br>Segmentation fault<br><br>This is from text mode.<br><br>Thanks in advance<br>Dehann<br></div>

------=_Part_16343_18422410.1222434635287--

