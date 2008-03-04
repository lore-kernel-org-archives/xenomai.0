Message-ID: <d3f72a390803040449i2111e0a7r5b0acf3d62674931@domain.hid>
Date: Tue, 4 Mar 2008 13:49:36 +0100
From: "axel axel" <softaxel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_25493_31275329.1204634976836"
Subject: [Xenomai-core] USING FLOATING POINT KERNEL SIDE
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

------=_Part_25493_31275329.1204634976836
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

i want to use floating point in module with some xenomai task.
I understand that i can use floating point if i implement some functions (
xnarch_fpu_init...... ).

Ok for this but if i try to compile the module, the compiler ( gcc 3.4.3 for
arm ) says me there are unresolved symbol like __mulsf3.

Have you ever try a xenomai task that use floating point in kernel space ?


Thanks a lot for your help.


Roberto Bielli

------=_Part_25493_31275329.1204634976836
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>i want to use floating point in module with some xenomai task. <br>I understand that i can use floating point if i implement some functions ( xnarch_fpu_init...... ).<br><br>Ok for this but if i try to compile the module, the compiler ( gcc 3.4.3 for arm ) says me there are unresolved symbol like __mulsf3.<br>
<br>Have you ever try a xenomai task that use floating point in kernel space ?<br><br><br>Thanks a lot for your help.<br><br><br>Roberto Bielli<br>

------=_Part_25493_31275329.1204634976836--

