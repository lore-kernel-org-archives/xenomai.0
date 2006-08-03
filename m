From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17617.56609.856127.381430@domain.hid>
Date: Thu, 3 Aug 2006 13:25:21 +0200
Subject: Re: [Xenomai-help] pthread_attr_setname_np
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A46D8E7@domain.hid>
References: <5D63919D95F87E4D9D34FF7748CE2C2A46D8E7@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

Roderik_Wildenburg@domain.hid wrote:
 > Is this function implemented in Xeno2.2-rc2 ?
 > When using it, the linker complains about a "undefined reference".

That is not clear in the documentation, but the function
pthread_attr_setname_np is only available in kernel-space. When
compiling with -Wall, you should get an "implicit function declaration"
warning, because this function is only declared in pthread.h when
included from kernel-space.

 > (Is this a a standard POSIX-funktion or a Xenomai extension ?)
As the _np suffix suggest it, it is a non portable extension.

In user-space, you should use pthread_setname_np, another non portable
extension.

-- 


					    Gilles Chanteperdrix.

