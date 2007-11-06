Message-ID: <2ff1a98a0711060209n19cd268dw122f4accfd30921b@domain.hid>
Date: Tue, 6 Nov 2007 11:09:06 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <f48df4840711060101w4f444247rcfd574e78b29425d@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <C46506B0-FC87-46CE-9FEE-F6E031CB95C9@domain.hid>
	<2ff1a98a0711050704s51a976cp96257f2712bd15ff@domain.hid>
	<f48df4840711050730t4309e500p715314c77caa28bb@domain.hid>
	<2ff1a98a0711050749n4237a818p5838896f84dc9dc8@domain.hid>
	<2ff1a98a0711051123l1348ed85se7a46ab420276346@domain.hid>
	<18224.10799.628508.676548@domain.hid>
	<f48df4840711060101w4f444247rcfd574e78b29425d@domain.hid>
Subject: Re: [Xenomai-core] About Xenomai test framework and publishing
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Bruno Rouchouse <brouchouse@domain.hid>
Cc: xenomai@xenomai.org

On Nov 6, 2007 10:01 AM, Bruno Rouchouse <brouchouse@domain.hid> wrote:
> Hi Gilles,
>
> I did manage to start the script and get everything downloaded but nothing
> got compiled indeed.
>
> I'll try again tonight with your updated version.
>
> Thanks.

Note that if you want to compile i386 code on an x86_64, you will have
some difficulties, you will need to define a pseudo cross-compilation
script (say x86-32-gcc) which will simply contain:
 gcc -m32 ${1+"$@"}

And call this script instead of gcc in the BX_CCS variable of the
bx_config script of the apropriate configurations.

-- 
                                               Gilles Chanteperdrix

