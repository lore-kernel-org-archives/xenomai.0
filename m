MIME-Version: 1.0
In-Reply-To: <1309280367.2101.83.camel@domain.hid>
References: <4E09D058.10906@domain.hid> <4E09DBC0.30705@domain.hid>
	<4E09E2F4.1000100@domain.hid> <1309271040.2101.76.camel@domain.hid>
	<4E0A007A.8020401@domain.hid> <1309280367.2101.83.camel@domain.hid>
Date: Tue, 28 Jun 2011 20:46:36 +0200
Message-ID: <BANLkTikcCK2ZsYm39nCVSMjzLOydQ+CfxA@mail.gmail.com>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: multipart/mixed; boundary=90e6ba21221f70b5cf04a6ca169c
Subject: Re: [Xenomai-help] Xenomai 2.6.5 with Linux 2.6.38.8 kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

--90e6ba21221f70b5cf04a6ca169c
Content-Type: text/plain; charset=ISO-8859-1

Kernel 2.6.38.8 has also renamed current_cpu_data.
See attached patch for fix.

On Tue, Jun 28, 2011 at 6:59 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On Tue, 2011-06-28 at 18:25 +0200, Daniele Nicolodi wrote:
>> On 28/06/11 16:24, Philippe Gerum wrote:
>> >> Thanks Gilles for the quick answer, but that's not the problem, NMI
>> >> watchdog option is already disabled (and looking at the source code
>> >> looks like the error comes from a section of the code that is not
>> >> affected by XENO_NMI_DEBUG_LATENCY.
>> >>
>> >> Cheers,
>> >
>> > https://mail.gna.org/public/xenomai-help/2011-06/msg00142.html
>>
>> Thank you Philippe. I should follow the mailing list more closely.
>
> Actually, I should have pushed the necessary bits way earlier to the
> repo.
>
>>
>> Cheers,
>
> --
> Philippe.
>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

--90e6ba21221f70b5cf04a6ca169c
Content-Type: text/x-diff; charset=US-ASCII; name="fix-current_cpu_data-rename.patch"
Content-Disposition: attachment; 
	filename="fix-current_cpu_data-rename.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gph7igtx0

SW5kZXg6IHhlbm9tYWktMi41LjYvaW5jbHVkZS9hc20teDg2L2NhbGlicmF0aW9uLmgKPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQotLS0geGVub21haS0yLjUuNi5vcmlnL2luY2x1ZGUvYXNtLXg4Ni9jYWxpYnJhdGlvbi5o
CTIwMTEtMDYtMjggMjA6MzE6MjMuMDAwMDAwMDAwICswMjAwCisrKyB4ZW5vbWFpLTIuNS42L2lu
Y2x1ZGUvYXNtLXg4Ni9jYWxpYnJhdGlvbi5oCTIwMTEtMDYtMjggMjA6MzM6MDguMDAwMDAwMDAw
ICswMjAwCkBAIC00NSw3ICs0NSwxMSBAQAogCSAqIHRoZSBhcHByb2FjaCBpcyBkZWZpbml0ZWx5
IHNhbmVyIHRoYW4gcHJldmlvdXMgYXR0ZW1wdHMgdG8KIAkgKiBndWVzcyBzdWNoIHZhbHVlIGR5
bmFtaWNhbGx5LgogCSAqLworI2lmIExJTlVYX1ZFUlNJT05fQ09ERSA8IEtFUk5FTF9WRVJTSU9O
KDIsNiwzOCkKICNkZWZpbmUgX19ib2dvbWlwcyAoY3VycmVudF9jcHVfZGF0YS5sb29wc19wZXJf
amlmZnkvKDUwMDAwMC9IWikpCisjZWxzZQorI2RlZmluZSBfX2JvZ29taXBzIChjcHVfaW5mby5s
b29wc19wZXJfamlmZnkvKDUwMDAwMC9IWikpCisjZW5kaWYKIAlzY2hlZF9sYXRlbmN5ID0gKF9f
Ym9nb21pcHMgPCAyNTAgPyAxNzAwMCA6CiAJCQkgX19ib2dvbWlwcyA8IDI1MDAgPyA0MjAwIDoK
IAkJCSAzNTAwKTsK
--90e6ba21221f70b5cf04a6ca169c--

