Message-ID: <4FCDB6A3.1050301@xenomai.org>
Date: Tue, 05 Jun 2012 09:34:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20120605073137.BFC60728009@webmail.sinamail.sina.com.cn>
In-Reply-To: <20120605073137.BFC60728009@webmail.sinamail.sina.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] How to build user_space
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: wonder_code@sina.com
Cc: Xenomai <Xenomai@xenomai.org>

On 06/05/2012 09:31 AM, wonder_code@sina.com wrote:
> 
> I follow the steps of the README_INSTALL to build the user_space,but the programs in /usr/xenomai/bin can't run(clocktest,cyclictest).it says:
> -ash:./clocktest:not found
> 
> My commomline as follow:
> /usr/local/xenomai-2.6.0/configure CFLAGS="-march=armv6" LDFLAGS="-march=armv6" --build=i686-pc-linux-gnu --host=arm-linux
> 
> Is there anything wrong,waiting for reply 

Have you run "make install" ?

-- 
                                                                Gilles.

