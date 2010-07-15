Message-ID: <4C3F192A.8080203@domain.hid>
Date: Thu, 15 Jul 2010 16:20:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinwyQgI26INSzLlvgyP2hlAmuziK7V3iNCVa8Nd@domain.hid>	<4C3EFB0B.7050801@domain.hid>
	<AANLkTinH0vj7gAxa8LscV_-Hvmggo9LigQkp30nIUcz6@domain.hid>
In-Reply-To: <AANLkTinH0vj7gAxa8LscV_-Hvmggo9LigQkp30nIUcz6@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [RTnet-users] Alignment problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Cyril Wallois <walloiscyril@domain.hid>
Cc: xenomai@xenomai.org

Cyril Wallois wrote:
> Hi Gilles,
> 
> Sorry, I don't mention that my problem has ever been evoqued on
> xenomai-help one month ago :

Ok. But if you had used the "reply" function of your MUA, the mail you
would have sent would have contained a "Reference" header pointing to
the mail you were replying, which would have allowed the MUA of the
people reading your mail, including Xenomai mailing list archives, to
properly sort this new mail as a follow-up of the mail you were replying to.

> 0xc002d3c8 correspond to do_page_fault in /proc/kallsyms

Ok. So, you enter do_page_fault from primary mode. Compile your kernel
with frame pointers, and try and insert a call to show_stack(NULL,NULL)
in the Xenomai code printing the messages which you see.

-- 
					    Gilles.

