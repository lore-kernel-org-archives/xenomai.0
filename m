From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Date: Tue, 13 Sep 2016 14:40:49 +0200
Message-ID: <1856300.iiYY0NCQlV@soho>
In-Reply-To: <1271995210.507800.1473769593022@mail.yahoo.com>
References: <1271995210.507800.1473769593022.ref@mail.yahoo.com>
 <1271995210.507800.1473769593022@mail.yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Subject: Re: [Xenomai] multiarch on ipipe kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

El Dimarts, 13 de setembre de 2016, a les 12:26:33, Frederik Bayart va 
escriure:
> Should it be possible to run an 32 bit non-rt binary on a 64 bit ipipe
> kernel ? I'm using debian jessie amd64 and xenomai 2.6.4 on kernel 3.18.20
> 
> I have added i386 as foreing architecture and installed the i386 toolchain
> $ dpkg --print-architectureamd64s$ dpkg --print-foreign-architecturesi386
> I have a small hello world binary
> 
> #include <stdio.h>
> int main(int argc, char* argv[]){  printf("hello world\n");  return 0;}
> I compile with 
> gcc -m32 -o hello hello.c
> This binary runs on the normal (non-ipipe) kernel
> linux-image-3.16.0-4-amd64.But if I'm booting the ipipe kernel on the same
> system, I get the error : -bash: ./hello: cannot execute binary file: Exec
> format error
> So the problem seems to be related to the kernel. But I didn't find whether
> a kernel option could be the cause. The kernel was prepared with I only
> found that you can't run 32 bit xenomai libraries on a 64 bit kernel, but
> this binary is not using these libraries. Kind regards,

do you have libc6-dev-i386 and libc6-i686 installed?

I'm able to run your example with a similar setup.

Cheers,

Leopold

-- 
--
Linux User 152692     GPG: 05F4A7A949A2D9AA
Catalonia
-------------------------------------
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

