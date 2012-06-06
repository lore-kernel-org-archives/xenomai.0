Message-ID: <4FCEF71D.7050704@xenomai.org>
Date: Wed, 06 Jun 2012 08:22:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20120606012640.3058C728001@webmail.sinamail.sina.com.cn>
In-Reply-To: <20120606012640.3058C728001@webmail.sinamail.sina.com.cn>
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

On 06/06/2012 03:26 AM, wonder_code@sina.com wrote:
> I have followed your steps to ldd clocktest,and the result as follow:
> $           not a dymamic executable

Ok. You probably picked the wrong ldd. You should have used the
toolchain ldd. Try that instead:

LD_TRACE_LOADED_OBJECTS=1 /usr/bin/clocktest

-- 
                                                                Gilles.

