Message-ID: <894886ec0807202305n5bf0384w2357ea6ed64f5a36@domain.hid>
Date: Sun, 20 Jul 2008 23:05:39 -0700
From: "Rob Wheeler" <wheeler@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_70553_9971912.1216620339329"
Subject: [Xenomai-help] Problem with atomic_32.h when included from C++
	source
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

------=_Part_70553_9971912.1216620339329
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I'm seeing an issue when trying to compile a C++ application that includes
native/task.h.  It eventually winds up including atomic_32.h which has a
function xnarch_atomic_cmpxchg which takes a function argument named 'new'.
This conflicts with the C++ compiler's reserved keyword and generates
compiler warnings.

-R

------=_Part_70553_9971912.1216620339329
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hello,<br><br>I&#39;m seeing an issue when trying to compile a C++ application that includes native/task.h.&nbsp; It eventually winds up including atomic_32.h which has a function xnarch_atomic_cmpxchg which takes a function argument named &#39;new&#39;.&nbsp; This conflicts with the C++ compiler&#39;s reserved keyword and generates compiler warnings.<br>
<br>-R<br></div>

------=_Part_70553_9971912.1216620339329--

