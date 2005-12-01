From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17294.60277.41131.894374@domain.hid>
Date: Thu, 1 Dec 2005 13:24:21 +0100
Subject: RE: [Xenomai-help] Problem building MVM: "error: The X11 library
	'-lX11' could not be found"
In-Reply-To: <8DF1258D5F0FC94EBF5810BF2C7BF2FB3FFD4A@ILEX5.IL.NDS.COM>
References: <8DF1258D5F0FC94EBF5810BF2C7BF2FB3FFD4A@ILEX5.IL.NDS.COM>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Ashri, Sarit" <Sashri@domain.hid>
Cc: xenomai@xenomai.org

Ashri, Sarit wrote:
 > 2. compile Xenomai without Simulator support and then try installing the
 > simulator separately?
 > BTW when I try to install the simulator separately:
 > I ran sim/configure it passed and so did make and make install of the
 > simulator directly in sim directory, but when I tried to compile the
 > demos with gcic (make sim) I received the error message:
 > "gcic:instrumenter/compiler is missing -- please check your
 > installation."
 > So I thought this might not be the correct way to do it. Maybe I should
 > continue on this
 > road?

In the course of building "gcic", the instrumenting compiler, a patched
version of gcc is built and need to be installed on your system. If you
do not have the proper rights, this installation will fail, and the
compilation will continue and fail when "gcic" is first needed, with the
error message you are seeing.

The cure is simple: go to the sim/gcic directory and run "make install",
as root.

-- 


					    Gilles Chanteperdrix.

