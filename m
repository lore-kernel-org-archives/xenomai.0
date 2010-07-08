Message-ID: <4C358969.60806@domain.hid>
Date: Thu, 08 Jul 2010 10:16:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20100708080105.27906.qmail@domain.hid>
In-Reply-To: <20100708080105.27906.qmail@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Testing RTNet in Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: prakash srinivasan <asprakash_83@domain.hid>
Cc: xenomai@xenomai.org

prakash srinivasan wrote:
> Dear All,
> 
> I am new to Xenomai. But I am already using RTAI. I referred this
> page, http://www.xenomai.org/index.php/RTnet:Installation_%26_Testing
> and tested RTNet in RTAI. Its working fine. However now I would like
> to test the same RTNet in Xenomai. According to the wiki page, i
> could not able to start the rtnet successfully. When I tried to start
> the rtnet, I am getting the segmentation fault error. The errors
> clearly shows that the dependent modules are not loaded.
> 
> 
> 
> Like RTAI dependent modules rtai_hal, rtai_lxrt, rtai_sem and
> rtai_rtdm, I did not loaded any modules in Xenomai. Even I never
> found any "modules" folder in my xenomai installation directory,
> /usr/xenomai/. I would like to know whether my xenomai is not
> properly installed or what are the other reasons rtnet is not
> started?. Kindly give me more about about from this wiki page, "If
> you have built the RTDM support of Xenomai into the kernel, nothing
> has to be done.". Do I no need to insert any modules?. Help me to
> resolve the above issues.

To install Xenomai, please follow the installation instructions. You
will find them in the README.INSTALL file in Xenomai sources
distribution, or online:
http://www.xenomai.org/documentation/xenomai-2.5/README.INSTALL

-- 
					    Gilles.

