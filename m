Message-ID: <2ff1a98a0711050834m5f5a70e1t74e49722a84a6551@domain.hid>
Date: Mon, 5 Nov 2007 17:34:45 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <OF7AA2B50F.2763501F-ONC125738A.0058C081-C125738A.00597EAF@philips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <OF7AA2B50F.2763501F-ONC125738A.0058C081-C125738A.00597EAF@philips.com>
Subject: Re: [Xenomai-help] calling posix functions in vxworks application
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "A.J.W. van Lievenoogen" <a.j.w.van.lievenoogen@domain.hid>
Cc: xenomai@xenomai.org

On 11/5/07, A.J.W. van Lievenoogen <a.j.w.van.lievenoogen@domain.hid> wrote:
>
>
> I'm trying to port a vxworks application to xenomai.
>  Some calls in this application are posix calls (which are supported by
> vxworks) for example the clock_gettime function.
>  This function in xenomai is implemented in the posix skin but not in the
> vxworks skin.
>  Can I still somehow use these functions in the posix skin while I'm using
> others in the VxWorks skin?
>
>  the only functions I mis from vxworks are clock_gettime and localtime_r so
> if I can't use both skins simultaneously is there a way to work around that
> for these functions?

Yes you can use the posix skin and the vxworks skin at the same time.
You will simply have to use both xeno-config --xeno-* and xeno-config
--posix-* when compiling. Note that there is no xenomai version of
localtime_r, but from its description it should run in real-time with
no modification.

-- 
                                               Gilles Chanteperdrix

