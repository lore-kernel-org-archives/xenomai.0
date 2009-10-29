Message-ID: <4AE96754.4050605@domain.hid>
Date: Thu, 29 Oct 2009 10:58:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1f3e02580910290229t5ad46268r5e7799a46950db5e@domain.hid>
In-Reply-To: <1f3e02580910290229t5ad46268r5e7799a46950db5e@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [VxWorks API] Compile and Link
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Didenko Sergey <didenkos@domain.hid>
Cc: xenomai@xenomai.org

Didenko Sergey wrote:
> Dear experts
> 
> assuming I have:
> 
> xenomai_tree - path to Xenomai source code
> project_tree - path to my project (originally based on VxWorks)
> 
> Which directories and files should I include to the project's makefile
> to be able to compile and link it with Xenimai's VxWorks APIs instead of
> VxWorks's API's?
> Do I need only *.h and *.c files or any libraries are required?

You need to install Xenomai, running 'make install' in the build tree.
Then use xeno-config.

-- 
                                          Gilles


