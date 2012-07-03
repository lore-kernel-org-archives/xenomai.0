Message-ID: <4FF326BB.8010700@xenomai.org>
Date: Tue, 03 Jul 2012 19:07:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAN_aGuXSLRdWQdoJjZXqChobTe6v=qVadAmz2zq6ZLzSLRRvbA@mail.gmail.com>	<CAN_aGuVxhFh+Dd0OOd0LS9eiMj_JQj2j38peEVCMVedAxvFcfg@mail.gmail.com>
	<CAN_aGuVDovxTMbG0CZE3eq_16jRcpZ6ZRFn-=pJ15rHYPfy5MQ@mail.gmail.com>
In-Reply-To: <CAN_aGuVDovxTMbG0CZE3eq_16jRcpZ6ZRFn-=pJ15rHYPfy5MQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Igep Xenomai problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Canku Alp Calargun <cankualp@gmail.com>
Cc: xenomai@xenomai.org

On 07/03/2012 03:24 PM, Canku Alp Calargun wrote:
> Hello All,
> 
> We are trying to develop a real time system which has a DM3730 processor on
> a custom board which is similar to IGEP v2 board. We were able to run the
> kernel 2.6.35 which is a xenomai patched version by igep and we were also
> able to run our application on this kernel. Because of our real time
> requirements, we want to use rt APIs of xenomai. The application is being
> developed using Code composer Studio v5 and all related configuration for
> cross compiling the system is working properly.
> 
> For reading serial data we tried to use rt_dev_read and included the header
> rtdm/rtdm.h. However, We got the error "undefined reference to
> `rt_dev_read". In the mailing list, it is suggested to add -lrtdm and
> -llxrt as linker flags. This time compiler could not find these libraries.

you will not find liblxrt, liblxrt is an RTAI thing, so I doubt you read
on the xenomai mailing list any mail telling any user to add this option.

In order to obtain the right set of options, you should use the
xeno-config tool.

In order for xeno-config to work, you have to compile xenomai user-space
support and install it with "make install". See README.INSTALL in
xenomai sources for more complete instructions.

If you wish to install in a subdirectory where the root filesystem of
the igep will be found, you have to pass a DESTDIR variable to make
install, then pass the same DESTDIR variable to the xeno-config tool.

-- 
					    Gilles.

