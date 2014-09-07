Message-ID: <540C89BC.9030508@xenomai.org>
Date: Sun, 07 Sep 2014 18:37:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <540C85F1.4070809@gatech.edu>
In-Reply-To: <540C85F1.4070809@gatech.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] mlockall and dlopenskins?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yogi A. Patel" <yapatel@gatech.edu>, xenomai@xenomai.org

On 09/07/2014 06:21 PM, Yogi A. Patel wrote:
> Hi -
> 
> I used to provide --enable-posix-auto-mlockall --enable-dlopen-skins as 
> options to the configure script when compiling user space support. 
> However in 2.6.3 I get a warning saying those are unrecognized options.
> 
> Now. I was looking online at the documentation and found the following:
> 

The title of the section is:

BEFORE VERSION 2.6.3

> /Xenomai libraries only invoked mlockall if a special option was passed 
> to the configure script when compiling Xenomai user-space support. So, 
> applications which did not want to depend on this configuration had to 
> call mlockall by themselves, before using any Xenomai service, by using://
> //
> //mlockall(MCL_CURRENT | MCL_FUTURE);/


The section named:

MLOCKALL AND STACK SIZE

says:
As part of its initialization, Xenomai libraries call mlockall to commit
and lock the whole application memory.

How can that be made more clear?

-- 
                                                                Gilles.

