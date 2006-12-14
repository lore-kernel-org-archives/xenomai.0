Message-ID: <45817C88.8070906@domain.hid>
Date: Thu, 14 Dec 2006 17:32:08 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] user space interrupt
References: <688800.81959.qm@domain.hid>
In-Reply-To: <688800.81959.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: mani bhatti <imranbashirbhatti@domain.hid>
Cc: xenomai@xenomai.org

mani bhatti wrote:
> Hi Gilles and all
> Thanks for ur help.The error i get after replacing printf with
> perror("iopl") is "iopl: Operation not permitted".
> Please suggest me some solution for this.Thanks again.

"Operation not permitted" is the error message for the error code EPERM.
Now look for EPERM in iopl manual page.

-- 
                                                 Gilles Chanteperdrix

