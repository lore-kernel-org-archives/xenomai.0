MIME-Version: 1.0
Date: Tue, 18 Dec 2012 15:35:03 +0100
Message-ID: <CAPpP=rPyuKK5Sr9mxXFw+KMhD3g1F+Q5=d8Xm7nQS6hF5OCebw@mail.gmail.com>
From: alex alex <duch.alexandre@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] [Page fault - POSIX skin] Interraction between malloc en
	nanosleep
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

The attached program shows an interraction bug between malloc and nanosleep.
The use of these two functions in a rt thread leads to a page fault.
The dmesg output is:

Xenomai: Switching test to secondary mode after exception #14 from
user-space at 0xb760393e (pid 30730)

I need to remove this switch because it prevents me to used the
rtdm_sem_down function ( which return -1) in my RTDM driver and I guess it
must also deteriorate the real time performance of my application.

Thanks for your help.

Alex.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Bug_switch.bz2
Type: application/x-bzip2
Size: 1208 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20121218/66ca891=
5/attachment.bin>
