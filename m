Message-ID: <5140F1FA.6060205@xenomai.org>
Date: Wed, 13 Mar 2013 22:39:06 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5140EEEA.2080209@yahoo.com>
In-Reply-To: <5140EEEA.2080209@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] linkage problem under 2.6.2.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Tom Z <tomz30@yahoo.com>
Cc: xenomai@xenomai.org

On 03/13/2013 10:26 PM, Tom Z wrote:

> Hi,


Hi,

> gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__ 
> -lnative -L/usr/xenomai/lib -lxenomai -lpthread -lrt -lxenomai ex01.c -o 
> ex01


The link order seems wrong.

-- 
                                                                Gilles.

