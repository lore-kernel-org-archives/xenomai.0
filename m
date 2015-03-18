Message-ID: <5509B7D8.2020807@xenomai.org>
Date: Wed, 18 Mar 2015 18:37:28 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKk99t3x2u4GN0D2w_pSBY8jWVRuE1yFki66dYNUfFBSd2GQ6w@mail.gmail.com>
 <CAKk99t2arbqbKke7EdM8accaghhdYstyVFQiysYoYB1LPGjnKA@mail.gmail.com>
 <CAKk99t0-b0bkndpxVDkFq-_pqzpq4FdEzV6nULMHq6bd+JkihQ@mail.gmail.com>
In-Reply-To: <CAKk99t0-b0bkndpxVDkFq-_pqzpq4FdEzV6nULMHq6bd+JkihQ@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
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
To: Helder Daniel <hdaniel@ualg.pt>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/18/2015 05:07 PM, Helder Daniel wrote:
> I also took a look here:
> 
> http://comments.gmane.org/gmane.linux.real-time.xenomai.users/11767
> 
> I did a: nm -s xddp-echo > symbols
> 
> cat symbols | grep sock
>                  U __wrap_setsockopt
>                  U __wrap_socket
> 
> So the wrappers seems to be applied.
> 

Is CONFIG_XENO_DRIVERS_RTIPC_XDDP enabled in your kernel config?

-- 
Philippe.

