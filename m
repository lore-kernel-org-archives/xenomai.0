Message-ID: <540C8BD0.2090604@xenomai.org>
Date: Sun, 07 Sep 2014 18:46:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <540C85F1.4070809@gatech.edu> <540C89BC.9030508@xenomai.org>
 <540C8A35.8090804@gatech.edu>
In-Reply-To: <540C8A35.8090804@gatech.edu>
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

On 09/07/2014 06:39 PM, Yogi A. Patel wrote:
> On 09/07/2014 12:37 PM, Gilles Chanteperdrix wrote:
>> On 09/07/2014 06:21 PM, Yogi A. Patel wrote:
>> The section named: MLOCKALL AND STACK SIZE says: As part of its 
>> initialization, Xenomai libraries call mlockall to commit and lock the 
>> whole application memory. How can that be made more clear? 
> 
> It might be clearer if that statement was in or referenced to by the 
> section titled "BEFORE VERSION 2.6.3".

The documentation is meant to be used the other way around: you read the
mlockall section, and find a link to what happened before 2.6.3.

If you are interested in the exhaustive changes between versions, the
information is available in the git logs and release announcements.

For instance, version 2.6.3 announcement, here:
http://www.xenomai.org/pipermail/xenomai/2013-October/029289.html
says:

Jan Kiszka (29):
      Invoke mlockall on every skin library initialization
      posix: Control auto-shadowing via environment variable
      Remove mlockall alert handler
      Drop --enable-dlopen, disable optimized TLS support by default
      posix: Skip auto-shadowing if current thread is already shadowed

And I find that the title of the section makes it pretty clear that this
information concerns what happened before version 2.6.3.

-- 
                                                                Gilles.

