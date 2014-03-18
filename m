Message-ID: <532802AB.2020300@xenomai.org>
Date: Tue, 18 Mar 2014 09:24:11 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1395089344.13662.YahooMailNeo@web171602.mail.ir2.yahoo.com>
In-Reply-To: <1395089344.13662.YahooMailNeo@web171602.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] header file order in copperplate/registry.c
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/17/2014 09:49 PM, Matthias Schneider wrote:
> Hi all,
>
> shouldn't fuse.h be include after xeno_config.h in copperplate/registry.c
> of xenomai-forge/next in order to allow xeno_config.h to set the FUSE_USE_VERSION
> define before it is set to a default value by fuse.h? Otherwise I get compile
> errors due to mismatching APIs.
>

Yep, something is wrong. Another option is to define FUSE_USE_VERSION in 
the local CFLAGS only for building the registry support. The commit 
below does this:

http://git.xenomai.org/xenomai-forge.git/commit/?h=next&id=f8dfc3f064ed75deda2336cd5db6bf4713f60700

-- 
Philippe.

