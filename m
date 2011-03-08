Message-ID: <4D75FDFA.3000003@domain.hid>
Date: Tue, 08 Mar 2011 10:59:22 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4D74EE69.5020705@domain.hid> <4D754DF2.8060908@domain.hid>
	<4D75FD0C.1070101@domain.hid>
In-Reply-To: <4D75FD0C.1070101@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Build and run xenomai 2.5.5.2 - linux-2.6.33 on
 imx27
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fabrice Gasnier <fabrice.gasnier@domain.hid>
Cc: xenomai@xenomai.org

Fabrice Gasnier wrote:
> Fine,
> 
> This patch fixes both issues on 2.6.33 kernel!
> Thanks.
> I'll let you know in case I detect something else.
> 
> Regarding 2.6.35 patch, I need to check more things as I don't use it 
> for the moment. (no valuable config / board support yet).
> I quiclky tried it, but cannot boot it (yet). I'll give it some more 
> tries and keep you informed.
> 
> Thanks again.
> Fabrice

Ok. Forget it, the code in the 2.6.35 patch is the same anyway, and was
build-tested on imx27. 2.5.6 will be released soon with both these patches.


-- 
					    Gilles.

