Message-ID: <4CAF88D2.1040103@domain.hid>
Date: Fri, 08 Oct 2010 23:10:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201010082121.43128.lux-integ@domain.hid>
In-Reply-To: <201010082121.43128.lux-integ@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] a xenomai qustion
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: luxInteg <lux-integ@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

luxInteg wrote:
> Greetings,
> 
> I am about to restart dabbling with xenomai on a cblfs x86_64/64-bit machine .  
> I have a question. Could one have multiple instances of kernels  
> patched/compiled/installed  thus  multiple instances of /lib/modules-xyz  AND 
> a single instance of xenomai in userspace  that works with all of them?
> 
> Advice would be appreciated.

The answer to your question is that the ABI is compatible between the
kernel-space and user-space. This means:
- kernel-space and user-space must be from the same branch, say,
kernel-space version 2.5.x with user-space version 2.5.y;
- they must be configured with compatible options, the said options
being dependent on the architectures and being described in the
README.INSTALL document:
http://www.xenomai.org/documentation/xenomai-2.5/README.INSTALL

-- 
                                                                Gilles.

