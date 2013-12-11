Message-ID: <52A88B17.8050707@steinkuehler.net>
Date: Wed, 11 Dec 2013 09:56:07 -0600
From: Charles Steinkuehler <charles@steinkuehler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] ARM 3.12 Kernel Support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I am successfully using Xenomai with a 3.8.13 kernel on the BeagleBone,
but there are no drivers for the on-chip GPU available.  TI is
apparently skipping the 3.8 kernel series, and now has drivers available
for 3.12.

So, if I want Xenomai and GPU acceleration on the BeagleBone, I either
need to back-port the TI GPU drivers from 3.12 to 3.8, or get Xenomai
working on a 3.12 ARM kernel.

I figure eventually the Xenomai patches will be updated for 3.12, but I
might be able to help move things along.  Is anyone actively working on
3.12 support, or is development still centered around 3.10?  Is the
master branch from http://git.xenomai.org/ipipe.git/ the most
appropriate branch to try and forward-port?  It looks like the 3.10
branches have more recent commits...

-- =

Charles Steinkuehler
charles@steinkuehler.net

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20131211/6a89ed8=
4/attachment.sig>
