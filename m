Date: Wed, 12 Nov 2014 21:21:38 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141112202138.GH17476@sisyphus.hd.free.fr>
References: <314E5ECDAA86314791309FA670550F89C676CD2D@SINTEFEXMBX05.sintef.no>
 <20141111140230.GA17476@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676CE2D@SINTEFEXMBX05.sintef.no>
 <314E5ECDAA86314791309FA670550F89C676E884@SINTEFEXMBX05.sintef.no>
 <20141112134531.GP17476@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676EB35@SINTEFEXMBX05.sintef.no>
 <20141112191631.GJ24110@csclub.uwaterloo.ca>
 <314E5ECDAA86314791309FA670550F89C676F324@SINTEFEXMBX05.sintef.no>
 <20141112200125.GG17476@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676F3A9@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C676F3A9@SINTEFEXMBX05.sintef.no>
Subject: Re: [Xenomai] xeno_16550A driver install problems.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Terje =?utf-8?Q?Fr=C3=B8ysa?= <Terje.Froysa@sintef.no>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On Wed, Nov 12, 2014 at 08:08:10PM +0000, Terje Frøysa wrote:
> Thanks a lot for you support Gilles,
> 
> I have not have time to do any practical sw work since I received your patch.
> If the patched xeno_16550A does not require further labor in providing UART clocks it is of great interest.

Well, even if you need to enable the clocks, it just means writing a
few bits to a few registers, this is not very complicated, of
course, the layers of generic software around it make it a bit more
complicated than that, but not much more.

As for testing the patch, it should have taken less than 5 minutes.

-- 
					    Gilles.

