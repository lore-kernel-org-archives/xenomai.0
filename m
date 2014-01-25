Message-ID: <52E3F8F4.1030006@steinkuehler.net>
Date: Sat, 25 Jan 2014 11:48:36 -0600
From: Charles Steinkuehler <charles@steinkuehler.net>
MIME-Version: 1.0
References: <52E1D646.8050907@steinkuehler.net> <52E3FEEF.9050205@xenomai.org>
In-Reply-To: <52E3FEEF.9050205@xenomai.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] ARM/BeagleBone Thumb2 Kernels
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 1/25/2014 12:14 PM, Gilles Chanteperdrix wrote:
> On 01/24/2014 03:56 AM, Charles Steinkuehler wrote:
>>
>> I applied a similar if-then patch (see below) to the two Xenomai calls
>> that generate the linker errors, and the result is a working kernel.
> =

> Applied, thanks, I could reproduce the issue, and thinking about it
> having entry-common.o close to entry-arm.o should not bring any
> performance improvement in fact.

Thanks for looking into this!

I've been running the Thumb2 kernel a while with no apparent problems,
and it does seem to have improved the latency numbers even with all the
other suggested tweaks.  Thanks again for all the advice!

-- =

Charles Steinkuehler
charles@steinkuehler.net

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140125/a404d09=
d/attachment.sig>
