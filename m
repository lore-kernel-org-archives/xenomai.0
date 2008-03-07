Message-ID: <2ff1a98a0803070904i3f69bf6l7f15ac3d7f078dec@domain.hid>
Date: Fri, 7 Mar 2008 18:04:04 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d3f72a390803070855l47a1625cg63915d5be304d434@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4186_13137047.1204909444298"
References: <d3f72a390803070847w1a5152d1o9d316d8ada2cd12c@domain.hid>
	<2ff1a98a0803070852t73f1c458m6b969019f16732f7@domain.hid>
	<d3f72a390803070855l47a1625cg63915d5be304d434@domain.hid>
Subject: Re: [Xenomai-help] [Xenomai-core] ERROR ON COMPILING TRUNK XENOMAI
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: axel axel <softaxel@domain.hid>, xenomai-help <xenomai@xenomai.org>

------=_Part_4186_13137047.1204909444298
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, Mar 7, 2008 at 5:55 PM, axel axel <softaxel@domain.hid> wrote:
>
>
> 2008/3/7, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>
> > On Fri, Mar 7, 2008 at 5:47 PM, axel axel <softaxel@domain.hid> wrote:
> > > Hi,
> > >
> > > i'm compiling xenomai trunk with the gcc 3.4.3 for ARM.
> > >
> > > I have the following error:
> > >
> > > thread.c: In function `pse51_thread_init':
> > >  thread.c:285: error: `_CS_GNU_LIBPTHREAD_VERSION' undeclared (first use
> in
> > > this function)
> > > thread.c:285: error: (Each undeclared identifier is reported only once
> > >  thread.c:285: error: for each function it appears in.)
> > > make[3]: *** [libpthread_rt_la-thread.lo] Error 1
> > >  make[2]: *** [all-recursive] Error 1
> > > make[1]: *** [all-recursive] Error 1
> > > make: *** [all-recursive] Error 1
> > >
> > > What do you think about this?
> >
> >
> > My fault, in an attempt to know if we are running linuxthreads or
> > NPTL, I assumed that _CS_GNU_LIBPTHREAD_VERSION was always defined. If
> > not defined, we should assume we are using libpthread.
> >
> > --
> >
> > Gilles Chanteperdrix
>
>
> When i can update my repository ?
> Or i have to modify manually the files( and if yes where  ) ?

It will not be in the repository before tonight. Try the attached patch.


-- 
 Gilles Chanteperdrix

------=_Part_4186_13137047.1204909444298
Content-Type: application/octet-stream;
 name=xeno-posix-test-linuxthreads.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fdizxtlj0
Content-Disposition: attachment; filename=xeno-posix-test-linuxthreads.diff

SW5kZXg6IHNyYy9za2lucy9wb3NpeC90aHJlYWQuYwo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBzcmMvc2tpbnMv
cG9zaXgvdGhyZWFkLmMJKHLDqXZpc2lvbiAzNTUwKQorKysgc3JjL3NraW5zL3Bvc2l4L3RocmVh
ZC5jCShjb3BpZSBkZSB0cmF2YWlsKQpAQCAtMjgxLDcgKzI4MSwxMSBAQCBzdGF0aWMgX19hdHRy
aWJ1dGVfXygoY29uc3RydWN0b3IpKSB2b2lkCiB7CiAJY2hhciB2ZXJzWzEyOF07CiAJcHRocmVh
ZF9hdHRyX2luaXQoJmRlZmF1bHRfYXR0cik7CisjaWZkZWYgX0NTX0dOVV9MSUJQVEhSRUFEX1ZF
UlNJT04KIAlsaW51eHRocmVhZHMgPQogCQkhY29uZnN0cihfQ1NfR05VX0xJQlBUSFJFQURfVkVS
U0lPTiwgdmVycywgc2l6ZW9mKHZlcnMpKQogCQl8fCBzdHJzdHIodmVycywgImxpbnV4dGhyZWFk
cyIpOworI2Vsc2UgLyogIV9DU19HTlVfTElCUFRIUkVBRF9WRVJTSU9OICovCisJbGludXh0aHJl
YWRzID0gMTsKKyNlbmRpZiAvKiAhX0NTX0dOVV9MSUJQVEhSRUFEX1ZFUlNJT04gKi8KIH0K
------=_Part_4186_13137047.1204909444298--

