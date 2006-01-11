From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17349.34151.559777.835174@domain.hid>
Date: Wed, 11 Jan 2006 23:23:35 +0100
Subject: Re: [Xenomai-help] PCI Framegrabber real-time driver
In-Reply-To: <200601111921.05544.lbocseg@domain.hid>
References: <200601111655.57020.lbocseg@domain.hid> <43C56124.4040407@domain.hid>
	<200601111921.05544.lbocseg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

Rodrigo Rosenfeld Rosas wrote:
 > The memory is obtained passing the kernel the parameter "mem=510M". So, the 
 > kernel won't use the last 2 Mb. I know it is not an elegant solution but it's 
 > pretty simple and I can't imagine another one...

Another one, suggested in "Linux devices drivers", chapter 8, is to
allocate your memory at boot time with one of the alloc_bootmem
functions. Of course, in order to call these functions, a small part of
your driver need to run in the kernel itself.

For more details, see:
http://lwn.net/Kernel/LDD3/

-- 


					    Gilles Chanteperdrix.

