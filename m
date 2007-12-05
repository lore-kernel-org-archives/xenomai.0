From: "Henk Geraads" <linux@domain.hid>
Date: Wed, 5 Dec 2007 09:43:11 +0100
Message-ID: <NGBBLNEOGLJIIJKLFLPFIEBPDFAA.linux@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <2ff1a98a0712040527k6f2c1439i52a5e2d9e756a3c5@domain.hid>
Subject: Re: [Xenomai-help] native pipe can not write
Reply-To: linux@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


Hi,

Does this mean I have to perform the following patch also in my system?

--- ksrc/skins/native/syscall.c	(revision 3195)
+++ ksrc/skins/native/syscall.c	(revision 3196)
@@ -2468,10 +2468,10 @@

 		if (size > 0)
 			__xn_copy_to_user(curr, buf, mbuf, size);
+
+		rt_queue_free(q, mbuf);
 	}

-	rt_queue_free(q, mbuf);
-
 	return (int)rsize;
 }


Br,

Henk Geraads

-----Oorspronkelijk bericht-----
Van: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Verzonden: dinsdag 4 december 2007 14:28
Aan: linux@domain.hid
CC: xenomai@xenomai.org
Onderwerp: Re: [Xenomai-help] native pipe can not write


On Dec 4, 2007 8:03 AM, Henk Geraads <linux@domain.hid> wrote:
>
> Hi,
>
> we are currently using a PXA270 board with kernel 2.6.15 with xenomai
2.2.2. We are having the same problem. We create a pipe like;
> rt_pipe_create(&dti_pipe_wr, "DTI_FROM_UART", FIFO_WR, 1000);
>
> i=rt_pipe_write(&dti_pipe_wr, data->dti_rcvbuf, 20, P_NORMAL)
>
> we got error = -ENOMEM?
>
> Is this the same error?

See this discussion thread:
https://mail.gna.org/public/xenomai-help/2007-12/msg00012.html

--
                                               Gilles Chanteperdrix



