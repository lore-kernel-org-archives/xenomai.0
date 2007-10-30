Message-ID: <2ff1a98a0710300247q3df99efbybb4ad9a03b7fdf6@domain.hid>
Date: Tue, 30 Oct 2007 10:47:06 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB025E41E8@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1571_4903056.1193737626250"
References: <1192524631.6045.23.camel@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB025E41E8@domain.hid>
Subject: Re: [Xenomai-help] [Xenomai-core] Xenomai v2.4-rc4
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_1571_4903056.1193737626250
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 10/30/07, Daniel Schnell <daniel.schnell@domain.hid> wrote:
> However we think there might be a problem with pthread_cond_timedwait()
> in the POSIX skin.
> It seems that after return of ETIMEOUT the mutex is not acquired again
> by the function automatically

Ok, do you still observe the same behaviour with the attached patch ?

-- 
                                               Gilles Chanteperdrix

------=_Part_1571_4903056.1193737626250
Content-Type: application/octet-stream;
 name=xeno-posix-save-mutex-recursion-count-upon-timeout.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f8e8jtxb
Content-Disposition: attachment;
 filename=xeno-posix-save-mutex-recursion-count-upon-timeout.diff

SW5kZXg6IGtzcmMvc2tpbnMvcG9zaXgvc3lzY2FsbC5jCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGtzcmMvc2tp
bnMvcG9zaXgvc3lzY2FsbC5jCShyw6l2aXNpb24gMzEzMykKKysrIGtzcmMvc2tpbnMvcG9zaXgv
c3lzY2FsbC5jCShjb3BpZSBkZSB0cmF2YWlsKQpAQCAtMTU0OSw3ICsxNTQ5LDcgQEAKIAl9CiAK
IAotCWlmICghZXJyIHx8IGVyciA9PSBFSU5UUikKKwlpZiAoIWVyciB8fCBlcnIgPT0gRUlOVFIg
fHwgZXJyID09IEVUSU1FRE9VVCkKIAkJX194bl9jb3B5X3RvX3VzZXIoY3VyciwgKHZvaWQgX191
c2VyICopIF9feG5fcmVnX2FyZzMocmVncyksCiAJCQkJICAmY291bnQsIHNpemVvZihjb3VudCkp
OwogCg==
------=_Part_1571_4903056.1193737626250--

