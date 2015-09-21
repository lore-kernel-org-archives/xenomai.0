MIME-Version: 1.0
In-Reply-To: <20150920080758.GF22852@hermes.click-hack.org>
References: <CAFkYNwbawB8iHkJA51FpuQFDDY2aYBj2_aMontPadSBf=VZ8AA@mail.gmail.com>
 <20150919151106.GD22852@hermes.click-hack.org>
 <20150919151423.GE22852@hermes.click-hack.org>
 <CAFkYNwZSskEBYeHOK1UEXi7iGucm5x=O7wBB9YQ+1A_Gu9iGgA@mail.gmail.com>
 <20150920080758.GF22852@hermes.click-hack.org>
Date: Tue, 22 Sep 2015 00:59:30 +1200
Message-ID: <CAFkYNwbKUCngFt+eA+m5u8MQw9475F3++LWiAVD_O9kVHGYfWw@mail.gmail.com>
From: vibnwis <vibnwis@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Installing xenomai libraries ARM OMAP4460
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,
I have switched to xenomai-gch and natively compiling on Pandaboard. See
the command below. The --build, --host have no effect since it is not
cross-compiling. However,  I face a problem here, it complains that
"checking for ARM machine... configure: error: Invalid machine selected:
"armv7"
". I have tried arm, arm-linux, arm-linux-gnueabihf, and blank. None of
them work. Appreciate any comments please.

./configure  --build=arm-linux-gnueabihf --host=arm-linux-gnueabihf
--with-core=cobalt --enable-smp --enable-pshared --enable-arm-mach=armv7

On 20 September 2015 at 20:07, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Sun, Sep 20, 2015 at 12:09:17PM +1200, vibnwis wrote:
> > I downloaded ipipe-ipipe-core-3.18.20-arm-5 and tried to run ./configure,
> > file not found as well. In addition, I checked in the ./scripts
> directory,
> > none of the configure or autoreconf exist. It is not the right source I
> > have downloaded? Any comments please.
>
> The configure script may be found in Xenomai sources tarball, it is
> not added by the I-pipe patch. You will need autoreconf if
> installing xenomai from a git repository checkout. autoreconf is not
> part of Xenomai sources distribution, it is a tool which should be
> provided by your distribution. For other requirements, see:
>
> http://xenomai.org/installing-xenomai-3-x/#Installing_the_Xenomai_libraries_and_tools
>
> If you have no experience building packages from sources using the
> autotools, I suggest you look for general information about that
> before starting and compiling xenomai, and asking question to this
> list every time something is missing.
>
> --
>                                             Gilles.
> https://click-hack.org
>
