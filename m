Message-ID: <4CBB0A33.4040009@domain.hid>
Date: Sun, 17 Oct 2010 16:37:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201010171523.21229.lux-integ@domain.hid>
In-Reply-To: <201010171523.21229.lux-integ@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai-2.5.5 xml requirments
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: luxInteg <lux-integ@domain.hid>
Cc: xenomai@xenomai.org

luxInteg wrote:
> Greetings,
> 
> I have successfully patched, compiled and installed kernels  2.6.32 and 
> 2.6.35.7   with senomai-2.5.5 on a computer  (not on the internet) 
>  with these:-
> ----cpu amd64 2 cores
> ----kernel: linux-2.6.35.7 (64-bit CBLFS linux)
> 
> I am now attempting to build the xenomai userspace  tools (out of kernel-
> build)  via autonconf
> 
> 
> ----------A) if I pass:-
> -------------------------
> --enable-dbx \
> --with-dbx-root=/usr/share/xml/docbook/xml-dtd-4.5  \
> --disable-dbx-network
> 
> to configure

The --enable-dbx option is made for people who intend to modify the
docbook-xml documentaiton. Is this what you want?

-- 
                                                                Gilles.

