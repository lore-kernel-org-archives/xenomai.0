From: Kurijn Buys <Kurijn.Buys@open.ac.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 8 Jan 2015 12:00:34 +0000
Message-ID: <31F55A66-200A-4CDE-872A-1AD01672F9CA@open.ac.uk>
MIME-Version: 1.0 (Apple Message framework v1283)
Subject: [Xenomai] externally triggered asynchronous = faster multiple
	channel acquisition?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Hi,

Having experimented with analogy's synchronous acquisition on a Pentium 4 w=
ith a NI PCI card, using the a4l_sync _read function with success,
I would like to record multiple channels now.

I've managed to do that by simply executing separate synchronous acquisitio=
n functions for each channel, but that significantly increases the acquisit=
ion time (compared to 1 channel).
So I supposed that the best performances could be reached with an asynchron=
ous acquisition in that case...  Is that correct?
And is it also possible to acquire data asynchronously by an external fast =
clocked function (so with the scan counter ".stop_arg" set to 1), or would =
that slow down the process?

I've tried to use the a4l_async_read and a4l_poll functions, basing myself =
on the cmd_read.c code, but I cannot get it to work right away...
(But before considering those problems, I thought that it is worth assuring=
 myself on the first questions!)

Thanks in advance for your advice!

Best regards,

Kurijn
-- The Open University is incorporated by Royal Charter (RC 000391), an exe=
mpt charity in England & Wales and a charity registered in Scotland (SC 038=
302). The Open University is authorised and regulated by the Financial Cond=
uct Authority.

