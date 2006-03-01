From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17413.58984.450192.400581@domain.hid>
Date: Wed, 1 Mar 2006 19:22:32 +0100
Subject: RE: [Xenomai-core] C++ Support for VxWorks Skin of Xenomai?
In-Reply-To: <FA9961D07FD27B4EB6058C0F35F3D0D17CD982@domain.hid>
References: <FA9961D07FD27B4EB6058C0F35F3D0D17CD982@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Wu, John" <John.Wu@domain.hid>
Cc: xenomai@xenomai.org

Wu, John wrote:
 > Jan,
 > 
 > We don't know how to compile the VxWork skin of xenomai to support C++
 > code.  We need some help!

Unless we are missing something, there is no need to compile vxworks
skin in a special way in order to support C++ code.

Xenomai vxworks skin functions are declared extern "C" in
vxworks/vxworks.h when it is included in C++ code.
So, if you want to call vxworks function from C++ code, all you have to
do is to include vxworks/vxworks.h.

-- 


					    Gilles Chanteperdrix.

