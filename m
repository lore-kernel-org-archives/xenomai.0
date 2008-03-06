Message-ID: <2ff1a98a0803060854v669e2642pf6d712c1f6380b24@domain.hid>
Date: Thu, 6 Mar 2008 17:54:49 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47D01673.8030909@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <47CFBB2E.3010700@domain.hid> <47CFBE53.4010707@domain.hid>
	<47D01673.8030909@domain.hid>
Subject: Re: [Xenomai-help] Need help with pipes
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Laurent BESSARD <laurent.bessard@domain.hid>
Cc: xenomai@xenomai.org

On Thu, Mar 6, 2008 at 5:06 PM, Laurent BESSARD
<laurent.bessard@domain.hid> wrote:
>  But I had another problem. I tried to compile PEAK CAN driver with
>  support for Xenomai and then "rtdm_driver.h" complains that he can't
>  find "nucleus/select.h". And effectively, there was no "select.h" file
>  in "/usr/xenomai/include/nucleus". So I copied the file from the
>  unpacked sources to the "/usr/xenomai/include/nucleus" and all works
>  fine. It seems that this file hasn't been copied during installation.

Yes, it looks like select.h is missing in include/nucleus/Makefile.am,
will fix, thanks.

-- 
                                               Gilles Chanteperdrix

