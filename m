MIME-Version: 1.0
Date: Thu, 17 Mar 2016 15:45:28 +0100
Message-ID: <CAPkGiCLc89Or8_636FETmiV59T=SqDBkwPEbES_RTJkFfabnsg@mail.gmail.com>
From: =?UTF-8?Q?M=C3=A4x_Tanner?= <maex.tanner@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Xenomai on Intel Edison
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I have some troubles installing Xenomai 3.0.1 on the Intel Edison (Yocto
Linux). I really hope you can help me with the following error:

After extracting Xenomai, running ./bootstrap and ./configure without
errors - I get the following error trying to run ./prepare-kernel.sh: line
307: linux_: command not found
Line 307 consists of:
eval linux_`grep '^EXTRAVERSION =' $linux_tree/Makefile | sed -e 's, ,,g'`
The problem is that grep does not find EXTRAVERSION in the Makefile. Hence
it returns nothing and of course the OS can not recognize the command
"linux_". I checked the Makefile and there is no "EXTRAVERSION"
declaration, neither (following in the next lines of the
"prepare_kernel.sh") a "PATCHLEVEL", "SUBLEVEL" or "VERSION" declaration.
As result of that I think that my Makefile is not generated correctly. But
I don't see the point why?

Thank you very much!
