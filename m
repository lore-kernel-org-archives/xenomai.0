Message-ID: <894886ec0807242231t44d37de6q4c23b02ae67d3bb8@domain.hid>
Date: Thu, 24 Jul 2008 22:31:43 -0700
From: "Rob Wheeler" <wheeler@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] nofastsem
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

I've been running revision 4007 from the Xenomai svn trunk
successfully, and I recently tried building and running a more recent
revision (4060).  The kernel and user code all build fine, but when I
try to run a Xenomai application I get a message saying the userland
wants fastsem and the kernel has nofastsem.  I'm not able to locate an
option in the kernel (2.6.24.3) to enable fastsem, nor do I see an
option in Xenomai's menuconfig to allow nofastsem.  What am I missing?

Thanks in advance...

-Rob

