MIME-Version: 1.0
In-Reply-To: <7f61eb0b96dd415b4fe11a855c310b8b.squirrel@127.0.0.1>
References: <CA+dLyOXPdSs81MZgEjxuCtc9xRKuHkDkFJyF5sLvRaa4SOSzhg@mail.gmail.com>
	<7f61eb0b96dd415b4fe11a855c310b8b.squirrel@127.0.0.1>
From: Seong-hyeon Kim <zedoul@gmail.com>
Date: Mon, 16 Sep 2013 19:20:02 +0200
Message-ID: <CA+dLyOWb+V9yCf6CBU_y3EQL_MeKDCJZNvAdf0ah=J9SLkZOYw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Building a RTDM driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> so, you need to use the xeno-config which corresponds to the ARM
installation

No, there are only one xenomai installation. I am sure and actually that's
what I really ask.

I would like to change my question, "how can I install xenomai arm-version
?"

What I really suspicious about is "./configure --prefix=/usr/xenomai
--host=arm" this command. I mean it's not documented so I have to guess.




2013/9/16 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

>
> Seong-hyeon Kim wrote:
> > How to build RTDM driver for *arm* arch?
> > I tried to build xenomai-head/examples/rtdm/driver-api
> >
> > 1. clone xenomai-head
> > 2. cd xenomai-head
> > 3. ./configure --prefix=/usr/xenomai --host=arm
> > 4. make DESTDIR=/home/<usrname>/xeno-target-staging ARCH=arm install
> > 5. cd example
> > 6. DESTDIR=/home/<usrname>/ make XENO=/home/<usrname>/xeno-target-
> > staging/usr/xenomai ARCH=arm KSRC=/home/<usrname>/<patched kernel root
> > directory>
> >
> > I found that *compiler setting* and *arch* setting in "xeno-config" is
> gcc
> > / i386 in  xeno-config which is not I want. I should change those to
> > arm-linux-gcc-gnueabi-hf- and arm.
> >
> > I already spend lots of hours to build it, unfortunately, it seems like I
> > didn't find any suitable documents to build rtdm. So I will be very
> > appreciate you if you let me know about documents or suitable
> instructions
> > for building it.
>
> Probably because you have two different xenomai installations:
> - one for i386
> - the other for arm.
> The xeno-config script is generated for each installation, so, you need to
> use the xeno-config which corresponds to the ARM installation, not the one
> for the i386 installation.
>
> --
>                                               Gilles
>
>
