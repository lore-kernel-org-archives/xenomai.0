Date: Sun, 20 Sep 2015 10:07:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150920080758.GF22852@hermes.click-hack.org>
References: <CAFkYNwbawB8iHkJA51FpuQFDDY2aYBj2_aMontPadSBf=VZ8AA@mail.gmail.com>
 <20150919151106.GD22852@hermes.click-hack.org>
 <20150919151423.GE22852@hermes.click-hack.org>
 <CAFkYNwZSskEBYeHOK1UEXi7iGucm5x=O7wBB9YQ+1A_Gu9iGgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFkYNwZSskEBYeHOK1UEXi7iGucm5x=O7wBB9YQ+1A_Gu9iGgA@mail.gmail.com>
Subject: Re: [Xenomai] Installing xenomai libraries ARM OMAP4460
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: vibnwis <vibnwis@gmail.com>
Cc: xenomai@xenomai.org

On Sun, Sep 20, 2015 at 12:09:17PM +1200, vibnwis wrote:
> I downloaded ipipe-ipipe-core-3.18.20-arm-5 and tried to run ./configure,
> file not found as well. In addition, I checked in the ./scripts directory,
> none of the configure or autoreconf exist. It is not the right source I
> have downloaded? Any comments please.

The configure script may be found in Xenomai sources tarball, it is
not added by the I-pipe patch. You will need autoreconf if
installing xenomai from a git repository checkout. autoreconf is not
part of Xenomai sources distribution, it is a tool which should be
provided by your distribution. For other requirements, see:
http://xenomai.org/installing-xenomai-3-x/#Installing_the_Xenomai_libraries_and_tools

If you have no experience building packages from sources using the
autotools, I suggest you look for general information about that
before starting and compiling xenomai, and asking question to this
list every time something is missing.

-- 
					    Gilles.
https://click-hack.org

