From: Paul <paul_c@domain.hid>
Subject: Re: [Xenomai-help] isa reading
Date: Sat, 27 Jan 2007 11:11:54 +0000
References: <81707.56382.qm@domain.hid>
In-Reply-To: <81707.56382.qm@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701271111.54531.paul_c@domain.hid>
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


Hi Mani

On Friday 26 January 2007 15:40, mani bhatti wrote:
> Hi all
> I want to know Which function are most appropriate for reading and writing
> to a memory mapped isa card if one is writing a kernel module for
> isa.Thanks.

Take a look at: http://lwn.net/images/pdf/LDD3/ch09.pdf and:
http://www.xml.com/ldd/chapter/book/ch08.html

If you need specific examples of usage, you can't go far wrong by looking at 
the kernel sources under drivers/*


Regards, Paul.


