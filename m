MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17357.6643.403829.486469@domain.hid>
Date: Tue, 17 Jan 2006 17:23:15 +0100
In-Reply-To: <43CD16C8.4000009@domain.hid>
References: <43CD16C8.4000009@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai-core] Re: --enable-linux-build
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > Hi Gilles,
 > 
 > I just tested your new build option. Maybe I'm using it the wrong way,
 > but I stumbled over two quirks:
 > 
 >  o "make install-nodev" fails as it tries to install the kernel without
 >    being root. Actually, I only wanted to install the user space part,
 >    how can I do this separately? Or is this rather a use-case for the
 >    standard build?

I did not think about this case. Any idea of what would be better ? Not
installing kernel when running "make install-nodev" ? Creating 
install-nokernel and install-nokernel-nodev targets ?

 > 
 >  o On every "make", the prepare-kernel script is executed -
 >    intentionally? Maybe it would be better to provide a dedicated make
 >    target to trigger the update.

prepare-kernel should be executed whenever any file or directory is
added in the ksrc and include dirs. On my own machine, prepare-kernel is
much shorter than the kernel build. So, I did not see this as an issue,
but I am ready to accept any better solution. Maybe it could depend on
maintainer mode ? Since the user-space will work automatically when
adding a file or directory only if maintainer mode is enabled.

-- 


					    Gilles Chanteperdrix.

