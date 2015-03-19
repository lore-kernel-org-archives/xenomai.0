Message-ID: <550A7331.4000601@xenomai.org>
Date: Thu, 19 Mar 2015 07:56:49 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKk99t3x2u4GN0D2w_pSBY8jWVRuE1yFki66dYNUfFBSd2GQ6w@mail.gmail.com>	<5509B74A.8080302@xenomai.org>
 <CAKk99t26kP+wCRVS07LSAkm3zfF_Xjoo-E6d7Ynn9Cof3vXnug@mail.gmail.com>
In-Reply-To: <CAKk99t26kP+wCRVS07LSAkm3zfF_Xjoo-E6d7Ynn9Cof3vXnug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Makefile to use 2 APIs (rtdm and alchemy)
	simultaneously
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Helder Daniel <hdaniel@ualg.pt>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/18/2015 09:46 PM, Helder Daniel wrote:
>     XDDP is based on RTDM, so you need POSIX, along with Alchemy for the
>     changes you added, i.e.:
> 
>     xeno-config --alchemy --posix --ldflags
> 
> 
> ok, thanks
>  
> 
>     > For the original version POSIX version xeno-config returns the correct
>     > compilation flags specifying rtdm skin or posix skin. It is not needed to
>     > specify both.
> 
>     Unlike with 2.6.x, mentioning RTDM is pointless with Xenomai 3.x because
>     you always have POSIX implicitly for any application, therefore you have
>     RTDM. Giving --skin=rtdm or --rtdm is a no-op for compat purpose with
>     legacy Makefiles actually.
> 
>     With 3.x, RTDM implies POSIX I/O calls and the socket interface, which
>     is readily available with libcobalt, which all apps link against.
> 
> 
> Ok, but it is still needed to specifying both:
> 
> xeno-config --alchemy --posix --ldflags
> 
> to get the all necessary linking flags, right?
> 

Yes, both for --cflags and --ldflags.

-- 
Philippe.

