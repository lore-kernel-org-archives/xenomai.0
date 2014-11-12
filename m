Date: Wed, 12 Nov 2014 20:06:52 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141112190652.GE17476@sisyphus.hd.free.fr>
References: <54626A2E.6020307@free.fr>
 <20141111200358.GL17476@sisyphus.hd.free.fr>
 <54635DD7.9090800@free.fr>
 <20141112133447.GO17476@sisyphus.hd.free.fr>
 <54636E3F.1070207@free.fr>
 <20141112143026.GT17476@sisyphus.hd.free.fr>
 <54637AD2.3080507@free.fr>
 <20141112152940.GX17476@sisyphus.hd.free.fr>
 <54638058.10509@free.fr>
 <20141112185301.GH24110@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141112185301.GH24110@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] IMX kernel 3.0.35_4.1.0 +
 adeos-ipipe-3.0.43-mx6q-1.18-14 -> very slow boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Thierry Bultel <tbultel@free.fr>, nicolas Mabire <nicolas.mabire@basystemes.fr>, xenomai@xenomai.org

On Wed, Nov 12, 2014 at 01:53:01PM -0500, Lennart Sorensen wrote:
> On Wed, Nov 12, 2014 at 04:44:24PM +0100, Thierry Bultel wrote:
> > This is all what I get when adding earlyprintk=serial,ttymxc1,115200
> > to the bootargs:
> 
> I have never used earlyprintk with an argument before.
> 
> I just set console= correctly, and then add earlyprintk as a seperate
> argument, and it does the right thing (assuming you configure the right
> UART for debuging if your platform requires that).

Thierry uses the documented syntax.

-- 
					    Gilles.

