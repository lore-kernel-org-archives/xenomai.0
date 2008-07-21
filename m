Message-ID: <488439B4.10205@domain.hid>
Date: Mon, 21 Jul 2008 09:24:36 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <894886ec0807202305n5bf0384w2357ea6ed64f5a36@domain.hid>
In-Reply-To: <894886ec0807202305n5bf0384w2357ea6ed64f5a36@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with atomic_32.h when included from C++
 source
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rob Wheeler <wheeler@domain.hid>
Cc: xenomai@xenomai.org

Rob Wheeler wrote:
> Hello,
> 
> I'm seeing an issue when trying to compile a C++ application that
> includes native/task.h.  It eventually winds up including atomic_32.h
> which has a function xnarch_atomic_cmpxchg which takes a function
> argument named 'new'.  This conflicts with the C++ compiler's reserved
> keyword and generates compiler warnings.
>

Fixed in trunk. Thanks.

> -R
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

