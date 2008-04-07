Message-ID: <2ff1a98a0804070539n2fcae12s58f6f5565d94737d@domain.hid>
Date: Mon, 7 Apr 2008 14:39:13 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2ff1a98a0804070514y4c632fbdk7fa2aedc7fdd8a31@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_14716_27825295.1207571953682"
References: <OF4C98FBB1.81F59369-ONC1257421.00355333-C1257424.003F5EB0@domain.hid>
	<2ff1a98a0804070514y4c632fbdk7fa2aedc7fdd8a31@domain.hid>
Subject: Re: [Xenomai-core] posix-skin: unexpected scheduler behaviour
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Thomas Wiedemann <Thomas.Wiedemann@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_14716_27825295.1207571953682
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, Apr 7, 2008 at 2:14 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Mon, Apr 7, 2008 at 1:32 PM, Thomas Wiedemann
>  <Thomas.Wiedemann@domain.hid> wrote:
>  > Hi folks,
>  >
>  >  i think there is a problem with the xenomai scheduler or the sched_yield()
>  >  call, when using the POSIX skin (Xenomai 2.4.3, Linux 2.6.24.4, SMP,
>  >  .config is attached).
>
>  The semantic of sched_yield() is a bit specific: it causes threads
>  running in primary mode to yield to other threads running in primary
>  mode. To get threads running in secondary mode to yield to other
>  threads running in secondary mode, you have to call
>  __real_sched_yield().

That said what we could do is that sched_yield() calls
__real_sched_yield() for threads running in secondary mode. Try the
attached patch (recompilation of kernel needed).

-- 
 Gilles

------=_Part_14716_27825295.1207571953682
Content-Type: application/octet-stream;
 name=xeno-posix-2ndary-mode-sched_yield.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fer150ul0
Content-Disposition: attachment;
 filename=xeno-posix-2ndary-mode-sched_yield.diff

SW5kZXg6IGtzcmMvc2tpbnMvcG9zaXgvc3lzY2FsbC5jCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGtzcmMvc2tp
bnMvcG9zaXgvc3lzY2FsbC5jCShyw6l2aXNpb24gMzY4MCkKKysrIGtzcmMvc2tpbnMvcG9zaXgv
c3lzY2FsbC5jCShjb3BpZSBkZSB0cmF2YWlsKQpAQCAtMzE1LDcgKzMxNSw4IEBAIHN0YXRpYyBp
bnQgX19zY2hlZF95aWVsZChzdHJ1Y3QgdGFza19zdHIKIAlwdGhyZWFkX2dldHNjaGVkcGFyYW0o
dGhyZWFkLCAmcG9saWN5LCAmcGFyYW0pOwogCXNjaGVkX3lpZWxkKCk7CiAKLQlyZXR1cm4gcG9s
aWN5ID09IFNDSEVEX09USEVSOworCXJldHVybiBwb2xpY3kgPT0gU0NIRURfT1RIRVIKKwkJfHwg
eG50aHJlYWRfdGVzdF9zdGF0ZSgmdGhyZWFkLT50aHJlYWJhc2UsIFhOUkVMQVgpOwogfQogCiBz
dGF0aWMgaW50IF9fcHRocmVhZF9tYWtlX3BlcmlvZGljX25wKHN0cnVjdCB0YXNrX3N0cnVjdCAq
Y3VyciwK
------=_Part_14716_27825295.1207571953682--

