Message-ID: <4C36D78C.6090400@domain.hid>
Date: Fri, 09 Jul 2010 10:02:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1278598017.S.4635.60583.F.H.TkdpbGxlcyBDaGFudGVwZXJkcml4AFJlOiBbWGVub21haS1oZWxwXSBUZXN0aW5nIFJUTmV0IGluIFhlbm8_.f4-234-220.old.1278650416.1245@domain.hid>
In-Reply-To: <1278598017.S.4635.60583.F.H.TkdpbGxlcyBDaGFudGVwZXJkcml4AFJlOiBbWGVub21haS1oZWxwXSBUZXN0aW5nIFJUTmV0IGluIFhlbm8_.f4-234-220.old.1278650416.1245@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Testing RTNet in Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: prakash srinivasan <asprakash_83@domain.hid>
Cc: xenomai@xenomai.org

prakash srinivasan wrote:
>> I answer you: "read README.INSTALL".
> 
> 
> 
> Yes. But I am sure, it was irrelevant to my query.

And you are wrong. It answers exactly your question. It explains that
the build was split in two, a user-space part and a kernel-space part,
which is why, in particular, you will not get any module when compiling
the user-space part. It also explains that you have the possibility to
compile Xenomai support to be built-in the kernel, in which case you
will not get any Xenomai modules at all. How is that irrelevant to your
query.

-- 
					    Gilles.

