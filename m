Message-ID: <4FB26A3F.9070800@domain.hid>
Date: Tue, 15 May 2012 16:37:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2032488254.158228581.1337092454641.JavaMail.root@domain.hid>
In-Reply-To: <2032488254.158228581.1337092454641.JavaMail.root@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai on the TS-7553 ARM SBC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: aubin.rebillat@domain.hid
Cc: xenomai@xenomai.org

On 05/15/2012 04:34 PM, aubin.rebillat@domain.hid wrote:
> I really didn't see how my code could influence this so I checked the 
> bug fixes for Xenomai 2.5 and i found one which was not fixed in my 
> version of xenomai. The bug was the return value of rthal_timer_request.

Oh, I missed that, don't do that. Please use Xenomai 2.6. It is backward
compatible with old I-pipe patches.

-- 
					    Gilles.

