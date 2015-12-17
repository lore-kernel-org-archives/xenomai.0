References: <CABShy46jn=__wPaUqu5kJf8e=TtKbysjE31EWkXkBh4S-GdTAw@mail.gmail.com>
From: Charles Steinkuehler <charles@steinkuehler.net>
Message-ID: <56720825.4040008@steinkuehler.net>
Date: Wed, 16 Dec 2015 18:56:05 -0600
MIME-Version: 1.0
In-Reply-To: <CABShy46jn=__wPaUqu5kJf8e=TtKbysjE31EWkXkBh4S-GdTAw@mail.gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] How can i make driver for CAN Bus loopback with
 receive own message in xenomai rtos ported beaglebone black or white and
 raspberry pi
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 12/14/2015 8:36 AM, BHISHMAPALSINH THAKOR wrote:
> Respected sir,
> I working on can bus driver development on xenomai rtos ported  beagle bo=
ne
> black or white so please so please tell me about how can i make can bus
> rtdm driver on beagle bone black or white which ported with xenomai rtos.

I don't work with CAN, but the CAN controller on the BBB is apparently
fairly standard and I believe there is a CAN driver available for
Xenomai on x86.  You should be able to fairly easily modify the
existing driver to work with the BBB.

-- =

Charles Steinkuehler
charles@steinkuehler.net

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 196 bytes
Desc: OpenPGP digital signature
URL: <http://xenomai.org/pipermail/xenomai/attachments/20151216/681bc462/at=
tachment.sig>
