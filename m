Message-ID: <545C80C4.5070706@xenomai.org>
Date: Fri, 07 Nov 2014 09:20:20 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CALe7ZU13j0JPCHCXUeog=p8wc+0Cg-swwYW9ULKwSAQ9XYEz9g@mail.gmail.com>
In-Reply-To: <CALe7ZU13j0JPCHCXUeog=p8wc+0Cg-swwYW9ULKwSAQ9XYEz9g@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] error: unknow type name 'RT_PIPE_MSG'
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: JAY KOTHARI <jaikothari10@gmail.com>, xenomai <xenomai@xenomai.org>

On 11/07/2014 07:36 AM, JAY KOTHARI wrote:
> Hello,
>        I am using real time pipe. I have also included the
> <native/pipe.h>. But RT_PIPE_MSG is not known. Why could this be
> error. I am using xenomai 2..6.3 in my system.
> 

As mentioned in the documentation, all packet-oriented services
accepting arguments of type RT_PIPE_MSG are part of the kernel-space API.

http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__pipe.html#ga731e5ef18007dcd58a9346bea66abbc6


-- 
Philippe.

