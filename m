Message-ID: <505349FB.9050300@xenomai.org>
Date: Fri, 14 Sep 2012 17:15:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1347627593.65114.YahooMailNeo@web29601.mail.ird.yahoo.com>
In-Reply-To: <1347627593.65114.YahooMailNeo@web29601.mail.ird.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai + Linux Kernel 3.1.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: devendra rai <rai.devendra@yahoo.co.uk>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/14/2012 02:59 PM, devendra rai wrote:
> Hello Community,
> 
> 
> 
> I have been trying to install xenomai + adeos patch on Linux kernel 3.1.4. I understand the following:
> 
> (a). Xenomai-2.5.6 patches Linux-3.1.4 smoothly
> (b). Adeos-3.2.21 patch (x86) failed.

No, the most recent Linux version usable with xenomai 2.5.6 is 2.6.37 on
x86. If you want some Linux 3.x, you should use xenomai 2.6.1.

Other than that, yes, the patch Adeos-3.2.21 is made... well... for
Linux 3.2.21, so is not supposed to be applied to anything else.

-- 
					    Gilles.

