Message-ID: <4FCDDAFE.6010406@xenomai.org>
Date: Tue, 05 Jun 2012 12:10:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20120605074518.118A4728015@webmail.sinamail.sina.com.cn>
In-Reply-To: <20120605074518.118A4728015@webmail.sinamail.sina.com.cn>
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

On 06/05/2012 09:45 AM, wonder_code@sina.com wrote:
> yes,I did.And I have rebuilded the filesystem

Ok. Please copy ldd on your target filesystem, replace the #! /bin/bash
at the top with #! /bin/ash

And show me the result of "ldd /usr/xenomai/bin/clocktest"

-- 
					    Gilles.

