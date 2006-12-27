Message-ID: <459291C6.1060106@domain.hid>
Date: Wed, 27 Dec 2006 16:31:18 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] adeos & protection rings on ppc
References: <ac3922a00612270713s72565d93j9bc566eed3c9632@domain.hid>
In-Reply-To: <ac3922a00612270713s72565d93j9bc566eed3c9632@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Syed Amer Gilani <amg@domain.hid>
Cc: xenomai@xenomai.org

Syed Amer Gilani wrote:
> (...) On an x86 CPU adeos runs on Ring 0 and pushes
> Linux to Ring 1 to ensure it alone has access to certain things (...)

No, even when running with Adeos on x86, Linux ring level is not changed.

-- 
                                                 Gilles Chanteperdrix

