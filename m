Message-ID: <51310A5E.20609@xenomai.org>
Date: Fri, 01 Mar 2013 21:06:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <512C806F.2020209@hilscher.com>
	<512C9E78.1060208@siemens.com>	<512CC5C6.8050204@hilscher.com>
	<512CC6A3.1010005@siemens.com>	<512F120A.5060109@hilscher.com>
	<512F4005.60000@siemens.com>	<512F48AA.8020601@hilscher.com>
	<5130B39C.70300@hilscher.com>
In-Reply-To: <5130B39C.70300@hilscher.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Hilscher driver for cifX boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jerome Poncin <JPoncin@hilscher.com>
Cc: xenomai@xenomai.org

On 03/01/2013 02:56 PM, Jerome Poncin wrote:

> Hello,
> 
> I finished to reformat my driver according to kernel coding style.
> 
> I'm compiling no version to test it ;-) !
> 
> I'm ready to do a patch against Xenomai git head. The patch will add the 
> driver source
> code under ksrc/drivers/cifx and change the Makefiles and Kconfigs as 
> required.
> 
> I did this command to get Xenomai git head :
> 
> git clone git://git.xenomai.org/xenomai-head.git xenomai-head


Please do not use xenomai-head. Use xenomai-2.6 if you are patching the
2.6 branch, or xenomai-forge if you are patching the -forge branch.

> 
> but connexion is refused. What must I do to clone Xenomai git head and 
> do my patch ?


This should be fixed now.

Please stop top-posting.


-- 
                                                                Gilles.

