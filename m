Message-ID: <5457811D.2030502@xenomai.org>
Date: Mon, 03 Nov 2014 14:20:29 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <54509406.4000600@bmwedler.de> <54509629.8080107@bmwedler.de>
 <54577374.9010609@bmwedler.de>
In-Reply-To: <54577374.9010609@bmwedler.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Using pipes in 3.0rc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Registrierungen <regist@bmwedler.de>, xenomai@xenomai.org

On 11/03/2014 01:22 PM, Registrierungen wrote:
> Sorry for the late feedback.
> 
> I found the source where it goes wrong:
> 
>     if (poolsize > 0) {
>         ret = __RT(setsockopt(sock, SOL_XDDP, XDDP_POOLSZ,
>                       &poolsize, sizeof(poolsize)));
>         if (ret)
>             goto fail_sockopt;
>     }
> 
> Hope there could be found a solution for me.
> 

The solution was given a few days ago:

http://www.xenomai.org/pipermail/xenomai/2014-October/032054.html

-- 
Philippe.

