Date: Mon, 21 Sep 2015 16:46:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150921144615.GA20753@hermes.click-hack.org>
References: <CAFkYNwbawB8iHkJA51FpuQFDDY2aYBj2_aMontPadSBf=VZ8AA@mail.gmail.com>
 <20150919151106.GD22852@hermes.click-hack.org>
 <20150919151423.GE22852@hermes.click-hack.org>
 <CAFkYNwZSskEBYeHOK1UEXi7iGucm5x=O7wBB9YQ+1A_Gu9iGgA@mail.gmail.com>
 <CAFkYNwZS5Js_22DMKozYciMwVUKxPbUJ0-FoAxoY50rfxtcBQA@mail.gmail.com>
 <20150920081716.GH22852@hermes.click-hack.org>
 <CAFkYNwY_sQxtHYfB=Y-bcpGyfaENWjAwnx0Yc7VvWcEPaUH+fg@mail.gmail.com>
 <20150920170330.GA3486@hermes.click-hack.org>
 <CAFkYNwbHQXK8_YA1A0NLErdcHbYB-PpTMo09VUaae7fgQTmxfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFkYNwbHQXK8_YA1A0NLErdcHbYB-PpTMo09VUaae7fgQTmxfw@mail.gmail.com>
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

On Mon, Sep 21, 2015 at 10:16:53PM +1200, vibnwis wrote:
> Hi Gilles,
> 
> I managed to get autoreconf -if to work, and advanced to compiling the
> xenomai. However, yet not to the end. I got the following error. Then I
> switch xenomai-gch. The same error as well. Hence, I changed the CC to
> Ubuntu arm-linux-gnueabihf package. The same error too. The errors are as
> follow.
> 
> checking for ARM machine... configure: error: Selecting a machine with
> --enable-arm-mach is mandatory
> 
> and the command is  ./configure CFLAGS="-march=armv7-a -mfpu=vfp3"
> LDFLAGS="-march=armv7-a -mfpu=vfp3" --with-core=cobalt --enable-smp
> --enable-pshared --build=x86_64-linux-gnu --host=arm-linux-gnueabihf
> 
> if I added --enable-arm-mach, I get error messages "checking for ARM
> machine... configure: error: Invalid machine selected: "yes"".
> 
> Googles don't seem to get any positive resolution. Appreciate any
> comments.

You are trying to compile an outdated version of Xenomai, Xenomai
version 2.5 or earlier. You can have access to the installation
instructions for that particular version in the sources (the file is
named README.INSTALL at the top of the sources tree), or on the
website, using the URL:

http://xenomai.org/documentation/xenomai-2.5/README.INSTALL

for instance, if installing the version 2.5. Replace 2.5 with the
version you are actually installing.

-- 
					    Gilles.
https://click-hack.org

